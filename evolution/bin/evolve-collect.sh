#!/usr/bin/env bash
# Scan records/*.jsonl and emit candidate learnings for patterns meeting evidence threshold.
# Idempotent: re-running updates evidence counts; does not duplicate candidates.
#
# Usage:  evolution/bin/evolve-collect.sh
#         CLAUDE_EVOLUTION_DRY_RUN=1 evolution/bin/evolve-collect.sh   (print only)
set -uo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

python3 - <<'PY'
import json, os, re, yaml, hashlib, datetime, glob
from collections import defaultdict

ROOT = os.path.abspath(os.path.dirname(os.path.dirname(__file__)) + "/..") if "__file__" in globals() else os.getcwd()
ROOT = os.getcwd()

cfg = yaml.safe_load(open("config.yaml"))
MIN_EVIDENCE = int(cfg.get("min_evidence", 3))
MIN_SESSIONS = int(cfg.get("min_distinct_sessions", 2))
DRY = os.environ.get("CLAUDE_EVOLUTION_DRY_RUN") == "1"

def slugify(s):
    s = re.sub(r'[^a-z0-9]+', '-', s.lower())
    return s.strip('-')[:60] or "unnamed"

# Load every JSONL record. Schema-lenient: we only need type, summary-ish text, session, project.
evidence = defaultdict(list)  # key = (scope, normalized_summary) -> list of records
for path in ("records/corrections.jsonl", "records/outcomes.jsonl"):
    if not os.path.exists(path): continue
    with open(path) as f:
        for ln in f:
            ln = ln.strip()
            if not ln: continue
            try:
                r = json.loads(ln)
            except Exception:
                continue
            # Normalize summary: lowercase + drop punctuation + take first 12 meaningful words.
            summary = (r.get("summary") or r.get("note") or "").strip()
            if not summary: continue
            norm = re.sub(r'[^a-z0-9 ]+', ' ', summary.lower())
            norm = ' '.join(norm.split()[:12])
            if not norm: continue
            scope = r.get("scope", "global")
            evidence[(scope, norm)].append(r)

# Load existing candidates by id → so we can update rather than overwrite.
existing = {}
for p in glob.glob("candidates/*.yaml"):
    try:
        d = yaml.safe_load(open(p)) or {}
        if d.get("id"): existing[d["id"]] = p
    except Exception:
        pass

created = updated = 0
for (scope, norm), records in evidence.items():
    if len(records) < MIN_EVIDENCE: continue
    session_ids = sorted({r.get("session","") for r in records if r.get("session")})
    if len(session_ids) < MIN_SESSIONS: continue
    project_slugs = sorted({r.get("project","") for r in records if r.get("project")})
    first = min(r.get("ts","") for r in records)
    last  = max(r.get("ts","") for r in records)
    rep = records[0].get("summary") or records[0].get("note") or norm
    slug = slugify(norm)[:32]
    cid = f"cand-{first[:10]}-{slug}-{hashlib.sha1(norm.encode()).hexdigest()[:6]}"

    cand = {
        "id": cid,
        "summary": rep,
        "rationale": f"Observed {len(records)} times across {len(session_ids)} sessions, {len(project_slugs)} project(s).",
        "scope": scope,
        "project_slugs": project_slugs,
        "evidence_count": len(records),
        "session_ids": session_ids,
        "first_seen": first,
        "last_seen": last,
        "last_confirmed": last,
        "last_failed": None,
        "confidence": min(0.99, 0.3 + 0.1 * len(records) + 0.05 * len(session_ids)),
        "contradictions": [],
        "supporting_record_ids": [r.get("id","") for r in records if r.get("id")][:50],
        "proposed_location": "stable/global.md" if scope == "global" else f"stable/by-project/{project_slugs[0] if project_slugs else 'unknown'}.md",
        "proposed_text": f"- {rep.strip()}",
        "status": "candidate",
        "notes": "",
    }

    path = existing.get(cid) or f"candidates/{cid}.yaml"
    if DRY:
        print("[dry] would write:", path)
        continue
    if path in existing.values():
        updated += 1
    else:
        created += 1
    with open(path, "w") as f:
        yaml.safe_dump(cand, f, sort_keys=False, width=100)

print(f"candidates: created={created} updated={updated}  (threshold: {MIN_EVIDENCE} evidence, {MIN_SESSIONS} sessions)")
PY

#!/usr/bin/env bash
# Regression guard. Scans recent records for post-promotion failures/corrections
# that reference promoted learnings. Reports suspected regressions.
# Output: evolution/reports/YYYY-MM-DD-regression.md
set -uo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

python3 - <<'PY'
import os, yaml, json, glob, datetime, re
cfg = yaml.safe_load(open("config.yaml"))
threshold = int(cfg.get("regression_failure_count", 3))

promoted = []
for p in glob.glob("reports/promoted-*.yaml"):
    try:
        d = yaml.safe_load(open(p)); promoted.append(d)
    except Exception: pass

# For each promoted learning, count how often a record since promotion "contradicts" it —
# proxy: the record summary shares ≥ 3 tokens with the proposed_text.
def tokens(s): return set(re.findall(r'[a-z0-9]+', (s or '').lower()))

findings = []
for pr in promoted:
    promoted_at = pr.get("promoted_at", "")
    target_tokens = tokens(pr.get("proposed_text",""))
    if not target_tokens: continue
    match_count = 0
    matches = []
    for path in ("records/corrections.jsonl",):
        if not os.path.exists(path): continue
        with open(path) as f:
            for ln in f:
                try: r = json.loads(ln)
                except: continue
                if r.get("ts","") <= promoted_at: continue
                if len(target_tokens & tokens(r.get("summary",""))) >= 3:
                    match_count += 1
                    matches.append(r)
    if match_count >= threshold:
        findings.append({"learning": pr, "match_count": match_count, "examples": matches[:5]})

today = datetime.date.today().isoformat()
out = f"reports/{today}-regression.md"
with open(out, "w") as f:
    f.write(f"# Regression report — {today}\n\n")
    if not findings:
        f.write("_No suspected regressions._ Promoted learnings not contradicted by recent records above threshold.\n")
    else:
        f.write(f"{len(findings)} suspected regression(s). Threshold: {threshold} contradicting records.\n\n")
        for fi in findings:
            l = fi["learning"]
            f.write(f"## {l['id']}\n\n")
            f.write(f"- Promoted: {l.get('promoted_at')}\n")
            f.write(f"- Text: `{(l.get('proposed_text','') or '').strip()[:200]}`\n")
            f.write(f"- Contradicting records since promotion: **{fi['match_count']}**\n")
            f.write(f"- Action: `/evolution demote {l['id']}` or investigate.\n\n")
print(f"wrote {out}")
PY

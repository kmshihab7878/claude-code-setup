#!/usr/bin/env bash
# Identify stale candidates and stale promoted learnings. Propose cleanup.
# Read-only; writes a report to evolution/reports/.
set -uo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

python3 - <<'PY'
import os, yaml, glob, datetime
cfg = yaml.safe_load(open("config.yaml"))
stale_days = int(cfg.get("stale_after_days", 90))
cutoff = (datetime.datetime.utcnow() - datetime.timedelta(days=stale_days)).strftime("%Y-%m-%dT%H:%M:%SZ")

stale_candidates = []
for p in glob.glob("candidates/*.yaml"):
    d = yaml.safe_load(open(p)) or {}
    last = d.get("last_confirmed", "")
    if last and last < cutoff:
        stale_candidates.append((p, d))

stale_promoted = []
for p in glob.glob("reports/promoted-*.yaml"):
    d = yaml.safe_load(open(p)) or {}
    last = d.get("last_confirmed", d.get("promoted_at",""))
    if last and last < cutoff:
        stale_promoted.append((p, d))

today = datetime.date.today().isoformat()
out = f"reports/{today}-prune.md"
with open(out, "w") as f:
    f.write(f"# Prune proposal — {today}\n\n")
    f.write(f"Cutoff: not confirmed in the last {stale_days} days (before {cutoff}).\n\n")
    f.write(f"## Candidates to archive ({len(stale_candidates)})\n\n")
    for p, d in stale_candidates:
        f.write(f"- `{d.get('id')}` — last_confirmed {d.get('last_confirmed')} — `{(d.get('summary','') or '')[:100]}`\n")
    f.write(f"\n## Stable learnings to consider demoting ({len(stale_promoted)})\n\n")
    for p, d in stale_promoted:
        f.write(f"- `{d.get('id')}` — promoted {d.get('promoted_at')} — `{(d.get('proposed_text','') or '').strip()[:100]}`\n")
    f.write("\nApply via `/evolution demote <id>` or move candidate files to `rejected/`.\n")
print(f"wrote {out}")
PY

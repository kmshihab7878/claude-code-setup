#!/usr/bin/env bash
# Demote a promoted learning: remove its line(s) from stable/*.md, move the
# reports/promoted-*.yaml to rejected/ with status=demoted.
# Usage:  evolution/bin/evolve-demote.sh <learning-id>
set -uo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

ID="${1:-}"
[ -n "$ID" ] || { echo "usage: $0 <learning-id>" >&2; exit 2; }
REC="reports/promoted-${ID}.yaml"
[ -f "$REC" ] || { echo "not found: $REC" >&2; exit 2; }

python3 - "$REC" <<'PY'
import sys, yaml, os, datetime, shutil
rec_path = sys.argv[1]
rec = yaml.safe_load(open(rec_path))
target = rec.get("proposed_location", "stable/global.md")
text   = rec.get("proposed_text", "").rstrip()
if not os.path.exists(target):
    print(f"target missing: {target}"); sys.exit(1)
with open(target) as f: body = f.read()
if text not in body:
    print(f"learning text not found in {target} (may already be demoted or edited)")
else:
    body = body.replace(text + "\n", "").replace(text, "")
    with open(target, "w") as f: f.write(body)
    print(f"removed from {target}")

rec["status"] = "demoted"
rec["demoted_at"] = datetime.datetime.utcnow().strftime("%Y-%m-%dT%H:%M:%SZ")
dest = f"rejected/demoted-{rec['id']}.yaml"
with open(dest, "w") as f: yaml.safe_dump(rec, f, sort_keys=False, width=100)
os.remove(rec_path)
print(f"archived → {dest}")
PY

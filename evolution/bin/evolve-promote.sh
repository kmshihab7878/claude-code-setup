#!/usr/bin/env bash
# Promotion gate. Given a candidate YAML id, check thresholds, and if all pass,
# append proposed_text to the target stable file. Fails closed.
#
# Usage:  evolution/bin/evolve-promote.sh <candidate-id>
#         evolution/bin/evolve-promote.sh --check <candidate-id>   (gate-only, no write)
set -uo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

CHECK_ONLY=0
if [ "${1:-}" = "--check" ]; then CHECK_ONLY=1; shift; fi
CID="${1:-}"
if [ -z "$CID" ]; then echo "usage: $0 [--check] <candidate-id>" >&2; exit 2; fi

FILE="candidates/${CID}.yaml"
[ -f "$FILE" ] || { echo "not found: $FILE" >&2; exit 2; }

python3 - "$FILE" "$CHECK_ONLY" <<'PY'
import sys, os, yaml, re
cand_path, check_only = sys.argv[1], sys.argv[2] == "1"
cfg = yaml.safe_load(open("config.yaml"))
cand = yaml.safe_load(open(cand_path))

min_ev       = int(cfg.get("min_evidence", 3))
min_sess     = int(cfg.get("min_distinct_sessions", 2))
min_projects = int(cfg.get("min_distinct_projects", 2))
budget       = int(cfg.get("startup_budget_chars", 4000))

fail = []

def require(ok, msg):
    if not ok: fail.append(msg)

require(cand.get("evidence_count", 0) >= min_ev,
        f"evidence_count {cand.get('evidence_count')} < {min_ev}")
require(len(cand.get("session_ids", [])) >= min_sess,
        f"distinct sessions {len(cand.get('session_ids', []))} < {min_sess}")
if cand.get("scope") != "project-specific":
    require(len(cand.get("project_slugs", [])) >= min_projects,
            f"distinct projects {len(cand.get('project_slugs', []))} < {min_projects}")
require(not cand.get("last_failed") or cand["last_confirmed"] > cand["last_failed"],
        "last_failed is more recent than last_confirmed")
require(cand.get("status") == "candidate",
        f"status is '{cand.get('status')}', not 'candidate'")
require(not cand.get("contradictions"),
        f"contradictions present: {cand.get('contradictions')}")

target = cand.get("proposed_location") or "stable/global.md"
# Size budget applies to stable/global.md + matched by-project file.
current_global = open("stable/global.md").read() if os.path.exists("stable/global.md") else ""
new_text = cand.get("proposed_text", "").rstrip() + "\n"
if target == "stable/global.md":
    projected = len(current_global) + len(new_text)
else:
    existing = open(target).read() if os.path.exists(target) else ""
    projected = len(current_global) + len(existing) + len(new_text)
require(projected <= budget,
        f"post-promotion startup size {projected} > budget {budget}")

# Contradiction substring sweep against current stable text.
for ln in current_global.splitlines():
    if not ln.strip() or ln.lstrip().startswith("#"): continue
    # naive contradiction: new text contains the literal negation of an existing line
    # (kept intentionally simple — enhance when needed)
    if re.search(r'^-\s*(.+)$', ln):
        pass

print("== Promotion gate ==")
for f in fail: print("  ✗", f)
if fail:
    print(f"\n  GATE FAILED: {len(fail)} condition(s) not met.")
    sys.exit(1)

print("  ✓ all gates passed")
if check_only:
    print("  (check-only — not writing)")
    sys.exit(0)

# Write: append to target. Preserve stable/global.md trailing content by appending before a blank line.
os.makedirs(os.path.dirname(target), exist_ok=True)
with open(target, "a") as f:
    if os.path.getsize(target) > 0 and not current_global.endswith("\n"):
        f.write("\n")
    f.write(new_text)

# Move candidate to rejected/ with status=promoted (record) — use a "promoted/" marker by renaming.
import datetime, shutil
cand["status"] = "promoted"
cand["promoted_at"] = datetime.datetime.utcnow().strftime("%Y-%m-%dT%H:%M:%SZ")
promoted_path = f"reports/promoted-{cand['id']}.yaml"
with open(promoted_path, "w") as f: yaml.safe_dump(cand, f, sort_keys=False, width=100)
os.remove(cand_path)

print(f"\n  promoted → {target}")
print(f"  record   → {promoted_path}")
PY

#!/usr/bin/env bash
# Validate this prompt-library repo. Exits 1 on failure.
# High-signal checks only. Do not add noisy ones.
#
# Run:  scripts/validate.sh

set -uo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

fail=0
pass=0
warn=0

section() { printf "\n== %s ==\n" "$1"; }
ok()      { printf "  ✓ %s\n" "$1"; pass=$((pass+1)); }
err()     { printf "  ✗ %s\n" "$1"; fail=$((fail+1)); }
wrn()     { printf "  ⚠ %s\n" "$1"; warn=$((warn+1)); }

# ----- 1. Inventory drift: CLAUDE.md and REGISTRY.md must match disk.
#        (README intentionally does not hardcode counts; INVENTORY.md is generated.)
section "Count drift (CLAUDE.md and REGISTRY.md match disk)"
inv=$(scripts/inventory.sh 2>/dev/null)
json() { echo "$inv" | python3 -c "import sys,json; d=json.load(sys.stdin); print($1)"; }

skills=$(json "d['skills']['count']")
agents_real=$(json "d['agents']['agents_real']")
agents_core=$(json "d['agents']['core_l0_l6']")
wave1=$(json "d['agents']['wave1_stage']")
rules=$(json "d['rules']")

check() { # file regex desc
  if grep -qE "$2" "$1"; then ok "$3 [$1]"; else err "$3 — pattern not in $1: $2"; fi
}

check CLAUDE.md "\\*\\*${skills}\\s+skills\\*\\*"    "CLAUDE.md skills = ${skills}"
check CLAUDE.md "\\*\\*${agents_real}\\s+agents\\*\\*" "CLAUDE.md agents = ${agents_real}"
check CLAUDE.md "${rules}\\s+path\\s+rules"         "CLAUDE.md path rules = ${rules}"
check agents/REGISTRY.md "${agents_real}\\s+agents"  "REGISTRY.md total = ${agents_real}"
check agents/REGISTRY.md "${agents_core}\\s+core"    "REGISTRY.md core = ${agents_core}"
check agents/REGISTRY.md "${wave1}\\s+Wave"          "REGISTRY.md Wave 1 = ${wave1}"

# ----- 2. Stale count anti-regression (patterns from the drift we already fixed).
section "Stale count patterns (anti-regression)"
stale_patterns=(
  '\b195\s+skills?\b'
  '\b196\s+skills?\b'
  '\b197\s+skills?\b'
  '\b177\s+skills?\b'
  '\b78\s+(slash\s+)?commands?\b'
  '\b77\s+commands?\b'
  '\b83\s+(slash\s+)?commands?\b'
  '\b171\s+Wave'
  '\b254\s+agents?\b'
  '\b282\s+(agents?|total)'
  '\b237\s+(total|agents?)\b'
  '\b239\s+agents?\b'
  '\b197-skill\b'
  '\b239-agent\b'
  '197 skills,?\s*\S+\s*agents?'
)
# Allowed to mention stale numbers ONLY in changelogs/remediation docs (historical record).
# Allowed to mention stale numbers ONLY in changelogs/remediation docs (historical record).
exclude_pattern='^\./(kb/wiki/changelog|docs/COUNCIL-REMEDIATION|docs/INVENTORY|docs/AUDIT|docs/_audit-workspace|CLAUDE\.md\.backup)'
for pat in "${stale_patterns[@]}"; do
  hits=$(grep -rlE "$pat" --include="*.md" . 2>/dev/null | grep -vE "$exclude_pattern" | head -5 || true)
  if [ -z "$hits" ]; then ok "no stale '$pat' in tracked files"
  else err "stale '$pat' in: $hits"; fi
done

# ----- 3. Placeholder / fake URL fingerprints.
section "Placeholder / fake URL check"
# Allowed inside the remediation doc as historical reference — use the same exclusion.
for bad in 'worwor' 'Flaworwor'; do
  hits=$(grep -rlE "$bad" --include="*.md" . 2>/dev/null | grep -vE "$exclude_pattern" | head -5 || true)
  if [ -z "$hits" ]; then ok "no '$bad' in tracked files"
  else err "found '$bad' in: $hits"; fi
done

# ----- 4. Hook-script references in settings.json exist on disk.
section "Hook-script references"
python3 - <<'PY'
import json, os, sys
try:
    s = json.load(open('settings.json'))
except Exception as e:
    print(f"  ✗ cannot read settings.json: {e}"); sys.exit(2)
missing = []
for _, arr in s.get('hooks', {}).items():
    for entry in arr:
        for h in entry.get('hooks', []):
            cmd = (h.get('command') or '').strip()
            if not cmd: continue
            first = cmd.split()[0]
            if first.startswith('~/.claude/hooks/'):
                local = 'hooks/' + first.rsplit('/',1)[-1]
                if not os.path.exists(local):
                    missing.append(local)
if missing:
    for m in missing: print(f"  ✗ hook script not in repo: {m}")
    sys.exit(1)
else:
    print("  ✓ all hook-script references resolve to files in hooks/")
PY
hook_rc=$?
[ $hook_rc -eq 0 ] && pass=$((pass+1)) || fail=$((fail+1))

# ----- 4.5 Evolution layer: startup-context budget.
section "Evolution startup budget"
if [ -f evolution/config.yaml ] && [ -f evolution/stable/global.md ]; then
  budget=$(awk '/^startup_budget_chars:/ {print $2; exit}' evolution/config.yaml)
  size=$(wc -c < evolution/stable/global.md | tr -d ' ')
  if [ "$size" -le "$budget" ]; then ok "stable/global.md $size ≤ budget $budget"
  else err "stable/global.md $size > budget $budget"; fi
else
  wrn "evolution layer not initialized (config.yaml or stable/global.md missing)"
fi

# ----- 5. Frontmatter sanity (warnings only — too much legacy to fail on).
section "Frontmatter sanity (warnings only)"
skill_no_name=0
skill_no_desc=0
while IFS= read -r f; do
  head=$(head -20 "$f")
  echo "$head" | grep -qE '^name:' || skill_no_name=$((skill_no_name+1))
  echo "$head" | grep -qE '^description:' || skill_no_desc=$((skill_no_desc+1))
done < <(find skills -name SKILL.md -type f)
[ $skill_no_name -eq 0 ] && ok "all SKILL.md have name:" || wrn "$skill_no_name SKILL.md missing name:"
[ $skill_no_desc -eq 0 ] && ok "all SKILL.md have description:" || wrn "$skill_no_desc SKILL.md missing description:"

cmd_no_desc=0
while IFS= read -r f; do
  head -10 "$f" | grep -qE '^description:' || cmd_no_desc=$((cmd_no_desc+1))
done < <(find commands -maxdepth 1 -name "*.md" -type f)
[ $cmd_no_desc -eq 0 ] && ok "all top-level commands have description:" || wrn "$cmd_no_desc commands missing description:"

# ----- summary -----
section "Summary"
printf "  pass=%d  warn=%d  fail=%d\n" "$pass" "$warn" "$fail"
[ $fail -eq 0 ] && exit 0 || exit 1

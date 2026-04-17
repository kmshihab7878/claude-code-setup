#!/usr/bin/env bash
# Smoke tests for the evolution layer. Fails fast; safe to run before commit.
# No external dependencies beyond python3 + pyyaml.
set -uo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$ROOT"

fail=0
pass=0
ok()  { printf "  ✓ %s\n" "$1"; pass=$((pass+1)); }
err() { printf "  ✗ %s\n" "$1"; fail=$((fail+1)); }

echo "== Evolution smoke tests =="

# 1. Config is valid YAML + required keys present.
python3 - <<'PY' 2>/dev/null && ok "config.yaml parses with required keys" || err "config.yaml invalid"
import yaml
c = yaml.safe_load(open("evolution/config.yaml"))
for k in ("enabled","startup_budget_chars","min_evidence","min_distinct_sessions"):
    assert k in c, k
PY

# 2. Stable/global.md fits the startup budget.
budget=$(awk '/^startup_budget_chars:/ {print $2}' evolution/config.yaml)
size=$(wc -c < evolution/stable/global.md | tr -d ' ')
if [ "$size" -le "$budget" ]; then ok "stable/global.md $size ≤ budget $budget chars"
else err "stable/global.md $size > budget $budget"; fi

# 3. All bin/ scripts executable (or will be after chmod on install).
missing_exec=0
for f in evolution/bin/*.sh; do
  head -1 "$f" | grep -qE '^#!/' || missing_exec=$((missing_exec+1))
done
[ $missing_exec -eq 0 ] && ok "all bin/*.sh have shebangs" || err "$missing_exec bin/*.sh missing shebang"

# 4. Hook would emit valid JSON (dry-run with simulated stdin).
TMP_CFG_ENABLED=$(grep -c '^enabled: true' evolution/config.yaml)
if [ "$TMP_CFG_ENABLED" -eq 1 ]; then
  out=$(printf '{"hook_event_name":"SessionStart","source":"startup","cwd":"/tmp/claude-code-setup","session_id":"test"}' \
    | bash hooks/evolution-startup.sh 2>/dev/null)
  echo "$out" | python3 -c 'import sys,json; d=json.load(sys.stdin); assert "hookSpecificOutput" in d; assert "additionalContext" in d["hookSpecificOutput"]; assert len(d["hookSpecificOutput"]["additionalContext"]) > 0' 2>/dev/null \
    && ok "SessionStart hook emits valid injection JSON" \
    || err "SessionStart hook output invalid"
else
  err "config.yaml 'enabled' is not true — cannot test injection path"
fi

# 5. Kill switch works.
out=$(CLAUDE_EVOLUTION_BASELINE=1 printf '{"hook_event_name":"SessionStart","source":"startup","cwd":"/tmp/x","session_id":"t"}' \
  | CLAUDE_EVOLUTION_BASELINE=1 bash hooks/evolution-startup.sh 2>/dev/null)
[ -z "$out" ] && ok "CLAUDE_EVOLUTION_BASELINE=1 suppresses injection" || err "baseline mode did not suppress: '$out'"

# 6. Collect script is a no-op with empty records (no crash).
bash evolution/bin/evolve-collect.sh >/dev/null 2>&1 && ok "evolve-collect.sh no-ops on empty records" || err "evolve-collect.sh crashed"

# 7. Status script runs.
bash evolution/bin/evolve-status.sh >/dev/null 2>&1 && ok "evolve-status.sh runs clean" || err "evolve-status.sh crashed"

echo
printf "  pass=%d  fail=%d\n" "$pass" "$fail"
[ $fail -eq 0 ] && exit 0 || exit 1

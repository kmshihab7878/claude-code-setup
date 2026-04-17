#!/usr/bin/env bash
# SessionStart hook: inject the evolution operating contract + project-scoped stable learnings.
#
# Per Claude Code hook spec: reads JSON on stdin, writes JSON on stdout with
# { "hookSpecificOutput": { "hookEventName": "SessionStart", "additionalContext": "<text>" } }
#
# Silently no-ops if:
#   - evolution/config.yaml has `enabled: false`
#   - CLAUDE_EVOLUTION_BASELINE=1
#   - stable/global.md is missing
#   - source is "compact" (avoid re-injecting after compaction)
set -uo pipefail

EVO="${CLAUDE_EVOLUTION_ROOT:-$HOME/.claude/evolution}"
RECORDS_DIR="${EVO}/records"

# Read the hook input JSON from stdin (best-effort).
INPUT="$(cat 2>/dev/null || true)"

source=$(printf '%s' "$INPUT" | python3 -c 'import sys,json; d=json.load(sys.stdin); print(d.get("source",""))' 2>/dev/null || echo "")
cwd=$(printf '%s' "$INPUT" | python3 -c 'import sys,json; d=json.load(sys.stdin); print(d.get("cwd",""))' 2>/dev/null || echo "")
sid=$(printf '%s' "$INPUT" | python3 -c 'import sys,json; d=json.load(sys.stdin); print(d.get("session_id",""))' 2>/dev/null || echo "")

# Baseline kill switches.
[ "${CLAUDE_EVOLUTION_BASELINE:-0}" = "1" ] && exit 0
[ -f "${EVO}/disabled" ] && exit 0

if [ -f "${EVO}/config.yaml" ]; then
  enabled=$(awk '/^enabled:/ {print $2; exit}' "${EVO}/config.yaml")
  [ "$enabled" = "true" ] || exit 0
fi

# Don't re-inject on compact (context is being compressed, this would un-compress).
[ "$source" = "compact" ] && exit 0

GLOBAL="${EVO}/stable/global.md"
[ -f "$GLOBAL" ] || exit 0

# Budget check — hard cap.
budget=4000
if [ -f "${EVO}/config.yaml" ]; then
  budget=$(awk '/^startup_budget_chars:/ {print $2; exit}' "${EVO}/config.yaml")
fi

# Build the injection text.
TEXT=$(cat "$GLOBAL")
if [ -n "$cwd" ]; then
  slug=$(basename "$cwd")
  PROJ="${EVO}/stable/by-project/${slug}.md"
  if [ -f "$PROJ" ]; then
    TEXT=$(printf '%s\n\n---\n\n## Project-scoped learnings: %s\n\n%s' "$TEXT" "$slug" "$(cat "$PROJ")")
  fi
fi

# Enforce budget at inject time — truncate hard if someone bypassed the promote gate.
TEXT_LEN=${#TEXT}
if [ "$TEXT_LEN" -gt "$budget" ]; then
  TEXT="${TEXT:0:$budget}

[... truncated at ${budget}-char budget — run /evolution status to investigate]"
fi

# Record the session start (best-effort; never block).
mkdir -p "$RECORDS_DIR" 2>/dev/null
ts=$(date -u +%Y-%m-%dT%H:%M:%SZ)
python3 - <<PY 2>/dev/null
import json, os
try:
    rec = {"ts": "$ts", "session": "$sid", "source": "$source", "cwd": "$cwd", "event": "start"}
    with open("${RECORDS_DIR}/sessions.jsonl", "a") as f:
        f.write(json.dumps(rec) + "\n")
except Exception:
    pass
PY

# Emit injection. Pass TEXT via stdin — avoids heredoc interpolation pitfalls.
printf '%s' "$TEXT" | python3 -c '
import sys, json
text = sys.stdin.read()
print(json.dumps({"hookSpecificOutput": {"hookEventName": "SessionStart", "additionalContext": text}}))
'
exit 0

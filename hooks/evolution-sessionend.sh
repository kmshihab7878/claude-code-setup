#!/usr/bin/env bash
# SessionEnd hook: append one record per session end, best-effort.
# Optionally fires evolve-collect.sh opportunistically (not required — /evolution collect is safer).
set -u

EVO="${CLAUDE_EVOLUTION_ROOT:-$HOME/.claude/evolution}"
RECORDS_DIR="${EVO}/records"

[ "${CLAUDE_EVOLUTION_BASELINE:-0}" = "1" ] && exit 0
[ -f "${EVO}/disabled" ] && exit 0
if [ -f "${EVO}/config.yaml" ]; then
  enabled=$(awk '/^enabled:/ {print $2; exit}' "${EVO}/config.yaml")
  [ "$enabled" = "true" ] || exit 0
fi

mkdir -p "$RECORDS_DIR" 2>/dev/null

INPUT="$(cat 2>/dev/null || true)"
sid=$(printf '%s' "$INPUT" | python3 -c 'import sys,json; d=json.load(sys.stdin); print(d.get("session_id",""))' 2>/dev/null || echo "")
cwd=$(printf '%s' "$INPUT" | python3 -c 'import sys,json; d=json.load(sys.stdin); print(d.get("cwd",""))' 2>/dev/null || echo "")
ts=$(date -u +%Y-%m-%dT%H:%M:%SZ)

python3 - <<PY 2>/dev/null
import json
try:
    rec = {"ts": "$ts", "session": "$sid", "cwd": "$cwd", "event": "end"}
    with open("${RECORDS_DIR}/sessions.jsonl", "a") as f:
        f.write(json.dumps(rec) + "\n")
except Exception:
    pass
PY

exit 0

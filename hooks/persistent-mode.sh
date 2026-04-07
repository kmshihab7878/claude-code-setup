#!/bin/bash
# Persistent Mode — Prevents Claude from stopping mid-task when work is incomplete
# Inspired by oh-my-claudecode's block-decision Stop hook pattern.
#
# Modes: autonomous, ultrawork, pipeline
# Activate: Set mode file in ~/.claude/state/{mode}.json
# Deactivate: Delete the mode file, or say "cancel" / "stop"
#
# Exit 2 = BLOCK stopping (work not done)
# Exit 0 = ALLOW stopping

STATE_DIR="$HOME/.claude/state"
mkdir -p "$STATE_DIR"

# ── Check if any persistent mode is active ──
ACTIVE_MODE=""
ACTIVE_FILE=""

for mode_file in "$STATE_DIR"/*.json; do
  [ -f "$mode_file" ] || continue

  # Parse mode state
  IS_ACTIVE=$(python3 -c "
import json, sys
try:
    with open('$mode_file') as f:
        d = json.load(f)
    if d.get('active', False):
        print('yes')
    else:
        print('no')
except:
    print('no')
" 2>/dev/null)

  if [ "$IS_ACTIVE" = "yes" ]; then
    ACTIVE_MODE=$(basename "$mode_file" .json)
    ACTIVE_FILE="$mode_file"
    break
  fi
done

# No active mode — allow stop
if [ -z "$ACTIVE_MODE" ]; then
  exit 0
fi

# ── Staleness check: if state is >2 hours old, deactivate ──
CREATED=$(python3 -c "
import json, os
try:
    with open('$ACTIVE_FILE') as f:
        d = json.load(f)
    print(d.get('created_at', ''))
except:
    print('')
" 2>/dev/null)

if [ -n "$CREATED" ]; then
  CREATED_TS=$(python3 -c "
from datetime import datetime, timezone
try:
    dt = datetime.fromisoformat('$CREATED')
    print(int(dt.timestamp()))
except:
    print(0)
" 2>/dev/null)
  NOW_TS=$(date +%s)
  AGE=$(( NOW_TS - CREATED_TS ))

  if [ "$AGE" -gt 7200 ]; then
    # Stale — deactivate and allow stop
    python3 -c "
import json
with open('$ACTIVE_FILE') as f:
    d = json.load(f)
d['active'] = False
d['deactivated_reason'] = 'stale (>2h)'
with open('$ACTIVE_FILE', 'w') as f:
    json.dump(d, f, indent=2)
" 2>/dev/null
    exit 0
  fi
fi

# ── Increment iteration counter ──
ITERATION=$(python3 -c "
import json
with open('$ACTIVE_FILE') as f:
    d = json.load(f)
d['iteration'] = d.get('iteration', 0) + 1
iteration = d['iteration']
max_iter = d.get('max_iterations', 50)
with open('$ACTIVE_FILE', 'w') as f:
    json.dump(d, f, indent=2)
print(f'{iteration}/{max_iter}')
" 2>/dev/null)

# ── Check if max iterations exceeded ──
CURRENT=$(echo "$ITERATION" | cut -d'/' -f1)
MAX=$(echo "$ITERATION" | cut -d'/' -f2)

if [ "$CURRENT" -ge "$MAX" ]; then
  # Deactivate and allow stop
  python3 -c "
import json
with open('$ACTIVE_FILE') as f:
    d = json.load(f)
d['active'] = False
d['deactivated_reason'] = 'max iterations reached'
with open('$ACTIVE_FILE', 'w') as f:
    json.dump(d, f, indent=2)
" 2>/dev/null
  exit 0
fi

# ── Extract original task for block reason ──
TASK=$(python3 -c "
import json
with open('$ACTIVE_FILE') as f:
    d = json.load(f)
print(d.get('task', 'Continue working on the current task.'))
" 2>/dev/null)

# ── BLOCK — work not done ──
echo "[PERSISTENT MODE: $ACTIVE_MODE — ITERATION $ITERATION]"
echo ""
echo "Work is NOT done. Continue executing the plan."
echo "Task: $TASK"
echo ""
echo "To cancel persistent mode: say 'cancel' or 'stop mode'"
exit 2

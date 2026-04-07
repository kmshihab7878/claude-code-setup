#!/bin/bash
# Tool Failure Tracker — Tracks failures with retry guidance
# Inspired by oh-my-claudecode's PostToolUseFailure pattern.
#
# Runs on PostToolUse. Detects failures and:
# - Tracks consecutive failure count
# - After 3 failures: suggests different approach
# - After 5 failures: recommends stopping and diagnosing
#
# Exit 0 = always allow (advisory only)

STATE_DIR="$HOME/.claude/state"
FAILURE_FILE="$STATE_DIR/tool-failures.json"
mkdir -p "$STATE_DIR"

# Check if tool result indicates failure
TOOL_OUTPUT="${TOOL_OUTPUT:-}"
EXIT_CODE="${TOOL_EXIT_CODE:-0}"

# Detect failure signals
IS_FAILURE=false
if [ "$EXIT_CODE" != "0" ]; then
  IS_FAILURE=true
fi
if echo "$TOOL_OUTPUT" | grep -qiE '(error|traceback|exception|failed|ENOENT|EACCES|permission denied|command not found)' 2>/dev/null; then
  IS_FAILURE=true
fi

if [ "$IS_FAILURE" = "true" ]; then
  # Increment failure counter
  python3 -c "
import json, os
f = '$FAILURE_FILE'
try:
    with open(f) as fh:
        d = json.load(fh)
except (FileNotFoundError, json.JSONDecodeError):
    d = {'consecutive': 0, 'total': 0, 'last_tool': ''}

d['consecutive'] = d.get('consecutive', 0) + 1
d['total'] = d.get('total', 0) + 1
d['last_tool'] = os.environ.get('TOOL_NAME', 'unknown')

with open(f, 'w') as fh:
    json.dump(d, fh, indent=2)

c = d['consecutive']
if c >= 5:
    print(f'## Tool Failure Tracker: {c} consecutive failures')
    print('')
    print('STOP retrying the same approach. Instead:')
    print('1. Read the error message carefully')
    print('2. Check your assumptions about file paths, function signatures, or API endpoints')
    print('3. Try a fundamentally different approach')
    print('4. If stuck, ask the user for guidance')
elif c >= 3:
    print(f'## Tool Failure Tracker: {c} consecutive failures')
    print('')
    print('Consider a different approach:')
    print('- Are you using the right tool for this task?')
    print('- Is the file path / function name correct?')
    print('- Would reading the file first help?')
" 2>/dev/null
else
  # Reset consecutive counter on success
  if [ -f "$FAILURE_FILE" ]; then
    python3 -c "
import json
with open('$FAILURE_FILE') as f:
    d = json.load(f)
d['consecutive'] = 0
with open('$FAILURE_FILE', 'w') as f:
    json.dump(d, f, indent=2)
" 2>/dev/null
  fi
fi

exit 0

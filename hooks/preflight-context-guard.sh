#!/bin/bash
# Preflight Context Guard — Blocks agent-heavy tools when context is high
# Inspired by oh-my-claudecode's pre-tool preflight pattern.
#
# Runs on PreToolUse for Agent/Task tools. Blocks spawning new agents
# when estimated context usage exceeds threshold (default 72%).
#
# Exit 2 = BLOCK tool use
# Exit 0 = ALLOW

THRESHOLD=${OMC_PREFLIGHT_THRESHOLD:-72}
STATE_DIR="$HOME/.claude/state"
METRICS_FILE="$HOME/.claude/session-metrics.json"

# Estimate context usage
TOOL_CALLS=0
if [ -f "$METRICS_FILE" ]; then
  TOOL_CALLS=$(python3 -c "
import json
try:
    with open('$METRICS_FILE') as f:
        d = json.load(f)
    print(d.get('tool_calls', 0))
except:
    print(0)
" 2>/dev/null)
fi

ESTIMATED_TOKENS=$((TOOL_CALLS * 2000))
MAX_CONTEXT=200000
CONTEXT_PCT=$((ESTIMATED_TOKENS * 100 / MAX_CONTEXT))

if [ "$CONTEXT_PCT" -ge "$THRESHOLD" ]; then
  echo "## Preflight Context Guard: BLOCKED"
  echo ""
  echo "Context usage ~${CONTEXT_PCT}% (threshold: ${THRESHOLD}%)."
  echo "Cannot spawn new agents — not enough context headroom."
  echo ""
  echo "Options:"
  echo "1. Run /compact to free context, then retry"
  echo "2. Handle this task directly instead of delegating"
  echo "3. Use Qwen Code for this task: qwen-dispatch raw \"<task>\" --cwd <dir>"
  exit 2
fi

exit 0

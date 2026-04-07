#!/bin/bash
# Context Guard — Estimates context usage and warns before exhaustion
# Inspired by oh-my-claudecode's context-guard-stop pattern.
#
# Fires on Stop hook. Checks transcript for context usage signals.
# At 75%: blocks stop and suggests /compact
# At 95%: allows stop (avoid deadlock)
#
# Exit 2 = BLOCK (suggest compaction)
# Exit 0 = ALLOW

STATE_DIR="$HOME/.claude/state"
GUARD_FILE="$STATE_DIR/context-guard.json"
mkdir -p "$STATE_DIR"

# ── Estimate context from environment ──
# Claude Code exposes session info via environment or we estimate from tool call count
TOOL_CALLS=${CLAUDE_TOOL_CALL_COUNT:-0}
SESSION_DURATION=${CLAUDE_SESSION_DURATION:-0}

# Heuristic: estimate context usage from session metrics
# Average tool call consumes ~2K tokens of context
# Long sessions naturally accumulate more context
ESTIMATED_TOKENS=$((TOOL_CALLS * 2000 + SESSION_DURATION / 60 * 500))
MAX_CONTEXT=200000  # Opus context window

# If we can read the metrics file, use that for better estimation
METRICS_FILE="$HOME/.claude/session-metrics.json"
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
  ESTIMATED_TOKENS=$((TOOL_CALLS * 2000))
fi

# Calculate percentage
if [ "$MAX_CONTEXT" -gt 0 ]; then
  CONTEXT_PCT=$((ESTIMATED_TOKENS * 100 / MAX_CONTEXT))
else
  CONTEXT_PCT=0
fi

# ── Retry guard: max 2 blocks per session ──
BLOCK_COUNT=0
if [ -f "$GUARD_FILE" ]; then
  BLOCK_COUNT=$(python3 -c "
import json
try:
    with open('$GUARD_FILE') as f:
        d = json.load(f)
    print(d.get('block_count', 0))
except:
    print(0)
" 2>/dev/null)
fi

if [ "$BLOCK_COUNT" -ge 2 ]; then
  # Already blocked twice — allow stop to prevent infinite loop
  exit 0
fi

# ── Critical threshold (95%+): always allow stop ──
if [ "$CONTEXT_PCT" -ge 95 ]; then
  echo "## Context Guard: CRITICAL ($CONTEXT_PCT%)"
  echo "Context nearly exhausted. Allowing stop to prevent deadlock."
  exit 0
fi

# ── Warning threshold (75%+): block and suggest /compact ──
if [ "$CONTEXT_PCT" -ge 75 ]; then
  # Update block count
  python3 -c "
import json
d = {'block_count': $BLOCK_COUNT + 1, 'last_pct': $CONTEXT_PCT}
with open('$GUARD_FILE', 'w') as f:
    json.dump(d, f)
" 2>/dev/null

  echo "## Context Guard: WARNING ($CONTEXT_PCT% estimated)"
  echo ""
  echo "Context usage is high. Before stopping:"
  echo "1. Consider running /compact to free context"
  echo "2. Summarize key findings before compaction"
  echo "3. Save any critical state to files"
  echo ""
  echo "Estimated: ~${ESTIMATED_TOKENS} tokens used of ${MAX_CONTEXT}"
  exit 2
fi

# ── Below threshold — allow stop ──
exit 0

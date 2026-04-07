#!/bin/bash
# Loop Detection Hook (DeerFlow-inspired)
# Tracks recent tool calls and warns/blocks on repetition.
# Claude Code PreToolUse hooks receive JSON on stdin with tool_name and tool_input.
# Hash: tool_name + first 100 chars of input
# Warn after 3 identical calls, BLOCK after 5.

LOOP_FILE="${HOME}/.claude/.loop-state"
MAX_WINDOW=20
WARN_THRESHOLD=5
BLOCK_THRESHOLD=8

# Read JSON from stdin (Claude Code passes tool context this way)
STDIN_DATA=$(cat 2>/dev/null || echo "{}")

# Extract tool name and tool_input content for hashing (not raw JSON envelope)
TOOL_NAME=$(echo "$STDIN_DATA" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_name','unknown'))" 2>/dev/null || echo "unknown")
INPUT_CONTENT=$(echo "$STDIN_DATA" | python3 -c "
import sys,json
d=json.load(sys.stdin)
inp=d.get('tool_input',{})
if isinstance(inp,dict):
    # For Bash, hash the command; for file tools, hash file_path; else hash full input
    cmd=inp.get('command',inp.get('file_path',''))
    if cmd:
        print(str(cmd)[:300])
    else:
        # For tools like TaskUpdate, TaskCreate etc — hash all params
        print(json.dumps(inp,sort_keys=True)[:300])
else:
    print(str(inp)[:300])
" 2>/dev/null || echo "$STDIN_DATA" | head -c 300)
INPUT_HASH=$(echo "${TOOL_NAME}:${INPUT_CONTENT}" | shasum -a 256 | cut -d' ' -f1)

# If we couldn't parse tool_name, skip detection (don't block on parse failure)
if [ "$TOOL_NAME" = "unknown" ]; then
    exit 0
fi

CALL_SIG="${TOOL_NAME}:${INPUT_HASH}"

# Ensure state file exists
touch "$LOOP_FILE"

# Append current call
echo "$CALL_SIG" >> "$LOOP_FILE"

# Keep only last MAX_WINDOW entries
tail -n "$MAX_WINDOW" "$LOOP_FILE" > "${LOOP_FILE}.tmp" && mv "${LOOP_FILE}.tmp" "$LOOP_FILE"

# Count occurrences of current signature
COUNT=$(grep -c "^${CALL_SIG}$" "$LOOP_FILE" 2>/dev/null || echo 0)

if [ "$COUNT" -ge "$BLOCK_THRESHOLD" ]; then
    echo "BLOCKED: Loop detected — identical tool call repeated ${COUNT} times (${TOOL_NAME}). Break the loop: try a different approach or ask the user." >&2
    exit 2
elif [ "$COUNT" -ge "$WARN_THRESHOLD" ]; then
    echo "WARNING: Possible loop — ${TOOL_NAME} called ${COUNT} times with same input. Consider varying your approach." >&2
    exit 0
fi

exit 0

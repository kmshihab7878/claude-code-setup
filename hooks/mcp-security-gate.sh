#!/usr/bin/env bash
# MCP Security Gate — Validates MCP server tools before first use
# Runs as PreToolUse hook, checks tool provenance and logs activations
#
# Security checks:
# 1. Tool name whitelist validation
# 2. First-use detection and logging
# 3. Suspicious pattern detection in tool inputs
# 4. Audit trail for all MCP tool invocations

set -euo pipefail

AUDIT_LOG="$HOME/.claude/audit-mcp.log"
WHITELIST="$HOME/.claude/recipes/lib/mcp-whitelist.json"
SEEN_FILE="$HOME/.claude/state/mcp-seen-tools.txt"

# Ensure state files exist
mkdir -p "$HOME/.claude/state"
touch "$SEEN_FILE" "$AUDIT_LOG"

# Extract tool info from environment
TOOL_NAME="${TOOL_USE_ID:-unknown}"
TOOL_INPUT="${TOOL_INPUT:-}"
SESSION_ID="${SESSION_ID:-$(date +%s)}"

# Get the tool name from the tool use (the actual tool being called)
# TOOL_USE_ID format is the tool name for MCP tools
TOOL="${TOOL_NAME}"

# Detect MCP tools (they contain "mcp__" prefix)
if [[ "$TOOL" != mcp__* ]]; then
    # Not an MCP tool, allow
    exit 0
fi

# Extract server name from MCP tool (format: mcp__server__tool)
SERVER_NAME=$(echo "$TOOL" | sed 's/^mcp__//' | sed 's/__.*$//')
TOOL_FUNC=$(echo "$TOOL" | sed "s/^mcp__${SERVER_NAME}__//")

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# --- Check 1: First-use detection ---
if ! grep -qF "${SERVER_NAME}::${TOOL_FUNC}" "$SEEN_FILE" 2>/dev/null; then
    echo "${SERVER_NAME}::${TOOL_FUNC}" >> "$SEEN_FILE"
    echo "[${TIMESTAMP}] FIRST_USE: server=${SERVER_NAME} tool=${TOOL_FUNC}" >> "$AUDIT_LOG"
fi

# --- Check 2: Suspicious input patterns ---
# Check for potential command injection in tool inputs
if echo "$TOOL_INPUT" | grep -qiE '(\$\(|`|;.*rm|;.*curl|;.*wget|eval\s|exec\s)' 2>/dev/null; then
    echo "[${TIMESTAMP}] SUSPICIOUS_INPUT: server=${SERVER_NAME} tool=${TOOL_FUNC} input_preview=$(echo "$TOOL_INPUT" | head -c 200)" >> "$AUDIT_LOG"
    echo "WARNING: Suspicious pattern detected in MCP tool input for ${SERVER_NAME}::${TOOL_FUNC}. Logged for review."
    # Don't block (exit 1 = warn), but flag it
    exit 1
fi

# --- Check 3: High-risk tool patterns ---
# Flag tools that modify external state
HIGH_RISK_PATTERNS="create_order|cancel_order|delete|drop|push_files|merge_pull|transfer|send_message|post_message"
if echo "$TOOL_FUNC" | grep -qiE "$HIGH_RISK_PATTERNS" 2>/dev/null; then
    echo "[${TIMESTAMP}] HIGH_RISK_TOOL: server=${SERVER_NAME} tool=${TOOL_FUNC}" >> "$AUDIT_LOG"
fi

# --- Check 4: Whitelist validation (if whitelist exists) ---
if [ -f "$WHITELIST" ]; then
    if ! python3 -c "
import json, sys
with open('$WHITELIST') as f:
    wl = json.load(f)
server = '$SERVER_NAME'
tool = '$TOOL_FUNC'
if server in wl:
    allowed = wl[server]
    if allowed == '*' or tool in allowed:
        sys.exit(0)
    else:
        print(f'BLOCKED: {server}::{tool} not in whitelist')
        sys.exit(2)
else:
    # Server not in whitelist — allow but warn on first session use
    sys.exit(0)
" 2>/dev/null; then
        RESULT=$?
        if [ "$RESULT" -eq 2 ]; then
            echo "[${TIMESTAMP}] BLOCKED: server=${SERVER_NAME} tool=${TOOL_FUNC} reason=whitelist" >> "$AUDIT_LOG"
            exit 2
        fi
    fi
fi

# --- Audit log entry ---
echo "[${TIMESTAMP}] MCP_CALL: server=${SERVER_NAME} tool=${TOOL_FUNC}" >> "$AUDIT_LOG"

exit 0

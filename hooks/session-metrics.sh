#!/bin/bash
# Session Metrics Hook (DeerFlow-inspired)
# Logs tool usage to a daily metrics file for self-improvement analysis.

METRICS_DIR="${HOME}/.claude/metrics"
mkdir -p "$METRICS_DIR"
TODAY=$(date '+%Y-%m-%d')
METRICS_FILE="${METRICS_DIR}/${TODAY}.log"

TOOL_NAME="${TOOL_NAME:-unknown}"
TIMESTAMP=$(date '+%H:%M:%S')

echo "${TIMESTAMP}|${TOOL_NAME}|${SESSION_ID:-nosession}" >> "$METRICS_FILE"
exit 0

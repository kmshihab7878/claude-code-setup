#!/usr/bin/env bash
# No-Secret-Commit Gate — PreToolUse hook for Write/Edit
#
# Blocks writes to obvious secret files (.env, *.pem, *.key, credentials) and
# warns when the file content contains likely secret patterns.
#
# Mirrors the inlined hook in settings.json (which only blocks .env/.pem/.key
# file paths) and adds content-pattern scanning.
#
# Status: NOT YET WIRED INTO settings.json. Wire only with explicit user approval —
# see docs/SECURITY.md § "Enabling extracted hooks".
#
# Exit codes:
#   0 — allow
#   1 — warn (logged, but tool proceeds)
#   2 — block

set -euo pipefail

AUDIT_LOG="${HOME}/.claude/audit.log"
TS="$(date '+%Y-%m-%d %H:%M:%S')"
TOOL_INPUT="${TOOL_INPUT:-}"

mkdir -p "$(dirname "$AUDIT_LOG")"
touch "$AUDIT_LOG"

log_audit() {
  local level="$1"; shift
  echo "[${TS}] NO_SECRET ${level}: $*" >> "$AUDIT_LOG"
}

# --- Extract file_path from tool input (JSON) ---
FILE_PATH=""
if [[ -n "$TOOL_INPUT" ]]; then
  FILE_PATH=$(echo "$TOOL_INPUT" | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    print(d.get('file_path', ''))
except Exception:
    print('')
" 2>/dev/null || echo "")
fi

# --- Block: writing to known secret file types or paths ---
if [[ -n "$FILE_PATH" ]] && echo "$FILE_PATH" | grep -qiE '(\.env(\.[a-z0-9_-]+)?$|\.pem$|\.key$|\.p12$|\.pfx$|\.crt$|/credentials($|\.)|/secrets/|/\.aws/credentials|/\.ssh/id_)'; then
  # Allow .env.example explicitly
  if echo "$FILE_PATH" | grep -qE '\.env\.example$'; then
    log_audit ALLOW ".env.example (template, no secrets)"
    exit 0
  fi
  log_audit BLOCK "write to secret-file path: $FILE_PATH"
  echo "BLOCKED: write to a secrets path ($FILE_PATH). Use .env.example for placeholders, never commit real credentials." >&2
  exit 2
fi

# --- Extract content (the new file content for Write, the new_string for Edit) ---
CONTENT=$(echo "$TOOL_INPUT" | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    print(d.get('content') or d.get('new_string') or '')
except Exception:
    print('')
" 2>/dev/null || echo "")

# --- Warn: content matches obvious secret patterns ---
if [[ -n "$CONTENT" ]]; then
  # AWS access key
  if echo "$CONTENT" | grep -qE 'AKIA[0-9A-Z]{16}'; then
    log_audit WARN "AWS access key pattern in content"
    echo "WARN: content contains an AWS access key pattern. Refuse if real; rotate immediately if real." >&2
    exit 1
  fi
  # Stripe live key
  if echo "$CONTENT" | grep -qE 'sk_live_[0-9a-zA-Z]{24,}'; then
    log_audit WARN "Stripe live key pattern in content"
    echo "WARN: content contains a Stripe live key pattern. Refuse if real; rotate immediately if real." >&2
    exit 1
  fi
  # Slack token
  if echo "$CONTENT" | grep -qE 'xox[baprs]-[0-9A-Za-z-]{10,}'; then
    log_audit WARN "Slack token pattern in content"
    echo "WARN: content contains a Slack token pattern. Refuse if real; rotate immediately if real." >&2
    exit 1
  fi
  # OpenAI key
  if echo "$CONTENT" | grep -qE 'sk-[A-Za-z0-9]{32,}'; then
    log_audit WARN "OpenAI-style API key pattern in content"
    echo "WARN: content contains an OpenAI-style key pattern. Refuse if real; rotate immediately if real." >&2
    exit 1
  fi
  # Generic 'private key' header
  if echo "$CONTENT" | grep -q 'BEGIN.*PRIVATE KEY'; then
    log_audit WARN "PEM private key in content"
    echo "WARN: content contains a PEM private key. Refuse." >&2
    exit 1
  fi
fi

# --- Default: allow ---
exit 0

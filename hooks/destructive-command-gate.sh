#!/usr/bin/env bash
# Destructive Command Gate — PreToolUse hook for the Bash tool
#
# Blocks high-risk shell operations unless an approved escape hatch is present.
# Mirrors the protections already inlined into settings.json under "PreToolUse"
# (force push detection, recursive delete on system paths) and adds a few more.
#
# Status: NOT YET WIRED INTO settings.json. Wire only with explicit user approval —
# see docs/SECURITY.md § "Enabling extracted hooks".
#
# Exit codes:
#   0 — allow
#   1 — warn (logged, but tool proceeds)
#   2 — block (Claude must abandon or rework the command)

set -euo pipefail

AUDIT_LOG="${HOME}/.claude/audit.log"
TS="$(date '+%Y-%m-%d %H:%M:%S')"
TOOL_INPUT="${TOOL_INPUT:-}"

mkdir -p "$(dirname "$AUDIT_LOG")"
touch "$AUDIT_LOG"

log_audit() {
  local level="$1"; shift
  echo "[${TS}] DESTRUCTIVE_GATE ${level}: $*" >> "$AUDIT_LOG"
}

# Helper — match against patterns; skip lookups when input is empty
match() {
  local pattern="$1"
  [[ -z "$TOOL_INPUT" ]] && return 1
  echo "$TOOL_INPUT" | grep -qE "$pattern"
}

# --- Block: rm -rf on protected paths ---
if match 'rm[[:space:]]+(-[rRf]+|-rf|-fr|--recursive|--force).*((/|~|\$HOME|\$\{HOME\}|/usr|/etc|/var|/bin|/sbin|/System|/Applications)([[:space:]]|$))'; then
  log_audit BLOCK "rm -rf on protected path"
  echo "BLOCKED: recursive delete on a protected system path. Review manually." >&2
  exit 2
fi

# --- Block: git push --force on a published branch (without --force-with-lease) ---
if match 'git[[:space:]]+push.*(-f|--force)([[:space:]]|$)' && ! match 'force-with-lease'; then
  log_audit BLOCK "git push --force without --force-with-lease"
  echo "BLOCKED: force push detected. Use --force-with-lease or get explicit approval." >&2
  exit 2
fi

# --- Block: git reset --hard on origin/main / origin/master ---
if match 'git[[:space:]]+reset[[:space:]]+--hard[[:space:]]+origin/(main|master|production|prod)'; then
  log_audit BLOCK "git reset --hard on protected upstream branch"
  echo "BLOCKED: hard reset on protected upstream branch. Confirm intent explicitly." >&2
  exit 2
fi

# --- Block: dropping primary database / production tables (rough heuristic) ---
if match 'DROP[[:space:]]+(DATABASE|TABLE)[[:space:]]+.*(prod|production|main|primary)'; then
  log_audit BLOCK "DROP on production-named entity"
  echo "BLOCKED: DROP on production-named entity. Confirm explicitly." >&2
  exit 2
fi

# --- Warn: chmod 777 ---
if match 'chmod[[:space:]]+(-R[[:space:]]+)?777'; then
  log_audit WARN "chmod 777 (overly permissive)"
  echo "WARN: chmod 777 makes files world-writable. Prefer 755 (executables) or 644 (data)." >&2
  exit 1
fi

# --- Warn: piping curl/wget straight into a shell ---
if match '(curl|wget)[[:space:]]+.*\|[[:space:]]*(sh|bash|zsh|fish)([[:space:]]|$)'; then
  log_audit WARN "curl|sh-style remote execution"
  echo "WARN: piping curl/wget into a shell executes untrusted code. Confirm the source URL and consider downloading first." >&2
  exit 1
fi

# --- Warn: sudo (Claude should very rarely need elevated privileges) ---
if match '^sudo[[:space:]]'; then
  log_audit WARN "sudo requested"
  echo "WARN: sudo invoked. Confirm necessity — most tasks should not require elevated privileges." >&2
  exit 1
fi

# --- Default: allow ---
exit 0

#!/usr/bin/env bash
# Validation Summary Hook — runs after a meaningful work session
#
# Surfaces validation gaps so the operator can spot "claimed done but not verified"
# without manually inspecting tool outputs. Runs from SubagentStop / Stop.
#
# Status: NOT YET WIRED INTO settings.json. Wire only with explicit user approval —
# see docs/SECURITY.md § "Enabling extracted hooks".
#
# Output is informational. Always exits 0.

set -euo pipefail

AUDIT_LOG="${HOME}/.claude/audit.log"
TS="$(date '+%Y-%m-%d %H:%M:%S')"
USAGE_LOG="${HOME}/.claude/usage.jsonl"

mkdir -p "$(dirname "$AUDIT_LOG")"
touch "$AUDIT_LOG"

# --- Only run if a session actually did meaningful work ---
# Heuristic: at least 5 Write/Edit calls in the last 60 minutes
if [[ ! -f "$USAGE_LOG" ]]; then
  exit 0
fi

# Count recent writes (last 60 min); be defensive — usage.jsonl format may vary
RECENT_WRITES=$(tail -500 "$USAGE_LOG" 2>/dev/null \
  | grep -E '"tool"[[:space:]]*:[[:space:]]*"(Write|Edit)"' \
  | wc -l \
  | tr -d ' ')

if [[ "$RECENT_WRITES" -lt 5 ]]; then
  exit 0
fi

# --- Inspect: were tests run? ---
RECENT_TESTS=$(tail -500 "$USAGE_LOG" 2>/dev/null \
  | grep -cE '"command"[[:space:]]*:[[:space:]]*"[^"]*\b(pytest|jest|vitest|go test|cargo test|npm test|yarn test|make test|uv run pytest)\b' \
  || echo 0)

# --- Inspect: was build / type-check run? ---
RECENT_BUILDS=$(tail -500 "$USAGE_LOG" 2>/dev/null \
  | grep -cE '"command"[[:space:]]*:[[:space:]]*"[^"]*\b(tsc|ruff|pyright|mypy|eslint|biome|cargo build|go build|npm run build|make build)\b' \
  || echo 0)

# --- Inspect: did we touch python/ts files? ---
TOUCHED_PY=$(tail -500 "$USAGE_LOG" 2>/dev/null | grep -cE '\.py"' || echo 0)
TOUCHED_TS=$(tail -500 "$USAGE_LOG" 2>/dev/null | grep -cE '\.tsx?"' || echo 0)

# --- Output the summary ---
SUMMARY=""
if [[ "$RECENT_TESTS" -eq 0 ]]; then
  SUMMARY+="• No test commands run this session. "
fi
if [[ "$RECENT_BUILDS" -eq 0 ]] && [[ "$TOUCHED_PY" -gt 0 || "$TOUCHED_TS" -gt 0 ]]; then
  SUMMARY+="• No type-check/lint run despite touching typed source files. "
fi

if [[ -n "$SUMMARY" ]]; then
  echo "VALIDATION GAPS: $SUMMARY" >&2
  echo "[${TS}] VALIDATION_GAPS writes=${RECENT_WRITES} tests=${RECENT_TESTS} builds=${RECENT_BUILDS}" >> "$AUDIT_LOG"
fi

exit 0

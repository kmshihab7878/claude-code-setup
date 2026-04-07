#!/bin/bash
# KhaledPowers Stop Verification Hook
# Runs on Stop/SubagentStop — quality gate before Claude finishes.
# Inspired by altmemy/claude-code-templates stop-verification pattern.
# Exit 2 = block stopping (critical issues found)
# Exit 0 = allow stopping

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"
ISSUES=""

# ── Python: Ruff Check ──
if [ -f "$PROJECT_DIR/pyproject.toml" ] || [ -f "$PROJECT_DIR/ruff.toml" ]; then
  if command -v ruff &> /dev/null; then
    RUFF_OUT=$(ruff check "$PROJECT_DIR" --quiet 2>&1 | head -5)
    if [ -n "$RUFF_OUT" ]; then
      ISSUES="${ISSUES}Ruff found issues:\n${RUFF_OUT}\n\n"
    fi
  fi
fi

# ── TypeScript: Type Check ──
if [ -f "$PROJECT_DIR/tsconfig.json" ] && [ -d "$PROJECT_DIR/node_modules" ]; then
  if [ -f "$PROJECT_DIR/node_modules/.bin/tsc" ]; then
    TSC_OUT=$(cd "$PROJECT_DIR" && npx tsc --noEmit --pretty false 2>&1 | head -10)
    TSC_EXIT=$?
    if [ $TSC_EXIT -ne 0 ]; then
      ISSUES="${ISSUES}TypeScript errors:\n${TSC_OUT}\n\n"
    fi
  fi
fi

# ── Uncommitted Changes Warning ──
if command -v git &> /dev/null && git -C "$PROJECT_DIR" rev-parse --is-inside-work-tree &> /dev/null 2>&1; then
  CHANGED=$(git -C "$PROJECT_DIR" status --short 2>/dev/null | wc -l | tr -d ' ')
  if [ "$CHANGED" -gt 0 ]; then
    ISSUES="${ISSUES}${CHANGED} uncommitted file(s) — consider committing or stashing.\n\n"
  fi
fi

# ── Output ──
if [ -n "$ISSUES" ]; then
  echo "## Pre-Stop Verification"
  echo ""
  echo -e "$ISSUES"
  echo "Fix these before considering the work complete."
  # Note: Using exit 0 to warn but not block. Change to exit 2 to hard-block.
  exit 0
fi

exit 0

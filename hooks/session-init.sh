#!/bin/bash
# KhaledPowers Session Init Hook
# Runs on SessionStart — outputs rich project context into the conversation.
# Inspired by altmemy/claude-code-templates session-context pattern.

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"

echo "## Session Context"
echo ""

# ── Time & Identity ──
echo "**Date:** $(date '+%Y-%m-%d %H:%M %Z')"
echo ""

# ── Git Info ──
if command -v git &> /dev/null && git -C "$PROJECT_DIR" rev-parse --is-inside-work-tree &> /dev/null 2>&1; then
  BRANCH=$(git -C "$PROJECT_DIR" rev-parse --abbrev-ref HEAD 2>/dev/null)
  CHANGED=$(git -C "$PROJECT_DIR" status --short 2>/dev/null | wc -l | tr -d ' ')
  LAST_COMMIT=$(git -C "$PROJECT_DIR" log --oneline -1 2>/dev/null)
  REMOTE=$(git -C "$PROJECT_DIR" remote get-url origin 2>/dev/null | sed 's/.*github.com[:/]\(.*\)\.git/\1/' | sed 's/.*github.com[:/]\(.*\)/\1/')

  echo "**Git Branch:** \`${BRANCH}\`"
  [ -n "$REMOTE" ] && echo "**Repo:** ${REMOTE}"
  echo "**Uncommitted:** ${CHANGED} files"
  echo "**Last Commit:** ${LAST_COMMIT}"
  echo ""
fi

# ── Project Detection ──
PROJECT_NAME=""
if [ -f "$PROJECT_DIR/pyproject.toml" ]; then
  PROJECT_NAME=$(grep -m1 '^name' "$PROJECT_DIR/pyproject.toml" 2>/dev/null | sed 's/name.*=.*"\(.*\)"/\1/')
  echo "**Project:** ${PROJECT_NAME} (Python)"
elif [ -f "$PROJECT_DIR/package.json" ]; then
  PROJECT_NAME=$(python3 -c "import json; print(json.load(open('$PROJECT_DIR/package.json')).get('name',''))" 2>/dev/null)
  echo "**Project:** ${PROJECT_NAME} (Node.js)"
elif [ -f "$PROJECT_DIR/pubspec.yaml" ]; then
  PROJECT_NAME=$(grep -m1 '^name:' "$PROJECT_DIR/pubspec.yaml" 2>/dev/null | awk '{print $2}')
  echo "**Project:** ${PROJECT_NAME} (Flutter)"
elif [ -f "$PROJECT_DIR/Cargo.toml" ]; then
  PROJECT_NAME=$(grep -m1 '^name' "$PROJECT_DIR/Cargo.toml" 2>/dev/null | sed 's/name.*=.*"\(.*\)"/\1/')
  echo "**Project:** ${PROJECT_NAME} (Rust)"
fi

# ── Stack Detection ──
STACK=""
[ -f "$PROJECT_DIR/pyproject.toml" ] && STACK="${STACK}Python "
[ -f "$PROJECT_DIR/package.json" ] && STACK="${STACK}Node "
[ -f "$PROJECT_DIR/tsconfig.json" ] && STACK="${STACK}TypeScript "
[ -f "$PROJECT_DIR/next.config.ts" ] || [ -f "$PROJECT_DIR/next.config.js" ] || [ -f "$PROJECT_DIR/next.config.mjs" ] && STACK="${STACK}Next.js "
[ -f "$PROJECT_DIR/docker-compose.yml" ] || [ -f "$PROJECT_DIR/docker-compose.yaml" ] && STACK="${STACK}Docker "
[ -f "$PROJECT_DIR/Dockerfile" ] && STACK="${STACK}Docker "
[ -d "$PROJECT_DIR/terraform" ] || [ -f "$PROJECT_DIR/main.tf" ] && STACK="${STACK}Terraform "
[ -f "$PROJECT_DIR/justfile" ] && STACK="${STACK}Just "
[ -f "$PROJECT_DIR/alembic.ini" ] && STACK="${STACK}Alembic "
[ -f "$PROJECT_DIR/pubspec.yaml" ] && STACK="${STACK}Flutter "

if [ -n "$STACK" ]; then
  echo "**Stack:** ${STACK}"
  echo ""
fi

# ── Environment Check ──
ENVS=""
command -v python3 &> /dev/null && ENVS="${ENVS}Python:$(python3 --version 2>&1 | awk '{print $2}') "
command -v node &> /dev/null && ENVS="${ENVS}Node:$(node --version 2>&1) "
command -v docker &> /dev/null && docker info &> /dev/null 2>&1 && ENVS="${ENVS}Docker:running "
command -v ruff &> /dev/null && ENVS="${ENVS}Ruff:yes "

if [ -n "$ENVS" ]; then
  echo "**Environment:** ${ENVS}"
  echo ""
fi

# ── Dependency Status ──
if [ -f "$PROJECT_DIR/package.json" ] && [ ! -d "$PROJECT_DIR/node_modules" ]; then
  echo "**Warning:** node_modules not found — run \`npm install\`"
fi
if [ -f "$PROJECT_DIR/pyproject.toml" ] && [ ! -d "$PROJECT_DIR/.venv" ] && [ -z "$VIRTUAL_ENV" ]; then
  echo "**Warning:** No Python venv active — check your environment"
fi

# ── Persistent Tasks ──
# Adjust this path: replace <YOUR_USER> with your macOS username
TASKS_FILE="${HOME}/.claude/projects/-Users-${USER}/memory/persistent-tasks.md"
if [ -f "$TASKS_FILE" ]; then
  OPEN_TASKS=$(grep -c '^\- \[' "$TASKS_FILE" 2>/dev/null || true)
  OPEN_TASKS=${OPEN_TASKS:-0}
  OPEN_TASKS=$(echo "$OPEN_TASKS" | tr -d '[:space:]')
  if [ "$OPEN_TASKS" -gt 0 ] 2>/dev/null; then
    echo "**Persistent Tasks:** ${OPEN_TASKS} tracked (check memory)"
  fi
fi

# ── Project CLAUDE.md ──
if [ -f "$PROJECT_DIR/CLAUDE.md" ]; then
  echo "**Project CLAUDE.md:** found"
elif [ -f "$PROJECT_DIR/.claude/CLAUDE.md" ]; then
  echo "**Project CLAUDE.md:** found (in .claude/)"
fi

# ── Session Metrics ──
METRICS_DIR="${HOME}/.claude/metrics"
TODAY=$(date '+%Y-%m-%d')
if [ -f "${METRICS_DIR}/${TODAY}.log" ]; then
  TOOL_COUNT=$(wc -l < "${METRICS_DIR}/${TODAY}.log" | tr -d ' ')
  echo "**Today's Tool Calls:** ${TOOL_COUNT}"
fi

echo ""
echo "---"
exit 0

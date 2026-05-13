#!/usr/bin/env bash
# Read-only local environment and repository doctor.

set -uo pipefail

PASS=0
WARN=0
FAIL=0

pass() { printf "PASS %s\n" "$*"; PASS=$((PASS + 1)); }
warn() { printf "WARN %s\n" "$*"; WARN=$((WARN + 1)); }
fail() { printf "FAIL %s\n" "$*"; FAIL=$((FAIL + 1)); }
section() { printf "\n== %s ==\n" "$*"; }

have() {
  command -v "$1" >/dev/null 2>&1
}

check_tool() {
  tool="$1"
  status="$2"
  if have "$tool"; then
    pass "$tool installed"
  elif [ "$status" = "required" ]; then
    fail "$tool missing"
  else
    warn "$tool missing (optional)"
  fi
}

if have git && git rev-parse --show-toplevel >/dev/null 2>&1; then
  REPO_ROOT="$(git rev-parse --show-toplevel)"
else
  REPO_ROOT="$(pwd)"
fi
cd "$REPO_ROOT" || exit 1

section "Tools"
check_tool git required
check_tool bash required
check_tool python3 required
check_tool gh optional
check_tool gitleaks optional
check_tool trivy optional
check_tool claude optional

section "Required scripts"
check_script() {
  path="$1"
  if [ ! -f "$path" ]; then
    fail "$path missing"
  elif [ -x "$path" ]; then
    pass "$path executable"
  elif [ -r "$path" ]; then
    pass "$path runnable with bash"
  else
    fail "$path not readable"
  fi
}

check_script scripts/validate.sh
check_script scripts/check-public-safety.sh
check_script scripts/audit-public-readiness.sh

section "Required docs"
check_file() {
  path="$1"
  if [ -f "$path" ]; then
    pass "$path exists"
  else
    fail "$path missing"
  fi
}

check_file README.md
check_file CLAUDE.md
check_file AGENTS.md
check_file docs/SETUP.md
check_file docs/SECURITY.md
check_file docs/PUBLICATION_CHECKLIST.md
check_file docs/TROUBLESHOOTING.md
check_file CONTRIBUTING.md
check_file .env.example

section "Repository hygiene"
if have git && git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  TRACKED_ENV=""
  while IFS= read -r path; do
    base="${path##*/}"
    case "$base" in
      .env|*.env|.env.*)
        [ "$base" = ".env.example" ] && continue
        TRACKED_ENV="${TRACKED_ENV}${path}
"
        ;;
    esac
  done < <(git ls-files)

  if [ -z "$TRACKED_ENV" ]; then
    pass "no tracked .env files"
  else
    fail "tracked .env files present"
    printf "%s" "$TRACKED_ENV" | sed 's/^/  /'
  fi

  TRACKED_DS="$(git ls-files | grep -E '(^|/)\.DS_Store$' || true)"
  if [ -z "$TRACKED_DS" ]; then
    pass "no tracked .DS_Store files"
  else
    fail "tracked .DS_Store files present"
    printf "%s\n" "$TRACKED_DS" | sed 's/^/  /'
  fi
else
  fail "not inside a git worktree"
fi

DS_ON_DISK="$(find . -path ./.git -prune -o -name .DS_Store -print 2>/dev/null | head -10)"
if [ -z "$DS_ON_DISK" ]; then
  pass "no .DS_Store files on disk"
else
  warn ".DS_Store files on disk"
  printf "%s\n" "$DS_ON_DISK" | sed 's/^/  /'
fi

section "Git state"
if have git && git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  BRANCH="$(git branch --show-current 2>/dev/null || true)"
  if [ -n "$BRANCH" ]; then
    pass "current branch: $BRANCH"
  else
    warn "detached HEAD or branch unavailable"
  fi

  STATUS="$(git status --short 2>/dev/null || true)"
  if [ -z "$STATUS" ]; then
    pass "working tree clean"
  else
    warn "working tree has uncommitted changes"
    printf "%s\n" "$STATUS" | sed 's/^/  /'
  fi

  if git remote get-url origin >/dev/null 2>&1; then
    pass "remote origin configured"
  else
    warn "remote origin not configured"
  fi

  if [ "$BRANCH" = "main" ]; then
    UPSTREAM="$(git rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null || true)"
    if [ "$UPSTREAM" = "origin/main" ]; then
      pass "main tracks origin/main"
    else
      warn "main does not track origin/main"
    fi
  else
    pass "main upstream check skipped on branch $BRANCH"
  fi
fi

section "Summary"
printf "pass=%d warn=%d fail=%d\n" "$PASS" "$WARN" "$FAIL"

[ "$FAIL" -eq 0 ] || exit 1
exit 0

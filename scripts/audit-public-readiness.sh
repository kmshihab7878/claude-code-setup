#!/usr/bin/env bash
# Orchestrator: runs every check that gates a public-safe state.
# Designed to be re-runnable, fail fast, and produce a single PASS/FAIL summary
# at the end. Each section is independently rerunnable.
#
# Usage:
#   bash scripts/audit-public-readiness.sh [--quick]
#
#   --quick  Skip the cross-history blob grep (the slowest check).

set -uo pipefail

QUICK=0
[[ "${1:-}" == "--quick" ]] && QUICK=1

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$ROOT"

PASS=0
FAIL=0
WARN=0

ok()    { echo "  PASS  $*"; PASS=$((PASS+1)); }
bad()   { echo "  FAIL  $*"; FAIL=$((FAIL+1)); }
warn()  { echo "  WARN  $*"; WARN=$((WARN+1)); }
section() { echo; echo "== $* =="; }

# -----------------------------------------------------------------------------
section "Working tree state"
if [[ -z "$(git status --short)" ]]; then
  ok "clean working tree"
else
  warn "uncommitted changes present (expected if you're iterating)"
fi

# -----------------------------------------------------------------------------
section "Public-safety banned-term check"
if bash scripts/check-public-safety.sh >/dev/null 2>&1; then
  ok "scripts/check-public-safety.sh"
else
  bad "scripts/check-public-safety.sh (run it directly for detail)"
fi

# -----------------------------------------------------------------------------
section "Free-form leak grep (forward tree)"
LEAK_RE='[k]haled|[s]hihab|[k]mshihab|[J]ARVIS|[j]arvis|[k]haledpowers|[s]hihab-task|[M]acBook'
if git grep -nEi -- "$LEAK_RE" ':!.gitignore' ':!scripts/check-public-safety.sh' \
     ':!scripts/audit-public-readiness.sh' >/dev/null 2>&1; then
  bad "banned terms detected in tracked files (see git grep)"
else
  ok "no banned terms in tracked files"
fi

# /Users/ path leaks excluding known placeholders
USERS_RE='/Users/[a-z]+'
USERS_HITS=$(git grep -nE -- "$USERS_RE" ':!.gitignore' ':!scripts/check-public-safety.sh' \
                ':!scripts/audit-public-readiness.sh' 2>/dev/null \
              | grep -viE '/Users/me|/Users/<|/Users/redacted-username' || true)
if [[ -z "$USERS_HITS" ]]; then
  ok "no /Users/<real-name> path leaks"
else
  bad "/Users/<name> path present:"
  echo "$USERS_HITS" | head -5 | sed 's/^/        /'
fi

# -----------------------------------------------------------------------------
section "Untracked artifacts that should never appear"
DS_HITS=$(find . -path ./.git -prune -o -name ".DS_Store" -print 2>/dev/null | head -10)
if [[ -z "$DS_HITS" ]]; then
  ok "no .DS_Store on disk"
else
  warn ".DS_Store on disk (gitignored, just delete them)"
  echo "$DS_HITS" | sed 's/^/        /'
fi

ENV_HITS=$(find . -path ./.git -prune -o -name "*.env" -not -name "*.env.example" -print 2>/dev/null | head -5)
if [[ -z "$ENV_HITS" ]]; then
  ok "no *.env on disk (other than .env.example)"
else
  bad "real *.env file present:"
  echo "$ENV_HITS" | sed 's/^/        /'
fi

# -----------------------------------------------------------------------------
section "Secret detection (working tree + history)"
if command -v gitleaks >/dev/null 2>&1; then
  if gitleaks detect --no-banner --redact --source . >/dev/null 2>&1; then
    ok "gitleaks (working tree)"
  else
    bad "gitleaks reports leaks (working tree)"
  fi
  if gitleaks detect --no-banner --redact >/dev/null 2>&1; then
    ok "gitleaks (history)"
  else
    bad "gitleaks reports leaks (history)"
  fi
else
  warn "gitleaks not installed — skipping (install via brew install gitleaks)"
fi

if command -v trivy >/dev/null 2>&1; then
  if trivy fs --scanners secret --quiet --no-progress . 2>&1 | grep -qE '^.*✗|HIGH|CRITICAL' ; then
    bad "trivy reports findings"
  else
    ok "trivy secret scan"
  fi
else
  warn "trivy not installed — skipping (install via brew install trivy)"
fi

# -----------------------------------------------------------------------------
section "Validation suite"
if bash scripts/validate.sh 2>&1 | tail -1 | grep -q 'fail=0'; then
  ok "scripts/validate.sh (fail=0)"
else
  bad "scripts/validate.sh has failures"
fi

# -----------------------------------------------------------------------------
section "Broken-rename refs (post-scrub safety)"
# Pattern uses [j]arvis-style character-class wrappers so this script does
# not trip its own banned-term check (same trick as check-public-safety.sh).
STALE=$(git grep -lE \
  "skills/[j]arvis-core|skills/[j]arvis-sec|skills/understand-[j]arvis|skills/using-[k]haledpowers|commands/[j]arvis-sec\\.md" \
  ':!.gitignore' ':!scripts/check-public-safety.sh' ':!scripts/audit-public-readiness.sh' 2>/dev/null || true)
if [[ -z "$STALE" ]]; then
  ok "no references to pre-scrub paths"
else
  bad "references to pre-scrub paths detected:"
  echo "$STALE" | sed 's/^/        /'
fi

# -----------------------------------------------------------------------------
if [[ $QUICK -eq 0 ]]; then
  section "History blob grep (slow — pass --quick to skip)"
  if [[ "$(git rev-list --all | wc -l | tr -d ' ')" -gt 0 ]]; then
    # Excluding local backup tags created by the scrub process; their entire
    # purpose is to preserve pre-rewrite state. If those tags are the only
    # thing keeping leaks reachable, this is a WARN (delete tags to clear),
    # not a FAIL.
    LIVE_REFS=$(git for-each-ref --format='%(refname)' \
      | grep -vE '^refs/tags/(pre-public-scrub|pre-handle-rewrite)-' || true)
    LIVE_COMMITS=$(echo "$LIVE_REFS" | xargs -I{} git rev-list {} 2>/dev/null | sort -u || true)

    if [[ -z "$LIVE_COMMITS" ]]; then
      ok "no live refs to scan"
    else
      # Exclude gate machinery / docs about the gate from the history scan.
      # These files legitimately reference the patterns they're protecting
      # against and would self-match; the forward-tree gate excludes them
      # for the same reason.
      HISTORY_HITS=$(echo "$LIVE_COMMITS" \
        | xargs git grep -nEi -- "$LEAK_RE" \
            ':!scripts/audit-public-readiness.sh' \
            ':!scripts/check-public-safety.sh' \
            ':!docs/PUBLICATION_CHECKLIST.md' \
            ':!.github/workflows/public-safety.yml' \
            2>/dev/null | head -1 || true)
      if [[ -z "$HISTORY_HITS" ]]; then
        ok "no banned terms in history blobs (excluding gate machinery)"
      else
        bad "banned terms in history blobs reachable from non-backup refs"
      fi
    fi

    # Backup-tag advisory
    BACKUP_TAGS=$(git tag | grep -E '^(pre-public-scrub|pre-handle-rewrite)-' || true)
    if [[ -n "$BACKUP_TAGS" ]]; then
      warn "backup tags retain pre-scrub commits locally — delete when confident:"
      echo "$BACKUP_TAGS" | sed 's/^/        /'
      echo "        (git tag -d <tagname> && git reflog expire --expire=now --all && git gc --prune=now)"
    fi
  fi
fi

# -----------------------------------------------------------------------------
echo
echo "================================================================"
printf "Summary:  pass=%d  warn=%d  fail=%d\n" "$PASS" "$WARN" "$FAIL"
echo "================================================================"

[[ $FAIL -eq 0 ]] && exit 0 || exit 1

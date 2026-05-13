#!/usr/bin/env bash
# Public-safety banned-term check.
# Fails CI if personally-identifying or private-project terms reappear in tracked files.
# Exclusions: the .gitignore (intentionally lists patterns) and this script itself.
set -euo pipefail

BANNED_PATTERNS=(
  'operator'
  'contributor'
  'kmcontributor'
  'contributor'
  'operating-framework'
  'Operating Framework'
  'CoreMind'
  'CoreMind'
  '[redacted-AI-surface]'
  'contributor-task'
)

EXCLUDE_PATHSPEC=(
  ':!.gitignore'
  ':!scripts/check-public-safety.sh'
)

EXIT=0
for pattern in "${BANNED_PATTERNS[@]}"; do
  if git grep -InE -- "$pattern" "${EXCLUDE_PATHSPEC[@]}" >/dev/null 2>&1; then
    echo "FAIL: banned pattern present: $pattern"
    git grep -InE -- "$pattern" "${EXCLUDE_PATHSPEC[@]}" | head -5
    EXIT=1
  fi
done

# Lowercase coremind catch (file-path references)
if git grep -InE -- 'coremind' "${EXCLUDE_PATHSPEC[@]}" >/dev/null 2>&1; then
  echo "FAIL: lowercase 'coremind' present"
  git grep -InE -- 'coremind' "${EXCLUDE_PATHSPEC[@]}" | head -5
  EXIT=1
fi

# Loose email leakage (any *@gmail.com that isn't already a placeholder/example)
if git grep -InE -- '[A-Za-z0-9._+-]+@gmail\.com' "${EXCLUDE_PATHSPEC[@]}" | grep -viE 'example|placeholder|<.*>' >/dev/null 2>&1; then
  echo "FAIL: literal @gmail.com email present"
  git grep -InE -- '[A-Za-z0-9._+-]+@gmail\.com' "${EXCLUDE_PATHSPEC[@]}" | grep -viE 'example|placeholder|<.*>' | head -5
  EXIT=1
fi

if [[ $EXIT -eq 0 ]]; then
  echo "Public-safety check passed."
fi
exit $EXIT

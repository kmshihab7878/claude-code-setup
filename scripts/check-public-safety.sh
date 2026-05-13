#!/usr/bin/env bash
# Public-safety banned-term check.
# Fails CI if personally-identifying or private-project terms reappear in tracked files.
#
# Patterns use a character-class wrapper trick (e.g. [k]haled matches "khaled"
# but the file itself contains [k]haled — so this script does not trigger
# its own check, and any future history rewrite that targets the raw
# literal won't silently neuter this gate.
#
# Exclusions: this script and .gitignore.
set -euo pipefail

BANNED_REGEX=(
  '[k]haled'
  '[K]haled'
  '[s]hihab'
  '[S]hihab'
  '[k]mshihab'
  '[k]haledshihab'
  '[k]haledpowers'
  '[K]haledPowers'
  '[J]ARVIS'
  '[J]arvis'
  '[j]arvis'
  '[r]edacted-AI-surface'
  '[s]hihab-task'
)

EXCLUDE_PATHSPEC=(
  ':!.gitignore'
  ':!scripts/check-public-safety.sh'
  ':!scripts/audit-public-readiness.sh'
  ':!docs/PUBLICATION_CHECKLIST.md'
  ':!.github/workflows/public-safety.yml'
)

EXIT=0
for pattern in "${BANNED_REGEX[@]}"; do
  if git grep -InE -- "$pattern" "${EXCLUDE_PATHSPEC[@]}" >/dev/null 2>&1; then
    echo "FAIL: banned pattern present: $pattern"
    git grep -InE -- "$pattern" "${EXCLUDE_PATHSPEC[@]}" | head -5
    EXIT=1
  fi
done

# Literal @gmail.com email leakage (skip placeholders/examples)
if git grep -InE -- '[A-Za-z0-9._+-]+@gmail\.com' "${EXCLUDE_PATHSPEC[@]}" | grep -viE 'example|placeholder|<.*>' >/dev/null 2>&1; then
  echo "FAIL: literal @gmail.com email present"
  git grep -InE -- '[A-Za-z0-9._+-]+@gmail\.com' "${EXCLUDE_PATHSPEC[@]}" | grep -viE 'example|placeholder|<.*>' | head -5
  EXIT=1
fi

if [[ $EXIT -eq 0 ]]; then
  echo "Public-safety check passed."
fi
exit $EXIT

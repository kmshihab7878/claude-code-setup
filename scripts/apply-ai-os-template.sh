#!/usr/bin/env bash
# apply-ai-os-template.sh — Copy the AI OS template into a target project repo.
#
# Default: dry-run. Print every planned change. Touch nothing.
# With --apply: actually copy files. Refuses to overwrite CLAUDE.md.
# With --allow-dirty: proceed even if the target repo has uncommitted changes (dangerous).
#
# Usage:
#   scripts/apply-ai-os-template.sh /path/to/target/repo                 # dry-run
#   scripts/apply-ai-os-template.sh /path/to/target/repo --apply         # apply
#   scripts/apply-ai-os-template.sh /path/to/target/repo --apply --allow-dirty
#
# Source: $REPO_ROOT/templates/ai-engineering-os/
# Refusal: never copies CLAUDE.md (creates CLAUDE.addendum.md instead, expects user to merge)
# Refusal: never copies anything resembling secrets

set -euo pipefail

# --- Arg parsing ---
TARGET=""
APPLY=false
ALLOW_DIRTY=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --apply) APPLY=true; shift ;;
    --allow-dirty) ALLOW_DIRTY=true; shift ;;
    --help|-h)
      sed -n '2,17p' "$0"
      exit 0
      ;;
    *)
      if [[ -z "$TARGET" ]]; then
        TARGET="$1"
      else
        echo "ERROR: unexpected argument: $1" >&2
        exit 2
      fi
      shift
      ;;
  esac
done

if [[ -z "$TARGET" ]]; then
  echo "ERROR: target repo path required." >&2
  echo "Usage: $0 /path/to/target/repo [--apply] [--allow-dirty]" >&2
  exit 2
fi

# --- Resolve paths ---
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TEMPLATE_DIR="$REPO_ROOT/templates/ai-engineering-os"
TARGET_ABS="$(cd "$TARGET" 2>/dev/null && pwd || echo "")"

if [[ -z "$TARGET_ABS" ]]; then
  echo "ERROR: target path does not exist: $TARGET" >&2
  exit 2
fi

if [[ ! -d "$TEMPLATE_DIR" ]]; then
  echo "ERROR: template directory not found: $TEMPLATE_DIR" >&2
  exit 2
fi

if [[ "$TARGET_ABS" == "$REPO_ROOT" ]]; then
  echo "ERROR: refusing to apply template to the source repo itself." >&2
  exit 2
fi

# --- Dirty repo check ---
if [[ -d "$TARGET_ABS/.git" ]]; then
  cd "$TARGET_ABS"
  if [[ -n "$(git status --porcelain 2>/dev/null)" ]] && ! $ALLOW_DIRTY; then
    echo "ERROR: target repo has uncommitted changes." >&2
    echo "Either commit/stash first, or pass --allow-dirty (dangerous)." >&2
    exit 2
  fi
  cd - >/dev/null
fi

# --- Plan: enumerate every file in the template ---
echo "============================================================"
echo "AI OS Template Apply"
echo "  Source : $TEMPLATE_DIR"
echo "  Target : $TARGET_ABS"
echo "  Mode   : $([[ $APPLY == true ]] && echo APPLY || echo DRY-RUN)"
echo "============================================================"
echo

declare -a PLANNED_COPIES
declare -a SKIPPED

# Enumerate template files relative to template root
while IFS= read -r -d '' src; do
  rel="${src#$TEMPLATE_DIR/}"
  dst="$TARGET_ABS/$rel"

  # --- Refusals ---

  # Refuse to overwrite CLAUDE.md — use addendum instead
  if [[ "$rel" == "CLAUDE.md" ]]; then
    SKIPPED+=("CLAUDE.md (use CLAUDE.addendum.md and merge manually)")
    continue
  fi

  # Refuse to copy anything that looks like a secret
  case "$rel" in
    *.env|*.pem|*.key|*.p12|*credentials*|*secret*)
      SKIPPED+=("$rel (secret-like name)")
      continue
      ;;
  esac

  # Already exists in target — never overwrite, suggest merge
  if [[ -e "$dst" ]]; then
    SKIPPED+=("$rel (already exists in target — merge manually)")
    continue
  fi

  PLANNED_COPIES+=("$rel")
done < <(find "$TEMPLATE_DIR" -type f -not -path '*/\.git/*' -print0)

# --- Output the plan ---
if [[ ${#PLANNED_COPIES[@]} -eq 0 ]]; then
  echo "No new files to copy. (Either target already has them or all were filtered.)"
else
  echo "PLANNED COPIES (${#PLANNED_COPIES[@]} files):"
  for f in "${PLANNED_COPIES[@]}"; do
    echo "  + $f"
  done
fi

echo
if [[ ${#SKIPPED[@]} -gt 0 ]]; then
  echo "SKIPPED (${#SKIPPED[@]} files):"
  for f in "${SKIPPED[@]}"; do
    echo "  ! $f"
  done
fi

echo

# --- Apply ---
if ! $APPLY; then
  echo "DRY-RUN complete. Re-run with --apply to perform the copy."
  exit 0
fi

echo "Applying..."
COPIED=0
for rel in "${PLANNED_COPIES[@]}"; do
  src="$TEMPLATE_DIR/$rel"
  dst="$TARGET_ABS/$rel"
  mkdir -p "$(dirname "$dst")"
  cp "$src" "$dst"
  COPIED=$((COPIED + 1))
done

echo "Copied $COPIED files."
echo
echo "Manual next steps:"
echo "  1. Merge CLAUDE.addendum.md into the target's CLAUDE.md (if it has one)."
echo "  2. Edit context/About Me.md, About Business.md, Priorities.md (or run /onboard there)."
echo "  3. Populate connections.md Tier-4 rows from your tool stack."
echo "  4. Validate: run 'bash -n' on any new shell scripts copied."
echo "  5. Commit on a feature branch in the target."
exit 0

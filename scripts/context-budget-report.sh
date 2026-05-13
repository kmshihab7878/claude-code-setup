#!/usr/bin/env bash
# Read-only context budget report. Estimates tokens as characters / 4.

set -uo pipefail

PASS=0
WARN=0
FAIL=0

pass() { printf "PASS %s\n" "$*"; PASS=$((PASS + 1)); }
warn() { printf "WARN %s\n" "$*"; WARN=$((WARN + 1)); }
note() { printf "INFO %s\n" "$*"; }
section() { printf "\n== %s ==\n" "$*"; }

if git rev-parse --show-toplevel >/dev/null 2>&1; then
  REPO_ROOT="$(git rev-parse --show-toplevel)"
else
  REPO_ROOT="$(pwd)"
fi
cd "$REPO_ROOT" || exit 1

is_tracked() {
  git ls-files --cached --others --exclude-standard -- "$1" | grep -Fxq "$1"
}

chars_for() {
  wc -c < "$1" | tr -d ' '
}

lines_for() {
  wc -l < "$1" | tr -d ' '
}

tokens_for_chars() {
  awk -v c="$1" 'BEGIN { print int((c + 3) / 4) }'
}

tokens_for() {
  chars="$(chars_for "$1")"
  tokens_for_chars "$chars"
}

print_header() {
  printf "%-58s %8s %10s %10s\n" "file" "lines" "chars" "est_tokens"
}

print_file() {
  path="$1"
  if [ -f "$path" ] && is_tracked "$path"; then
    lines="$(lines_for "$path")"
    chars="$(chars_for "$path")"
    tokens="$(tokens_for_chars "$chars")"
    printf "%-58s %8s %10s %10s\n" "$path" "$lines" "$chars" "$tokens"
  fi
}

tracked_matching() {
  git ls-files --cached --others --exclude-standard | awk "$1"
}

largest_files() {
  limit="$1"
  shift
  for path in "$@"; do
    [ -f "$path" ] || continue
    is_tracked "$path" || continue
    chars="$(chars_for "$path")"
    tokens="$(tokens_for_chars "$chars")"
    lines="$(lines_for "$path")"
    printf "%d %d %d %s\n" "$tokens" "$chars" "$lines" "$path"
  done | sort -rn | head -n "$limit" | while read -r tokens chars lines path; do
    printf "%-58s %8d %10d %10d\n" "$path" "$lines" "$chars" "$tokens"
  done
}

warn_large_files() {
  threshold="$1"
  label="$2"
  shift 2
  count=0
  over_budget=""
  for path in "$@"; do
    [ -f "$path" ] || continue
    is_tracked "$path" || continue
    tokens="$(tokens_for "$path")"
    if [ "$tokens" -gt "$threshold" ]; then
      over_budget="${over_budget}${tokens} ${path}
"
      count=$((count + 1))
    fi
  done
  if [ "$count" -eq 0 ]; then
    pass "no $label files over ${threshold} est tokens"
  else
    warn "$count $label files over ${threshold} est tokens"
    printf "%s" "$over_budget" | sort -rn | head -5 | while read -r tokens path; do
      note "largest $label over budget: $path ($tokens est tokens)"
    done
  fi
}

section "Always-loaded candidates"
print_header
for path in CLAUDE.md AGENTS.md WARP.md settings.json; do
  print_file "$path"
done

if [ -f CLAUDE.md ]; then
  claude_tokens="$(tokens_for CLAUDE.md)"
  if [ "$claude_tokens" -gt 5000 ]; then
    warn "CLAUDE.md is above 5000 est tokens ($claude_tokens)"
  else
    pass "CLAUDE.md within 5000 est token budget ($claude_tokens)"
  fi
fi

for pointer in AGENTS.md WARP.md; do
  if [ -f "$pointer" ]; then
    pointer_tokens="$(tokens_for "$pointer")"
    if [ "$pointer_tokens" -gt 1000 ]; then
      warn "$pointer is above 1000 est tokens ($pointer_tokens)"
    else
      pass "$pointer within 1000 est token pointer budget ($pointer_tokens)"
    fi
  fi
done

section "Startup-injected candidates"
print_header
startup_files=""
for path in evolution/stable/global.md memory/MEMORY.md; do
  if [ -f "$path" ] && is_tracked "$path"; then
    startup_files="${startup_files}${path}
"
    print_file "$path"
  fi
done

if command -v python3 >/dev/null 2>&1 && [ -f settings.json ]; then
  hook_files="$(python3 - <<'PY'
import json
from pathlib import Path

try:
    data = json.loads(Path("settings.json").read_text())
except Exception:
    raise SystemExit

for entry in data.get("hooks", {}).get("SessionStart", []):
    for hook in entry.get("hooks", []):
        command = (hook.get("command") or "").strip()
        first = command.split()[0] if command.split() else ""
        if first.startswith("~/.claude/hooks/"):
            print("hooks/" + first.rsplit("/", 1)[-1])
PY
)"
  if [ -n "$hook_files" ]; then
    while IFS= read -r path; do
      [ -n "$path" ] || continue
      startup_files="${startup_files}${path}
"
      print_file "$path"
    done <<< "$hook_files"
  fi
else
  warn "python3 unavailable; skipped SessionStart hook discovery"
fi

if [ -f evolution/config.yaml ] && [ -f evolution/stable/global.md ]; then
  budget_chars="$(awk '/^startup_budget_chars:/ {print $2; exit}' evolution/config.yaml)"
  [ -n "$budget_chars" ] || budget_chars=4000
  global_chars="$(chars_for evolution/stable/global.md)"
  if [ "$global_chars" -gt "$budget_chars" ]; then
    warn "evolution/stable/global.md exceeds startup_budget_chars ($global_chars > $budget_chars)"
  else
    pass "evolution/stable/global.md within startup_budget_chars ($global_chars <= $budget_chars)"
  fi
fi

startup_tokens=0
while IFS= read -r path; do
  [ -n "$path" ] || continue
  [ -f "$path" ] || continue
  is_tracked "$path" || continue
  startup_tokens=$((startup_tokens + $(tokens_for "$path")))
done <<< "$startup_files"

if [ "$startup_tokens" -gt 4000 ]; then
  warn "startup-injected candidates exceed 4000 est tokens ($startup_tokens)"
else
  pass "startup-injected candidates within 4000 est tokens ($startup_tokens)"
fi

if grep -nE '"SessionStart"|"command"' settings.json 2>/dev/null | grep -q 'docs/'; then
  warn "docs appear in SessionStart hook configuration"
else
  pass "no docs files referenced by SessionStart hook configuration"
fi

section "Routing and index files"
print_header
routing_files="agents/REGISTRY.md"
while IFS= read -r path; do routing_files="${routing_files}
${path}"; done < <(tracked_matching '/^domains\/.*\/DOMAIN\.md$/ { print }')
while IFS= read -r path; do routing_files="${routing_files}
${path}"; done < <(tracked_matching '/^core\/[^\/]+\.md$/ { print }')
while IFS= read -r path; do
  [ -n "$path" ] || continue
  print_file "$path"
done <<< "$routing_files"

section "Heavy docs"
doc_files=()
while IFS= read -r path; do doc_files+=("$path"); done < <(tracked_matching '/^docs\/[^\/]+\.md$/ { print }')
print_header
largest_files 15 "${doc_files[@]}"
note "docs are ranked for awareness only; large docs do not fail this report"

section "Skills"
skill_files=()
while IFS= read -r path; do skill_files+=("$path"); done < <(tracked_matching '/^skills\/.*\/SKILL\.md$/ { print }')
note "SKILL.md count: ${#skill_files[@]}"
print_header
largest_files 15 "${skill_files[@]}"
warn_large_files 2000 "skill" "${skill_files[@]}"

section "Commands"
command_files=()
while IFS= read -r path; do command_files+=("$path"); done < <(tracked_matching '/^commands\/[^\/]+\.md$/ { print }')
note "top-level command count: ${#command_files[@]}"
print_header
largest_files 15 "${command_files[@]}"
warn_large_files 2000 "command" "${command_files[@]}"

section "Agents"
agent_files=()
while IFS= read -r path; do agent_files+=("$path"); done < <(tracked_matching '/^agents\/.*\.md$/ && $0 !~ /^agents\/(REGISTRY|README)\.md$/ { print }')
note "agent markdown count: ${#agent_files[@]}"
print_header
largest_files 15 "${agent_files[@]}"
warn_large_files 2000 "agent" "${agent_files[@]}"

section "Hooks"
hook_files_all=()
while IFS= read -r path; do
  [ -f "$path" ] || continue
  hook_files_all+=("$path")
done < <(tracked_matching '/^hooks\/[^\/]+$/ { print }')
note "hook script count: ${#hook_files_all[@]}"
print_header
largest_files 15 "${hook_files_all[@]}"

section "Next optimization targets"
print_header
combined=("${skill_files[@]}" "${command_files[@]}" "${agent_files[@]}" "${hook_files_all[@]}")
largest_files 10 "${combined[@]}"

section "Summary"
printf "pass=%d warn=%d fail=%d\n" "$PASS" "$WARN" "$FAIL"
exit 0

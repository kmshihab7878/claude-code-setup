#!/usr/bin/env bash
# Dashboard for the evolution layer. Read-only.
set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

enabled=$(grep -E '^enabled:' config.yaml | awk '{print $2}')
baseline="${CLAUDE_EVOLUTION_BASELINE:-0}"
budget=$(grep -E '^startup_budget_chars:' config.yaml | awk '{print $2}')

global_size=$(wc -c < stable/global.md 2>/dev/null | tr -d ' ')
project_files=$(ls stable/by-project/*.md 2>/dev/null | grep -v '\.gitkeep' | wc -l | tr -d ' ')
candidates=$(ls candidates/*.yaml 2>/dev/null | wc -l | tr -d ' ')
rejected=$(ls rejected/*.yaml 2>/dev/null | wc -l | tr -d ' ')
reports=$(ls reports/*.md 2>/dev/null | wc -l | tr -d ' ')
session_records=$(wc -l < records/sessions.jsonl 2>/dev/null | tr -d ' ' || echo 0)
correction_records=$(wc -l < records/corrections.jsonl 2>/dev/null | tr -d ' ' || echo 0)
outcome_records=$(wc -l < records/outcomes.jsonl 2>/dev/null | tr -d ' ' || echo 0)

kill="off"; [ "$enabled" = "true" ] || kill="ON (layer disabled)"
base="off"; [ "$baseline" = "1" ] && base="ON (this session only)"

cat <<EOF
== Evolution Layer Status ==
  enabled:          $enabled         (kill switch: $kill)
  baseline mode:    $base
  startup budget:   $budget chars
  stable/global.md: $global_size chars   ($([ "$global_size" -le "$budget" ] 2>/dev/null && echo "within budget" || echo "OVER BUDGET"))
  project stables:  $project_files file(s) in stable/by-project/
  candidates:       $candidates
  rejected:         $rejected
  reports:          $reports
  records:
    sessions:       $session_records
    corrections:    $correction_records
    outcomes:       $outcome_records

== Last 3 session records ==
EOF
tail -3 records/sessions.jsonl 2>/dev/null || echo "  (none yet — hook has not fired)"

echo
echo "Commands:  /evolution candidates · /evolution promotions · /evolution regressions · /evolution disable"

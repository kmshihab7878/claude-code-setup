# /metrics

> Show framework observability data — how the operating system is performing.

## Instructions

When invoked, analyze the metrics collected in `~/.claude/metrics/` and present
a framework health report.

### If metrics data exists

Read the current month's JSONL file from `~/.claude/metrics/YYYY-MM.jsonl` and
compute:

1. **Session Stats** — Total sessions, completions, abandonment rate
2. **Gate Compliance** — Gate blocks vs overrides, compliance percentage
3. **First-Pass Rate** — Sessions completed without rework cycles
4. **Evidence Rate** — Completions with evidence attached
5. **Artifact Completeness** — Required artifacts produced vs expected
6. **Top Skills** — Most frequently triggered skills (flag any that never triggered)
7. **Top Commands** — Most frequently invoked commands
8. **Risk Distribution** — T0/T1/T2/T3 breakdown
9. **Lane Distribution** — Explore/Specify/Build/Verify/Ship/Recover breakdown

### If no metrics data exists

Report that metrics collection has not started yet. Suggest:
- Running `~/.claude/scripts/metrics_collector.sh start` at session start
- Using `/start-task` which can auto-log session_start events
- Using `/complete` which can auto-log session_end events

### Benchmark Comparison

Compare actual metrics against framework targets:

| Metric | Target | Actual | Status |
|--------|--------|--------|--------|
| First-pass rate | > 85% | ? | |
| Gate compliance | 100% | ? | |
| Root cause accuracy | > 90% | ? | |
| Artifact completeness | 100% | ? | |
| Evidence attached | 100% | ? | |
| Regression rate | < 5% | ? | |

Flag any metric below target in red. Suggest specific improvements for
underperforming metrics.

### Optional Arguments

- `$ARGUMENTS` = specific month (e.g., `2026-03`) — show that month's data
- `$ARGUMENTS` = `all` — show all-time data across all months
- `$ARGUMENTS` = `compare` — compare last 2 months side by side

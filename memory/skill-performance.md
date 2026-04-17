# Skill Performance

_Per-skill usage + signal tracking. Populated by `scripts/analyze-usage.sh` after ≥7 days of `~/.claude/usage.jsonl` data; for now this file is the schema + a placeholder._

## Schema

For each actively-tracked skill:

```
### {skill-name}

- **Recent usage:** {count in last 14d}
- **Observed quality:** {notes — "worked well for X", "failed on Y"}
- **Context cost:** low | medium | high (body line count; low < 150, medium 150-400, high > 400)
- **Last refinement:** {date + commit} or "never"
- **Status:** core | supporting | experimental | archival
- **Pruning decision:** keep | review | archive — only set if truly unused AND low-value for extraction/positioning
```

## Active signals

_No telemetry data yet. Run `make usage` after 14 days of real `~/.claude/` sessions._

## Known-CORE skills (pre-telemetry, evidence-based via cross-refs)

From `docs/_audit-workspace/CROSSREF.md` §1 — most-referenced skills:

| Skill | Inbound | Status |
|-------|--------:|--------|
| `anti-ai-writing` | 63 | CORE — universal binder |
| `security-review` | 36 | CORE |
| `testing-methodology` | 29 | CORE |
| `test-driven-development` | 24 | CORE |
| `research-methodology` | 24 | CORE |
| `data-analysis` | 23 | CORE |
| `api-design-patterns` | 18 | CORE |
| `devops-patterns` | 18 | CORE |
| `frontend-design` | 18 | CORE (merge candidate per AUDIT §5.2) |
| `coding-workflow` | 17 | CORE |
| `production-monitoring` | 17 | CORE |
| `baseline-ui` | 16 | CORE |

## Pruning-candidate watchlist (≤1 strict inbound)

`paperclip-create-plugin`, `mirofish-prediction`, `session-bootstrap`, `quality-manager-qmr`, `hybrid-search-implementation`, `ultrathink` (self-referenced only), `para-memory-files`, `recall` (invoked via `/recall` slash but not as dep), `hermes-integration`, `graphql-architect`, `wshobson-sync-policies`, `goose-integration`, `pruning-view`, `b2c-app-strategist`.

**Do not archive without telemetry.** Each may carry extraction or positioning value that static cross-refs don't capture. See AUDIT §4.4 for extraction candidates.

## Do-not-archive (positioning value)

- `hue` — extraction candidate, 19 brand demos
- `mcp-mastery` — extraction candidate, 30-server catalog
- `ultrathink` — cognitive depth engine
- `jarvis-sec` — autonomous security ecosystem narrative
- `react-bits` — 130-component catalog extraction candidate
- `elite-ops` — headline differentiator
- Self-evolution family (`session-bootstrap`, `evidence-recorder`, `session-analyst`, `promotion-gate`, `pruning-view`, `skill-evolution`) — distinctive engineering story

# Surface Map — Canonical Entrypoints

When multiple commands/skills overlap, pick the **canonical** one. Specialized alternatives are listed below it. "Pending telemetry review" = kept because no invocation data exists yet to prove/disprove value.

## Implement something

| Intent | Canonical | Alternatives | Why canonical |
|--------|-----------|--------------|---------------|
| Build a complete feature | `/ship` | `/start-task`, `/sc:implement` | `/ship` has the strictest completion standard and enforces the Elite Ops protocol |
| Plan before building | `/plan` | `/ultraplan`, `/planUI`, `/spec` | `/plan` is the 10-stage governed default. Use `/ultraplan` only for enterprise-risk, cross-system tasks. `/planUI` is a UI-only sub-flow. |
| Fix a bug | `/fix-root` | `/debug` | `/fix-root` mandates root-cause + regression protection; `/debug` is looser. |

## Inspect something

| Intent | Canonical | Alternatives |
|--------|-----------|--------------|
| Full-stack audit | `/audit-deep` | `/sc:analyze`, `/repo-review`, `/setup-audit` |
| Security audit | `/security-audit` | `security-review` skill, `sc:analyze` (security flag) |
| Code review a diff | `/review` | `/sc:analyze` |

## Tighten UX / polish

| Intent | Canonical | Alternatives | Differentiation |
|--------|-----------|--------------|-----------------|
| UX-only polish pass | `/polish-ux` | `impeccable-polish` skill | `/polish-ux` covers copy + a11y + microstates; `impeccable-polish` is visual micro-detail only |
| Frontend design from scratch | `impeccable-design` skill | `frontend-design`, `interface-design`, `ui-ux-pro-max` | Other three are **pending telemetry review** — no evidence of distinct value yet |
| UI audit | `impeccable-audit` skill | `baseline-ui`, `interface-design-audit` | Other two are pending telemetry review |
| Brand-specific design system | `hue` skill | — | No overlap. `hue` is the only meta-skill for brand → generated design-language child skill |
| Component catalog install | `react-bits` skill | — | No overlap |

## Multi-perspective decision

| Intent | Canonical | Alternatives |
|--------|-----------|--------------|
| Strategic decision pressure-test | `/council` | `/sc:business-panel` |

## Knowledge / recall

| Intent | Canonical | Alternatives |
|--------|-----------|--------------|
| Ingest a raw file into KB | `/wiki-ingest` | — |
| Query the KB | `/wiki-query` | — |
| KB health check | `/wiki-lint` | — |
| Cross-session search | `/recall` | — |

## Pending telemetry review

Non-canonical surfaces in the tables above are kept, not archived. Archive decisions wait for 14+ days of `~/.claude/usage.jsonl` data (see [TELEMETRY.md](./TELEMETRY.md)). Zero-invocation items then move to `skills/_archive/`, `commands/_archive/`, `agents/_archive/`.

## Rule of thumb

If you cannot name a concrete difference between two surfaces in one sentence, the non-canonical one is a pruning candidate. File a deletion once telemetry confirms zero real-world usage.

# Evolution Layer

Controlled self-evolution for this Claude Code setup. Active in every session via a `SessionStart` hook. Records evidence, promotes repeated patterns to stable startup context, and stays out of your way otherwise.

## Directory map

| Path | Tracked in git? | Purpose |
|------|:---------------:|---------|
| `config.yaml` | yes | Kill switch + budget + promotion thresholds |
| `stable/global.md` | yes | Compact operating contract injected on every session start |
| `stable/by-project/<slug>.md` | yes | Project-scoped stable learnings, injected when CWD matches |
| `candidates/` | yes (files only) | Candidate learnings awaiting promotion — one YAML per candidate |
| `rejected/` | yes | Archived candidates that failed evaluation (provenance) |
| `reports/` | yes | Analysis and promotion-decision reports |
| `records/` | **no** (gitignored) | Raw JSONL evidence — session events, corrections, outcomes, adaptations |
| `bin/` | yes | Operator scripts: status, collect, promote, regression, prune, test |
| `tests/` | yes | Smoke tests for the pipeline |

## Pipeline

```
observe → record → analyze → evaluate → propose → test → promote → monitor → prune
           ↑                                                ↓
           └──────── evidence-recorder skill ───────────────┘
```

Nothing promotes automatically. The gate at every step is explicit.

## Startup behavior

The SessionStart hook (`hooks/evolution-startup.sh`):
1. Checks kill switch (`config.yaml: enabled: true`) and `CLAUDE_EVOLUTION_BASELINE` env.
2. Reads `stable/global.md` (size-gated by `config.yaml: startup_budget_chars`).
3. If `stable/by-project/$(basename $CWD).md` exists, appends it.
4. Emits `additionalContext` JSON to inject the combined text.
5. Appends one JSONL line to `records/sessions.jsonl`.

## Oversight

- `/evolution status` — dashboard
- `/evolution candidates` — top candidate learnings
- `/evolution promotions` — recent promotions + reasons
- `/evolution regressions` — suspected regressions
- `/evolution disable` / `/evolution enable` — kill switch
- `CLAUDE_EVOLUTION_BASELINE=1 claude` — baseline mode (skip injection for one session)

## Guardrails (hard rules)

Promotion gate (`bin/evolve-promote.sh`) enforces, per candidate:
- `evidence_count ≥ config.min_evidence` (default 3)
- distinct `session_count ≥ 2`
- distinct `project_count ≥ 2` (unless scope is `project-specific`)
- `last_confirmed > last_failed`
- post-promotion `stable/*` total chars ≤ `startup_budget_chars`
- no contradiction with existing stable text (simple substring check)

Fail any gate → stay in `candidates/`. Never auto-promote.

## What is NOT automatic

- Promotions (require `/evolution promote <candidate>`).
- Edits to `stable/` files (only via `bin/evolve-promote.sh` + structural validation).
- Demotion (require `/evolution demote <stable-id>`).
- Changes to skills, agents, commands, or CLAUDE.md (adaptation-planner proposes; human applies).

## What IS automatic

- Evidence recording on session start + end.
- Session-context injection from `stable/` (if enabled).
- Adaptation *proposals* in `reports/` (not application).

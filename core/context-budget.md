# Core — Context Budget

> How context flows through this repo. Pairs with `docs/OVERHEAD.md` (measured token cost), `docs/TELEMETRY.md` (usage logging), and the `context-budget-audit` skill (measurement toolkit).

## Loading tiers

| Tier | What loads | When | Cost model |
|------|-----------|------|-----------|
| **T0 — Always-loaded** | `CLAUDE.md`, `rules/*.md` (path-scoped by harness), `settings.json` hook triggers, skill *descriptions* only, agent *names* only, `MEMORY.md` index | Every session start | ~7k–10k tokens |
| **T1 — On skill invocation** | Full `SKILL.md` body (35–800 lines) | When model picks skill | 1k–20k tokens per skill |
| **T2 — On agent dispatch** | Agent body + declared skills lazy-load if invoked | When `Agent` tool is called | Variable; subagent context is isolated |
| **T3 — On tool call** | Referenced files (via Read), bundled skill references under `skills/*/references/` | When the model explicitly fetches | Variable |
| **T4 — On command dispatch** | Full command body | When `/command` is invoked | ~30–600 lines |

T0 is the only tier that consumes context every turn. Everything else is on-demand.

## Progressive disclosure pattern

Skills, agents, and commands in this repo follow this shape:

1. **Descriptor** in frontmatter — name + ≤1-sentence description. Loaded at T0 into the available-surfaces list.
2. **Body** in the main file — loaded at T1/T2/T4 only when invoked.
3. **References** in a `references/` subdirectory — loaded at T3 via Read calls the skill itself initiates.
4. **Examples** in an `examples/` subdirectory — never pre-loaded; demo assets.

This is enforced by convention (skills follow `skill-creator` conventions) rather than by a hook.

## Lazy-loaded indexes

| Index | Points at | When to load |
|-------|-----------|--------------|
| `agents/REGISTRY.md` | All 240 agents | When /plan or /ultraplan is running Stage 6 (delegate) |
| `docs/INVENTORY.md` (generated) | Disk truth | When answering "what's in here" |
| `docs/SURFACE-MAP.md` | Canonical commands per intent | When multiple commands match user intent |
| `docs/EXTRACTABLE-PRODUCTS.md` | Extraction candidates | When extraction question comes up |
| `domains/{domain}/DOMAIN.md` | Skills/agents/commands for that domain | When the task classifies into that domain |

## Budgeting rules

1. **Keep `CLAUDE.md` lean.** Under 800 lines / ~3k tokens is the target. Every section must justify its always-loaded tax.
2. **Prefer indexes over duplication.** If two files describe the same mechanism, one is canonical and the other links to it.
3. **Skills can be long.** T1 loading means a 500-line SKILL.md only pays its cost when actually used. Don't artificially trim skills that carry real instructional content.
4. **Commands describe protocol, not content.** A command body should orchestrate — it should not restate what the invoked skill/agent already says.
5. **Agent bodies should be tight.** Most L0–L6 agents are 40–100 lines. If an agent grows beyond 200 lines, check whether it's actually a skill.
6. **References and examples stay big.** The 19 Hue brand demos and 22 n8n evaluations are leverage; keep them. They never enter context unless explicitly read.

## Known costs (measured / estimated)

- 202 SKILL.md files × ~140-char descriptions ≈ **~7k tokens** injected at session start (see `docs/OVERHEAD.md`).
- CLAUDE.md is currently **~335 lines**, comfortably under budget.
- `evolution/stable/global.md` is bounded by `evolution/config.yaml` `startup_budget_chars` (4000) and validated by `scripts/validate.sh`.
- Average skill body: ~230 lines. Largest: `skills/hue/SKILL.md` at 807 lines (earned — it's the biggest demo surface).

## Measurement

- **`scripts/analyze-usage.sh`** — after 14+ days of `~/.claude/usage.jsonl` data, identifies zero-invocation skills for pruning consideration.
- **`context-budget-audit` skill** — on-demand token-cost measurement of agents/skills/MCP servers/CLAUDE.md.
- **`docs/OVERHEAD.md`** — the honest framing: measured / estimated / unknown.

What is **not** measurable from this side:
- Exact token count after Claude Code's internal compaction of the skill list
- Cache-hit rate for the stable prompt across a session
- Interaction between `enabledPlugins` and skill loading

Treat any specific token claim about those as speculation.

## Honest summary

The library *is* large in raw bytes (~46 KB of SKILL.md bodies). In a cold session the description-list overhead is probably a few thousand tokens — acceptable for heavy use, questionable if most skills never fire. The pruning decision waits for telemetry (see `docs/TELEMETRY.md`). Reducing the description-list is a pruning decision, not a rewrite.

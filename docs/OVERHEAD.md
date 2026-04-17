# Overhead — Measured vs Estimated vs Unknown

The council report labeled the skill library a "token bomb." This document replaces that rhetoric with the numbers we can actually measure, the ones we can estimate with stated assumptions, and the ones we cannot compute from outside Claude Code.

Regenerate the measured numbers with: `scripts/inventory.sh`

## Measured (deterministic from disk)

| Quantity | Value | How |
|---------|------:|-----|
| SKILL.md files | from `scripts/inventory.sh` (`skills.count`) | `find skills -name SKILL.md -type f` |
| Total lines across SKILL.md | from `scripts/inventory.sh` (`skills.skill_md_total_lines`) | `find skills -name SKILL.md -exec wc -l {} +` |
| Skill size distribution | see `docs/INVENTORY.md` | individual `wc -l` results |

At last generation: **202 SKILL.md files, ~46,000 lines total** (exact number in `docs/INVENTORY.md`). Spread: smallest ~35 lines, largest ~807 lines.

## Estimated (with stated assumptions)

The Skills system in Claude Code uses **progressive disclosure** — full `SKILL.md` content is only loaded when a skill is selected; until then Claude Code injects the skill's name + `description` frontmatter field into the system prompt (the "available skills" list).

### Description-only overhead (what loads on every turn)

Assumption: the description string is ≤ 1 sentence in this library (enforced by the frontmatter template, spot-checked).

Approximate size per description: **80–200 characters**, median ~140 characters.

Approximate description-list cost: `202 skills × ~140 chars ≈ 28 KB ≈ ~7k tokens` using a 4-chars-per-token rule of thumb.

**Caveats:**
- The 4-chars-per-token ratio is a rough English-text approximation. Actual tokenization varies.
- Claude Code may compact or truncate the skills list — we cannot observe this externally.
- Commands and agents also inject names into context. We have not measured those.
- This overhead is paid at the beginning of a conversation, not per-turn, thanks to prompt caching (when the surface list is stable across turns).

### Full SKILL.md load (when selected)

Only the invoked skill's `SKILL.md` body is added to context. With sizes from 35 to ~800 lines, a single invocation adds on the order of **1k–20k tokens** of prompt depending on the skill.

Bundled reference files under `skills/<name>/references/` are loaded on demand (they are fetched via tool calls, not pre-injected). Not counted here.

## Unknown (not computable from this side of the API)

- Exact token count of Claude Code's system-prompt skill list after its internal compaction.
- Whether/how Claude Code deduplicates skill descriptions against user turns.
- How `enabledPlugins` interacts with skill loading.
- Cache-hit rate for the stable portion of the prompt across a session.

These are properties of the Claude Code harness and Anthropic's API, not of this repo. Treat any specific token claim about them as speculation.

## What the telemetry will (and won't) resolve

Telemetry (`~/.claude/usage.jsonl`, see `docs/TELEMETRY.md`) will show **which skills actually fire tool calls**, not what the description-list tax is.

To measure the description-list tax directly, you would need to compare prompt-cache-miss token counts of a session with and without the skill set loaded. That is an experiment this repo does not currently run.

## Honest summary

- **Fact:** the skill library is large in raw bytes (~46 KB of SKILL.md bodies).
- **Likely:** it adds a few thousand tokens of system-prompt overhead per cold session via the description list. Acceptable for a heavy user; a questionable trade if the majority of skills never fire.
- **Unknown:** whether Claude Code's selective loading makes this cheaper than the naive estimate.

The correct next step is to collect the usage log, prune zero-invocation surfaces, and re-check description-list size. That is a pruning decision, not a rewrite.

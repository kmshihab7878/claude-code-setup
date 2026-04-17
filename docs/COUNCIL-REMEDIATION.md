# Council Remediation Map

The council report at `~/.claude/council-reports/council-2026-04-17-claude-code-setup-assessment.html` raised specific gaps. This document maps each one to the exact implementation that addresses it, and labels each with verification.

Legend:
- ✅ **Fixed** — deterministic change landed in this commit
- 🛠 **Instrumented** — mechanism in place; waiting on real data
- ⏳ **Deferred** — requires time or media that cannot be produced on demand

## Criticism → fix → verification

| # | Criticism | Status | Fix (files) | How to verify |
|--:|-----------|:------:|-------------|---------------|
| 1 | Count drift / self-misrepresentation (claimed 282 agents / 195 skills / 171 Wave 1 while disk had 237 / 197 / 126) | ✅ | `scripts/inventory.sh`, `scripts/validate.sh`, `docs/INVENTORY.md` (generated), Makefile target `validate`. Hand-written counts in `README.md`, `CLAUDE.md`, `agents/REGISTRY.md`, `commands/{plan,ultraplan}.md`, `docs/ELITE-OPS-*.md` reconciled in commit `d753627`. | `make validate` exits 0; `scripts/inventory.sh \| jq .` shows disk truth. |
| 2 | No usage telemetry | 🛠 | `hooks/usage-logger.sh`, `settings.json` PreToolUse entry, `scripts/analyze-usage.sh`, `docs/TELEMETRY.md`. | Hook writes to `~/.claude/usage.jsonl` on tool calls. Run setup ≥ 14 days, then `scripts/analyze-usage.sh`. |
| 3 | No before/after lean-vs-full measurement | ⏳ | Not attempted. Requires paired workflow on a benchmark task with the full repo vs a stripped setup, across enough sessions to be meaningful. The telemetry layer is the prerequisite. | After 14 days of usage, the zero-invocation list from `scripts/analyze-usage.sh` is the minimal-viable lean set. Compare by archiving and re-running the same task. |
| 4 | README leads with inventory stats instead of value | ✅ | `README.md` rewritten: outcome / who it's for / top entrypoints / install / proof / what's real vs aspirational / inventory (pointer). | `head -60 README.md` shows no count in the opening section. |
| 5 | Aspirational MCP mixed with connected | ✅ | `CLAUDE.md` MCP section restructured into three clearly labeled tiers (Connected / Auth-pending / Aspirational). `README.md` MCP section replaced with a 3-tier summary linking to the authoritative table. `scripts/inventory.sh` counts each tier independently; `docs/INVENTORY.md` exposes them. | `grep -c '^| ✓ \|' CLAUDE.md`, `grep -c '^| ⚠️ \|' CLAUDE.md`, `grep -c '^| ○ \|' CLAUDE.md`. |
| 6 | KB infrastructure far ahead of content | ✅ | `docs/KB-STATUS.md` labels KB explicitly as "scaffold / pilot" with exit criteria. `kb/CLAUDE.md` updated to state current article count and link to status. `kb/wiki/INDEX.md` gets a prominent status line. `README.md` refers to KB as scaffold, not capability. | Read the three files; counts in `scripts/inventory.sh` kb section. |
| 7 | Overlapping surfaces not rationalized | ✅ | `docs/SURFACE-MAP.md` lists canonical entrypoint per intent (implement / inspect / polish / decide / recall). Non-canonical surfaces flagged "pending telemetry review." `README.md` Top Entrypoints points to the map. No surface deleted without evidence. | Open `docs/SURFACE-MAP.md` and try to pick a planner — one obvious answer. |
| 8 | No setup lint / drift detection | ✅ | `scripts/validate.sh` checks: frontmatter presence on all SKILL.md and top-level commands, count drift against generated inventory, stale count anti-regression patterns, hook-script reference integrity, fake-URL patterns. `Makefile` exposes `make validate`. | `make validate` and inspect output. |
| 9 | No demo / proof artifact | 🛠 | `docs/DEMO.md`: reproducible command sequence for audit → root-cause fix → ship, with expected signals and recording guidance. Video not produced (cannot be generated). | Walk the sequence in a target repo; record when ready. |
| 10 | "Token bomb" rhetoric without numbers | ✅ | `docs/OVERHEAD.md` separates measured (deterministic), estimated (stated assumptions), unknown (Claude Code internals). SKILL.md line totals come from `scripts/inventory.sh`. | Read `docs/OVERHEAD.md`; regenerate numbers with `scripts/inventory.sh`. |
| 11 | Broken SuperClaude attribution URL | ✅ | Fixed in commit `d753627`: corrupted repeated-string URL replaced with `SuperClaude-Org/SuperClaude_Framework`. | `grep SuperClaude README.md`. |

## Not fixed yet because evidence takes time

These are intentionally deferred. They are real, but they cannot be closed by writing more files — they require running the setup against reality.

1. **14-day usage-based pruning.** The telemetry is live. A human needs to let it run, then re-open this file and trigger the pruning protocol documented in `docs/TELEMETRY.md`.
2. **Recorded demo video.** `docs/DEMO.md` is the script. A human needs to run it and capture the screencast. Do not link a placeholder.
3. **Before/after benchmark.** Requires a fixed task, two setups (full vs lean), and multiple runs. Design pending.
4. **KB maturity.** 7 articles → 50+ articles with ≥ 0.8 confidence is weeks of deliberate content work. Status is labeled, not faked.

Each of these is linked from the README proof section so a future maintainer (or reviewer) can see what is pending vs done.

## How to audit this document

```bash
make validate      # asserts no stale numeric claims, counts match disk, frontmatter sane
make inventory     # regenerates docs/INVENTORY.md from disk
make usage         # prints telemetry analysis (blank until you've used Claude Code with the hook active)
```

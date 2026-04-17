---
name: project-context
description: Active restructuring of ~/.claude/ → claude-code-setup repo. Phase 0 audit shipped, Phase 1 done, Phase 2+ pending.
type: project
---

## State (2026-04-17)

Owner is executing a multi-phase restructuring of this `~/.claude/` configuration repo following the master prompt in the session's `/ultrathink` invocation.

**Why:** The repo has grown to 202 skills / 84 commands / 240 agents across ~986 files; the Phase 0 audit (see `docs/AUDIT.md`) identified count drift, broken MCP bindings, 171 experimental-scaffold files, and 9 parallel routing authorities. Restructure targets: composability, legibility, honest labeling, extraction readiness.

**How to apply:**
- All work lands in the git repo first (`~/Projects/claude-code-setup/`). The runtime at `~/.claude/` gets re-synced only after Phase 7 validation passes.
- First-wave fixes (count reconciliation, `sequential`→`sequential-thinking`, REGISTRY L6 completion, tier note) committed as `d763901`.
- Phase 1 introduced virtual indexes: `core/` (identity / governance / context-budget / memory), `domains/{engineering, finance, marketing}/DOMAIN.md` with 13 subdomain sub-indexes, `memory/`, and `docs/ARCHITECTURE.md`. No skills, agents, or commands were physically moved — the harness discovers them at their existing paths; DOMAIN.md files are pointers.
- Phase 2 will rewrite `CLAUDE.md` to a leaner form that references `core/*.md` and `domains/*/DOMAIN.md` as the lazy-loaded layer.
- Phase 6 telemetry-based pruning is blocked until `~/.claude/usage.jsonl` has ≥14 days of data.

## Backup

- `~/.claude.backup.20260417/` captured before Phase 1 mutations.
- Previous backups: `~/.claude.backup/` (2026-04-13), `~/.claude.bak.20260413/`.

## Key artifacts

- `docs/AUDIT.md` — Phase 0 synthesis
- `docs/_audit-workspace/` — raw audit artifacts (CLASSIFY, CROSSREF, CONFLICTS)
- `docs/ARCHITECTURE.md` — Phase 1 design rationale (lands at the end of Phase 1)
- `Makefile` + `scripts/{inventory, validate, analyze-usage}.sh` — drift gates

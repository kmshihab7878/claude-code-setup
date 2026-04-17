# Claude Code Architecture — Pointer

> This doc used to be a 524-line hand-maintained architecture narrative from 2026-03-15. It drifted badly per `docs/AUDIT.md` §D.5 (claimed 40 agents / 56 commands / 34 skills / 3 hooks while disk reality grew to 240 / 84 / 202 / 13). This file is now a redirect.

## Where architecture content lives now

| Question | File |
|----------|------|
| Why is the repo shaped the way it is? (Phase 1 design rationale) | [`docs/ARCHITECTURE.md`](./ARCHITECTURE.md) |
| What's the always-loaded contract? | [`CLAUDE.md`](../CLAUDE.md) |
| What's the agent dispatch model? | [`agents/REGISTRY.md`](../agents/REGISTRY.md) |
| What's the execution pipeline? | [`skills/jarvis-core/SKILL.md`](../skills/jarvis-core/SKILL.md) (10-stage) + [`commands/ultraplan.md`](../commands/ultraplan.md) (15-stage) |
| What's the governance model? | [`core/governance.md`](../core/governance.md) + [`skills/governance-gate/SKILL.md`](../skills/governance-gate/SKILL.md) |
| How do the 3 domains route? | [`domains/engineering/DOMAIN.md`](../domains/engineering/DOMAIN.md), [`domains/finance/DOMAIN.md`](../domains/finance/DOMAIN.md), [`domains/marketing/DOMAIN.md`](../domains/marketing/DOMAIN.md) |
| What's the self-evolution architecture? | [`evolution/README.md`](../evolution/README.md) |
| How does memory work? | [`core/memory.md`](../core/memory.md) |
| How does context budget work? | [`core/context-budget.md`](../core/context-budget.md) + [`docs/OVERHEAD.md`](./OVERHEAD.md) |
| What was the Phase 0 audit? | [`docs/AUDIT.md`](./AUDIT.md) + `docs/_audit-workspace/` |

## Why this was consolidated

The previous narrative overlapped heavily with the CLAUDE.md content it was supposed to expand on, and with `docs/ARCHITECTURE.md` (which is the canonical design-rationale doc). Per AUDIT §5.2, hand-maintained architecture docs with zero inbound links guarantee future drift — the fix is a single canonical home (`ARCHITECTURE.md`) plus pointer-only redirects.

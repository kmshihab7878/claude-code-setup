---
description: "AI OS Four-Cs audit. Score 0-100 across Context, Connections, Capabilities, Cadence. Read-only by default. Surfaces top 3 gaps + one next action. Saves to docs/audits/YYYY-MM-DD.md."
---

# /audit — AI OS Four-Cs Audit

Invokes `skills/audit/SKILL.md`.

## What this is NOT
- Not `/audit-deep` (codebase audit) — different skill, different scope
- Not `/security-audit` — different scope, different rubric
- Not `/setup-audit` — narrower (claude config only)

## What this IS
A weekly OS-level pulse-check across:
- **Context** — does the OS know who you are and what you care about?
- **Connections** — are tools wired up safely with kill switches?
- **Capabilities** — do reusable skills exist for repeat work?
- **Cadence** — are loops actually running?

## Output
- One-page summary in chat
- Full report in `docs/audits/YYYY-MM-DD.md`
- One-line entry in `decisions/log.md`

## Cadence
Friday weekly. See `docs/CADENCE.md`. Pair with `/level-up` (action loop) which uses this audit's output as input.

## Flags
- `--no-save` — print to chat only, skip files
- `--quick` — score only Context + Cadence, skip the rest

## See also
- `references/four-cs-framework.md` — rubric
- `skills/level-up/SKILL.md` — pairs with this
- `docs/audits/` — historical reports

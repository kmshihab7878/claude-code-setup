# Decisions Log

_Append-only operating log. Each entry: date, decision, rationale, status, follow-up. No edits to past entries — append corrections as new entries._

_This file is the AI OS counterpart to `kb/decisions/` (formal ADRs). Use this for lightweight day-to-day operating decisions; promote anything architectural to `kb/decisions/` as a numbered ADR._

---

## 2026-05-03 — AI OS layered architecture introduced

**Decision:** Adopt a four-layer operating model — Warp (cockpit) · Claude Code (governed execution) · SocratiCode (codebase intelligence, when installed) · `claude-code-setup` (constitution / policy / memory) — with AIS-OS framework providing the personal/business context, cadence, and onboarding layer.

**Rationale:** Each layer plays a distinct role. Warp gives terminal UX and visibility. Claude Code enforces hooks, MCP gates, skill routing. SocratiCode adds AST-aware code search and impact analysis. AIS-OS provides the human operating model (Three Ms, Four Cs, weekly loops). `CLAUDE.md` remains canonical — every other config file points back to it instead of competing.

**Status:** Implemented as additive scaffolding on branch `ai-os-nate-warp-socraticode-setup`. SocratiCode plugin not yet installed (docs only). AIS-OS reference repo not yet cloned (placeholder only).

**Follow-up:**
- Run `/onboard` to populate `context/` files.
- Decide whether to install SocratiCode plugin (`docs/SOCRATICODE.md`).
- Decide whether to clone AIS-OS reference (`references/external/ais-os/README.md`).
- Run first `/audit` after a week of usage; baseline the Four-Cs score.

---

## How to add an entry

```markdown
## YYYY-MM-DD — One-line title

**Decision:** What was decided.
**Rationale:** Why this and not alternatives.
**Status:** Proposed | Active | Superseded by YYYY-MM-DD entry | Reverted.
**Follow-up:** Concrete next actions, owner, due date.
```

Triggered by `/audit`, `/level-up`, `/onboard`, or any non-obvious operating choice. Architectural decisions still go to `kb/decisions/` as numbered ADRs.

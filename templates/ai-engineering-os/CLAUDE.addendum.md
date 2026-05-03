# CLAUDE.addendum.md — AI OS Layer

> **Append, don't replace.** This addendum documents the AI OS layer (AIS-OS-style context, cadence, capabilities). It does not replace your project's existing `CLAUDE.md` — it adds a section pointing to AI OS files.

> Apply with `scripts/apply-ai-os-template.sh --apply` from the source repo (`claude-code-setup`). The script will refuse to overwrite an existing `CLAUDE.md`; this addendum is the safe additive surface.

---

## How to use this addendum

Append the following section to your project's `CLAUDE.md` under any "Architecture" or "References" heading. Update the paths to match where your project keeps the AI OS files (default: repo root for `context/`, `connections.md`, `decisions/`, `archives/`, `references/`).

---

## AI OS Layered Architecture

The OS runs as four cooperating layers + one personal-context layer adapted from AIS-OS.

| Layer | Role | Source of truth |
|-------|------|-----------------|
| **Warp** | Cockpit — terminal panes, blocks, workflows, diff review | `WARP.md` (thin pointer) |
| **Claude Code** | Governed execution — hooks, MCP gates, skills, agents | `CLAUDE.md` (this file) |
| **SocratiCode** | Codebase intelligence (when installed) | `docs/SOCRATICODE.md` |
| **Project setup** | Constitution, policy, memory | `CLAUDE.md` is canonical |
| **AIS-OS context layer** | Personal/business operating model | `references/3ms-framework.md`, `references/four-cs-framework.md` |

### Operating commands

| Command | Purpose | Cadence |
|---------|---------|---------|
| `/onboard` | 7-question intake; populates `context/`. Hard PII guard. | Once at setup |
| `/audit` | Score AI OS 0-100 across Four Cs | Weekly (Friday) |
| `/level-up` | One recommended next artifact | Weekly |
| `/weekly-operating-review` | Combines `/audit` + `/level-up` + hot-cache refresh | Weekly |
| `/daily-plan` | Morning focus | Daily |
| `/end-of-day-review` | Evening reflection | Daily |

### Source of truth

`CLAUDE.md` is canonical. `WARP.md` and `AGENTS.md` are thin pointers. `references/` are loaded on demand.

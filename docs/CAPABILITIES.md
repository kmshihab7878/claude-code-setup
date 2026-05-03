# Capability Registry

> What the OS can do, where it lives, when to use it. Updated whenever a new capability is added or retired. Used by `/audit` to score the Capabilities pillar (Four Cs).

> This is the **operator-facing** registry — focused on AI-OS-layer capabilities the operator invokes directly. The full agent dispatch table is `agents/REGISTRY.md` (240 agents). The full surface map of all 84 commands is `docs/SURFACE-MAP.md`. The full skill list is `docs/INVENTORY.md`.

---

## Schema

| Field | Meaning |
|-------|---------|
| Capability | The thing the OS does |
| Trigger | How it fires (`/command`, agent invocation, hook event, manual) |
| Type | `script` · `skill` · `command` · `agent` · `recipe` · `hook` · `connection` · `reference` |
| Path | Where it lives |
| Inputs | What it needs |
| Outputs | What it produces |
| Owner | What sub-system owns it (operator / engineering / docs / ops) |
| Status | `active` · `experimental` · `deprecated` · `archived` · `planned` |
| Last improved | Date of the last meaningful change (used to flag stale capabilities) |

---

## AI OS layer (operator-facing)

| Capability | Trigger | Type | Path | Inputs | Outputs | Owner | Status | Last improved |
|------------|---------|------|------|--------|---------|-------|--------|---------------|
| Onboard the OS | `/onboard` | command + skill | `commands/onboard.md`, `skills/onboard/SKILL.md` | 7-question intake | `context/*.md`, `connections.md` rows, `decisions/log.md` entry | operator | active | 2026-05-03 |
| Score the OS | `/audit` | command + skill | `commands/audit.md`, `skills/audit/SKILL.md` | repo state | `docs/audits/YYYY-MM-DD.md` | operator | active | 2026-05-03 |
| Recommend next artifact | `/level-up` | command + skill | `commands/level-up.md`, `skills/level-up/SKILL.md` | week's signals | one recommendation in `decisions/log.md` | operator | active | 2026-05-03 |
| Friday operating review | `/weekly-operating-review` | skill | `skills/weekly-operating-review/SKILL.md` | week's signals | audit + level-up + `_hot.md` refresh | operator | active | 2026-05-03 |
| Daily planning | `/daily-plan` | skill | `skills/daily-plan/SKILL.md` | priorities + hot cache | top focus + AI-assisted task | operator | active | 2026-05-03 |
| End-of-day review | `/end-of-day-review` | skill | `skills/end-of-day-review/SKILL.md` | day's signals | `decisions/log.md` entry + tomorrow's hint | operator | active | 2026-05-03 |
| Wiki ingest | `/wiki-ingest` | command | `commands/wiki-ingest.md` | new files in `kb/raw/` | wiki articles + INDEX + log + (optional) `_hot.md` | wiki-curator | active | (existing) |
| Wiki query | `/wiki-query` | command | `commands/wiki-query.md` | question | answer in `kb/outputs/` | wiki-curator | active | (existing) |
| Wiki health check | `/wiki-lint` | command | `commands/wiki-lint.md` | wiki state | lint report | wiki-curator | active | (existing) |
| SocratiCode preflight | (implicit, called by other skills) | skill | `skills/socraticode-preflight/SKILL.md` | files / symbols | preflight summary + recommendation | engineering | experimental (until SocratiCode installed) | 2026-05-03 |

## Engineering / execution layer

| Capability | Trigger | Type | Path | Status |
|------------|---------|------|------|--------|
| Full implementation mode | `/ship` | command | `commands/ship.md` | active |
| Plan an implementation | `/plan` (10-stage) / `/ultraplan` (15-stage) / `/planUI` | command | `commands/plan.md`, `commands/ultraplan.md`, `commands/planUI.md` | active |
| Root-cause fix | `/fix-root` | command | `commands/fix-root.md` | active |
| Code review | `/review` / `/council-review` | command | `commands/review.md`, `commands/council-review.md` | active |
| Full-stack audit | `/audit-deep` | command | `commands/audit-deep.md` | active |
| Setup audit | `/setup-audit` | command | `commands/setup-audit.md` | active |
| Security audit | `/security-audit` | command | `commands/security-audit.md` | active |
| Generate tests | `/test-gen` | command | `commands/test-gen.md` | active |
| PR preparation | `/pr-prep` | command | `commands/pr-prep.md` | active |
| Polish UX | `/polish-ux` | command | `commands/polish-ux.md` | active |
| Optimize performance | `/optimize` | command | `commands/optimize.md` | active |
| Recall across sessions | `/recall` | skill | `skills/recall/SKILL.md` | active |

For the full command list (84 entries: 39 custom + 31 SuperClaude + 15 BMAD), see `docs/SURFACE-MAP.md`.

## Operations layer

| Capability | Trigger | Type | Path | Status |
|------------|---------|------|------|--------|
| MCP security gate | `PreToolUse` (MCP calls) | hook | `hooks/mcp-security-gate.sh` | active (wired) |
| Loop detection | `PreToolUse` | hook | `hooks/loop-detector.sh` | active (wired) |
| Usage logging | `PreToolUse` | hook | `hooks/usage-logger.sh` | active (wired) |
| Session init | `SessionStart` | hook | `hooks/session-init.sh` | active (wired) |
| Stop verification | `Stop`, `SubagentStop` | hook | `hooks/stop-verification.sh` | active (wired) |
| Persistent mode (autonomous) | `Stop` | hook | `hooks/persistent-mode.sh` | active (wired) |
| Context guard | `Stop` | hook | `hooks/context-guard.sh` | active (wired) |
| Destructive command gate | `PreToolUse` (Bash) | hook | `hooks/destructive-command-gate.sh` | **extracted, NOT wired** (approval required) |
| No-secret-commit gate | `PreToolUse` (Write/Edit) | hook | `hooks/no-secret-commit.sh` | **extracted, NOT wired** (approval required) |
| Validation summary | `Stop` | hook | `hooks/validation-summary.sh` | **extracted, NOT wired** (approval required) |
| Inventory generation | `make inventory` | script | `scripts/inventory.sh` | active |
| Drift validation | `make validate` | script | `scripts/validate.sh` | active |
| Usage analysis | manual | script | `scripts/analyze-usage.sh` | active |

## Subagents (operator-facing — beyond the 240 in REGISTRY.md, this is the new AIS-OS layer)

| Capability | Trigger | Type | Path | Status |
|------------|---------|------|------|--------|
| DevEx operations | invoke `agents/devex-operator.md` | agent | `agents/devex-operator.md` | active |
| Wiki curation | invoke `agents/wiki-curator.md` | agent | `agents/wiki-curator.md` | active |
| Automation design | invoke `agents/automation-designer.md` | agent | `agents/automation-designer.md` | active |

## Connections (registry of external surfaces)

See `connections.md` for the live list, `docs/CONNECTIONS_ROADMAP.md` for the framework.

## Reference docs (for skills/agents to load on demand)

| Reference | Path |
|-----------|------|
| Three Ms (operator mindset) | `references/3ms-framework.md` |
| Four Cs (system structure) | `references/four-cs-framework.md` |
| Skill-building framework | `references/skill-building-framework.md` |
| API integration principles | `references/api-integration-principles.md` |
| Direct API vs MCP | `references/direct-api-vs-mcp.md` |
| AIS-OS reference (placeholder) | `references/external/ais-os/README.md` |

---

## Rules for adding to this registry

1. **Every repeated task becomes a candidate** — surfaces via `/level-up`.
2. **Build smallest useful POC first** — Bike Method.
3. **Improve only after real failures** — don't pre-optimise.
4. **Prefer scripts for deterministic operations.**
5. **Prefer skills for judgment-heavy workflows.**
6. **Prefer APIs for stable tool integrations** (deterministic, narrow surface, scheduled).
7. **Prefer MCP when tool abstraction is genuinely safer or faster** (broad surface, OAuth-managed, exploratory).
8. **Set `Status: planned`** for capabilities not yet built; **`active`** for live; **`experimental`** for ones not yet validated; **`deprecated`** for ones being phased out; **`archived`** for ones moved to `archives/`.
9. **Update `Last improved`** on every meaningful change — used by `/audit` to flag staleness.

---

## How `/audit` reads this file

The Capabilities pillar (out of 25) considers:
- Number of `active` capabilities tied to repeated workflows in `decisions/log.md`
- Ratio of `active` to `deprecated` (high deprecated count = drift)
- Last-improved staleness (>180 days = penalty)
- Coverage of the operator's repeated tasks (Q4 from `/onboard`)

If a capability is in `decisions/log.md` Q4 list but not in this registry → that's a gap `/level-up` should target.

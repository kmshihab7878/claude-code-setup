# Claude Code Setup

A `~/.claude/` configuration that turns Claude Code into a four-layer personal AI Engineering OS — Warp cockpit, Claude Code execution, SocratiCode intelligence, AIS-OS context layer — with explicit guardrails, governed agents, and a controlled self-evolution loop. Not a chatbot.

## For whom

Engineers who want Claude Code to:
- Ship production-grade code end-to-end (`/ship`), not scaffolds.
- Inspect first, fix root-cause, and leave a regression test (`/audit-deep`, `/fix-root`).
- Refuse to commit secrets, force-push, or delete system paths without confirmation.
- Route by risk tier and authority level, not by vibe.
- Own a personal operating layer that knows your business, tracks repeat work, and improves weekly (`/onboard`, `/audit`, `/level-up`).

If you want a one-file prompt tweak, this is not it. This is a full operating environment, mounted at `~/.claude/`.

## Start here

Two surfaces cover the common cases — engineering work and AI OS operation. Full map in [`docs/SURFACE-MAP.md`](docs/SURFACE-MAP.md). Common workflow recipes in [`docs/RUNBOOK.md`](docs/RUNBOOK.md).

### Engineering surface

| Intent | Command | What happens |
|--------|---------|--------------|
| Build something end-to-end | `/ship <task>` | Inspect → plan → build → validate → deliver. No placeholders. |
| Inspect before acting | `/audit-deep <area>` | 6-dimension review (arch / quality / perf / UX / security / tests) with P0–P3 severity. |
| Fix a bug the right way | `/fix-root <bug>` | Root-cause diagnosis + narrow patch + regression test. |
| Refine a skill / agent / doc | `/improve <target>` | Evidence-driven minimal refinement loop (telemetry-informed after 14d of usage). |

### AI OS surface (AIS-OS layer)

| Intent | Command | What happens |
|--------|---------|--------------|
| First-time setup of personal context | `/onboard` | 7-question intake. Hard PII guard — never auto-fills identity from session env. Populates `context/`, seeds `connections.md`. |
| Score the OS this week | `/audit` | 0-100 across the Four Cs (Context · Connections · Capabilities · Cadence). Saves to `docs/audits/YYYY-MM-DD.md`. |
| Recommend ONE next artifact | `/level-up` | 5 reflection questions mapped to Three Ms. Plan, no code. |
| Friday combo | `/weekly-operating-review` | `/audit` + `/level-up` + refresh of `kb/wiki/_hot.md`. |
| Daily | `/daily-plan`, `/end-of-day-review` | Morning focus + evening reflection. |

For planning heavy/cross-system work, `/plan` is canonical (`/ultraplan` for enterprise-risk only). Pick one.

Tasks route via three domain indexes — [`domains/engineering/DOMAIN.md`](domains/engineering/DOMAIN.md) (6 subdomains: full-stack, devops, security, quality, ai-ml, design), [`domains/finance/DOMAIN.md`](domains/finance/DOMAIN.md) (trading, analysis, portfolio), [`domains/marketing/DOMAIN.md`](domains/marketing/DOMAIN.md) (growth, content, brand, ads). DOMAIN.md files are lazy-loaded pointers into existing `skills/`, `agents/`, `commands/`, `recipes/` — no skills or agents move.

## Install

```bash
git clone https://github.com/kmshihab7878/claude-code-setup.git
cp -r ~/.claude ~/.claude.backup.$(date +%Y%m%d) 2>/dev/null
rsync -av --exclude='.git' claude-code-setup/ ~/.claude/
```

Then:
- Edit `~/.claude/CLAUDE.md` — replace identity/email.
- Review `~/.claude/rules/` — adapt path rules to your conventions.
- Run `claude` and type `/plan test` to confirm the pipeline wires up.

## Four-layer architecture

| Layer | Role | Source of truth |
|-------|------|-----------------|
| **Warp** | Cockpit — terminal panes, blocks, workflows, diff review | `WARP.md` (thin pointer), [`docs/WARP_COCKPIT.md`](docs/WARP_COCKPIT.md), [`docs/WARP_WORKFLOWS.md`](docs/WARP_WORKFLOWS.md) |
| **Claude Code** | Governed execution engine — hooks, MCP gates, skills, agents | `CLAUDE.md` (canonical) |
| **SocratiCode** | Codebase intelligence — AST search, graph, impact, call-flow (when installed) | [`docs/SOCRATICODE.md`](docs/SOCRATICODE.md) |
| **claude-code-setup** | Constitution, policy, memory — this repo | `core/`, `memory/`, `agents/REGISTRY.md` |
| **AIS-OS context layer** | Personal/business operating model — Three Ms, Four Cs, weekly loops | [`references/3ms-framework.md`](references/3ms-framework.md), [`references/four-cs-framework.md`](references/four-cs-framework.md), [`docs/AIS_OS_INTEGRATION.md`](docs/AIS_OS_INTEGRATION.md) |

Adapted from [AIS-OS by Nate Herk](https://github.com/nateherkai/AIS-OS) (the personal/business layer); built on top of [Claude Code](https://docs.anthropic.com/en/docs/claude-code) (the execution engine). `CLAUDE.md` is canonical — every other config (`WARP.md`, `AGENTS.md`, AIS-OS docs) points back to it instead of competing.

## What's real today

| Tier | What it means | How many |
|------|---------------|---------:|
| **Live capabilities** | Installed and usable after `rsync`: hooks, path rules, skills, commands, agents | 209 skills · 88 commands · 243 agents · 13 recipes |
| **Connected MCP servers** | Live via `claude mcp list` | 8 (see `CLAUDE.md` Tier 1) |
| **Auth-pending MCP** | Configured, needs re-auth | 2 |
| **Aspirational MCP** | Listed in docs as options; **not installed** until `claude mcp add ...` is run | 20 (see `CLAUDE.md` Tier 3 — do not assume access) |
| **Knowledge base** | Infrastructure + workflow built; content is sparse (see [`docs/KB-STATUS.md`](docs/KB-STATUS.md)) | scaffold / pilot |
| **Self-evolution layer** | Active on every session via a SessionStart hook. Records evidence, never auto-promotes. See `evolution/` and `/evolution status`. | enabled |
| **AIS-OS personal/business layer** | Onboarding, audit, level-up, weekly loops, connections roadmap, capabilities registry | added 2026-05-03; populate via `/onboard` |
| **SocratiCode codebase intelligence** | Documented; install requires explicit approval (`docs/SOCRATICODE.md`) | not installed by default |

## Proof

- **Phase 0 audit:** [`docs/AUDIT.md`](docs/AUDIT.md) (441 lines) — per-file bucket classification, dependency graph, overlap map, extraction-value zones. Raw evidence in `docs/_audit-workspace/` (CLASSIFY / CROSSREF / CONFLICTS).
- **Why the repo is shaped this way:** [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) — rationale for virtual-index design (`core/`, `domains/`, `memory/`), deviations from the target layout, context-loading tiers.
- **What could be pulled out as standalone products:** [`docs/EXTRACTABLE-PRODUCTS.md`](docs/EXTRACTABLE-PRODUCTS.md) — 10 self-contained extraction candidates (Elite Ops, self-evolution, /market, Hue, JARVIS-sec, react-bits, mcp-mastery, anti-ai-writing, n8n, JARVIS-Core governance).
- **What a session actually looks like:** [`docs/DEMO.md`](docs/DEMO.md) — reproducible `/audit-deep → /fix-root → /ship` sequence on a target repo. Script ready; video not recorded yet.
- **Common workflows:** [`docs/RUNBOOK.md`](docs/RUNBOOK.md) — 10 recipes from "start a coding task" to "recover from a failed task".
- **What's in the repo, deterministically:** [`docs/INVENTORY.md`](docs/INVENTORY.md) — machine-generated from disk. Regenerate with `make inventory`.
- **How accumulation is measured, not asserted:** [`docs/TELEMETRY.md`](docs/TELEMETRY.md) — PreToolUse hook logs every tool call to `~/.claude/usage.jsonl`; analyze with `make usage`.
- **How drift is caught:** `make validate` — pass=25 / fail=0 at last run. Checks CLAUDE.md + REGISTRY counts against disk, anti-regression patterns for 16 stale-count fingerprints, hook-script integrity, fake URLs. See [`docs/COUNCIL-REMEDIATION.md`](docs/COUNCIL-REMEDIATION.md) for history.
- **Pruning protocol:** `docs/TELEMETRY.md` → archive zero-invocation surfaces after 14 days of real usage.
- **Controlled self-evolution:** [`evolution/README.md`](evolution/README.md) — observe → record → evaluate → promote pipeline with hard evidence gates. Status via `/evolution status`; smoke test via `make evolve-test`.

## Guardrails (active)

These hooks fire automatically (configured in `settings.json`, implemented in `hooks/*.sh` or inline):

| Trigger | What it does |
|---------|--------------|
| Session start | Evolution layer injects `evolution/stable/global.md` + matching project-scoped learnings (bounded by `startup_budget_chars`); records the session in `evolution/records/sessions.jsonl`. Disable: `/evolution disable` or `CLAUDE_EVOLUTION_BASELINE=1`. |
| Every tool call | Usage telemetry (`~/.claude/usage.jsonl`), MCP whitelist gate, infinite-loop detector |
| `Write`/`Edit` to `.env` / `.pem` / `.key` / credentials | Blocks the write |
| `Write`/`Edit` to linter/formatter configs | Warns (prefer fixing code over weakening rules) |
| `git push --force` without `--force-with-lease` | Blocks |
| `rm -rf` on system paths (`/`, `~`, `/usr`, `/etc`, `/var`) | Blocks |
| Python file write | Auto-runs `ruff check --fix` + `ruff format` |
| Bash call | Appends to `~/.claude/audit.log` |
| Stop / SubagentStop | Checks uncommitted files, context usage, persistent mode |

## Self-evolution layer (controlled)

Active in every session. Observes, records, and learns — but never mutates stable behavior without passing an evidence gate.

- Pipeline: `observe → record → analyze → evaluate → propose → test → promote → monitor → prune`.
- Startup injection (SessionStart hook) adds `evolution/stable/global.md` — the operating contract — plus any `evolution/stable/by-project/<cwd-basename>.md` if present. Hard cap via `evolution/config.yaml: startup_budget_chars`.
- Candidates live in `evolution/candidates/*.yaml` and never enter startup context until promoted.
- Promotion gate (`evolution/bin/evolve-promote.sh`) enforces: evidence ≥ 3, distinct sessions ≥ 2, distinct projects ≥ 2 (unless project-scoped), no contradiction, size budget respected.
- Kill switch: `/evolution disable` (creates `evolution/disabled`). Baseline mode: `CLAUDE_EVOLUTION_BASELINE=1 claude` for one clean session.

Operator commands: `/evolution status | candidates | promotions | regressions | prune | run | promote <id> | demote <id> | disable | enable | baseline`.

See [`evolution/README.md`](evolution/README.md) for full architecture.

## Architecture, briefly

```
~/.claude/
├── CLAUDE.md            # Always-loaded operating contract (≤270 lines, ~4k tokens) — canonical
├── WARP.md              # Thin pointer to CLAUDE.md (Warp cockpit rules)
├── AGENTS.md            # Thin pointer to CLAUDE.md (for tools that look for AGENTS.md)
├── settings.json        # Hook bindings, enabled plugins
│
├── core/                # Lazy-loaded contract expansions
│   ├── identity.md      # Execution posture · ambiguity · completion · communication
│   ├── governance.md    # Non-negotiables · operating philosophy · Constitution (SEC-001)
│   ├── context-budget.md # Loading tiers · token-cost rules
│   └── memory.md        # Memory architecture across 6 layers
│
├── domains/             # Virtual domain indexes — pointers into skills/agents/commands
│   ├── engineering/DOMAIN.md  + 6 subdomains (full-stack, devops, security, quality, ai-ml, design)
│   ├── finance/DOMAIN.md      + 3 subdomains (trading, analysis, portfolio)
│   └── marketing/DOMAIN.md    + 4 subdomains (growth, content, brand, ads)
│
├── memory/              # File-based auto-memory + MEMORY.md always-loaded index
├── skills/              # Prompt-library skills (SKILL.md + references) — 209 skills
├── commands/            # Slash commands: 42 custom + 31 SuperClaude + 15 BMAD = 88
├── agents/              # Agent definitions (243) + REGISTRY.md dispatch table
├── rules/               # Path-scoped rules (python, typescript, security, testing, infrastructure, implementation)
├── hooks/               # Shell scripts invoked from settings.json
├── recipes/             # Parameterized YAML workflows
├── evolution/           # Self-evolution layer (observe → record → evaluate → promote, kill-switchable)
├── kb/                  # Knowledge base — wiki + decisions (ADRs) + retrospectives
│   └── wiki/_hot.md     # Current-week cache (AIS-OS pattern), refreshed via /weekly-operating-review
│
├── ── AIS-OS personal/business layer ──
├── context/             # About Me · About Business · Priorities · Voice Sample · Operating Preferences
├── decisions/log.md     # Append-only operating log (lighter than ADRs in kb/decisions/)
├── archives/            # Cold storage for retired material; quarterly review only
├── references/          # Three Ms · Four Cs · skill-building · API integration · direct-API-vs-MCP
├── connections.md       # Single source of truth for tools/accounts/sensitivity tiers
├── aios-intake.md       # The 7-question /onboard interview
├── .env.example         # Placeholder credential vars (real .env stays gitignored)
├── .socraticodeignore   # Patterns SocratiCode (when installed) should skip
├── templates/ai-engineering-os/  # Starter pack for replicating this pattern in other repos
│
└── docs/                # AUDIT · ARCHITECTURE · RUNBOOK · SURFACE-MAP · INVENTORY · OVERHEAD · TELEMETRY · KB-STATUS
                         # + AIS_OS_INTEGRATION · CADENCE · CAPABILITIES · CONNECTIONS_ROADMAP
                         # + MCP_GOVERNANCE · SECURITY · SOCRATICODE · WARP_COCKPIT · WARP_WORKFLOWS · WIKI_LAYER
```

Risk tiers control execution: T0 auto, T1 log+proceed, T2 wait for approval, T3 block unless pre-authorized. Agents operate only within their declared MCP server bindings (aspirational Tier-3 bindings gated at runtime by `hooks/mcp-security-gate.sh`). Full structural rationale in [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md). AIS-OS integration mapping in [`docs/AIS_OS_INTEGRATION.md`](docs/AIS_OS_INTEGRATION.md).

## Inventory

Exact counts live in the machine-generated [`docs/INVENTORY.md`](docs/INVENTORY.md). Regenerate anytime with `make inventory`. If you see a count elsewhere in the repo that doesn't match, `make validate` will flag it.

## Validation and maintenance

```bash
make validate     # frontmatter + count drift + fake URLs + hook-script integrity
make inventory    # regenerate docs/INVENTORY.md from disk
make usage        # analyze ~/.claude/usage.jsonl (last 30 days)
```

`make validate` is the one command to run before committing structural changes.

## Credits & sources

Patterns and skills integrated from:

- [Anthropic Skills Spec](https://github.com/anthropics/skills)
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) — the execution engine
- [AIS-OS by Nate Herk](https://github.com/nateherkai/AIS-OS) — personal/business operating layer (Three Ms, Four Cs, /onboard, /audit, /level-up, weekly loops, connections roadmap)
- [SocratiCode](https://github.com/giancarloerra/socraticode) — codebase intelligence (AST search, graph, impact, call-flow) — documented; install on demand
- [Warp](https://www.warp.dev/) — terminal cockpit (panes, blocks, workflows, diff review)
- [SuperClaude Framework](https://github.com/SuperClaude-Org/SuperClaude_Framework) — 31 commands, specialized agents, cognitive personas
- [BMAD Method](https://github.com/bmadcode/BMAD-METHOD) — 15 agile/product commands
- [oh-my-claudecode](https://github.com/nicobailon/oh-my-claudecode) — hook patterns, persistent mode
- [everything-claude-code](https://github.com/affaan-m/everything-claude-code) — context optimization
- [pbakaus/impeccable](https://github.com/pbakaus/impeccable) — frontend design skills (Apache 2.0)
- [JCodesMore/ai-website-cloner-template](https://github.com/JCodesMore/ai-website-cloner-template)
- [wshobson](https://github.com/wshobson) — Kubernetes and quant trading skills
- [alirezarezvani](https://github.com/alirezarezvani) — C-suite advisor and marketing skills
- [czlonkowski](https://github.com/czlonkowski) — n8n automation skills
- [dominikmartn/hue](https://github.com/dominikmartn/hue) — brand design-language meta-skill
- [DavidHDev/react-bits](https://github.com/DavidHDev/react-bits) — React component catalog

## Security posture

- `settings.local.json`, `projects/`, `audit.log`, `history.jsonl`, `usage.jsonl`, `.env`, `*.pem`, `*.key`, and Python bytecode (`__pycache__/`, `*.pyc`) are `.gitignore`d.
- Gitleaks-clean at commit time.
- No real emails, API keys, or personal paths in tracked files (placeholders only).

## License

MIT.

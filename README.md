# Claude Code Setup

A public-safe reference implementation for a Claude Code-based AI engineering environment. Slash commands, skills, agents, hooks, MCP governance, and automated safety validation — designed to be cloned, audited, and adopted as-is.

## What this is

A `~/.claude/` configuration that turns Claude Code into a four-layer AI engineering environment with explicit guardrails, governed agents, and a controlled self-evolution loop. Not a chatbot.

For engineers who want Claude Code to:

- Ship production-grade code end-to-end (`/ship`), not scaffolds.
- Inspect first, fix root-cause, and leave a regression test (`/audit-deep`, `/fix-root`).
- Refuse to commit secrets, force-push, or delete system paths without confirmation.
- Route work by risk tier and authority level, not by vibe.
- Maintain a personal operating layer (`/onboard`, `/audit`, `/level-up`) that learns from repeat work.

This is a full operating environment mounted at `~/.claude/`, not a one-file prompt tweak.

## What it includes

- **Slash commands** — engineering (`/ship`, `/audit-deep`, `/fix-root`, `/plan`, `/review`, `/test-gen`) plus AI OS workflow (`/onboard`, `/audit`, `/level-up`, `/daily-plan`).
- **Skills** — domain-specific prompt libraries with structured `SKILL.md` frontmatter.
- **Agents** — registry-routed specialist agents organized by authority level (executive → department head → specialist → worker) with declared MCP bindings.
- **Hooks** — 16 shell scripts wired to Claude Code lifecycle events (SessionStart, PreToolUse, PostToolUse, Stop). See [`docs/HOOKS.md`](docs/HOOKS.md).
- **MCP governance** — security-gated tool calls against an authoritative whitelist. See [`docs/MCP_GOVERNANCE.md`](docs/MCP_GOVERNANCE.md).
- **Recipes** — parameterized YAML workflows under `recipes/`.
- **Validation automation** — drift detection, banned-term gate, secret scanning. See [`scripts/`](scripts/).
- **Public-release safety checks** — pre-publication checklist + CI workflows. See [`docs/PUBLICATION_CHECKLIST.md`](docs/PUBLICATION_CHECKLIST.md).

Exact counts (machine-generated from disk) live in [`docs/INVENTORY.md`](docs/INVENTORY.md). Regenerate with `make inventory`.

## Architecture

Four cooperating layers + one personal-context layer. Each plays a distinct role; none replaces another.

| Layer | Role | Source of truth |
|-------|------|-----------------|
| **Warp** | Cockpit — terminal panes, blocks, workflows, diff review | [`WARP.md`](WARP.md), [`docs/WARP_COCKPIT.md`](docs/WARP_COCKPIT.md) |
| **Claude Code** | Governed execution engine — hooks, MCP gates, skills, agents | [`CLAUDE.md`](CLAUDE.md) (canonical) |
| **SocratiCode** | Codebase intelligence — AST search, graph, impact, call-flow (when installed) | [`docs/SOCRATICODE.md`](docs/SOCRATICODE.md) |
| **claude-code-setup** | Constitution, policy, memory — this repo | `core/`, `memory/`, [`agents/REGISTRY.md`](agents/REGISTRY.md) |
| **AIS-OS context layer** | Personal/business operating model — Three Ms, Four Cs, weekly loops | [`docs/AIS_OS_INTEGRATION.md`](docs/AIS_OS_INTEGRATION.md) |

`CLAUDE.md` is canonical — every other config (`WARP.md`, `AGENTS.md`, AIS-OS framework docs) points back to it instead of competing. If a contradiction surfaces, `CLAUDE.md` wins.

Risk tiers gate execution: T0 auto, T1 log+proceed, T2 wait for approval, T3 block unless pre-authorized. Agents operate only within their declared MCP server bindings; aspirational Tier-3 bindings are gated at runtime by `hooks/mcp-security-gate.sh`. Full structural rationale in [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md).

## Quick start

```bash
git clone https://github.com/<your-org>/<your-repo>.git
cd <your-repo>
```

Install as your global `~/.claude/` (back up any existing config first):

```bash
[ -d ~/.claude ] && mv ~/.claude ~/.claude.backup.$(date +%Y%m%d-%H%M%S)
ln -s "$(pwd)" ~/.claude
```

Then:

```bash
cp .env.example .env       # edit locally; never commit
bash scripts/validate.sh   # confirm internal consistency
claude                     # session-start banner should appear
```

First-time configuration walkthrough: [`docs/SETUP.md`](docs/SETUP.md).
If anything fails: [`docs/TROUBLESHOOTING.md`](docs/TROUBLESHOOTING.md).

## Public-safety model

The repository is designed so a fresh clone is publishable without further redaction. Defence layers, in order:

| Layer | What it stops | Where |
|---|---|---|
| `.gitignore` | Real `.env`, keys, credentials, session records, memory exports entering the index | `.gitignore` |
| Pre-commit secret hook | Direct `Write`/`Edit` to `.env`, `*.key`, `*.pem`, `credentials.json` | `hooks/no-secret-commit.sh` |
| MCP security gate | Unknown / write-capable MCP calls | `hooks/mcp-security-gate.sh` + `recipes/lib/mcp-whitelist.json` |
| Public-safety check | Personal-identifier regression in tracked files | `scripts/check-public-safety.sh` |
| Destructive-command gate | `rm -rf /`, force-push to main, unsafe resets | `hooks/destructive-command-gate.sh` |
| CI gates | Re-runs all the above on every PR + weekly cron | `.github/workflows/public-safety.yml`, `.github/workflows/secret-scan.yml` |
| Validation suite | Internal-consistency drift | `scripts/validate.sh` |

All in-repo examples use placeholders only: `<your-org>/<your-repo>`, `<workspace>`, `<project-root>`, `<your-api-key>`, `<contributor>`. Full publication discipline: [`docs/PUBLICATION_CHECKLIST.md`](docs/PUBLICATION_CHECKLIST.md). Defence-in-depth detail: [`docs/SECURITY.md`](docs/SECURITY.md).

## Validation

```bash
bash scripts/audit-public-readiness.sh   # orchestrator — runs every safety/scanner check
bash scripts/check-public-safety.sh      # banned-term gate
bash scripts/validate.sh                 # internal consistency, count drift, hook integrity
bash scripts/inventory.sh                # regenerate docs/INVENTORY.md from disk
```

`scripts/audit-public-readiness.sh` is the single command to run before publishing or merging anything substantial. It composes the banned-term gate, the broad path/file-leak sweep, gitleaks, trivy (if installed), the validation suite, and a backup-tag advisory.

CI mirrors these in `.github/workflows/`.

## Repository structure

```
.
├── CLAUDE.md                    # always-loaded operating contract (canonical)
├── WARP.md                      # Warp-cockpit pointer back to CLAUDE.md
├── AGENTS.md                    # AGENTS.md-spec pointer back to CLAUDE.md
├── SECURITY.md                  # GitHub-convention vulnerability reporting
├── CONTRIBUTING.md              # contributor rules + workflow
├── settings.json                # hook bindings, enabled plugins
│
├── core/                        # lazy-loaded contract expansions
│   ├── identity.md              # execution posture · ambiguity · completion · communication
│   ├── governance.md            # non-negotiables · operating philosophy · Constitution
│   ├── context-budget.md        # loading tiers · token-cost rules
│   └── memory.md                # memory architecture across the memory layers
│
├── domains/                     # virtual domain indexes (pointers, not duplicates)
│   ├── engineering/DOMAIN.md    # full-stack, devops, security, quality, ai-ml, design
│   ├── finance/DOMAIN.md        # trading, analysis, portfolio
│   └── marketing/DOMAIN.md      # growth, content, brand, ads
│
├── skills/                      # SKILL.md + references — prompt-library skills
├── commands/                    # slash commands (custom + SuperClaude + BMAD)
├── agents/                      # agent definitions + REGISTRY.md dispatch table
├── hooks/                       # shell scripts invoked from settings.json
├── recipes/                     # parameterized YAML workflows
├── rules/                       # path-scoped rules (python, typescript, security, …)
├── evolution/                   # self-evolution layer (observe → record → evaluate → promote)
├── kb/                          # knowledge base (wiki, decisions, retrospectives)
├── memory/                      # file-based auto-memory + MEMORY.md always-loaded index
│
├── context/                     # personal/business context (placeholders public-safe)
├── decisions/                   # append-only operating log
├── references/                  # framework references (Three Ms, Four Cs, …)
├── connections.md               # tools/accounts/sensitivity tiers (placeholder rows)
├── aios-intake.md               # the 7-question /onboard interview
├── .env.example                 # placeholder credential vars
│
├── templates/                   # public-safe starter templates
│   ├── ai-engineering-os/       # full starter pack for forking into a new project
│   ├── mcp.example.json         # MCP server config (placeholders only)
│   ├── claude.local.example.md  # settings.local.json override pattern
│   └── project-context.example.md  # context/*.md skeletons
│
├── scripts/                     # validation + inventory + public-readiness automation
│   ├── check-public-safety.sh   # banned-term gate
│   ├── audit-public-readiness.sh  # orchestrator
│   ├── inventory.sh             # regenerates docs/INVENTORY.md
│   └── validate.sh              # internal consistency
│
├── .github/workflows/           # CI: public-safety.yml + secret-scan.yml
│
└── docs/                        # SETUP · TROUBLESHOOTING · PUBLICATION_CHECKLIST · HOOKS · MCP_GOVERNANCE · …
```

## Local configuration

The repository ships in a state safe to publish. **Anything operator-specific stays out of git.** The mechanisms:

| Concern | How to handle | Where it lives |
|---|---|---|
| Real credentials | `cp .env.example .env`, edit the copy. `.env` is gitignored. | `.env` (untracked) |
| MCP servers with real tokens | Copy [`templates/mcp.example.json`](templates/mcp.example.json) to your real config path; never commit populated. | local-only |
| Personal context (filled `context/*.md`) | The shipped files are placeholders. If you fork and fill them, uncomment `# context/` in `.gitignore`. | local working copy |
| Local hook overrides | Use [`templates/claude.local.example.md`](templates/claude.local.example.md) → `settings.local.json` (gitignored). | local-only |
| Session records, memory exports, audit logs | Already gitignored. Never commit `~/.claude/state/`, `~/.claude/projects/`, `~/.claude/audit*.log`. | local-only |

If you fork this repo for personal use, the first commit on your fork should NOT include any of the above. The orchestrator (`scripts/audit-public-readiness.sh`) flags forbidden files before they can land.

## Documentation

| Topic | Doc |
|---|---|
| First-time install / adoption | [`docs/SETUP.md`](docs/SETUP.md) |
| Common failure modes | [`docs/TROUBLESHOOTING.md`](docs/TROUBLESHOOTING.md) |
| Pre-publication safety checklist | [`docs/PUBLICATION_CHECKLIST.md`](docs/PUBLICATION_CHECKLIST.md) |
| Hooks reference (all 16) | [`docs/HOOKS.md`](docs/HOOKS.md) |
| MCP governance | [`docs/MCP_GOVERNANCE.md`](docs/MCP_GOVERNANCE.md) |
| Defence-in-depth security | [`docs/SECURITY.md`](docs/SECURITY.md) |
| Vulnerability reporting | [`SECURITY.md`](SECURITY.md) |
| Contributing | [`CONTRIBUTING.md`](CONTRIBUTING.md) |
| Architecture rationale | [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) |
| Inventory (auto-generated) | [`docs/INVENTORY.md`](docs/INVENTORY.md) |
| Surface map | [`docs/SURFACE-MAP.md`](docs/SURFACE-MAP.md) |
| Common workflows | [`docs/RUNBOOK.md`](docs/RUNBOOK.md) |
| Telemetry protocol | [`docs/TELEMETRY.md`](docs/TELEMETRY.md) |
| Self-evolution layer | [`evolution/README.md`](evolution/README.md) |
| Workflow quickstart | [`docs/QUICKSTART.md`](docs/QUICKSTART.md) |

## Contributing

See [`CONTRIBUTING.md`](CONTRIBUTING.md). Hard rules:

1. Never commit secrets or real credentials.
2. Never commit personal identifiers. Use placeholders.
3. Never copy private local context — abstract into templates.
4. Don't weaken safety automation to ship faster. Fix the underlying issue.
5. Surgical changes only.

Every PR runs `scripts/check-public-safety.sh`, gitleaks, trivy, and `scripts/validate.sh` in CI. A red gate blocks merge.

## Security

- Vulnerability reporting: see [`SECURITY.md`](SECURITY.md).
- Defence model: see [`docs/SECURITY.md`](docs/SECURITY.md).
- All scans run on every PR via `.github/workflows/`.

## Credits

Patterns and skills integrated from open-source upstream projects (attribution required by their licenses):

- [Anthropic Skills Spec](https://github.com/anthropics/skills)
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) — the execution engine
- [AIS-OS](https://github.com/nateherkai/AIS-OS) — personal/business operating layer pattern
- [SocratiCode](https://github.com/giancarloerra/socraticode) — codebase intelligence
- [Warp](https://www.warp.dev/) — terminal cockpit
- [SuperClaude Framework](https://github.com/SuperClaude-Org/SuperClaude_Framework) — 31 commands + cognitive personas
- [BMAD Method](https://github.com/bmadcode/BMAD-METHOD) — 15 agile/product commands
- [oh-my-claudecode](https://github.com/nicobailon/oh-my-claudecode) — hook patterns, persistent mode
- [everything-claude-code](https://github.com/affaan-m/everything-claude-code) — context optimization
- [impeccable](https://github.com/pbakaus/impeccable) — frontend design skills (Apache 2.0)
- [wshobson](https://github.com/wshobson) — Kubernetes + quant trading skills
- [czlonkowski](https://github.com/czlonkowski) — n8n automation skills

## License

MIT. See [`LICENSE`](LICENSE).

# Claude Code Setup

A `~/.claude/` configuration that makes Claude Code behave like an owner-level engineer with explicit guardrails, governed agents, and an Elite Operations execution layer — not a chatbot.

## For whom

Engineers who want Claude Code to:
- Ship production-grade code end-to-end (`/ship`), not scaffolds.
- Inspect first, fix root-cause, and leave a regression test (`/audit-deep`, `/fix-root`).
- Refuse to commit secrets, force-push, or delete system paths without confirmation.
- Route by risk tier and authority level, not by vibe.

If you want a one-file prompt tweak, this is not it. This is a full operating environment, mounted at `~/.claude/`.

## Start here

Three entrypoints cover the common cases. Full map in [`docs/SURFACE-MAP.md`](docs/SURFACE-MAP.md).

| Intent | Command | What happens |
|--------|---------|--------------|
| Build something end-to-end | `/ship <task>` | Inspect → plan → build → validate → deliver. No placeholders. |
| Inspect before acting | `/audit-deep <area>` | 6-dimension review (arch / quality / perf / UX / security / tests) with P0–P3 severity. |
| Fix a bug the right way | `/fix-root <bug>` | Root-cause diagnosis + narrow patch + regression test. |

For planning heavy/cross-system work, `/plan` is canonical (`/ultraplan` for enterprise-risk only). Pick one.

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

## What's real today

| Tier | What it means | How many |
|------|---------------|---------:|
| **Live capabilities** | Installed and usable after `rsync`: hooks, path rules, skills, commands, agents | all of `skills/`, `commands/`, `rules/`, `hooks/`, `agents/`, `recipes/` |
| **Connected MCP servers** | Live via `claude mcp list` | 8 (see `CLAUDE.md` Tier 1) |
| **Auth-pending MCP** | Configured, needs re-auth | 2 |
| **Aspirational MCP** | Listed in docs as options; **not installed** until `claude mcp add ...` is run | 20 (see `CLAUDE.md` Tier 3 — do not assume access) |
| **Knowledge base** | Infrastructure + workflow built; content is sparse (see [`docs/KB-STATUS.md`](docs/KB-STATUS.md)) | scaffold / pilot |

## Proof

- **What a session actually looks like:** [`docs/DEMO.md`](docs/DEMO.md) — reproducible `/audit-deep → /fix-root → /ship` sequence on a target repo. Video not recorded yet; the script is.
- **What's in the repo, deterministically:** [`docs/INVENTORY.md`](docs/INVENTORY.md) — machine-generated from disk. Regenerate with `make inventory`.
- **How accumulation is measured, not asserted:** [`docs/TELEMETRY.md`](docs/TELEMETRY.md) — PreToolUse hook logs every tool call to `~/.claude/usage.jsonl`; analyze with `make usage`.
- **How drift is caught:** [`docs/COUNCIL-REMEDIATION.md`](docs/COUNCIL-REMEDIATION.md) and `make validate` — fails if documented counts diverge from disk.
- **Pruning protocol:** `docs/TELEMETRY.md` → archive zero-invocation surfaces after 14 days of real usage.

## Guardrails (active)

These hooks fire automatically (configured in `settings.json`, implemented in `hooks/*.sh` or inline):

| Trigger | What it does |
|---------|--------------|
| Every tool call | Usage telemetry (`~/.claude/usage.jsonl`), MCP whitelist gate, infinite-loop detector |
| `Write`/`Edit` to `.env` / `.pem` / `.key` / credentials | Blocks the write |
| `Write`/`Edit` to linter/formatter configs | Warns (prefer fixing code over weakening rules) |
| `git push --force` without `--force-with-lease` | Blocks |
| `rm -rf` on system paths (`/`, `~`, `/usr`, `/etc`, `/var`) | Blocks |
| Python file write | Auto-runs `ruff check --fix` + `ruff format` |
| Bash call | Appends to `~/.claude/audit.log` |
| Stop / SubagentStop | Checks uncommitted files, context usage, persistent mode |

## Architecture, briefly

```
~/.claude/
├── CLAUDE.md            # Identity, non-negotiables, Elite Operations Layer
├── settings.json        # Hook bindings, enabled plugins
├── skills/              # Prompt-library skills (SKILL.md + references)
├── commands/            # Slash commands: custom + SuperClaude + BMAD
├── agents/              # Agent definitions + REGISTRY.md dispatch table
├── rules/               # Path-scoped rules (python, typescript, security, testing, infrastructure, implementation)
├── hooks/               # Shell scripts invoked from settings.json
├── recipes/             # Parameterized YAML workflows
├── docs/                # Reference: inventory, telemetry, demo, surface map, overhead, remediation
└── kb/                  # Knowledge base — scaffold stage (see docs/KB-STATUS.md)
```

Risk tiers control execution: T0 auto, T1 log+proceed, T2 wait for approval, T3 block unless pre-authorized. Agents operate only within their declared MCP server bindings.

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

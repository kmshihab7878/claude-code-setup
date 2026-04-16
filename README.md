# Claude Code Setup

A production-grade `~/.claude/` configuration — **196 skills, 78 slash commands, 239 agent definitions, 13 recipes, 10 hook scripts**, and a governed multi-agent pipeline. Built for engineers who want Claude Code to operate as an autonomous system, not a chatbot.

## What This Is

The full `~/.claude/` directory that turns Claude Code into a governed AI operating system. Components:

- **196 skills** across 27 domains (engineering, security, trading, frontend, marketing, DevOps, AI/ML, product, design systems, knowledge-management, offensive security, and more)
- **78 slash commands** — 32 custom + 31 SuperClaude + 15 BMAD
- **239 agent definitions** organized in a 7-level authority hierarchy (L0 System Core → L6 Workers), plus Wave 1 department agents and Wave 2 surface agents
- **10 hook scripts** + 8 inline hooks (auto-formatting, MCP security gate, context guards, audit logging, sensitive-file blocking)
- **13 parameterized YAML recipes** (security, engineering, trading, devops) — 10 primary + 3 composable sub-recipes
- **17 reference documents** in `docs/` covering architecture, security, DevOps, frontend patterns, AI agents, RAG, and operating framework
- **A knowledge base** with `raw → wiki → outputs` structure, YAML frontmatter articles, source citations, decay detection

## Architecture

```
.
├── CLAUDE.md              # Master configuration — identity, rules, capabilities
├── settings.json          # Hook bindings, inline rules, MCP server refs
├── agents/                # 239 agent definitions (7 authority levels + departments)
│   ├── REGISTRY.md        # Dispatch table — authority, MCP bindings, skills
│   ├── *.md               # 68 core agents (L0-L6)
│   └── {dept}/            # Department sub-folders with stage agents
├── commands/              # 78 slash commands
│   ├── *.md               # 32 custom (plan, ultraplan, planUI, review, debug, etc.)
│   ├── sc/                # 31 SuperClaude commands
│   └── bmad/              # 15 BMAD commands
├── skills/                # 196 skills with SKILL.md + references
├── hooks/                 # 10 shell scripts (security gate, context guard, etc.)
├── rules/                 # 5 path-specific rules (python, typescript, security, testing, infrastructure)
├── recipes/               # 13 YAML workflows (security, engineering, trading, devops)
├── docs/                  # 17 reference documents
└── kb/                    # Knowledge base (raw → wiki → outputs)
    ├── CLAUDE.md          # KB operating rules
    ├── raw/               # Drop zone (never AI-edited)
    ├── wiki/              # AI-maintained articles with frontmatter + citations
    └── outputs/           # Saved query results
```

## Key Features

### Governed Execution Pipeline

Every non-trivial task flows through a 10-stage pipeline (or 15-stage `/ultraplan` for cross-system work):

```
SANITIZE → PARSE → POLICY GATE → GOAL → PLAN → POLICY GATE → DELEGATE → EXECUTE → REFLECT → TRACK → WORLD STATE → VALIDATE → DELIVER
```

Risk tiers control what runs automatically vs. what pauses for approval:

| Tier | Risk     | Behavior |
|------|----------|----------|
| T0   | Safe     | Execute immediately |
| T1   | Local    | Log and proceed |
| T2   | Shared   | Wait for user approval |
| T3   | Critical | Block unless pre-authorized |

### Agent Authority Hierarchy (66 core + departments + surfaces)

```
L0  System Core    repo-index, knowledge-graph-guide, self-review, pm-agent, agent-installer
L1  Executive      system-architect, architect, business-panel-experts
L2  Dept Heads     backend-architect, frontend-architect, security-engineer, ai-engineer,
                   devops-architect, quality-engineer, deep-research, growth-marketer,
                   performance-engineer, data-analyst
L3  Specialists    python-expert, docker-specialist, db-admin, api-designer, ux-designer...
L4  Managers       scrum-facilitator, project-shipper, release-engineer, incident-responder...
L5  Leaders        performance-optimizer, rapid-prototyper, root-cause-analyst...
L6  Workers        tester, debugger, code-reviewer, documenter, market-*...
```

See `agents/REGISTRY.md` for the full dispatch table with MCP bindings, skills, and risk tiers per agent.

### Security Guarantees

- **MCP security gate** validates every MCP tool call against `recipes/lib/mcp-whitelist.json`
- **Sensitive file writes** (`.env`, `.pem`, `.key`, credentials) are blocked by inline hooks
- **Force-push protection** — requires `--force-with-lease`, blocks destructive operations
- **Recursive delete guard** on system paths (`/`, `$HOME`, etc.)
- **Audit logging** — all Bash commands appended to `~/.claude/audit.log`
- **Context guards** — block subagent spawning above 72% context, warn at 75%
- **Pre-commit orchestration** via `pre-commit` CLI

### Knowledge Base (Karpathy-inspired)

4-layer memory stack:

1. **Vector semantic memory** — `claude-mem` plugin (SQLite + ChromaDB)
2. **Confidence-scored facts** — `MEMORY.md` with 0.0–1.0 scores
3. **Personal notes** — Obsidian vault integration via MCP (aspirational)
4. **Synthesized KB** — `kb/wiki/` articles with YAML frontmatter, source citations, decay detection

Commands: `/wiki-ingest` (ingest raw files), `/wiki-query` (research with auto-save), `/wiki-lint` (health check).

### MCP Servers

The live setup tracks **30+ MCP servers** grouped by connection status (see `CLAUDE.md` table).

- **Foundation (connected)**: filesystem, memory, sequential-thinking, git
- **Connected extras**: chrome-devtools, gmail, supabase, code-review-graph
- **Auth-pending**: google-calendar, google-drive
- **Aspirational** (not installed by default): github, context7, playwright, puppeteer, postgres, docker, kubernetes, terraform, brave-search, tavily, slack, stripe, aster, obsidian, penpot, aidesigner, notion, hermes, sim-studio

Install missing MCPs via the `mcp-mastery` skill — it contains exact `claude mcp add` commands and a gap-analysis table.

## Installation

1. **Clone into your workspace:**
   ```bash
   git clone https://github.com/kmshihab7878/claude-code-setup.git
   ```

2. **Back up your existing config and copy:**
   ```bash
   cp -r ~/.claude ~/.claude.backup.$(date +%Y%m%d) 2>/dev/null
   rsync -av --exclude='.git' claude-code-setup/ ~/.claude/
   ```

3. **Customize before first run:**
   - Edit `~/.claude/CLAUDE.md` — replace identity, email, and preferences
   - Edit `~/.claude/settings.json` — configure hooks and any local paths
   - Set environment variables for API keys (never commit these)
   - Review `~/.claude/rules/` — adapt path-specific rules to your codebase conventions

4. **Verify:**
   ```bash
   claude           # Start Claude Code — CLAUDE.md loads automatically
   /plan            # Test the governed pipeline
   claude mcp list  # See which MCP servers are live
   ```

## Customization

### Add a skill
Create `skills/<your-skill>/SKILL.md`:
```yaml
---
name: your-skill
description: "What it does and when Claude should use it"
user-invocable: true
argument-hint: "[target]"
---

Your skill instructions...
```

### Add a command
Create `commands/<your-command>.md`:
```yaml
---
description: "What it does"
---

Instructions. Use $ARGUMENTS for user input.
```

### MCP server configuration
MCP connections live in `~/.mcp.json` (per-user) or `~/.claude.json` (scoped). Neither is committed here. See the `mcp-mastery` skill for install commands and security considerations.

## Skill Highlights

| Skill | Domain | What It Does |
|-------|--------|--------------|
| `/ultraplan` | Meta | 15-stage sovereign execution pipeline with DAG cost model + knowledge capture |
| `/planUI` | Meta | UI-focused pipeline: brief → route → direction → system → build → audit → polish → ship |
| `impeccable-design` | Frontend | Anti-AI-slop design — OKLCH colors, fluid type, motion, audit scoring |
| `impeccable-audit` | Frontend | Technical quality audit with P0-P3 severity across 5 dimensions |
| `impeccable-polish` | Frontend | Final micro-detail pass on alignment, spacing, consistency |
| `hue` | Frontend | Meta-skill: brand URL/name/screenshot → generates child design-language skill |
| `react-bits` | Frontend | 130-component animated/interactive catalog with shadcn-CLI install |
| `mcp-mastery` | AI | 30-server MCP catalog, task-to-MCP routing, gap analysis |
| `b2c-app-strategist` | Product | B2C iOS app strategy — validation, MVP, 5-channel marketing |
| `council` | Strategy | Multi-advisor decision panel with anonymous peer review |
| `clone-website` | Frontend | 5-phase pixel-perfect website reconstruction |
| `/wiki-ingest` | Knowledge | Raw files → structured KB articles with frontmatter + citations |
| `/security-audit` | Security | OWASP + SAST + secrets + dependency scan |
| `/test-gen` | Quality | Generate comprehensive test suites with edge cases |

## Recipes

Parameterized YAML workflows in `recipes/`:

| Recipe | Domain |
|--------|--------|
| `security-audit` | Security |
| `secrets-scan` | Security |
| `code-review` | Engineering |
| `test-suite` | Engineering |
| `api-endpoint` | Engineering |
| `refactor` | Engineering |
| `debug-investigation` | Engineering |
| `market-scan` | Trading |
| `position-review` | Trading |
| `deploy-check` | DevOps |
| `lint-check`, `test-run`, `dep-audit` | Sub-recipes (composable) |

## Hook System

Active hooks (fire automatically — `settings.json` + `hooks/*.sh`):

| Hook | Trigger | What It Does |
|------|---------|--------------|
| `mcp-security-gate.sh` | Every MCP tool call | Validates against whitelist, logs high-risk calls |
| `loop-detector.sh` | Every tool call | Detects and breaks infinite tool loops |
| `preflight-context-guard.sh` | Agent spawning | Blocks subagents when context > 72% |
| `context-guard.sh` | Stop | Warns at 75% context, suggests `/compact` |
| `stop-verification.sh` | Stop / SubagentStop | Checks ruff, tsc, uncommitted files |
| `keyword-detector.sh` | User prompt | Auto-activates skills on keyword match |
| `session-init.sh` | Session start | Loads git, project, environment context |
| `persistent-mode.sh` | Stop | Blocks premature stop while autonomous mode active |
| `tool-failure-tracker.sh` | PostToolUse | Counts failures, suggests pivot at 3, stop at 5 |
| `session-metrics.sh` | PostToolUse (Bash) | Tracks session metrics |
| *inline* | PreToolUse (Write\|Edit) | Blocks writes to `.env`, `.pem`, `.key`, credentials |
| *inline* | PreToolUse (Bash `git push`) | Blocks `--force` without `--force-with-lease` |
| *inline* | PreToolUse (Bash `rm`) | Blocks recursive delete on system paths |
| *inline* | PostToolUse (Python write) | Auto-runs `ruff check --fix` + `ruff format` |
| *inline* | PostToolUse (Bash) | Appends all Bash commands to `~/.claude/audit.log` |

## Credits & Sources

Patterns and skills integrated from:

- [Anthropic Skills Spec](https://github.com/anthropics/skills)
- [SuperClaude](https://github.com/NicolasFlaworworworworworworworworworworworworworworworworworworwor) — 31 commands, 20+ agents
- [BMAD Method](https://github.com/bmadcode/BMAD-METHOD) — 15 agile/product commands
- [oh-my-claudecode](https://github.com/nicobailon/oh-my-claudecode) — Hook patterns, persistent mode
- [everything-claude-code](https://github.com/affaan-m/everything-claude-code) — Context optimization
- [pbakaus/impeccable](https://github.com/pbakaus/impeccable) — Frontend design skills (Apache 2.0)
- [JCodesMore/ai-website-cloner-template](https://github.com/JCodesMore/ai-website-cloner-template)
- [wshobson](https://github.com/wshobson) — Kubernetes and quant trading skills
- [alirezarezvani](https://github.com/alirezarezvani) — C-suite advisor and marketing skills
- [czlonkowski](https://github.com/czlonkowski) — n8n automation skills
- [dominikmartn/hue](https://github.com/dominikmartn/hue) — Brand design-language meta-skill
- [DavidHDev/react-bits](https://github.com/DavidHDev/react-bits) — React component catalog

## Security Posture

Before cloning this repo to your machine, note:

- `settings.local.json`, `projects/`, `audit.log`, `history.jsonl`, `.env`, `*.pem`, `*.key`, and Python bytecode (`__pycache__/`, `*.pyc`) are all `.gitignore`d
- Gitleaks-clean at commit time
- No real emails, API keys, or personal paths in tracked files (fictional examples only in skill docs)
- Email field in `CLAUDE.md` is a placeholder — fill in your own after cloning

## License

MIT

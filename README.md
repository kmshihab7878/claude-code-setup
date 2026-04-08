# Claude Code Setup

A complete, production-grade Claude Code configuration with 192 skills, 77 commands, 23 MCP server bindings, and a governed multi-agent architecture. Built for software engineers who want Claude Code to operate as an autonomous engineering system, not a chatbot.

## What This Is

This repo contains the full `~/.claude/` directory structure that turns Claude Code into a governed AI operating system. It includes:

- **192 skills** across 27 domains (engineering, security, trading, frontend, marketing, DevOps, AI/ML, product, and more)
- **77 slash commands** (31 custom + 31 SuperClaude + 15 BMAD)
- **282 agent definitions** organized in a 7-level authority hierarchy (L0 System Core → L6 Workers)
- **23 MCP server configurations** (GitHub, Playwright, Kubernetes, Terraform, Postgres, Slack, trading APIs, etc.)
- **10 hook scripts** + 8 inline hooks for auto-formatting, security gates, context guards, and audit logging
- **13 parameterized YAML recipes** for repeatable workflows
- **A knowledge base system** with raw/wiki/outputs structure and AI-maintained articles
- **12 reference documents** covering architecture, security, DevOps, frontend patterns, AI agents, RAG, and more

## Architecture

```
.
├── CLAUDE.md              # Master configuration — identity, rules, capabilities
├── settings.json          # Hook bindings, inline rules, MCP server refs
├── agents/                # 282 agent definitions (7 authority levels)
│   ├── REGISTRY.md        # Dispatch table — authority, MCP bindings, skills
│   ├── *.md               # 68 core agents (L0-L6)
│   ├── {dept}/            # 9 departments × 3 stages (intel/gen/loop)
│   └── surfaces/          # 5 surfaces × 3 stages
├── commands/              # 77 slash commands
│   ├── *.md               # 31 custom (plan, ultraplan, review, debug, etc.)
│   ├── sc/                # 31 SuperClaude commands
│   └── bmad/              # 15 BMAD commands
├── skills/                # 192 skills with SKILL.md + references
├── hooks/                 # 10 shell scripts (security gate, context guard, etc.)
├── rules/                 # 5 path-specific rules (python, typescript, security, etc.)
├── recipes/               # 13 YAML workflows (security, engineering, trading, devops)
├── docs/                  # 12 reference documents
└── kb/                    # Knowledge base (raw → wiki → outputs)
    ├── CLAUDE.md          # KB operating rules
    ├── raw/               # Drop zone (never AI-edited)
    ├── wiki/              # AI-maintained articles
    └── outputs/           # Saved query results
```

## Key Features

### Governed Execution Pipeline

Every task flows through a 10-stage pipeline (or 15-stage `/ultraplan` for complex work):

```
SANITIZE → PARSE → POLICY GATE → PLAN → VALIDATE → DELEGATE → EXECUTE → REFLECT → TRACK → DELIVER
```

Risk tiers control what runs automatically vs. what pauses for approval:

| Tier | Risk | Behavior |
|------|------|----------|
| T0 | Safe | Execute immediately |
| T1 | Local | Log and proceed |
| T2 | Shared | Wait for user approval |
| T3 | Critical | Block unless pre-authorized |

### Agent Authority Hierarchy

```
L0  System Core    repo-index, knowledge-graph-guide, self-review
L1  Executive      system-architect, architect, business-panel-experts
L2  Dept Heads     backend-architect, frontend-architect, security-engineer, ai-engineer...
L3  Specialists    python-expert, docker-specialist, db-admin, api-designer...
L4  Managers       scrum-facilitator, project-shipper, release-engineer...
L5  Leaders        performance-optimizer, rapid-prototyper, root-cause-analyst...
L6  Workers        tester, debugger, code-reviewer, documenter...
```

### Security

- MCP security gate validates every tool call against a whitelist
- Sensitive file writes (.env, .pem, .key, credentials) are blocked by hooks
- Force-push protection requires `--force-with-lease`
- Recursive delete on system paths is blocked
- Audit logging for all Bash commands
- Pre-commit hook orchestration via `pre-commit`

### Knowledge Base (Karpathy Method)

A 4-layer memory stack:

1. **Vector semantic memory** — claude-mem plugin (SQLite + ChromaDB)
2. **Confidence-scored facts** — MEMORY.md with 0.0-1.0 scores
3. **Personal notes** — Obsidian vault integration via MCP
4. **Synthesized KB** — `kb/wiki/` articles with YAML frontmatter, source citations, decay detection

Commands: `/wiki-ingest`, `/wiki-query`, `/wiki-lint`

## Installation

1. **Clone into your home directory:**
   ```bash
   git clone https://github.com/kmshihab7878/claude-code-setup.git
   ```

2. **Copy to `~/.claude/`:**
   ```bash
   # Back up your existing config first
   cp -r ~/.claude ~/.claude.backup 2>/dev/null

   # Copy everything except .git
   rsync -av --exclude='.git' claude-code-setup/ ~/.claude/
   ```

3. **Customize:**
   - Edit `CLAUDE.md` — replace identity, email, and preferences
   - Edit `settings.json` — configure your MCP server connections
   - Replace `<YOUR_USER>` placeholders in hooks and skills with your username
   - Add API keys to your environment (never in the repo)

4. **Verify:**
   ```bash
   claude  # Start Claude Code — it should load CLAUDE.md automatically
   /plan   # Test the governed pipeline
   ```

## Customization

### Adding Your Own Skills

Create `skills/<your-skill>/SKILL.md`:
```yaml
---
name: your-skill
description: "What it does"
user-invocable: true
argument-hint: "[target]"
---

Your skill instructions here...
```

### Adding Commands

Create `commands/<your-command>.md`:
```yaml
---
description: "What it does"
---

Your command instructions. Use $ARGUMENTS for user input.
```

### MCP Servers

MCP server connections are configured in `settings.json` (not in this repo — that file is gitignored for security). See `CLAUDE.md` for the full list of 23 supported servers.

## Skill Highlights

| Skill | Domain | What It Does |
|-------|--------|-------------|
| `/impeccable-design` | Frontend | Anti-AI-slop design guidance — OKLCH colors, fluid type, audit scoring |
| `/impeccable-audit` | Frontend | Technical quality audit with P0-P3 severity across 5 dimensions |
| `/b2c-app-strategist` | Product | B2C iOS app strategy — validation, MVP planning, 5-channel marketing |
| `/ultraplan` | Meta | 15-stage sovereign execution pipeline with DAG cost model |
| `/council` | Strategy | Multi-advisor panel for strategic decisions |
| `/clone-website` | Frontend | 5-phase pixel-perfect website reconstruction |
| `/wiki-ingest` | Knowledge | Process raw files into structured KB articles |
| `/security-audit` | Security | Full OWASP + SAST + secrets scan |
| `/test-gen` | Quality | Generate comprehensive test suites |

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

## Hook System

| Hook | Trigger | What It Does |
|------|---------|-------------|
| `mcp-security-gate.sh` | Every MCP tool call | Validates against whitelist, logs high-risk calls |
| `loop-detector.sh` | Every tool call | Detects and breaks infinite loops |
| `preflight-context-guard.sh` | Agent spawning | Blocks subagents when context >72% |
| `stop-verification.sh` | Session end | Checks for lint errors, uncommitted files |
| `keyword-detector.sh` | User prompt | Auto-activates skills on keyword match |
| `session-init.sh` | Session start | Loads git, project, environment context |

## Credits & Sources

This setup integrates patterns and skills from:

- [Anthropic Skills Spec](https://github.com/anthropics/skills)
- [SuperClaude](https://github.com/NicolasFlaworworworworworworworworworworworworworworworworworwor) — 31 commands, 20+ agents
- [BMAD](https://github.com/bmadcode/BMAD-METHOD) — 15 agile/product commands
- [oh-my-claudecode](https://github.com/nicobailon/oh-my-claudecode) — Hook patterns, persistent mode
- [everything-claude-code](https://github.com/affaan-m/everything-claude-code) — Context optimization patterns
- [pbakaus/impeccable](https://github.com/pbakaus/impeccable) — Frontend design skills (Apache 2.0)
- [JCodesMore/ai-website-cloner-template](https://github.com/JCodesMore/ai-website-cloner-template) — Website cloning skill
- [wshobson](https://github.com/wshobson) — Kubernetes and quant trading skills
- [alirezarezvani](https://github.com/alirezarezvani) — C-suite advisor and marketing skills
- [czlonkowski](https://github.com/czlonkowski) — n8n automation skills

## License

MIT

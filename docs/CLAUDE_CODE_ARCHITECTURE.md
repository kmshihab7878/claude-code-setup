# Khaled's Claude Code Architecture

> **Owner**: Khaled Shihab (kmshihab7878)
> **Platform**: macOS ARM64 (Apple Silicon)
> **Last Updated**: 2026-03-15

---

## 1. At a Glance

| Metric | Count |
|--------|-------|
| MCP Servers | 8 |
| Agents | 40 (13 custom + 20 SuperClaude + 6 domain + 1 installer) |
| Commands | 56 (10 custom + 31 SuperClaude + 15 BMAD) |
| Skills | 34 directories |
| Hooks | 3 (PreToolUse, PostToolUse, Notification) |
| Memory Files | 4 + MEMORY.md index |
| Active Projects | JARVIS-FRESH, FINCALC AI, Financial Intelligence Dept, SuperClaude |

---

## 2. Directory Tree

```
~/.claude/
├── CLAUDE.md                    # Global instructions (identity, non-negotiables, rosters)
├── settings.json                # Hooks, plugins, effort level
├── claude.json                  # MCP server configurations (sibling: ~/.claude.json)
├── audit.log                    # PostToolUse bash audit trail (~4500 entries)
│
├── agents/                      # 40 agent definitions (.md)
│   ├── code-reviewer.md         # Custom (13)
│   ├── security-auditor.md
│   ├── architect.md
│   ├── tester.md
│   ├── debugger.md
│   ├── refactorer.md
│   ├── documenter.md
│   ├── performance-optimizer.md
│   ├── infra-engineer.md
│   ├── docker-specialist.md
│   ├── ci-cd-engineer.md
│   ├── db-admin.md
│   ├── api-designer.md
│   ├── backend-architect.md     # SuperClaude (20)
│   ├── frontend-architect.md
│   ├── system-architect.md
│   ├── devops-architect.md
│   ├── python-expert.md
│   ├── security-engineer.md
│   ├── quality-engineer.md
│   ├── performance-engineer.md
│   ├── technical-writer.md
│   ├── refactoring-expert.md
│   ├── root-cause-analyst.md
│   ├── deep-research.md
│   ├── learning-guide.md
│   ├── socratic-mentor.md
│   ├── repo-index.md
│   ├── requirements-analyst.md
│   ├── pm-agent.md
│   ├── self-review.md
│   ├── business-panel-experts.md
│   ├── growth-marketer.md       # Domain (6)
│   ├── content-strategist.md
│   ├── ux-designer.md
│   ├── data-analyst.md
│   ├── incident-responder.md
│   ├── scrum-facilitator.md
│   ├── agent-installer.md       # VoltAgent installer
│   └── README.md
│
├── commands/                    # 10 custom + 31 SC + 15 BMAD
│   ├── context-load.md
│   ├── debug.md
│   ├── explain.md
│   ├── optimize.md
│   ├── plan.md
│   ├── pr-prep.md
│   ├── review.md
│   ├── security-audit.md
│   ├── spec.md
│   ├── test-gen.md
│   ├── sc/                      # SuperClaude commands (31)
│   └── bmad/                    # BMAD commands (15)
│
├── skills/                      # 34 skill directories
│   ├── api-design-patterns/
│   ├── aster-trading/           # DeFi trading via Aster MCP
│   ├── baseline-ui/
│   ├── bmad/
│   ├── branch-finishing/        # KhaledPowers
│   ├── browser-automation-safety/
│   ├── claude-api/
│   ├── coding-workflow/
│   ├── confidence-check/
│   ├── database-patterns/
│   ├── devops-patterns/
│   ├── doc-coauthoring/
│   ├── document-handling/
│   ├── executing-plans/         # KhaledPowers
│   ├── fixing-accessibility/
│   ├── fixing-metadata/
│   ├── fixing-motion-performance/
│   ├── frontend-design/
│   ├── git-workflows/
│   ├── git-worktrees/           # KhaledPowers
│   ├── mcp-builder/
│   ├── pdf/
│   ├── receiving-code-review/   # KhaledPowers
│   ├── research-methodology/
│   ├── security-review/
│   ├── skill-architect/
│   ├── skill-creator/
│   ├── subagent-development/    # KhaledPowers
│   ├── test-driven-development/ # KhaledPowers
│   ├── testing-methodology/
│   ├── ui-ux-pro-max/           # 50+ styles, 97 palettes, BM25 search
│   ├── using-khaledpowers/      # KhaledPowers meta-skill (always active)
│   ├── verification-before-completion/ # KhaledPowers
│   ├── webapp-testing/
│   └── xlsx/
│
├── skills-audit/                # Audit documentation
│   ├── MASTER_AUDIT.md
│   ├── MIGRATION_MATRIX.md
│   ├── RISK_REGISTER.md
│   ├── REJECTED_SKILLS.md
│   └── CHECKPOINTS.md
│
├── projects/                    # Per-project configs and memory
│   └── -Users-<YOUR_USER>/
│       └── memory/
│           ├── MEMORY.md        # Index (auto-loaded)
│           ├── architecture.md
│           ├── decisions.md
│           ├── mistakes.md
│           └── patterns.md
│
├── docs/                        # Reference documents (this file)
├── plugins/                     # Pyright LSP
├── config/                      # Additional config
├── plans/                       # Saved plans
├── tasks/                       # Task tracking
├── sessions/                    # Session data
├── cache/                       # Cache files
└── telemetry/                   # Usage telemetry

```

---

## 3. MCP Server Architecture

| # | Server | Transport | Command / URL | Tools | Auth |
|---|--------|-----------|---------------|-------|------|
| 1 | **penpot** | HTTP | `http://localhost:4401/mcp` | 5 | None (local) |
| 2 | **memory** | stdio | `npx @anthropic/memory-server` | 8 | None |
| 3 | **filesystem** | stdio | `npx @anthropic/filesystem-server` | 12 | None (scoped) |
| 4 | **sequential** | stdio | `npx @anthropic/sequential-thinking` | 1 | None |
| 5 | **github** | stdio | `npx @anthropic/github-mcp-server` | 20+ | GitHub PAT |
| 6 | **context7** | stdio | `npx @upstash/context7-mcp` | 2 | None |
| 7 | **docker** | stdio | Docker MCP server | 6 | Docker socket |
| 8 | **aster** | stdio | `~/.venv/bin/python -m aster_mcp.simple_server` | 44 | Fernet-encrypted HMAC |

### Server Notes

- **penpot**: Requires `cd ~/Projects/penpot-mcp && npm run start:all` first. Ports: HTTP 4401, WS 4402, Plugin 4400.
- **aster**: Keys stored Fernet-encrypted in `~/.config/aster-mcp/`. Supports HMAC and EIP-712 V3 auth. Futures + Spot.
- **github**: PAT stored via `gh auth`. Never expose in logs.
- **filesystem**: Scoped to allowed directories only.

---

## 4. Agent Roster

### Custom Agents (13)

| Agent | Domain | Primary Use |
|-------|--------|-------------|
| code-reviewer | Quality | PR review, code quality checks |
| security-auditor | Security | Vulnerability scanning, compliance |
| architect | Design | System design, architecture decisions |
| tester | Quality | Test writing, coverage analysis |
| debugger | Debug | Root cause analysis, bug investigation |
| refactorer | Quality | Code cleanup, pattern extraction |
| documenter | Docs | API docs, README, inline docs |
| performance-optimizer | Perf | Profiling, bottleneck identification |
| infra-engineer | DevOps | Terraform, cloud infrastructure |
| docker-specialist | DevOps | Dockerfile, compose, container optimization |
| ci-cd-engineer | DevOps | GitHub Actions, pipeline setup |
| db-admin | Data | Schema design, migrations, query tuning |
| api-designer | Design | REST/GraphQL API design, OpenAPI specs |

### SuperClaude Agents (20)

| Agent | Domain |
|-------|--------|
| backend-architect | Backend systems design |
| frontend-architect | UI architecture, design tokens, motion |
| system-architect | Distributed systems, scalability |
| devops-architect | Infrastructure automation |
| python-expert | Production Python, SOLID principles |
| security-engineer | Vulnerability detection, compliance |
| quality-engineer | Testing strategies, measurable targets |
| performance-engineer | Measurement-driven optimization |
| technical-writer | Documentation, audience-tailored |
| refactoring-expert | Tech debt reduction, clean code |
| root-cause-analyst | Evidence-based investigation |
| deep-research | Adaptive external research |
| learning-guide | Progressive learning, examples |
| socratic-mentor | Discovery learning via questioning |
| repo-index | Repository indexing, codebase briefing |
| requirements-analyst | Requirements discovery, specs |
| pm-agent | Self-improvement workflows, sprints |
| self-review | Post-implementation validation |
| business-panel-experts | Multi-expert business strategy |
| agent-installer | Discover and install community agents |

### Domain Agents (6)

| Agent | Domain |
|-------|--------|
| growth-marketer | Acquisition, retention, referral |
| content-strategist | SEO, brand voice, content auditing |
| ux-designer | User research, journey mapping |
| data-analyst | Statistical analysis, ETL patterns |
| incident-responder | Incident classification, post-mortems |
| scrum-facilitator | Sprint planning, retrospectives |

### BMAD Agents (9)

BMad Master (orchestrator), Analyst, PM, Architect, Scrum Master, Developer, UX Designer, Builder, Creative Intelligence.

---

## 5. Command Catalog

### Custom Commands (10)

| Command | Purpose | KhaledPowers Gate |
|---------|---------|-------------------|
| `/review` | Code review | +SHA-based requesting |
| `/security-audit` | Security review | — |
| `/debug` | Bug investigation | +Root cause gate |
| `/plan` | RIPER framework planning | +Task granularity |
| `/optimize` | Performance optimization | — |
| `/test-gen` | Generate tests | — |
| `/pr-prep` | Prepare PR | — |
| `/context-load` | Load project context | — |
| `/explain` | Explain code/concepts | — |
| `/spec` | Write specifications | — |

### SuperClaude Commands (31)

| Command | Purpose | KhaledPowers Gate |
|---------|---------|-------------------|
| `/sc:agent` | Agent selection | — |
| `/sc:analyze` | Code analysis | — |
| `/sc:brainstorm` | Requirements discovery | +Approval gate |
| `/sc:build` | Build/compile projects | — |
| `/sc:cleanup` | Dead code removal | — |
| `/sc:design` | System/API design | — |
| `/sc:document` | Documentation | — |
| `/sc:estimate` | Development estimates | — |
| `/sc:explain` | Code explanations | — |
| `/sc:git` | Git operations | — |
| `/sc:help` | List SC commands | — |
| `/sc:implement` | Feature implementation | — |
| `/sc:improve` | Code quality improvements | — |
| `/sc:index` | Project documentation | — |
| `/sc:index-repo` | Repository indexing (94% token reduction) | — |
| `/sc:load` | Session context loading | — |
| `/sc:pm` | Project management | — |
| `/sc:recommend` | Command recommendation | — |
| `/sc:reflect` | Task validation | — |
| `/sc:research` | Deep web research | — |
| `/sc:save` | Session persistence | — |
| `/sc:sc` | Command dispatcher | — |
| `/sc:select-tool` | MCP tool selection | — |
| `/sc:spawn` | Task orchestration | +Status protocol, two-stage review, domain grouping |
| `/sc:spec-panel` | Multi-expert spec review | — |
| `/sc:task` | Task management | — |
| `/sc:test` | Test execution | — |
| `/sc:troubleshoot` | Issue diagnosis | — |
| `/sc:workflow` | Implementation workflows | — |
| `/sc:business-panel` | Business strategy panel | — |
| `/sc:README` | SuperClaude readme | — |

### BMAD Commands (15)

`/bmad:workflow-init`, `/bmad:workflow-status`, `/bmad:product-brief`, `/bmad:prd`, `/bmad:tech-spec`, `/bmad:architecture`, `/bmad:solutioning-gate-check`, `/bmad:sprint-planning`, `/bmad:create-story`, `/bmad:dev-story`, `/bmad:brainstorm`, `/bmad:research`, `/bmad:create-agent`, `/bmad:create-workflow`, `/bmad:create-ux-design`

---

## 6. Skills Matrix

### By Category

| Category | Skills | Count |
|----------|--------|-------|
| **KhaledPowers** | using-khaledpowers, test-driven-development, verification-before-completion, executing-plans, subagent-development, git-worktrees, branch-finishing, receiving-code-review | 8 |
| **Security & Quality** | security-review, confidence-check, testing-methodology, coding-workflow | 4 |
| **Frontend & Design** | ui-ux-pro-max, baseline-ui, frontend-design, fixing-accessibility, fixing-metadata, fixing-motion-performance | 6 |
| **API & Backend** | api-design-patterns, database-patterns, claude-api, devops-patterns | 4 |
| **Trading & DeFi** | aster-trading | 1 |
| **Tooling & Meta** | skill-creator, skill-architect, mcp-builder, doc-coauthoring, document-handling, pdf, xlsx, webapp-testing, browser-automation-safety, git-workflows, research-methodology | 11 |

### KhaledPowers Cross-References

| Skill | Enforces Non-Negotiable | Modifies Commands |
|-------|-------------------------|-------------------|
| using-khaledpowers (meta) | All 6-10 | Activates all below |
| test-driven-development | #6 Test first | — |
| verification-before-completion | #8 Evidence first | — |
| executing-plans | #9 Approval first | `/plan` |
| subagent-development | — | `/sc:spawn` |
| git-worktrees | — | — |
| branch-finishing | — | — |
| receiving-code-review | — | `/review` |

---

## 7. Hooks & Enforcement

### PreToolUse: Sensitive File Guard

- **Matcher**: `Write|Edit`
- **Action**: Blocks writes to files matching `.env`, `.pem`, `.key`, `credentials`, `secret`
- **Exit code**: 2 (blocks tool execution)
- **Enforces**: Non-Negotiable #2 (Security-first)

```bash
echo "$TOOL_INPUT" | grep -qiE '\.(env|pem|key)$|credentials|secret' && \
  echo 'BLOCKED: Cannot write to sensitive files' && exit 2 || exit 0
```

### PostToolUse: Bash Audit Log

- **Matcher**: `Bash`
- **Action**: Appends timestamp + first 200 chars of command to `~/.claude/audit.log`
- **Enforces**: Non-Negotiable #3 (Verify before asserting), Traceability

```bash
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Bash: $(echo "$TOOL_INPUT" | head -c 200)" >> ~/.claude/audit.log
```

### Notification: Task Complete Alert

- **Matcher**: `""` (all notifications)
- **Action**: macOS notification via `osascript`

```bash
osascript -e 'display notification "Task completed" with title "Claude Code"' 2>/dev/null; exit 0
```

---

## 8. Memory System

### Memory Files

| File | Type | Purpose |
|------|------|---------|
| `MEMORY.md` | Index | Auto-loaded; links to all memory files |
| `architecture.md` | Reference | System overviews (JARVIS-FRESH, FINCALC AI) |
| `decisions.md` | Record | Architecture Decision Records (ADR log) |
| `mistakes.md` | Learning | Error journal (what, root cause, prevention) |
| `patterns.md` | Reference | Code patterns and conventions |

### Memory Types

| Type | Purpose | Trigger |
|------|---------|---------|
| `user` | User profile, preferences | Learn about user role/goals |
| `feedback` | Corrections, guidance | User corrects approach |
| `project` | Ongoing work context | Learn who/what/why/when |
| `reference` | External system pointers | External resources mentioned |

### Location

```
~/.claude/projects/-Users-<YOUR_USER>/memory/
```

---

## 9. Projects Inventory

### JARVIS-FRESH

- **Path**: `~/JARVIS-FRESH/`
- **Stack**: Python 3.10+, FastAPI, SQLAlchemy (async), PostgreSQL, Redis, WebSocket
- **LLM**: OpenAI + Anthropic + Ollama (unified prompt, fallback chain)
- **Architecture**: GAOS (Governed Autonomous Operating System) — CoreMind orchestrator, 10-stage pipeline, 5-layer safety stack
- **Constitution**: `CLAUDE.md` (COMPASS) — SEC-001 coordinator guard, PolicyGate tiers, SHA-256 hash chain audit
- **Key modules**: `src/jarvis/gaos/`, `src/jarvis/security/`, `src/jarvis/core/contracts/`, `src/jarvis/agents/`
- **Governance scripts**: `scripts/compass/compass_check.sh`, `patterns.blocklist.txt`
- **Git hooks**: `.githooks/pre-commit`, `.githooks/pre-push` (compass checks)

### FINCALC AI

- **Path**: `~/FINCALC AI/`
- **Type**: Financial calculator application

### Financial Intelligence Department

- **Path**: `~/Financial Intelligence Department /`
- **Type**: Financial analysis and intelligence

### SuperClaude

- **Path**: `~/SuperClaude/`
- **Version**: v4.2.0
- **Type**: Agent framework (31 commands, 20+ agents)

---

## 10. Non-Negotiables & Process Gates

| # | Rule | Enforcement Mechanism |
|---|------|----------------------|
| 1 | No fabrication | Verification skill, self-review agent |
| 2 | Security-first | PreToolUse hook (blocks .env/.pem/.key), security-review skill |
| 3 | Verify before asserting | PostToolUse audit log, verification-before-completion skill |
| 4 | Incremental changes | git-workflows skill, branch-finishing skill |
| 5 | Existing conventions | coding-workflow skill, patterns.md memory |
| 6 | Test first | test-driven-development skill (KhaledPowers) |
| 7 | Root cause first | `/debug` command (+root cause gate), root-cause-analyst agent |
| 8 | Evidence first | verification-before-completion skill (KhaledPowers) |
| 9 | Approval first | `/sc:brainstorm` (+approval gate), executing-plans skill |
| 10 | 1% rule | using-khaledpowers meta-skill (always active) |

---

## 11. Quick Reference

### Session Startup Checklist

1. Check MEMORY.md for relevant context
2. Check project-specific CLAUDE.md if working in a project
3. Verify MCP servers are running (penpot requires manual start)
4. Review recent git log for branch context
5. Apply thinking depth: standard / think hard / ultrathink

### Thinking Depth Guide

| Task Type | Level | Examples |
|-----------|-------|---------|
| Standard | Default | Simple edits, file lookups, git status |
| Complex | think hard | Multi-file changes, debugging, refactoring |
| Critical | ultrathink | Architecture, security, data migration, trading |

### 1% Rule Workflow

1. Task arrives
2. Scan skill list — does any skill have even 1% relevance?
3. If yes: check the skill before proceeding
4. If no: proceed normally
5. Never rationalize skipping a potentially relevant skill

### Code Quality Gate

- Type hints on all Python function signatures
- No bare `except:` — catch specific exceptions
- No TODO/FIXME without a linked issue
- Follow existing project conventions first
- Tests for all new functionality (RED-GREEN-REFACTOR)

### Key Paths

| What | Path |
|------|------|
| Global config | `~/.claude/CLAUDE.md` |
| Hooks & settings | `~/.claude/settings.json` |
| MCP config | `~/.claude.json` |
| Audit log | `~/.claude/audit.log` |
| Memory index | `~/.claude/projects/-Users-<YOUR_USER>/memory/MEMORY.md` |
| Aster keys | `~/.config/aster-mcp/` (encrypted) |
| Penpot MCP | `~/Projects/penpot-mcp/` |
| Aster MCP | `~/Projects/aster-mcp/` |
| Skills audit | `~/.claude/skills-audit/` |

---

## 12. External Integrations & Ecosystem

### Evaluated Tools (see PRODUCT_EVALUATIONS.md)

| Tool | Category | Status | Integration |
|------|----------|--------|-------------|
| Serena | Code Intelligence MCP | Evaluate | Potential MCP Server #9 |
| Firecrawl | Web Scraping MCP | Evaluate | Potential MCP Server #10 |
| pfMCP | Financial Operations | Evaluate | Potential MCP Server #11 |

### Reference Documentation

| Document | Purpose | Content |
|----------|---------|---------|
| `CLAUDE_CODE_ECOSYSTEM.md` | Claude Code tools & extensions | Templates, agents, MCP servers |
| `SECURITY_ARSENAL.md` | Security tools inventory | Recon, scanning, exploitation, forensics |
| `FINANCE_ML_STACK.md` | Financial ML toolkit | Data sources, models, risk metrics |
| `AI_AGENT_LANDSCAPE.md` | Agent framework comparison | AG2, Parlant, LiveKit, patterns |
| `RAG_LLM_REFERENCE.md` | RAG/LLM optimization | Chunking, embeddings, caching |
| `DATA_PLATFORM_GUIDE.md` | Data/analytics tools | Metabase, Superset, Airbyte |
| `DEVOPS_TOOLKIT.md` | DevOps tools | Tauri, Devbox, Hatchet, Nezha |
| `FRONTEND_PATTERNS.md` | UI/frontend patterns | shadcn/ui, terminal UI, automation |
| `PRODUCT_EVALUATIONS.md` | Product evaluations | AI tools, MCP servers, platforms |
| `LEARNING_ROADMAP.md` | Learning paths | AI/ML, LLM apps, DevOps, DS/Algo |
| `CURATED_TOOLS.md` | Misc tools | macOS monitoring, terminal tools |

### Skills Added (2026-03-15)

| Skill | Category | Purpose |
|-------|----------|---------|
| `offensive-security` | Security | Pen testing, CTF, vulnerability assessment |
| `osint-recon` | Security | OSINT investigation, username enumeration |
| `finance-ml` | Finance | ML models, technical indicators, backtesting |
| `agent-orchestration` | Agents | Multi-agent coordination, delegation |
| `multi-agent-patterns` | Agents | Design patterns for agent systems |
| `rag-patterns` | AI/ML | RAG architecture, chunking, evaluation |
| `data-analysis` | Data | NL→SQL, visual exploration, ETL |
| `responsive-design` | Frontend | Mobile-first, breakpoints, fluid typography |

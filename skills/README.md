# Skill Catalog

50 skills organized by taxonomy. Flat directories, tag-based discovery.

## Governance

- Template: [_shared/skill-template.md](_shared/skill-template.md)
- Review gate: [_shared/review-checklist.md](_shared/review-checklist.md)
- Naming rules: [_shared/naming-conventions.md](_shared/naming-conventions.md)

## Catalog

### Foundation (10) — Process gates, operating rules

| Skill | Risk | Tags | Description |
|-------|------|------|-------------|
| operating-framework | low | process, routing | KhaledPowers operating framework v1.0 — lane routing, risk tiers, councils |
| using-khaledpowers | low | meta, process | Meta-skill — always active, routes to other KhaledPowers skills |
| confidence-check | low | gate, quality | Pre-implementation confidence assessment (>=90% required) |
| test-driven-development | low | gate, testing | RED-GREEN-REFACTOR enforcement |
| verification-before-completion | low | gate, quality | No "done" without evidence |
| executing-plans | low | process, workflow | Plan execution with task tracking |
| branch-finishing | low | git, process | Branch completion workflow |
| subagent-development | low | agents, process | Subagent-driven development patterns |
| receiving-code-review | low | git, quality | Code review response workflow |
| git-worktrees | low | git, process | Git worktree management |

### Engineering (8) — Code patterns, architecture, process

| Skill | Risk | Tags | Description |
|-------|------|------|-------------|
| api-design-patterns | low | api, patterns | REST/GraphQL design — naming, methods, status codes, pagination |
| database-patterns | low | database, patterns | Schema design, migrations, indexing, query optimization |
| devops-patterns | medium | infra, cloud | Terraform, Kubernetes, Docker, CI/CD patterns |
| testing-methodology | low | testing, patterns | Test pyramid, AAA, coverage targets, edge cases |
| coding-workflow | low | process, patterns | Pre-implementation checklist, incremental development |
| git-workflows | low | git, patterns | Commit conventions, branching strategies, PR best practices |
| research-methodology | low | research, process | Search workflows, source credibility, citation management |
| data-analysis | low | data, analytics | NL-to-SQL, visual exploration, ETL, database modeling |

### AI (4) — LLM, agents, RAG

| Skill | Risk | Tags | Description |
|-------|------|------|-------------|
| multi-agent-patterns | medium | agents, architecture | Design patterns + orchestration: supervisor, pipeline, swarm, delegation, lifecycle |
| rag-patterns | low | llm, retrieval | Chunking, embeddings, retrieval tuning, agentic RAG, memory |
| claude-api | low | llm, api | Claude API/Anthropic SDK — model IDs, streaming, tool use, Agent SDK |
| mcp-builder | medium | mcp, tooling | Build MCP servers — 4-phase workflow, tool naming, eval framework |

### Security (3) — Audit, offense, recon

| Skill | Risk | Tags | Description |
|-------|------|------|-------------|
| security-review | medium | security, audit | OWASP Top 10, secrets scanning, auth patterns, container security |
| offensive-security | high | security, pentest | Penetration testing, vulnerability assessment, CTF (authorized only) |
| osint-recon | high | security, recon | OSINT investigation, username enumeration, domain intel (authorized only) |

### Frontend (6) — Design, accessibility, performance

| Skill | Risk | Tags | Description |
|-------|------|------|-------------|
| baseline-ui | low | ui, tailwind | Tailwind constraints + responsive design: mobile-first, breakpoints, fluid typography |
| frontend-design | low | ui, creative | Bold aesthetics, typography, color systems, motion, anti-AI-slop |
| fixing-accessibility | low | ui, a11y | ARIA, keyboard nav, focus management, contrast, WCAG |
| fixing-metadata | low | seo, meta | Titles, descriptions, OG tags, canonical URLs, JSON-LD |
| fixing-motion-performance | low | ui, performance | Animation perf: compositor props, scroll-linked motion, blur |
| ui-ux-pro-max | low | ui, design-system | 50+ styles, 97 palettes, 57 font pairings, 9 stacks |

### Tools (5) — Document processing, testing, docs

| Skill | Risk | Tags | Description |
|-------|------|------|-------------|
| pdf | low | documents, processing | Read, create, merge, split, OCR PDFs |
| xlsx | low | documents, processing | Spreadsheet formulas, financial models, pandas+openpyxl |
| webapp-testing | medium | testing, browser | Playwright testing + browser automation safety rules |
| doc-coauthoring | low | writing, workflow | 3-stage context-refinement-reader testing for docs |
| skill-creator | low | meta, tooling | Create, improve, benchmark skills with eval framework |

### Domain (4) — Trading, finance, optimization, meta

| Skill | Risk | Tags | Description |
|-------|------|------|-------------|
| autoresearch | medium | optimization, loop | Autonomous self-improvement loop — propose, test, keep/revert. Karpathy-inspired. Trading, code quality, prompts, config |
| finance-ml | medium | finance, ml | Price prediction, portfolio optimization, risk metrics, backtesting |
| aster-trading | high | trading, defi | Aster DEX futures/spot trading, risk rules, 44 MCP tools |
| skill-architect | low | meta, governance | Build, validate, improve skills — design-first with YAML frontmatter |

### Framework (1) — Product workflow

| Skill | Risk | Tags | Description |
|-------|------|------|-------------|
| bmad | low | product, workflow | BMAD Method — 15 commands, 9 agents, product lifecycle |

## Tag Index

| Tag | Skills |
|-----|--------|
| process | operating-framework, using-khaledpowers, executing-plans, branch-finishing, coding-workflow, research-methodology, subagent-development, git-worktrees |
| gate | confidence-check, test-driven-development, verification-before-completion |
| quality | confidence-check, verification-before-completion, receiving-code-review |
| git | branch-finishing, receiving-code-review, git-worktrees, git-workflows |
| testing | test-driven-development, testing-methodology, webapp-testing |
| ui | baseline-ui, frontend-design, fixing-accessibility, fixing-motion-performance, ui-ux-pro-max, fixing-metadata |
| security | security-review, offensive-security, osint-recon |
| agents | subagent-development, multi-agent-patterns |
| patterns | api-design-patterns, database-patterns, devops-patterns, testing-methodology, coding-workflow, git-workflows |
| meta | using-khaledpowers, skill-creator, skill-architect |
| llm | rag-patterns, claude-api, mcp-builder |
| documents | pdf, xlsx, doc-coauthoring |
| data | data-analysis, finance-ml |
| optimization | autoresearch |
| trading | aster-trading, finance-ml, autoresearch |
| api | api-design-patterns, claude-api |
| database | database-patterns |
| infra | devops-patterns |
| mcp | mcp-builder |
| creative | frontend-design, ui-ux-pro-max |
| a11y | fixing-accessibility |
| seo | fixing-metadata |
| performance | fixing-motion-performance |
| writing | doc-coauthoring |
| research | research-methodology, data-analysis |
| workflow | coding-workflow, executing-plans, operating-framework, bmad |
| product | bmad |
| finance | finance-ml, aster-trading |
| recon | osint-recon |
| pentest | offensive-security |
| codebase | understand, understand-chat, understand-diff, understand-explain, understand-jarvis, understand-setup, understand-onboard, understand-memory-sync, understand-dashboard |
| governance | skill-architect, operating-framework |
| tooling | skill-creator, mcp-builder, webapp-testing |

## Deleted Skills (Absorbed)

These skills were consolidated and their content absorbed into existing skills:

| Former Skill | Absorbed Into | Date |
|--------------|--------------|------|
| responsive-design | baseline-ui | 2026-03-17 |
| document-handling | pdf + xlsx | 2026-03-17 |
| browser-automation-safety | webapp-testing | 2026-03-17 |
| agent-orchestration | multi-agent-patterns | 2026-03-17 |

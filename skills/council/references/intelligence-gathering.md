# Intelligence gathering (Phase 0 detail)

Domain classification table, per-domain MCP-data-source map, semantic + project memory checks, and the Intelligence Brief format. SKILL.md keeps the five-step summary; this file holds the full tables.


**Step 1: Classify the question domain.**

| Domain | Signals |
|--------|---------|
| engineering | code, architecture, technical debt, API, performance, testing |
| trading | positions, market, price, entry, exit, risk, funding, portfolio |
| product | feature, launch, users, retention, pricing, roadmap, PMF |
| infrastructure | deploy, scale, uptime, cost, cloud, containers, monitoring |
| security | vulnerability, breach, compliance, audit, access, encryption |
| growth | acquisition, activation, retention, revenue, referral, CAC, LTV |
| strategy | direction, competitors, moat, market entry, pivot, partnerships |
| operations | hiring, process, team, budget, timeline, resource allocation |
| research | technology choice, framework selection, build vs buy, evaluation |

**Step 2: Pull data from MCP servers based on domain.**

Only query servers relevant to the classified domain. Don't spray all servers.

| Domain | MCP Data Sources | What to Pull |
|--------|-----------------|--------------|
| engineering | github (PRs, issues, recent commits), filesystem (relevant code), Agent Orchestrator (fleet status if running on :3000) | Open PRs, recent commit frequency, code complexity, test coverage state, parallel agent fleet health, CI remediation queue |
| trading | aster (positions, ticker, funding rates, klines), TimesFM (price forecasts via aster-timesfm-pipeline skill), MiroFish (scenario simulation if running on :5001) | Current positions, P&L, funding exposure, recent price action, order book depth, quantitative forecasts with confidence intervals, qualitative scenario narratives |
| product | github (issues labeled feature/enhancement), obsidian (product notes), aidesigner (credit status, recent generations) | Feature backlog, user feedback themes, roadmap notes, UI generation capacity, DESIGN.md compliance if present |
| infrastructure | github (infra files), filesystem (terraform/k8s configs) | Current infra state, recent deploy history, cost indicators |
| security | github (security issues), filesystem (auth/security dirs) | Known vulnerabilities, recent security changes, compliance status |
| growth | obsidian (growth notes), github (analytics code) | Current metrics, experiment results, channel performance |
| strategy | obsidian (strategy notes), brave-search/tavily (market intelligence), MiroFish (scenario simulation if running on :5001), Paperclip (company governance state if running on :3101) | Competitor moves, market trends, relevant news, scenario predictions, agent governance metrics |
| operations | github (project boards), obsidian (ops notes) | Team capacity, timeline state, budget tracking |
| research | context7 (library docs), brave-search/tavily (comparisons), MiroFish (trend simulation if running) | Technical evaluations, benchmark data, community adoption metrics, simulated trend scenarios |

**Step 3: Check semantic memory for prior council decisions and relevant context.**

```
mcp__plugin_claude-mem_mcp-search__search({ query: "<council question keywords>" })
```

If past council decisions on related topics exist, note them for advisors — they should build on (or challenge) prior conclusions rather than starting from zero.

**Step 4: Check project memory files.**

Read `~/.claude/projects/*/memory/MEMORY.md` for any confidence-scored facts relevant to the question. Facts with confidence >= 0.8 are treated as established context.

**Step 5: Compile the Intelligence Brief.**

Present a concise brief (max 300 words) with:
- **Domain**: Classified domain
- **Hard Data**: Numbers, metrics, and facts gathered from MCP queries
- **Prior Decisions**: Relevant past council conclusions (if any)
- **Known Context**: Established facts from memory (if any)
- **Data Gaps**: What data you couldn't get (be transparent about blind spots)

This brief is given to ALL advisors. They must reference it.

---

# Agent Catalog

52 specialized agents organized by domain. All agents are flat `.md` files in this directory (Claude Code does not discover agents in subdirectories).

## Quick Reference

| Domain | Count | Agents |
|--------|-------|--------|
| Engineering & Architecture | 13 | backend-architect, frontend-architect, python-expert, system-architect, architect, devops-architect, infra-engineer, docker-specialist, ci-cd-engineer, db-admin, ai-engineer, mobile-app-builder, rapid-prototyper |
| Product & Strategy | 7 | pm-agent, scrum-facilitator, requirements-analyst, project-shipper, trend-researcher, feedback-synthesizer, experiment-tracker |
| Quality & Testing | 7 | quality-engineer, tester, code-reviewer, refactorer, refactoring-expert, self-review, test-results-analyzer |
| Security | 2 | security-engineer, security-auditor |
| Research & Learning | 4 | deep-research, data-analyst, root-cause-analyst, socratic-mentor |
| Operations | 6 | incident-responder, performance-engineer, performance-optimizer, legal-compliance-checker, finance-tracker, workflow-optimizer |
| Growth & Content | 4 | growth-marketer, content-strategist, ux-designer, analytics-reporter |
| Documentation & Meta | 5 | technical-writer, documenter, agent-installer, knowledge-graph-guide, repo-index |
| Strategy | 4 | business-panel-experts, learning-guide, api-designer, debugger |

---

## Engineering & Architecture (13)

| Agent | Description |
|-------|-------------|
| `backend-architect` | Reliable backend systems — data integrity, security, fault tolerance |
| `frontend-architect` | Accessible, performant UIs — modern frameworks, design tokens, motion |
| `python-expert` | Production-ready Python — SOLID, async, type safety, performance |
| `system-architect` | Scalable system architecture — maintainability, long-term decisions |
| `architect` | General software architecture and design review |
| `devops-architect` | Infrastructure automation — reliability, observability, deployment |
| `infra-engineer` | Cloud infrastructure — Terraform, Kubernetes, networking |
| `docker-specialist` | Container architecture — Docker, Compose, optimization, security |
| `ci-cd-engineer` | Build/deploy pipelines — GitHub Actions, testing gates, artifacts |
| `db-admin` | Database operations — schema management, optimization, migrations |
| `ai-engineer` | AI/ML systems — agent architectures, LLM integration, RAG pipelines |
| `mobile-app-builder` | Cross-platform mobile — React Native, Flutter, native iOS/Android |
| `rapid-prototyper` | Fast MVPs — speed over perfection, validated learning, demo-ready |

## Product & Strategy (7)

| Agent | Description |
|-------|-------------|
| `pm-agent` | Self-improvement workflow — implementations, mistakes, knowledge base |
| `scrum-facilitator` | Sprint planning, estimation, retros, velocity, agile ceremonies |
| `requirements-analyst` | Ambiguous ideas to concrete specs — systematic requirements discovery |
| `project-shipper` | Drive to completion — release readiness, scope cutting, launch plans |
| `trend-researcher` | Market trends, emerging tech, competitor analysis, strategic signals |
| `feedback-synthesizer` | User feedback analysis — patterns, sentiment, actionable insights |
| `experiment-tracker` | A/B tests — design, tracking, statistical analysis, learning velocity |

## Quality & Testing (7)

| Agent | Description |
|-------|-------------|
| `quality-engineer` | Comprehensive testing strategies — edge cases, E2E, visual, a11y |
| `tester` | Test writing and execution — unit, integration, E2E |
| `code-reviewer` | Code quality assessments — correctness, style, performance |
| `refactorer` | Code improvement — readability, patterns, technical debt reduction |
| `refactoring-expert` | Systematic refactoring — clean code principles, safe transformations |
| `self-review` | Post-implementation validation and reflection |
| `test-results-analyzer` | Test result analysis — flaky detection, coverage gaps, health metrics |

## Security (2)

| Agent | Description |
|-------|-------------|
| `security-engineer` | Vulnerability identification — OWASP, compliance, security standards |
| `security-auditor` | Security audit — code review, secrets scanning, auth patterns |

## Research & Learning (4)

| Agent | Description |
|-------|-------------|
| `deep-research` | Autonomous web research — adaptive depth, multi-source synthesis |
| `data-analyst` | Data exploration — statistics, visualization, ETL, pandas/SQL |
| `root-cause-analyst` | Problem investigation — evidence-based analysis, hypothesis testing |
| `socratic-mentor` | Socratic teaching — programming concepts through guided discovery |

## Operations (6)

| Agent | Description |
|-------|-------------|
| `incident-responder` | Incident management — classification, severity, post-mortems, runbooks |
| `performance-engineer` | Performance optimization — measurement-driven analysis, bottlenecks |
| `performance-optimizer` | Code-level optimization — profiling, caching, resource management |
| `legal-compliance-checker` | Regulatory compliance — financial, privacy, licensing, platform policies |
| `finance-tracker` | Financial metrics — unit economics, P&L, projections, trading finance |
| `workflow-optimizer` | Dev workflow optimization — CI/CD, tool chains, automation, DORA metrics |

## Growth & Content (4)

| Agent | Description |
|-------|-------------|
| `growth-marketer` | Data-driven growth — AARRR funnel, experimentation, channel strategy |
| `content-strategist` | Content planning — SEO, copywriting, brand voice, content auditing |
| `ux-designer` | User research — journey mapping, wireframes, usability, info architecture |
| `analytics-reporter` | Dashboards and KPIs — business intelligence, data storytelling, alerts |

## Documentation & Meta (5)

| Agent | Description |
|-------|-------------|
| `technical-writer` | Technical documentation — clarity, audience adaptation, accessibility |
| `documenter` | Code documentation — docstrings, README, API docs |
| `agent-installer` | Discover, browse, and install agents from community repositories |
| `knowledge-graph-guide` | Understand-Anything knowledge graph — queries, layers, dashboard |
| `repo-index` | Repository indexing — codebase briefing, structure analysis |

## Strategy & Misc (4)

| Agent | Description |
|-------|-------------|
| `business-panel-experts` | Multi-expert panel — Christensen, Porter, Drucker, Godin, Collins, Taleb |
| `learning-guide` | Programming education — progressive learning, practical examples |
| `api-designer` | API design — REST, GraphQL, OpenAPI, versioning |
| `debugger` | Bug investigation — trace analysis, hypothesis testing, root cause |

---

## Agent Format

All agents follow this structure:

```markdown
---
name: agent-name
description: One-line description (used for discovery and auto-activation)
category: domain-name
---

# Agent Name

## Triggers
## Behavioral Mindset
## Focus Areas
## Key Actions
## Outputs
## Boundaries
```

## Sources
- SuperClaude v4.2.0 (base agents)
- Custom agents (code-reviewer, security-auditor, architect, tester, debugger, refactorer, documenter, performance-optimizer, infra-engineer, docker-specialist, ci-cd-engineer, db-admin, api-designer)
- Domain agents (growth-marketer, content-strategist, ux-designer, data-analyst, incident-responder, scrum-facilitator)
- Enhancement batch 2026-03-21 (ai-engineer, mobile-app-builder, rapid-prototyper, trend-researcher, feedback-synthesizer, experiment-tracker, project-shipper, legal-compliance-checker, finance-tracker, analytics-reporter, workflow-optimizer, test-results-analyzer)

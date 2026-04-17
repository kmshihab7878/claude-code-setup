# Agent Registry — JARVIS-Mirrored Architecture

> Central dispatch table for 240 agents across 7 authority levels.
> 69 core (includes self-evolution trio) + 126 Wave 1 stage agents + 45 Wave 2 surface agents.
> Mirrors JARVIS-FRESH's AgentRegistry + DelegationEngine + SEC-001 routing.

## Authority Hierarchy

```
L0  System Core   (5)   Infrastructure agents — system health, indexing, meta-ops
L1  Executive     (3)   Cross-domain strategy — architecture decisions, business councils
L2  Dept Heads   (10)   Domain leaders — own a vertical, delegate to L3-L6
L3  Specialists  (18)   Domain experts — deep focus, tool-heavy execution
L4  Managers      (8)   Coordination — planning, tracking, shipping, ceremonies
L5  Leaders       (9)   Senior practitioners — optimization, analysis, mentoring
L6  Workers       (8)   Task executors — implementation, testing, documentation
```

---

## L0 — System Core

| Agent | Domain | MCP Servers | Skills | Risk | Interop |
|-------|--------|-------------|--------|------|---------|
| repo-index | meta | github, filesystem, memory | understand, understand-setup, doc-gap-analyzer | T0 | knowledge-graph-guide, pm-agent |
| agent-installer | meta | github, filesystem | skill-architect, skill-creator | T1 | repo-index |
| knowledge-graph-guide | meta | memory, filesystem | understand, understand-chat, understand-dashboard | T0 | repo-index, deep-research |
| self-review | meta | github, sequential | verification-before-completion, coding-workflow | T0 | code-reviewer, quality-engineer |
| pm-agent | meta | memory, github, slack, sequential, hermes | operating-framework, executing-plans, product-intelligence, hermes-integration | T1 | ALL (meta-layer) |

## L1 — Executive

| Agent | Domain | MCP Servers | Skills | Risk | Interop |
|-------|--------|-------------|--------|------|---------|
| system-architect | engineering | github, sequential, memory | multi-agent-patterns, clean-architecture-python, rag-patterns, architecture-radar | T0 | architect, backend-architect, ai-engineer |
| architect | engineering | github, sequential, memory | multi-agent-patterns, clean-architecture-python, api-design-patterns | T0 | system-architect, backend-architect, frontend-architect |
| business-panel-experts | strategy | sequential, memory, brave-search, tavily | ceo-advisor, cto-advisor, cfo-advisor, competitive-intel, market-scanner, paperclip | T0 | finance-tracker, growth-marketer, trend-researcher, ai-engineer |

## L2 — Department Heads

| Agent | Domain | MCP Servers | Skills | Risk | Interop |
|-------|--------|-------------|--------|------|---------|
| backend-architect | engineering | github, postgres, context7, sequential | clean-architecture-python, api-design-patterns, database-patterns, structured-logging | T1 | python-expert, db-admin, api-designer |
| frontend-architect | engineering | github, playwright, penpot, context7, aidesigner | baseline-ui, frontend-design, fixing-accessibility, ui-design-system, aidesigner-frontend | T1 | ux-designer, mobile-app-builder |
| devops-architect | infrastructure | terraform, kubernetes, docker, github | devops-patterns, container-security, github-actions-patterns, infrastructure-scanning, infra-intelligence | T2 | infra-engineer, docker-specialist, ci-cd-engineer |
| security-engineer | security | github, filesystem, sequential | security-review, infrastructure-scanning, container-security, offensive-security, threat-intelligence-feed | T2 | security-auditor, secrets-manager, compliance-officer |
| quality-engineer | quality | playwright, github, sequential | testing-methodology, property-based-testing, api-testing-suite, webapp-testing, test-gap-analyzer | T1 | tester, api-tester, test-results-analyzer |
| ai-engineer | engineering | github, context7, sequential, memory | multi-agent-patterns, rag-patterns, claude-api, autoresearch | T1 | prompt-engineer, system-architect |
| deep-research | research | brave-search, tavily, memory, sequential, context7 | research-methodology, data-analysis, paper-scanner, mirofish-prediction | T0 | trend-researcher, data-analyst, knowledge-graph-guide |
| growth-marketer | growth | brave-search, tavily, slack | marketing-demand-acquisition, seo-audit, ab-test-setup, content-strategy, ad-research, ad-script-generator, ad-performance-loop | T2 | content-strategist, analytics-reporter, experiment-tracker |
| performance-engineer | operations | github, sequential | production-monitoring, structured-logging, anomaly-detector | T1 | performance-optimizer, observability-engineer |
| data-analyst | research | postgres, filesystem, sequential, aster | data-analysis, research-methodology, timesfm-forecasting, aster-timesfm-pipeline, mirofish-prediction | T0 | analytics-reporter, deep-research, finance-tracker |

## L3 — Specialists

| Agent | Domain | MCP Servers | Skills | Risk | Interop |
|-------|--------|-------------|--------|------|---------|
| python-expert | engineering | github, context7, sequential | python-quality-gate, clean-architecture-python, structured-logging | T1 | backend-architect, refactoring-expert |
| docker-specialist | infrastructure | docker, github | container-security, devops-patterns, local-dev-orchestration | T1 | devops-architect, infra-engineer |
| ci-cd-engineer | infrastructure | github, docker | github-actions-patterns, release-automation | T2 | devops-architect, release-engineer |
| db-admin | engineering | postgres, github | database-patterns | T2 | backend-architect, migration-specialist |
| mobile-app-builder | engineering | github, context7, playwright | baseline-ui, frontend-design | T1 | frontend-architect, ux-designer |
| api-designer | engineering | github, context7, sequential | api-design-patterns, api-testing-suite | T1 | backend-architect, api-tester |
| security-auditor | security | github, filesystem | security-review, infrastructure-scanning, osint-recon | T1 | security-engineer, secrets-manager |
| secrets-manager | security | github, filesystem | security-review | T3 | security-engineer, compliance-officer |
| compliance-officer | security | github, filesystem, sequential | gdpr-dsgvo-expert, security-review | T2 | security-engineer, legal-compliance-checker |
| monorepo-manager | engineering | github, filesystem | github-actions-patterns, release-automation | T1 | ci-cd-engineer, devops-architect |
| migration-specialist | engineering | postgres, github | database-patterns | T3 | db-admin, backend-architect |
| prompt-engineer | ai | sequential, memory, context7, hermes | claude-api, multi-agent-patterns, prompt-reliability-engine, hermes-integration | T0 | ai-engineer, deep-research |
| analytics-reporter | operations | postgres, filesystem | data-analysis, product-analytics | T0 | data-analyst, growth-marketer |
| finance-tracker | operations | aster, sequential, memory | aster-trading, finance-ml, financial-modeling, wshobson-SKILL, timesfm-forecasting, aster-timesfm-pipeline | T2 | business-panel-experts, cost-optimizer, data-analyst |
| observability-engineer | operations | github, kubernetes | production-monitoring, structured-logging | T2 | performance-engineer, incident-responder |
| content-strategist | growth | brave-search, tavily, memory | content-strategy, seo-audit, brand-guidelines, ad-script-generator, anti-ai-writing | T1 | growth-marketer, technical-writer |
| ux-designer | engineering | penpot, playwright, puppeteer, aidesigner | ui-ux-pro-max, baseline-ui, fixing-accessibility, ux-researcher-designer, aidesigner-frontend | T1 | frontend-architect, mobile-app-builder |
| infra-engineer | infrastructure | terraform, kubernetes, docker, github | devops-patterns, cost-optimization, infrastructure-scanning, local-dev-orchestration | T3 | devops-architect, docker-specialist |

## L4 — Managers

| Agent | Domain | MCP Servers | Skills | Risk | Interop |
|-------|--------|-------------|--------|------|---------|
| scrum-facilitator | product | github, memory, slack | product-manager-toolkit | T0 | pm-agent, project-shipper |
| project-shipper | product | github, slack | git-workflows, branch-finishing, release-automation | T2 | release-engineer, scrum-facilitator |
| requirements-analyst | product | memory, sequential, github | product-manager-toolkit, product-strategist | T0 | pm-agent, architect |
| experiment-tracker | product | github, memory, sequential | ab-test-setup, experiment-designer, product-analytics | T1 | growth-marketer, analytics-reporter |
| feedback-synthesizer | product | memory, slack, sequential | product-analytics, ux-researcher-designer | T0 | ux-designer, pm-agent |
| trend-researcher | research | brave-search, tavily, memory | research-methodology, competitive-intel, mirofish-prediction | T0 | deep-research, business-panel-experts, data-analyst |
| release-engineer | operations | github, docker | release-automation, github-actions-patterns, git-workflows | T2 | ci-cd-engineer, project-shipper |
| incident-responder | operations | github, slack, kubernetes | production-monitoring, security-review | T3 | observability-engineer, security-engineer |

## L5 — Leaders

| Agent | Domain | MCP Servers | Skills | Risk | Interop |
|-------|--------|-------------|--------|------|---------|
| performance-optimizer | operations | github, sequential | production-monitoring, structured-logging | T1 | performance-engineer, observability-engineer |
| cost-optimizer | operations | github, terraform, kubernetes | cost-optimization, devops-patterns | T2 | infra-engineer, devops-architect |
| workflow-optimizer | operations | github, sequential | github-actions-patterns, local-dev-orchestration | T1 | ci-cd-engineer, pm-agent |
| legal-compliance-checker | security | github, filesystem, sequential | gdpr-dsgvo-expert, security-review | T0 | compliance-officer, security-engineer |
| rapid-prototyper | engineering | github, context7, filesystem | coding-workflow, frontend-design | T1 | frontend-architect, mobile-app-builder |
| refactoring-expert | engineering | github, sequential | clean-architecture-python, python-quality-gate | T1 | python-expert, code-reviewer |
| root-cause-analyst | research | github, sequential, memory | research-methodology | T0 | debugger, incident-responder |
| socratic-mentor | research | sequential, memory | research-methodology | T0 | learning-guide, pm-agent |
| learning-guide | research | sequential, memory, context7 | research-methodology | T0 | socratic-mentor, prompt-engineer |

## L6 — Workers

| Agent | Domain | MCP Servers | Skills | Risk | Interop |
|-------|--------|-------------|--------|------|---------|
| tester | quality | playwright, github | test-driven-development, testing-methodology, property-based-testing, webapp-testing | T1 | quality-engineer, api-tester |
| debugger | quality | github, sequential-thinking, playwright | coding-workflow | T1 | root-cause-analyst, tester |
| refactorer | quality | github | python-quality-gate | T1 | refactoring-expert, code-reviewer |
| documenter | documentation | github, filesystem | doc-coauthoring | T1 | technical-writer, pm-agent |
| code-reviewer | quality | github | receiving-code-review, python-quality-gate, security-review | T1 | security-auditor, quality-engineer |
| technical-writer | documentation | github, filesystem, memory | doc-coauthoring | T1 | documenter, content-strategist |
| api-tester | quality | github, context7 | api-testing-suite, api-design-patterns | T1 | quality-engineer, api-designer |
| test-results-analyzer | quality | github, sequential-thinking | testing-methodology, product-analytics | T0 | quality-engineer, tester |
| market-content | growth | brave-search, tavily, playwright | market-copy, market-brand | T1 | growth-marketer, content-strategist |
| market-conversion | growth | brave-search, tavily, playwright | market-funnel, market-landing | T1 | growth-marketer, content-strategist |
| market-competitive | growth | brave-search, tavily, playwright | market-competitors | T1 | growth-marketer, content-strategist |
| market-technical | growth | brave-search, tavily, playwright | market-seo | T1 | growth-marketer, content-strategist |
| market-strategy | growth | brave-search, tavily, playwright | market-audit, market-launch, market-proposal | T1 | growth-marketer, content-strategist |

> **MCP tier note:** Many MCP servers listed above (`github`, `context7`, `playwright`, `brave-search`, `tavily`, `postgres`, `slack`, `docker`, `kubernetes`, `terraform`, `aster`, `penpot`, `puppeteer`) are **Tier-3 aspirational** per CLAUDE.md — they are not currently connected. Agent bindings declare the intended MCP set (extraction-ready); runtime calls to unconnected servers are blocked by `hooks/mcp-security-gate.sh`. This is the repo's honest interpretation of SEC-001 rule #2: declarations are aspirational; execution is gated.

---

## Wave 1 Expansion Agents

### Growth Department — Stage Agents (17)

#### Intelligence (5)
| Agent | Stage | MCP Servers | Skills | Risk | Reports To |
|-------|-------|-------------|--------|------|-----------|
| growth-intel-ad-scraper | intel | brave-search, tavily, playwright | ad-research, competitive-intel | T1 | growth-marketer |
| growth-intel-landing-analyzer | intel | brave-search, playwright | ad-research, seo-audit | T1 | growth-marketer |
| growth-intel-review-scanner | intel | brave-search, tavily | product-intelligence, research-methodology | T0 | growth-marketer |
| growth-intel-trend-scanner | intel | brave-search, tavily, memory | competitive-intel, research-methodology | T0 | growth-marketer |
| growth-intel-channel-analyst | intel | brave-search, memory | marketing-demand-acquisition, data-analysis | T0 | growth-marketer |

#### Generation (7)
| Agent | Stage | MCP Servers | Skills | Risk | Reports To |
|-------|-------|-------------|--------|------|-----------|
| growth-gen-script-writer | gen | memory, sequential | ad-script-generator, anti-ai-writing | T0 | content-strategist |
| growth-gen-hook-generator | gen | memory | ad-script-generator, anti-ai-writing | T0 | content-strategist |
| growth-gen-copy-writer | gen | memory | ad-script-generator, anti-ai-writing, cold-email | T0 | content-strategist |
| growth-gen-brief-writer | gen | memory, slack | ad-script-generator, brand-guidelines | T1 | growth-marketer |
| growth-gen-content-writer | gen | memory, brave-search | content-strategy, seo-audit, anti-ai-writing | T0 | content-strategist |
| growth-gen-seo-writer | gen | brave-search, memory | seo-audit, content-strategy, anti-ai-writing | T0 | content-strategist |
| growth-gen-email-writer | gen | memory | cold-email, anti-ai-writing | T1 | growth-marketer |

#### Self-Improvement Loop (5)
| Agent | Stage | MCP Servers | Skills | Risk | Reports To |
|-------|-------|-------------|--------|------|-----------|
| growth-loop-cpa-analyst | loop | memory, sequential, postgres | ad-performance-loop, data-analysis | T0 | growth-marketer |
| growth-loop-roas-optimizer | loop | memory, sequential | ad-performance-loop, financial-modeling | T1 | growth-marketer |
| growth-loop-fatigue-detector | loop | memory, sequential | ad-performance-loop, anomaly-detector | T0 | growth-marketer |
| growth-loop-winner-amplifier | loop | memory, sequential | ad-performance-loop, ad-script-generator | T1 | growth-marketer |
| growth-loop-attribution-analyst | loop | memory, postgres, sequential | ad-performance-loop, data-analysis, product-analytics | T0 | growth-marketer |

### Security Department — Stage Agents (13)
| Agent | Stage | Skills | Risk | Reports To |
|-------|-------|--------|------|-----------|
| security-intel-cve-scanner | intel | threat-intelligence-feed, security-review | T1 | security-engineer |
| security-intel-dep-auditor | intel | threat-intelligence-feed, infrastructure-scanning | T1 | security-engineer |
| security-intel-threat-monitor | intel | threat-intelligence-feed, osint-recon | T0 | security-engineer |
| security-intel-config-scanner | intel | threat-intelligence-feed, infrastructure-scanning | T1 | security-engineer |
| security-gen-rule-writer | gen | security-review, anti-ai-writing | T0 | security-engineer |
| security-gen-policy-writer | gen | security-review, gdpr-dsgvo-expert | T0 | security-engineer |
| security-gen-playbook-writer | gen | security-review, anti-ai-writing | T0 | security-engineer |
| security-gen-patch-creator | gen | security-review, threat-intelligence-feed | T0 | security-engineer |
| security-loop-patch-tracker | loop | threat-intelligence-feed, data-analysis | T0 | security-engineer |
| security-loop-vuln-analyst | loop | threat-intelligence-feed, data-analysis | T0 | security-engineer |
| security-loop-false-pos-tuner | loop | threat-intelligence-feed, security-review | T0 | security-engineer |
| security-loop-compliance-scorer | loop | threat-intelligence-feed, gdpr-dsgvo-expert | T0 | security-engineer |
| security-loop-pentest-analyst | loop | offensive-security, security-review | T0 | security-engineer |

### Quality Department — Stage Agents (15)
| Agent | Stage | Skills | Risk | Reports To |
|-------|-------|--------|------|-----------|
| quality-intel-failure-analyst | intel | test-gap-analyzer, testing-methodology | T0 | quality-engineer |
| quality-intel-flaky-detector | intel | test-gap-analyzer, testing-methodology | T0 | quality-engineer |
| quality-intel-coverage-scanner | intel | test-gap-analyzer, testing-methodology | T0 | quality-engineer |
| quality-gen-unit-writer | gen | test-driven-development, testing-methodology | T0 | quality-engineer |
| quality-gen-integration-writer | gen | test-driven-development, api-testing-suite | T0 | quality-engineer |
| quality-gen-e2e-writer | gen | webapp-testing, testing-methodology | T0 | quality-engineer |
| quality-gen-property-writer | gen | property-based-testing, testing-methodology | T0 | quality-engineer |
| quality-gen-regression-writer | gen | test-driven-development, testing-methodology | T0 | quality-engineer |
| quality-gen-contract-writer | gen | api-testing-suite, api-design-patterns | T0 | quality-engineer |
| quality-gen-mutation-runner | gen | testing-methodology, test-gap-analyzer | T0 | quality-engineer |
| quality-gen-fixture-builder | gen | testing-methodology, test-driven-development | T0 | quality-engineer |
| quality-loop-escape-analyst | loop | test-gap-analyzer, data-analysis | T0 | quality-engineer |
| quality-loop-strategy-optimizer | loop | test-gap-analyzer, testing-methodology | T0 | quality-engineer |
| quality-loop-flaky-fixer | loop | testing-methodology, test-driven-development | T0 | quality-engineer |
| quality-loop-coverage-reporter | loop | test-gap-analyzer, data-analysis | T0 | quality-engineer |

### Engineering Department — Stage Agents (15)
| Agent | Stage | Skills | Risk | Reports To |
|-------|-------|--------|------|-----------|
| engineering-intel-repo-scanner | intel | architecture-radar, research-methodology | T1 | system-architect |
| engineering-intel-dep-tracker | intel | architecture-radar | T1 | system-architect |
| engineering-intel-perf-profiler | intel | production-monitoring | T1 | system-architect |
| engineering-intel-arch-reviewer | intel | architecture-radar, clean-architecture-python | T0 | system-architect |
| engineering-intel-tech-scout | intel | architecture-radar, research-methodology | T0 | system-architect |
| engineering-gen-api-scaffolder | gen | api-design-patterns, coding-workflow | T0 | backend-architect |
| engineering-gen-test-scaffolder | gen | test-driven-development, testing-methodology | T0 | backend-architect |
| engineering-gen-migration-writer | gen | database-patterns | T0 | backend-architect |
| engineering-gen-component-builder | gen | frontend-design, baseline-ui | T0 | frontend-architect |
| engineering-gen-doc-writer | gen | doc-coauthoring, anti-ai-writing | T0 | backend-architect |
| engineering-loop-quality-scorer | loop | python-quality-gate, coding-workflow | T0 | system-architect |
| engineering-loop-pattern-tracker | loop | architecture-radar | T0 | system-architect |
| engineering-loop-perf-tracker | loop | production-monitoring | T0 | system-architect |
| engineering-loop-debt-tracker | loop | clean-architecture-python, python-quality-gate | T0 | system-architect |
| engineering-loop-coverage-tracker | loop | test-gap-analyzer, testing-methodology | T0 | system-architect |

### Operations Department — Stage Agents (14)
| Agent | Stage | Skills | Risk | Reports To |
|-------|-------|--------|------|-----------|
| operations-intel-metric-collector | intel | anomaly-detector, production-monitoring | T1 | performance-engineer |
| operations-intel-cost-scanner | intel | infra-intelligence, cost-optimization | T1 | performance-engineer |
| operations-intel-capacity-forecaster | intel | infra-intelligence, anomaly-detector | T0 | performance-engineer |
| operations-intel-deploy-analyzer | intel | anomaly-detector, github-actions-patterns | T0 | performance-engineer |
| operations-gen-dashboard-builder | gen | production-monitoring | T0 | performance-engineer |
| operations-gen-alert-writer | gen | anomaly-detector, production-monitoring | T0 | performance-engineer |
| operations-gen-runbook-writer | gen | anomaly-detector, anti-ai-writing | T0 | performance-engineer |
| operations-gen-capacity-planner | gen | infra-intelligence | T0 | performance-engineer |
| operations-gen-cost-report-builder | gen | infra-intelligence, data-analysis | T0 | performance-engineer |
| operations-loop-mttr-tracker | loop | anomaly-detector, production-monitoring | T0 | performance-engineer |
| operations-loop-alert-tuner | loop | anomaly-detector | T0 | performance-engineer |
| operations-loop-cost-optimizer-loop | loop | infra-intelligence, cost-optimization | T0 | performance-engineer |
| operations-loop-reliability-scorer | loop | production-monitoring | T0 | performance-engineer |
| operations-loop-toil-tracker | loop | anomaly-detector | T0 | performance-engineer |

### Product Department — Stage Agents (13)
| Agent | Stage | Skills | Risk | Reports To |
|-------|-------|--------|------|-----------|
| product-intel-feedback-scanner | intel | product-intelligence | T0 | pm-agent |
| product-intel-competitor-tracker | intel | product-intelligence, competitive-intel | T0 | pm-agent |
| product-intel-usage-analyst | intel | product-analytics, data-analysis | T0 | pm-agent |
| product-intel-nps-analyzer | intel | product-intelligence, product-analytics | T0 | pm-agent |
| product-gen-prd-writer | gen | product-manager-toolkit, anti-ai-writing | T0 | pm-agent |
| product-gen-story-writer | gen | product-manager-toolkit | T0 | pm-agent |
| product-gen-experiment-designer-agent | gen | experiment-designer, ab-test-setup | T0 | pm-agent |
| product-gen-okr-cascader | gen | product-strategist | T0 | pm-agent |
| product-loop-adoption-tracker | loop | product-analytics | T0 | pm-agent |
| product-loop-experiment-analyst | loop | experiment-designer, data-analysis | T0 | pm-agent |
| product-loop-churn-predictor | loop | customer-success-manager, data-analysis | T0 | pm-agent |
| product-loop-velocity-tracker | loop | product-manager-toolkit | T0 | pm-agent |
| product-loop-satisfaction-scorer | loop | product-analytics | T0 | pm-agent |

### Research Department — Stage Agents (10)
| Agent | Stage | Skills | Risk | Reports To |
|-------|-------|--------|------|-----------|
| research-intel-arxiv-scanner | intel | paper-scanner, research-methodology | T1 | deep-research |
| research-intel-blog-scanner | intel | paper-scanner, research-methodology | T1 | deep-research |
| research-intel-conference-tracker | intel | paper-scanner | T0 | deep-research |
| research-intel-benchmark-monitor | intel | paper-scanner, research-methodology | T0 | deep-research |
| research-gen-brief-writer | gen | paper-scanner, anti-ai-writing | T0 | deep-research |
| research-gen-eval-designer | gen | research-methodology | T0 | deep-research |
| research-gen-learning-path-builder | gen | research-methodology | T0 | deep-research |
| research-loop-conversion-tracker | loop | paper-scanner, research-methodology | T0 | deep-research |
| research-loop-source-ranker | loop | research-methodology | T0 | deep-research |
| research-loop-impact-analyst | loop | research-methodology, data-analysis | T0 | deep-research |

### Documentation Department — Stage Agents (10)
| Agent | Stage | Skills | Risk | Reports To |
|-------|-------|--------|------|-----------|
| documentation-intel-freshness-scanner | intel | doc-gap-analyzer | T0 | repo-index |
| documentation-intel-gap-scanner | intel | doc-gap-analyzer | T0 | repo-index |
| documentation-intel-search-analyst | intel | doc-gap-analyzer, data-analysis | T0 | repo-index |
| documentation-gen-api-doc-writer | gen | doc-coauthoring, anti-ai-writing | T0 | repo-index |
| documentation-gen-guide-writer | gen | doc-coauthoring, anti-ai-writing | T0 | repo-index |
| documentation-gen-changelog-writer | gen | doc-coauthoring, release-automation | T0 | repo-index |
| documentation-gen-diagram-builder | gen | doc-coauthoring | T0 | repo-index |
| documentation-loop-sync-checker | loop | doc-gap-analyzer | T0 | repo-index |
| documentation-loop-quality-scorer | loop | doc-gap-analyzer | T0 | repo-index |
| documentation-loop-onboarding-timer | loop | doc-gap-analyzer | T0 | repo-index |

### Strategy Department — Stage Agents (9)
| Agent | Stage | Skills | Risk | Reports To |
|-------|-------|--------|------|-----------|
| strategy-intel-competitor-monitor | intel | market-scanner, competitive-intel | T0 | business-panel-experts |
| strategy-intel-regulatory-scanner | intel | market-scanner, gdpr-dsgvo-expert | T0 | business-panel-experts |
| strategy-intel-funding-tracker | intel | market-scanner | T0 | business-panel-experts |
| strategy-gen-battlecard-writer | gen | competitive-intel, anti-ai-writing | T0 | business-panel-experts |
| strategy-gen-model-builder | gen | financial-modeling, market-scanner | T0 | business-panel-experts |
| strategy-gen-brief-writer | gen | market-scanner, anti-ai-writing | T0 | business-panel-experts |
| strategy-loop-forecast-scorer | loop | market-scanner, financial-modeling | T0 | business-panel-experts |
| strategy-loop-initiative-tracker | loop | market-scanner | T0 | business-panel-experts |
| strategy-loop-narrative-analyst | loop | market-scanner, competitive-intel | T0 | business-panel-experts |

### Infrastructure Department — Stage Agents (10)
| Agent | Stage | Skills | Risk | Reports To |
|-------|-------|--------|------|-----------|
| infrastructure-intel-cost-monitor | intel | infra-intelligence, cost-optimization | T1 | devops-architect |
| infrastructure-intel-utilization-scanner | intel | infra-intelligence | T1 | devops-architect |
| infrastructure-intel-drift-detector | intel | infra-intelligence, devops-patterns | T1 | devops-architect |
| infrastructure-gen-terraform-writer | gen | devops-patterns, infra-intelligence | T0 | devops-architect |
| infrastructure-gen-helm-writer | gen | devops-patterns | T0 | devops-architect |
| infrastructure-gen-pipeline-builder | gen | github-actions-patterns | T0 | devops-architect |
| infrastructure-gen-dockerfile-optimizer | gen | container-security, devops-patterns | T0 | devops-architect |
| infrastructure-loop-deploy-success-tracker | loop | infra-intelligence | T0 | devops-architect |
| infrastructure-loop-cost-trend-analyst | loop | infra-intelligence, cost-optimization | T0 | devops-architect |
| infrastructure-loop-drift-fixer | loop | infra-intelligence, devops-patterns | T0 | devops-architect |

## Wave 2: Per-Surface Agents (45)

9 agents per product surface (3 intel, 3 gen, 3 loop). Each surface agent is tuned to its specific market, users, and KPIs.

| Surface | Intel Agents | Gen Agents | Loop Agents |
|---------|-------------|-----------|------------|
| **Command** | market-scanner, user-researcher, competitor-watcher | content-creator, feature-spec-writer, campaign-builder | adoption-tracker, satisfaction-scorer, growth-analyst |
| **Studio** | market-scanner, user-researcher, competitor-watcher | content-creator, feature-spec-writer, campaign-builder | adoption-tracker, satisfaction-scorer, growth-analyst |
| **Helios** | market-scanner, user-researcher, competitor-watcher | content-creator, feature-spec-writer, campaign-builder | adoption-tracker, satisfaction-scorer, growth-analyst |
| **Nova** | market-scanner, user-researcher, competitor-watcher | content-creator, feature-spec-writer, campaign-builder | adoption-tracker, satisfaction-scorer, growth-analyst |
| **Forge** | market-scanner, user-researcher, competitor-watcher | content-creator, feature-spec-writer, campaign-builder | adoption-tracker, satisfaction-scorer, growth-analyst |

Agent definitions: `~/.claude/agents/surfaces/{surface}/{stage}/*.md`

---

## Domain Routing Table

Maps incoming task domains to authority chains (highest authority first).

| Domain | L1 Executive | L2 Dept Head | L3+ Specialists |
|--------|-------------|--------------|-----------------|
| engineering | system-architect, architect | backend-architect, frontend-architect, ai-engineer | python-expert, db-admin, api-designer, mobile-app-builder, ux-designer, monorepo-manager, migration-specialist |
| infrastructure | architect | devops-architect | docker-specialist, ci-cd-engineer, infra-engineer |
| security | system-architect | security-engineer | security-auditor, secrets-manager, compliance-officer |
| quality | — | quality-engineer | tester, api-tester, test-results-analyzer, code-reviewer, debugger, refactorer |
| research | — | deep-research, data-analyst | prompt-engineer, trend-researcher, root-cause-analyst |
| product | — | — | scrum-facilitator, project-shipper, requirements-analyst, experiment-tracker, feedback-synthesizer |
| growth | — | growth-marketer | content-strategist, analytics-reporter |
| operations | — | performance-engineer | observability-engineer, finance-tracker, incident-responder, release-engineer |
| strategy | business-panel-experts | — | — |
| meta | — | — | pm-agent, repo-index, agent-installer, knowledge-graph-guide, self-review |

## MCP Server → Agent Binding

Which agents are authorized to use each MCP server.

| MCP Server | Authorized Agents |
|------------|-------------------|
| **github** | ALL agents (read), code-reviewer, ci-cd-engineer, release-engineer, project-shipper (write) |
| **penpot** | frontend-architect, ux-designer |
| **aidesigner** | frontend-architect, ux-designer |
| **memory** | pm-agent, knowledge-graph-guide, repo-index, deep-research, system-architect, architect, ai-engineer, prompt-engineer, content-strategist, trend-researcher, root-cause-analyst, socratic-mentor, learning-guide, technical-writer, business-panel-experts, finance-tracker, requirements-analyst, experiment-tracker, feedback-synthesizer |
| **filesystem** | ALL agents (read), agent-installer, documenter, technical-writer (write) |
| **sequential** | system-architect, architect, backend-architect, security-engineer, quality-engineer, ai-engineer, deep-research, performance-engineer, data-analyst, python-expert, api-designer, compliance-officer, prompt-engineer, finance-tracker, legal-compliance-checker, refactoring-expert, root-cause-analyst, socratic-mentor, learning-guide, debugger, test-results-analyzer, workflow-optimizer, performance-optimizer, business-panel-experts, requirements-analyst, experiment-tracker, feedback-synthesizer, self-review |
| **context7** | backend-architect, frontend-architect, ai-engineer, deep-research, python-expert, mobile-app-builder, api-designer, prompt-engineer, rapid-prototyper, learning-guide, api-tester |
| **docker** | devops-architect, docker-specialist, ci-cd-engineer, infra-engineer, release-engineer |
| **aster** | finance-tracker, data-analyst |
| **notion** | pm-agent, scrum-facilitator |
| **playwright** | frontend-architect, quality-engineer, mobile-app-builder, ux-designer, tester, debugger |
| **puppeteer** | ux-designer |
| **postgres** | backend-architect, db-admin, migration-specialist, data-analyst, analytics-reporter |
| **brave-search** | deep-research, growth-marketer, content-strategist, trend-researcher, business-panel-experts |
| **tavily** | deep-research, growth-marketer, content-strategist, trend-researcher, business-panel-experts |
| **slack** | pm-agent, growth-marketer, scrum-facilitator, project-shipper, feedback-synthesizer, incident-responder |
| **stripe** | finance-tracker, growth-marketer |
| **hermes** | ai-engineer, prompt-engineer, pm-agent |
| **kubernetes** | devops-architect, infra-engineer, observability-engineer, cost-optimizer, incident-responder |
| **terraform** | devops-architect, infra-engineer, cost-optimizer |
| **google-maps** | data-analyst, growth-marketer |
| **code-review-graph** | code-reviewer, self-review, quality-engineer |

## UAOP Context Binding

Every agent loads department context files from `~/.claude/contexts/` before generating output.
Universal `writing-rules.md` applies to ALL agents.

| Domain | Context Directory | Agents |
|--------|------------------|--------|
| engineering | `contexts/engineering/` | system-architect, architect, backend-architect, frontend-architect, ai-engineer, python-expert, db-admin, api-designer, mobile-app-builder, ux-designer, monorepo-manager, migration-specialist, rapid-prototyper, refactoring-expert, refactorer |
| infrastructure | `contexts/infrastructure/` | devops-architect, docker-specialist, ci-cd-engineer, infra-engineer |
| security | `contexts/security/` | security-engineer, security-auditor, secrets-manager, compliance-officer, legal-compliance-checker |
| quality | `contexts/quality/` | quality-engineer, tester, debugger, code-reviewer, api-tester, test-results-analyzer |
| product | `contexts/product/` | pm-agent, scrum-facilitator, project-shipper, requirements-analyst, experiment-tracker, feedback-synthesizer |
| research | `contexts/research/` | deep-research, data-analyst, root-cause-analyst, socratic-mentor, learning-guide, prompt-engineer, trend-researcher |
| operations | `contexts/operations/` | performance-engineer, observability-engineer, finance-tracker, analytics-reporter, incident-responder, release-engineer, performance-optimizer, cost-optimizer, workflow-optimizer |
| growth | `contexts/growth/` | growth-marketer, content-strategist |
| documentation | `contexts/documentation/` | repo-index, agent-installer, knowledge-graph-guide, documenter, technical-writer |
| strategy | `contexts/strategy/` | business-panel-experts |

### Context Load Order (UAOP Stage 2)
```
1. ~/.claude/contexts/writing-rules.md          (universal anti-slop)
2. ~/.claude/contexts/{department}/rules.md      (department constraints)
3. ~/.claude/contexts/{department}/voice.md      (department tone)
4. ~/.claude/contexts/{department}/domain.md     (department knowledge)
5. ~/.claude/contexts/{department}/audience.md   (output consumers)
```

### Universal Skill Binding
All agents inherit `anti-ai-writing` skill for written output quality gating.

---

## Escalation Tiers

| Tier | Behavior | Risk Level | Example |
|------|----------|------------|---------|
| **ALLOW** | Execute immediately | T0 Safe | Research, analysis, code reading |
| **REVIEW** | Log and proceed | T1 Local | Local code changes, test runs |
| **ESCALATE** | Pause for approval | T2 Shared | GitHub pushes, Slack messages, infra changes |
| **BLOCK** | Reject unless authorized | T3 Critical | Production deploys, secret rotation, DB migrations |

## Performance Routing Protocol

Mirrors JARVIS DelegationEngine — when multiple agents qualify for a task:

1. **Filter by domain** — only agents in the relevant domain
2. **Filter by authority** — prefer higher authority for ambiguous scope
3. **Filter by MCP access** — agent must have the required MCP servers declared
4. **Rank by performance** — if outcome tracking available, prefer higher quality scores
5. **Fallback chain** — L2 Head → L3 Specialist → L5 Leader → L6 Worker

## Constitution Rules (SEC-001 Equivalent)

1. **All agent execution flows through the orchestrator** — no direct agent invocation bypassing governance
2. **Agents operate only within declared MCP server bindings** — tool access is capability-gated
3. **Risk tier determines approval flow** — T0/T1 auto-execute, T2 logged, T3 requires explicit approval
4. **Every execution produces a trace** — agent, task, tools used, outcome, quality score
5. **Performance routing is closed-loop** — better performers get more tasks over time

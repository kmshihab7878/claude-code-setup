# Agent Registry — CoreMind-Mirrored Architecture

> Central dispatch table for **243 agents** across 7 authority levels.
> **72 core** (L0–L6 + self-evolution trio + AIS-OS layer trio: devex-operator, wiki-curator, automation-designer) + **126 Wave 1** stage agents + **45 Wave 2** surface agents.
> Mirrors CoreMind's AgentRegistry + DelegationEngine + SEC-001 routing.

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

Column legend (L0–L6 tables): **MCP** = declared MCP servers; **Skills** = bound skill names; **Risk** = T0 Safe / T1 Local / T2 Shared / T3 Critical; **Interop** = common collaborators.

---

## L0 — System Core

| Agent | Domain | MCP | Skills | Risk | Interop |
|-------|--------|-----|--------|------|---------|
| repo-index | meta | github, filesystem, memory | understand, understand-setup, doc-gap-analyzer | T0 | knowledge-graph-guide, pm-agent |
| agent-installer | meta | github, filesystem | skill-architect, skill-creator | T1 | repo-index |
| knowledge-graph-guide | meta | memory, filesystem | understand, understand-chat, understand-dashboard | T0 | repo-index, deep-research |
| self-review | meta | github, sequential | verification-before-completion, coding-workflow | T0 | code-reviewer, quality-engineer |
| pm-agent | meta | memory, github, slack, sequential, hermes | operating-framework, executing-plans, product-intelligence, hermes-integration | T1 | ALL (meta-layer) |

## L1 — Executive

| Agent | Domain | MCP | Skills | Risk | Interop |
|-------|--------|-----|--------|------|---------|
| system-architect | engineering | github, sequential, memory | multi-agent-patterns, clean-architecture-python, rag-patterns, architecture-radar | T0 | architect, backend-architect, ai-engineer |
| architect | engineering | github, sequential, memory | multi-agent-patterns, clean-architecture-python, api-design-patterns | T0 | system-architect, backend-architect, frontend-architect |
| business-panel-experts | strategy | sequential, memory, brave-search, tavily | ceo-advisor, cto-advisor, cfo-advisor, competitive-intel, market-scanner, paperclip | T0 | finance-tracker, growth-marketer, trend-researcher, ai-engineer |

## L2 — Department Heads

| Agent | Domain | MCP | Skills | Risk | Interop |
|-------|--------|-----|--------|------|---------|
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

| Agent | Domain | MCP | Skills | Risk | Interop |
|-------|--------|-----|--------|------|---------|
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

| Agent | Domain | MCP | Skills | Risk | Interop |
|-------|--------|-----|--------|------|---------|
| scrum-facilitator | product | github, memory, slack | product-manager-toolkit | T0 | pm-agent, project-shipper |
| project-shipper | product | github, slack | git-workflows, branch-finishing, release-automation | T2 | release-engineer, scrum-facilitator |
| requirements-analyst | product | memory, sequential, github | product-manager-toolkit, product-strategist | T0 | pm-agent, architect |
| experiment-tracker | product | github, memory, sequential | ab-test-setup, experiment-designer, product-analytics | T1 | growth-marketer, analytics-reporter |
| feedback-synthesizer | product | memory, slack, sequential | product-analytics, ux-researcher-designer | T0 | ux-designer, pm-agent |
| trend-researcher | research | brave-search, tavily, memory | research-methodology, competitive-intel, mirofish-prediction | T0 | deep-research, business-panel-experts, data-analyst |
| release-engineer | operations | github, docker | release-automation, github-actions-patterns, git-workflows | T2 | ci-cd-engineer, project-shipper |
| incident-responder | operations | github, slack, kubernetes | production-monitoring, security-review | T3 | observability-engineer, security-engineer |

## L5 — Leaders

| Agent | Domain | MCP | Skills | Risk | Interop |
|-------|--------|-----|--------|------|---------|
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

| Agent | Domain | MCP | Skills | Risk | Interop |
|-------|--------|-----|--------|------|---------|
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

Departments are organized by Stage: **intel** (signal collection), **gen** (artifact generation), **loop** (self-improvement). The stage is encoded in each agent's name (`{dept}-{stage}-{role}`). Reports-To is stated in each section header when constant; otherwise listed per row. Risk shown in trailing parens after each agent name (default T0 unless noted).

### Growth Department — 17 stage agents

5-column table because Growth alone carries explicit per-agent MCP bindings.

#### Intelligence (5)
| Agent | Stage | MCP | Skills | Risk | Reports To |
|-------|-------|-----|--------|------|-----------|
| growth-intel-ad-scraper | intel | brave-search, tavily, playwright | ad-research, competitive-intel | T1 | growth-marketer |
| growth-intel-landing-analyzer | intel | brave-search, playwright | ad-research, seo-audit | T1 | growth-marketer |
| growth-intel-review-scanner | intel | brave-search, tavily | product-intelligence, research-methodology | T0 | growth-marketer |
| growth-intel-trend-scanner | intel | brave-search, tavily, memory | competitive-intel, research-methodology | T0 | growth-marketer |
| growth-intel-channel-analyst | intel | brave-search, memory | marketing-demand-acquisition, data-analysis | T0 | growth-marketer |

#### Generation (7)
| Agent | MCP | Skills | Risk | Reports To |
|-------|-----|--------|------|-----------|
| growth-gen-script-writer | memory, sequential | ad-script-generator, anti-ai-writing | T0 | content-strategist |
| growth-gen-hook-generator | memory | ad-script-generator, anti-ai-writing | T0 | content-strategist |
| growth-gen-copy-writer | memory | ad-script-generator, anti-ai-writing, cold-email | T0 | content-strategist |
| growth-gen-brief-writer | memory, slack | ad-script-generator, brand-guidelines | T1 | growth-marketer |
| growth-gen-content-writer | memory, brave-search | content-strategy, seo-audit, anti-ai-writing | T0 | content-strategist |
| growth-gen-seo-writer | brave-search, memory | seo-audit, content-strategy, anti-ai-writing | T0 | content-strategist |
| growth-gen-email-writer | memory | cold-email, anti-ai-writing | T1 | growth-marketer |

#### Self-Improvement Loop (5)
| Agent | MCP | Skills | Risk | Reports To |
|-------|-----|--------|------|-----------|
| growth-loop-cpa-analyst | memory, sequential, postgres | ad-performance-loop, data-analysis | T0 | growth-marketer |
| growth-loop-roas-optimizer | memory, sequential | ad-performance-loop, financial-modeling | T1 | growth-marketer |
| growth-loop-fatigue-detector | memory, sequential | ad-performance-loop, anomaly-detector | T0 | growth-marketer |
| growth-loop-winner-amplifier | memory, sequential | ad-performance-loop, ad-script-generator | T1 | growth-marketer |
| growth-loop-attribution-analyst | memory, postgres, sequential | ad-performance-loop, data-analysis, product-analytics | T0 | growth-marketer |

### Security Department — 13 stage agents · all report to `security-engineer`

| Agent | Skills | Risk |
|-------|--------|------|
| security-intel-cve-scanner | threat-intelligence-feed, security-review | T1 |
| security-intel-dep-auditor | threat-intelligence-feed, infrastructure-scanning | T1 |
| security-intel-threat-monitor | threat-intelligence-feed, osint-recon | T0 |
| security-intel-config-scanner | threat-intelligence-feed, infrastructure-scanning | T1 |
| security-gen-rule-writer | security-review, anti-ai-writing | T0 |
| security-gen-policy-writer | security-review, gdpr-dsgvo-expert | T0 |
| security-gen-playbook-writer | security-review, anti-ai-writing | T0 |
| security-gen-patch-creator | security-review, threat-intelligence-feed | T0 |
| security-loop-patch-tracker | threat-intelligence-feed, data-analysis | T0 |
| security-loop-vuln-analyst | threat-intelligence-feed, data-analysis | T0 |
| security-loop-false-pos-tuner | threat-intelligence-feed, security-review | T0 |
| security-loop-compliance-scorer | threat-intelligence-feed, gdpr-dsgvo-expert | T0 |
| security-loop-pentest-analyst | offensive-security, security-review | T0 |

### Quality Department — 15 stage agents · all report to `quality-engineer`

| Agent | Skills | Risk |
|-------|--------|------|
| quality-intel-failure-analyst | test-gap-analyzer, testing-methodology | T0 |
| quality-intel-flaky-detector | test-gap-analyzer, testing-methodology | T0 |
| quality-intel-coverage-scanner | test-gap-analyzer, testing-methodology | T0 |
| quality-gen-unit-writer | test-driven-development, testing-methodology | T0 |
| quality-gen-integration-writer | test-driven-development, api-testing-suite | T0 |
| quality-gen-e2e-writer | webapp-testing, testing-methodology | T0 |
| quality-gen-property-writer | property-based-testing, testing-methodology | T0 |
| quality-gen-regression-writer | test-driven-development, testing-methodology | T0 |
| quality-gen-contract-writer | api-testing-suite, api-design-patterns | T0 |
| quality-gen-mutation-runner | testing-methodology, test-gap-analyzer | T0 |
| quality-gen-fixture-builder | testing-methodology, test-driven-development | T0 |
| quality-loop-escape-analyst | test-gap-analyzer, data-analysis | T0 |
| quality-loop-strategy-optimizer | test-gap-analyzer, testing-methodology | T0 |
| quality-loop-flaky-fixer | testing-methodology, test-driven-development | T0 |
| quality-loop-coverage-reporter | test-gap-analyzer, data-analysis | T0 |

### Engineering Department — 15 stage agents · reports vary

| Agent | Skills | Risk | Reports To |
|-------|--------|------|-----------|
| engineering-intel-repo-scanner | architecture-radar, research-methodology | T1 | system-architect |
| engineering-intel-dep-tracker | architecture-radar | T1 | system-architect |
| engineering-intel-perf-profiler | production-monitoring | T1 | system-architect |
| engineering-intel-arch-reviewer | architecture-radar, clean-architecture-python | T0 | system-architect |
| engineering-intel-tech-scout | architecture-radar, research-methodology | T0 | system-architect |
| engineering-gen-api-scaffolder | api-design-patterns, coding-workflow | T0 | backend-architect |
| engineering-gen-test-scaffolder | test-driven-development, testing-methodology | T0 | backend-architect |
| engineering-gen-migration-writer | database-patterns | T0 | backend-architect |
| engineering-gen-component-builder | frontend-design, baseline-ui | T0 | frontend-architect |
| engineering-gen-doc-writer | doc-coauthoring, anti-ai-writing | T0 | backend-architect |
| engineering-loop-quality-scorer | python-quality-gate, coding-workflow | T0 | system-architect |
| engineering-loop-pattern-tracker | architecture-radar | T0 | system-architect |
| engineering-loop-perf-tracker | production-monitoring | T0 | system-architect |
| engineering-loop-debt-tracker | clean-architecture-python, python-quality-gate | T0 | system-architect |
| engineering-loop-coverage-tracker | test-gap-analyzer, testing-methodology | T0 | system-architect |

### Operations Department — 14 stage agents · all report to `performance-engineer`

| Agent | Skills | Risk |
|-------|--------|------|
| operations-intel-metric-collector | anomaly-detector, production-monitoring | T1 |
| operations-intel-cost-scanner | infra-intelligence, cost-optimization | T1 |
| operations-intel-capacity-forecaster | infra-intelligence, anomaly-detector | T0 |
| operations-intel-deploy-analyzer | anomaly-detector, github-actions-patterns | T0 |
| operations-gen-dashboard-builder | production-monitoring | T0 |
| operations-gen-alert-writer | anomaly-detector, production-monitoring | T0 |
| operations-gen-runbook-writer | anomaly-detector, anti-ai-writing | T0 |
| operations-gen-capacity-planner | infra-intelligence | T0 |
| operations-gen-cost-report-builder | infra-intelligence, data-analysis | T0 |
| operations-loop-mttr-tracker | anomaly-detector, production-monitoring | T0 |
| operations-loop-alert-tuner | anomaly-detector | T0 |
| operations-loop-cost-optimizer-loop | infra-intelligence, cost-optimization | T0 |
| operations-loop-reliability-scorer | production-monitoring | T0 |
| operations-loop-toil-tracker | anomaly-detector | T0 |

### Product Department — 13 stage agents · all report to `pm-agent`

| Agent | Skills | Risk |
|-------|--------|------|
| product-intel-feedback-scanner | product-intelligence | T0 |
| product-intel-competitor-tracker | product-intelligence, competitive-intel | T0 |
| product-intel-usage-analyst | product-analytics, data-analysis | T0 |
| product-intel-nps-analyzer | product-intelligence, product-analytics | T0 |
| product-gen-prd-writer | product-manager-toolkit, anti-ai-writing | T0 |
| product-gen-story-writer | product-manager-toolkit | T0 |
| product-gen-experiment-designer-agent | experiment-designer, ab-test-setup | T0 |
| product-gen-okr-cascader | product-strategist | T0 |
| product-loop-adoption-tracker | product-analytics | T0 |
| product-loop-experiment-analyst | experiment-designer, data-analysis | T0 |
| product-loop-churn-predictor | customer-success-manager, data-analysis | T0 |
| product-loop-velocity-tracker | product-manager-toolkit | T0 |
| product-loop-satisfaction-scorer | product-analytics | T0 |

### Research Department — 10 stage agents · all report to `deep-research`

| Agent | Skills | Risk |
|-------|--------|------|
| research-intel-arxiv-scanner | paper-scanner, research-methodology | T1 |
| research-intel-blog-scanner | paper-scanner, research-methodology | T1 |
| research-intel-conference-tracker | paper-scanner | T0 |
| research-intel-benchmark-monitor | paper-scanner, research-methodology | T0 |
| research-gen-brief-writer | paper-scanner, anti-ai-writing | T0 |
| research-gen-eval-designer | research-methodology | T0 |
| research-gen-learning-path-builder | research-methodology | T0 |
| research-loop-conversion-tracker | paper-scanner, research-methodology | T0 |
| research-loop-source-ranker | research-methodology | T0 |
| research-loop-impact-analyst | research-methodology, data-analysis | T0 |

### Documentation Department — 10 stage agents · all report to `repo-index`

| Agent | Skills | Risk |
|-------|--------|------|
| documentation-intel-freshness-scanner | doc-gap-analyzer | T0 |
| documentation-intel-gap-scanner | doc-gap-analyzer | T0 |
| documentation-intel-search-analyst | doc-gap-analyzer, data-analysis | T0 |
| documentation-gen-api-doc-writer | doc-coauthoring, anti-ai-writing | T0 |
| documentation-gen-guide-writer | doc-coauthoring, anti-ai-writing | T0 |
| documentation-gen-changelog-writer | doc-coauthoring, release-automation | T0 |
| documentation-gen-diagram-builder | doc-coauthoring | T0 |
| documentation-loop-sync-checker | doc-gap-analyzer | T0 |
| documentation-loop-quality-scorer | doc-gap-analyzer | T0 |
| documentation-loop-onboarding-timer | doc-gap-analyzer | T0 |

### Strategy Department — 9 stage agents · all report to `business-panel-experts`

| Agent | Skills | Risk |
|-------|--------|------|
| strategy-intel-competitor-monitor | market-scanner, competitive-intel | T0 |
| strategy-intel-regulatory-scanner | market-scanner, gdpr-dsgvo-expert | T0 |
| strategy-intel-funding-tracker | market-scanner | T0 |
| strategy-gen-battlecard-writer | competitive-intel, anti-ai-writing | T0 |
| strategy-gen-model-builder | financial-modeling, market-scanner | T0 |
| strategy-gen-brief-writer | market-scanner, anti-ai-writing | T0 |
| strategy-loop-forecast-scorer | market-scanner, financial-modeling | T0 |
| strategy-loop-initiative-tracker | market-scanner | T0 |
| strategy-loop-narrative-analyst | market-scanner, competitive-intel | T0 |

### Infrastructure Department — 10 stage agents · all report to `devops-architect`

| Agent | Skills | Risk |
|-------|--------|------|
| infrastructure-intel-cost-monitor | infra-intelligence, cost-optimization | T1 |
| infrastructure-intel-utilization-scanner | infra-intelligence | T1 |
| infrastructure-intel-drift-detector | infra-intelligence, devops-patterns | T1 |
| infrastructure-gen-terraform-writer | devops-patterns, infra-intelligence | T0 |
| infrastructure-gen-helm-writer | devops-patterns | T0 |
| infrastructure-gen-pipeline-builder | github-actions-patterns | T0 |
| infrastructure-gen-dockerfile-optimizer | container-security, devops-patterns | T0 |
| infrastructure-loop-deploy-success-tracker | infra-intelligence | T0 |
| infrastructure-loop-cost-trend-analyst | infra-intelligence, cost-optimization | T0 |
| infrastructure-loop-drift-fixer | infra-intelligence, devops-patterns | T0 |

## Wave 2: Per-Surface Agents (45)

9 agents per product surface (3 intel, 3 gen, 3 loop), tuned to each surface's market, users, and KPIs. **Canonical agent set** (identical names across all 5 surfaces):

| Stage | Agents |
|-------|--------|
| Intel (3) | market-scanner, user-researcher, competitor-watcher |
| Gen (3) | content-creator, feature-spec-writer, campaign-builder |
| Loop (3) | adoption-tracker, satisfaction-scorer, growth-analyst |

**Surfaces (5):** Command, Studio, Helios, Nova, Forge.

Agent definitions: `~/.claude/agents/surfaces/{surface}/{stage}/*.md`.

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
| **github** | ALL agents (read); code-reviewer, ci-cd-engineer, release-engineer, project-shipper (write) |
| **penpot** | frontend-architect, ux-designer |
| **aidesigner** | frontend-architect, ux-designer |
| **memory** | pm-agent, knowledge-graph-guide, repo-index, deep-research, system-architect, architect, ai-engineer, prompt-engineer, content-strategist, trend-researcher, root-cause-analyst, socratic-mentor, learning-guide, technical-writer, business-panel-experts, finance-tracker, requirements-analyst, experiment-tracker, feedback-synthesizer |
| **filesystem** | ALL agents (read); agent-installer, documenter, technical-writer (write) |
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

Every agent loads department context from `~/.claude/contexts/` before generating output. Universal `writing-rules.md` applies to **all** agents.

| Domain | Context Dir | Agents |
|--------|-------------|--------|
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

**Load order (UAOP Stage 2):** `writing-rules.md` → `{dept}/rules.md` → `{dept}/voice.md` → `{dept}/domain.md` → `{dept}/audience.md`.

**Universal skill binding:** all agents inherit `anti-ai-writing` for written-output quality gating.

---

## Escalation Tiers

| Tier | Behavior | Risk Level | Example |
|------|----------|------------|---------|
| **ALLOW** | Execute immediately | T0 Safe | Research, analysis, code reading |
| **REVIEW** | Log and proceed | T1 Local | Local code changes, test runs |
| **ESCALATE** | Pause for approval | T2 Shared | GitHub pushes, Slack messages, infra changes |
| **BLOCK** | Reject unless authorized | T3 Critical | Production deploys, secret rotation, DB migrations |

## Performance Routing Protocol

Mirrors CoreMind DelegationEngine — when multiple agents qualify:

1. Filter by domain — only agents in the relevant domain.
2. Filter by authority — prefer higher authority for ambiguous scope.
3. Filter by MCP access — agent must have the required MCP servers declared.
4. Rank by performance — when outcome tracking is available, prefer higher quality scores.
5. Fallback chain: L2 Head → L3 Specialist → L5 Leader → L6 Worker.

## Constitution Rules (SEC-001 Equivalent)

1. **All agent execution flows through the orchestrator** — no direct agent invocation bypassing governance.
2. **Agents operate only within declared MCP server bindings** — tool access is capability-gated.
3. **Risk tier determines approval flow** — T0/T1 auto-execute, T2 logged, T3 requires explicit approval.
4. **Every execution produces a trace** — agent, task, tools used, outcome, quality score.
5. **Performance routing is closed-loop** — better performers get more tasks over time.

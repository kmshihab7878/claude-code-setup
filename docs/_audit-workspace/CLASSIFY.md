# CLASSIFY — 5-Bucket Classification of Every File

_Scope: Phase 0.1–0.3 classification pass. No cross-reference mapping, no conflict detection (done by sibling agents)._
_Generated: 2026-04-17._
_Total non-hidden files under repo root: **986** (excluding `.git` and `.DS_Store`)._

Buckets:

| Bucket | Defend-as |
|--------|-----------|
| CORE | Actively useful, integrated, daily workflow, clearly differentiated |
| SUPPORTING | Useful content or plumbing that strengthens the system; not daily-central |
| CANDIDATE_FOR_CONSOLIDATION | Overlaps with another file; merge target |
| EXPERIMENTAL | Promising but not yet validated/integrated |
| ARCHIVAL | Genuinely superseded, deprecated, placeholder |

Default for uncertain cases: **SUPPORTING**, not ARCHIVAL.

---

## 1. Summary table

| Bucket | Count | % |
|--------|------:|--:|
| CORE | 118 | 12.0% |
| SUPPORTING | 612 | 62.1% |
| CANDIDATE_FOR_CONSOLIDATION | 42 | 4.3% |
| EXPERIMENTAL | 212 | 21.5% |
| ARCHIVAL | 2 | 0.2% |
| **Total** | **986** | **100%** |

Notes on what drives the distribution:
- The **EXPERIMENTAL** bucket is dominated by wave-1 stage agents (126 files, ~13 lines each, unused scaffolding), wave-2 surface agents (45 files, 17-line parameterized stubs), and the self-evolution layer (evolution/, 17 files).
- **CANDIDATE_FOR_CONSOLIDATION** is where the "three overlapping design skills" and "five overlapping planners" live — confirmed as redundant in `docs/SURFACE-MAP.md`.
- **ARCHIVAL** is intentionally near-zero. `.gitignore` already prevents committed backups; no true dead files were found in tracked paths. Two edge cases listed explicitly in §7.

---

## 2. By-directory breakdown

### Root files (5)

| Path | Lines | Bucket | Rationale |
|------|------:|--------|-----------|
| `CLAUDE.md` | 335 | CORE | Always-loaded main config; identity + Elite Ops + MCP tiers + planning protocol |
| `README.md` | 147 | CORE | Public-facing positioning artifact, already rewritten to lead with value |
| `settings.json` | 247 | CORE | Live hook bindings and plugin enablement — the runtime contract |
| `Makefile` | 28 | CORE | `make validate / inventory / usage` — the one command before committing |
| `LICENSE` | 20 | SUPPORTING | MIT boilerplate, required for open-sourcing |

### `agents/` top-level — 66 core L0-L6 files + REGISTRY + README (68 files total tracked)

CORE core agents (highest-leverage, cited in CLAUDE.md Top-20):

| Path | Lines | Bucket | Rationale |
|------|------:|--------|-----------|
| `agents/REGISTRY.md` | 416 | CORE | Central dispatch table, cited in CLAUDE.md planning protocol as source of truth |
| `agents/README.md` | 145 | CORE | Onboarding to agent system; roster index |
| `agents/pm-agent.md` | 751 | CORE | L0 meta-orchestrator; huge because it's the router |
| `agents/system-architect.md` | 53 | CORE | L1, cited as top-used in CLAUDE.md |
| `agents/architect.md` | 85 | CORE | L1 executive |
| `agents/business-panel-experts.md` | 252 | CORE | L1; backs `/council` and `/sc:business-panel` |
| `agents/backend-architect.md` | 53 | CORE | L2 dept head, top-used |
| `agents/frontend-architect.md` | 53 | CORE | L2 dept head |
| `agents/devops-architect.md` | 53 | CORE | L2 dept head |
| `agents/security-engineer.md` | 53 | CORE | L2; backs /security-audit |
| `agents/quality-engineer.md` | 94 | CORE | L2; backs testing workflow |
| `agents/ai-engineer.md` | 56 | CORE | L2; top-20 |
| `agents/deep-research.md` | 36 | CORE | L2; top-20 |
| `agents/growth-marketer.md` | ~50 | CORE | L2; backs /market suite |
| `agents/performance-engineer.md` | 53 | CORE | L2 |
| `agents/data-analyst.md` | ~50 | CORE | L2 |
| `agents/python-expert.md` | 53 | CORE | L3; top-20 |
| `agents/code-reviewer.md` | 82 | CORE | L6; top-20 |
| `agents/tester.md` | 74 | CORE | L6; top-20 |
| `agents/debugger.md` | 76 | CORE | L6; top-20 |
| `agents/repo-index.md` | 52 | CORE | L0; backs understand-setup |
| `agents/knowledge-graph-guide.md` | 74 | CORE | L0; cited in plan protocol |
| `agents/self-review.md` | 38 | CORE | L0; cited as gate |
| `agents/agent-installer.md` | 102 | CORE | L0; meta-op |
| `agents/evolution-orchestrator.md` | 32 | EXPERIMENTAL | Gatekeeper for the self-evolution layer; small and unvalidated in practice |
| `agents/learning-curator.md` | 40 | EXPERIMENTAL | Part of evolution trio; same reason |
| `agents/evaluation-judge.md` | 41 | EXPERIMENTAL | Part of evolution trio |
| `agents/market-content.md` | 129 | CORE | Backs /market audit — flagship marketing flow |
| `agents/market-competitive.md` | 139 | CORE | /market audit |
| `agents/market-conversion.md` | 141 | CORE | /market audit |
| `agents/market-strategy.md` | 166 | CORE | /market audit |
| `agents/market-technical.md` | 175 | CORE | /market audit |

Remaining core L0-L6 agents (40 files): **SUPPORTING** — real definitions, adequate frontmatter, integrated into REGISTRY but not always-on. Examples: `api-tester`, `compliance-officer`, `content-strategist`, `cost-optimizer`, `db-admin`, `docker-specialist`, `documenter`, `experiment-tracker`, `feedback-synthesizer`, `finance-tracker`, `growth-marketer`, `incident-responder`, `infra-engineer`, `learning-guide`, `legal-compliance-checker`, `migration-specialist`, `mobile-app-builder`, `monorepo-manager`, `observability-engineer`, `performance-optimizer`, `prompt-engineer`, `rapid-prototyper`, `refactorer`, `refactoring-expert`, `release-engineer`, `requirements-analyst`, `root-cause-analyst`, `scrum-facilitator`, `secrets-manager`, `security-auditor`, `socratic-mentor` (296 lines), `technical-writer`, `test-results-analyzer`, `trend-researcher`, `ux-designer`, `workflow-optimizer`, `analytics-reporter`, `api-designer`, `ci-cd-engineer`, `project-shipper`.

### `agents/` Wave 1 — 10 domains × intel/gen/loop = 126 files

Every file is a ~13-line stub with frontmatter (name, authority L6, domain, stage, skills list, risk T0-T1) and a 1-sentence body.

| Group | Count | Bucket | Rationale |
|-------|------:|--------|-----------|
| `agents/documentation/{intel,gen,loop}/*.md` | 10 | EXPERIMENTAL | 13-line stubs, no scripts or backing implementations |
| `agents/engineering/{intel,gen,loop}/*.md` | 15 | EXPERIMENTAL | Same — scaffolded but never wired to hooks/skills with real bodies |
| `agents/growth/{intel,gen,loop}/*.md` | 17 | EXPERIMENTAL | Same |
| `agents/infrastructure/{intel,gen,loop}/*.md` | 10 | EXPERIMENTAL | Same |
| `agents/operations/{intel,gen,loop}/*.md` | 14 | EXPERIMENTAL | Same |
| `agents/product/{intel,gen,loop}/*.md` | 13 | EXPERIMENTAL | Same |
| `agents/quality/{intel,gen,loop}/*.md` | 15 | EXPERIMENTAL | Same |
| `agents/research/{intel,gen,loop}/*.md` | 10 | EXPERIMENTAL | Same |
| `agents/security/{intel,gen,loop}/*.md` | 13 | EXPERIMENTAL | Same |
| `agents/strategy/{intel,gen,loop}/*.md` | 9 | EXPERIMENTAL | Same |

### `agents/` Wave 2 — 5 surfaces × intel/gen/loop (3 each) = 45 files

All 5 surfaces (`command`, `forge`, `helios`, `nova`, `studio`) host the same 9 agent names (`campaign-builder`, `content-creator`, `feature-spec-writer`, `market-scanner`, `competitor-watcher`, `user-researcher`, `adoption-tracker`, `growth-analyst`, `satisfaction-scorer`) differing only in frontmatter surface/context/target-market. 17-line parameterized templates.

| Group | Count | Bucket | Rationale |
|-------|------:|--------|-----------|
| `agents/surfaces/{command,forge,helios,nova,studio}/{intel,gen,loop}/*.md` | 45 | EXPERIMENTAL | Parameterized templates for hypothetical product surfaces; no corresponding products exist in the repo. Label EXPERIMENTAL rather than ARCHIVAL per instruction — they represent a clear positioning narrative (surface-aware agent fleet) but are unvalidated. |

### `skills/` — 202 SKILL.md + ~359 reference/script/example files = 561 files total

CORE skills (top ~30 by integration + demo value + differentiation):

| Skill | SKILL.md lines | Bucket | Rationale |
|-------|---------------:|--------|-----------|
| `skills/jarvis-core` | 322 | CORE | 10-stage orchestration pipeline; anchors planning protocol |
| `skills/governance-gate` | 251 | CORE | 5 safety layers; anchors risk tiers |
| `skills/operating-framework` | 447 | CORE | KhaledPowers framework; top-20 |
| `skills/elite-ops` | 176 | CORE | Activates `/ship`/`/audit-deep`/`/fix-root` posture |
| `skills/moyu` | 267 | CORE | Anti-over-engineering guardrail, cited in top-20 |
| `skills/prompt-reliability-engine` | 386 | CORE | 9-mode prompt framework, top-20 |
| `skills/coding-workflow` | 91 | CORE | Top-20 |
| `skills/test-driven-development` | ~150 | CORE | Top-20, backs TDD non-negotiable |
| `skills/git-workflows` | ~120 | CORE | Top-20 |
| `skills/security-review` | ~150 | CORE | Top-20 |
| `skills/api-design-patterns` | ~180 | CORE | Top-20 |
| `skills/python-quality-gate` | ~150 | CORE | Top-20, backs ruff auto-fix hook |
| `skills/council` | 338 | CORE | Backs /council/\[/sc:business-panel\]; distinctive |
| `skills/n8n` | 200+multi | CORE | Full automation suite, backed by czlonkowski eval set |
| `skills/hue` | 807 | CORE | Biggest SKILL.md; meta-skill for brand → design-language child; extraction candidate |
| `skills/react-bits` | 149 | CORE | 130-component shadcn-cli catalog; extraction candidate |
| `skills/mcp-mastery` | 184 | CORE | 30-server catalog + router; extraction candidate |
| `skills/impeccable-design` | 123 | CORE | Canonical design-from-scratch skill per SURFACE-MAP |
| `skills/impeccable-audit` | 109 | CORE | Canonical UI audit skill per SURFACE-MAP |
| `skills/impeccable-polish` | 122 | CORE | Canonical polish skill per SURFACE-MAP |
| `skills/ultrathink` | 208 | CORE | Cognitive depth engine; cited in plan protocol |
| `skills/market` | 99 | CORE | Orchestrator for 15 /market commands |
| `skills/jarvis-sec` | 98 | CORE | Distinctive autonomous security ecosystem |
| `skills/recall` | 75 | CORE | Cross-session search; backs /recall |
| `skills/understand` | 46 | CORE | Knowledge-graph root for `understand-*` family |
| `skills/b2c-app-strategist` | ~300 | CORE | End-to-end B2C iOS playbook; distinctive |
| `skills/claude-api` | ~200 + 28 ref | CORE | Multi-language Claude SDK skill with live-sources |
| `skills/skill-creator` | 485 | CORE | Anthropic-grade skill-builder with eval harness |
| `skills/skill-architect` | ~250 | CORE | Pairs with skill-creator; validator |

CANDIDATE_FOR_CONSOLIDATION — overlapping skills flagged in `docs/SURFACE-MAP.md`:

| Skill | Overlaps With | Rationale |
|-------|---------------|-----------|
| `skills/frontend-design` | `impeccable-design` | SURFACE-MAP marks as "pending telemetry review" — no distinct value shown |
| `skills/interface-design` | `impeccable-design` | Same |
| `skills/ui-ux-pro-max` | `impeccable-design` | Same; 28-file data-driven variant |
| `skills/baseline-ui` | `impeccable-audit` | Same — pending telemetry |
| `skills/ui-design-system` | `impeccable-design` / `hue` | Overlaps with both design entry points |
| `skills/ux-researcher-designer` | `ui-design-system` / `ux-designer agent` | Role-mirror skill |
| `skills/distilled-aesthetics` | `impeccable-design` | Anthropic cookbook extract, likely merge target |
| `skills/brand-guidelines` | `hue` | Hue covers brand systematically; this is unscoped |
| `skills/clone-website` | `design-inspector` + `hue` | Overlapping capture pipeline |
| `skills/cold-email` | `market-emails` | Both do email generation; `/market` flow wins |
| `skills/content-strategy` | `market-brand` / `market-social` | Topic overlap |
| `skills/competitive-intel` | `market-competitors` | Both do competitor intelligence |
| `skills/pricing-strategy` | `marketing-strategy-pmm` | Both pricing-adjacent |
| `skills/seo-audit` | `market-seo` | Direct overlap |
| `skills/marketing-demand-acquisition` | `market-ads` + `market-audit` | PMM-flavored duplicate of /market suite |
| `skills/marketing-strategy-pmm` | `market-*` suite | Same |
| `skills/research-methodology` | `agents/deep-research.md` | Role-mirror |
| `skills/hybrid-search-implementation` | `rag-patterns` | Both cover retrieval strategy |
| `skills/understand-setup` | `understand` | Understand-family over-fragmented (see below) |
| `skills/understand-jarvis` | `understand-chat` | Specific-variant that duplicates general chat skill |

Understand-family note: `understand`, `understand-chat`, `understand-dashboard`, `understand-diff`, `understand-explain`, `understand-jarvis`, `understand-memory-sync`, `understand-onboard`, `understand-setup` — 9 skills under 70 lines each, all thin wrappers. Keep `understand` + 2–3 differentiated children; the rest are CANDIDATE_FOR_CONSOLIDATION.

Confidence-check / verification-before-completion / subagent-development / executing-plans / receiving-code-review / branch-finishing / git-worktrees: **SUPPORTING** — imported KhaledPowers process skills, useful but not routed daily.

EXPERIMENTAL skills:

| Skill | Bucket | Rationale |
|-------|--------|-----------|
| `skills/session-bootstrap` | EXPERIMENTAL | 29 lines; part of self-evolution layer |
| `skills/evidence-recorder` | EXPERIMENTAL | 62 lines; self-evolution trio |
| `skills/session-analyst` | EXPERIMENTAL | 33 lines; self-evolution trio |
| `skills/promotion-gate` | EXPERIMENTAL | 34 lines; self-evolution gate |
| `skills/pruning-view` | EXPERIMENTAL | 31 lines; self-evolution view |
| `skills/skill-evolution` | EXPERIMENTAL | Self-evolving skill lifecycle — paired with evolution layer |
| `skills/paperclip` | EXPERIMENTAL | Vendor-specific control-plane integration, 3 references |
| `skills/paperclip-create-agent` | EXPERIMENTAL | Same |
| `skills/paperclip-create-plugin` | EXPERIMENTAL | Same |
| `skills/mirofish-prediction` | EXPERIMENTAL | Qualitative swarm-sim; interesting but unproven |
| `skills/hermes-integration` | EXPERIMENTAL | Depends on aspirational `hermes` MCP (not installed) |
| `skills/sim-studio` | EXPERIMENTAL | Depends on aspirational `sim-studio` MCP |
| `skills/aidesigner-frontend` | EXPERIMENTAL | Depends on aspirational `aidesigner` MCP |
| `skills/aster-trading` | EXPERIMENTAL | Depends on aspirational `aster` MCP; trading-specific |
| `skills/aster-timesfm-pipeline` | EXPERIMENTAL | Same — MCP-gated |
| `skills/goose-integration` | EXPERIMENTAL | Parallel engine route, not default |
| `skills/qwen-dispatch` | EXPERIMENTAL | Tri-engine routing, not measured in practice |
| `skills/unified-router` | EXPERIMENTAL | Cross-engine router, speculative |
| `skills/agent-orchestrator` | EXPERIMENTAL | Multi-agent pluggable tooling, unvalidated |
| `skills/autoresearch` | EXPERIMENTAL | Self-improvement loop; one template only |
| `skills/understand-jarvis` | EXPERIMENTAL | Product-specific (JARVIS-FRESH) variant |
| `skills/understand-memory-sync` | EXPERIMENTAL | Niche sync path |

SUPPORTING skills (the bulk, ~120 skills):
- **C-suite advisors** (7): `ceo-advisor`, `cfo-advisor`, `ciso-advisor`, `cmo-advisor`, `coo-advisor`, `cpo-advisor`, `cto-advisor` — all SUPPORTING. Cohesive persona set, used by `business-panel-experts` agent.
- **Marketing /market suite** (15 market-* skills): `market-ads`, `market-audit`, `market-brand`, `market-competitors`, `market-copy`, `market-emails`, `market-funnel`, `market-landing`, `market-launch`, `market-proposal`, `market-report`, `market-report-pdf`, `market-scanner`, `market-seo`, `market-social` — all CORE (routed by `market` orchestrator). Extraction candidate as a standalone product.
- **Infrastructure/devops**: `container-security`, `cost-optimization`, `devops-patterns`, `github-actions-patterns`, `infrastructure-scanning`, `local-dev-orchestration`, `release-automation`, `production-monitoring`, `structured-logging`, `infra-intelligence` — SUPPORTING. Real content, referenced by infra agents.
- **Python quality family**: `python-quality-gate` (CORE), `property-based-testing`, `clean-architecture-python`, `database-patterns` — SUPPORTING.
- **Testing family**: `testing-methodology` (CORE), `api-testing-suite`, `webapp-testing`, `expect-testing`, `test-gap-analyzer`, `agent-evaluation` — SUPPORTING.
- **Document-generation skills**: `pdf`, `xlsx`, `pptx-generator`, `docx-generator`, `docx-generator`, `web-artifacts-builder`, `algorithmic-art`, `remotion-animation`, `video-ui-patterns` — SUPPORTING. Real capability with scripts + LICENSE files.
- **Financial/trading/analysis**: `financial-modeling`, `financial-analyst`, `finance-ml`, `timesfm-forecasting`, `revenue-operations`, `sales-engineer`, `customer-success-manager` — SUPPORTING.
- **Security family**: `offensive-security`, `osint-recon`, `threat-intelligence-feed`, `gdpr-dsgvo-expert`, `security-review` (CORE) — SUPPORTING except `security-review`.
- **Content/creative**: `anti-ai-writing`, `design-inspector`, `framer-motion-patterns`, `responsive-design`, `fixing-accessibility`, `fixing-motion-performance`, `fixing-metadata`, `ab-test-setup`, `experiment-designer`, `doc-coauthoring`, `doc-gap-analyzer`, `doc-gap-analyzer` — SUPPORTING.
- **wshobson-* (7 skills)**: `wshobson-SKILL`, `wshobson-argocd-setup`, `wshobson-chart-structure`, `wshobson-deployment-spec`, `wshobson-rbac-patterns`, `wshobson-service-spec`, `wshobson-sync-policies` — SUPPORTING. Kubernetes reference skills with large bodies (500-780 lines each). They are canonical reference material but domain-narrow.
- **Anomaly/intel scanners**: `anomaly-detector`, `architecture-radar`, `product-intelligence`, `market-scanner`, `paper-scanner` — SUPPORTING. Each is ~60-80 lines and routes to a department agent.
- **Process skills**: `project-template`, `using-khaledpowers`, `quality-manager-qmr`, `para-memory-files`, `recipe`, `agent-evaluation`, `anti-ai-writing`, `confidence-check` (has .py + .ts), `context-budget-audit` — SUPPORTING.
- **Domain-specialty**: `graphql-architect`, `mcp-builder`, `multi-agent-patterns`, `rag-patterns`, `data-analysis`, `mlops-engineer`, `supabase-postgres-best-practices`, `domain-driven-design`, `product-analytics`, `product-manager-toolkit`, `product-strategist`, `content-strategy`, `seo-audit`, `cold-email`, `ab-test-setup`, `experiment-designer` — SUPPORTING.

`skills/README.md` (141 lines) → SUPPORTING (navigation aid).
`skills/_shared/{skill-template.md, review-checklist.md, naming-conventions.md}` → CORE (governance templates cited in CLAUDE.md).
`skills/bmad/{bmm,bmb,cis,core}/...SKILL.md` (9 files) → SUPPORTING (pairs with /bmad:* commands).
`skills/n8n/*` (94 files including czlonkowski eval JSONs) → CORE for SKILL.md files; SUPPORTING for evaluation JSON fixtures and docs; licensing file SUPPORTING.
`skills/xlsx/scripts/office/schemas/**/*.xsd` (~30 schema files, 16-4439 lines each) → SUPPORTING. Third-party OOXML reference schemas, vendored by the skill for offline validation. Large footprint but legitimately consumed by `pack.py`/`validate.py`.
`skills/hue/examples/{atlas,auris,drift,fizz,halcyon,kiln,ledger,meadow,orivion,oxide,prism,relay,ridge,solvent,stint,thrive,velvet}/*.html` (~19 brand demo HTML files, 900-4500 lines each) → CORE. These are the **demo artifacts** — they prove Hue can generate brand-aware design languages end-to-end. Top leverage.
`skills/timesfm-forecasting/examples/**` (17 files: demos, outputs, gifs, HTML) → SUPPORTING. Demo payload.
`skills/claude-api/{python,typescript,java,go,php,ruby,csharp,curl,shared}/*.md` (28 files) → CORE for shared/ reference; SUPPORTING for individual-language pages.

### `commands/` — 39 custom + 31 SC + 15 BMAD = 85 entries (84 .md + sc/README)

CORE custom commands (by SURFACE-MAP canonicalization):

| Command | Lines | Bucket | Rationale |
|---------|------:|--------|-----------|
| `commands/plan.md` | 496 | CORE | Canonical planner; 10-stage CoreMind pipeline |
| `commands/ultraplan.md` | 576 | CORE | Canonical for enterprise-risk planning |
| `commands/planUI.md` | 309 | CORE | UI-dedicated pipeline routing 26 skills |
| `commands/ship.md` | 40 | CORE | Canonical build-something-end-to-end |
| `commands/audit-deep.md` | 68 | CORE | Canonical full-stack audit |
| `commands/fix-root.md` | 47 | CORE | Canonical bug fix |
| `commands/polish-ux.md` | 60 | CORE | Canonical UX polish |
| `commands/council-review.md` | 53 | CORE | Multi-perspective debate |
| `commands/council.md` | 7 | CORE | Slim alias — triggers council skill |
| `commands/evolution.md` | 86 | CORE | Operator panel for self-evolution layer |
| `commands/wiki-ingest.md` | 26 | CORE | KB ingest entrypoint |
| `commands/wiki-query.md` | 25 | CORE | KB query entrypoint |
| `commands/wiki-lint.md` | 48 | CORE | KB health check |
| `commands/setup-audit.md` | 53 | CORE | Health check of this repo setup |

SUPPORTING custom commands:

| Command | Lines | Bucket | Rationale |
|---------|------:|--------|-----------|
| `commands/pr-prep.md` | 46 | CORE (top-20) | Git-flow final gate |
| `commands/review.md` | 51 | CORE (top-20) | Code review |
| `commands/debug.md` | 43 | CORE (top-20) | Debug flow |
| `commands/test-gen.md` | 42 | CORE (top-20) | Test generation |
| `commands/explain.md` | 35 | CORE (top-20) | Explain |
| `commands/spec.md` | 51 | CORE (top-20) | Specification |
| `commands/start-task.md` | 81 | CORE (top-20) | Task start |
| `commands/complete.md` | 74 | CORE (top-20) | Task complete |
| `commands/security-audit.md` | 28 | CORE | Referenced in SURFACE-MAP |
| `commands/optimize.md` | 38 | SUPPORTING | Performance flow |
| `commands/bootstrap.md` | 49 | SUPPORTING | Interactive CLAUDE.md generator |
| `commands/repo-review.md` | 64 | CANDIDATE_FOR_CONSOLIDATION | Overlaps with /audit-deep and /setup-audit |
| `commands/metrics.md` | 52 | SUPPORTING | Metrics report |
| `commands/retro.md` | 87 | SUPPORTING | Retrospective |
| `commands/context-load.md` | 54 | SUPPORTING | Context loader |
| `commands/handoff.md` | 73 | SUPPORTING | Session handoff |
| `commands/skill-design.md` | 40 | SUPPORTING | Paired with skill-creator |
| `commands/jarvis-sec.md` | 48 | CORE | Invokes jarvis-sec skill |
| `commands/autoresearch.md` | 96 | EXPERIMENTAL | Autonomous self-improvement loop |

Interface-design family (5 commands):

| Command | Lines | Bucket | Rationale |
|---------|------:|--------|-----------|
| `commands/interface-design-init.md` | 83 | CANDIDATE_FOR_CONSOLIDATION | Overlaps with /planUI and impeccable-design; pending SURFACE-MAP telemetry review |
| `commands/interface-design-audit.md` | 69 | CANDIDATE_FOR_CONSOLIDATION | Overlaps with impeccable-audit skill |
| `commands/interface-design-critique.md` | 68 | CANDIDATE_FOR_CONSOLIDATION | Overlaps with polish-ux |
| `commands/interface-design-extract.md` | 80 | CANDIDATE_FOR_CONSOLIDATION | Overlaps with design-inspector skill |
| `commands/interface-design-status.md` | 50 | CANDIDATE_FOR_CONSOLIDATION | Utility for the same family |

`commands/sc/*.md` (31 files): all **SUPPORTING**. Imported SuperClaude framework; large + well-formed (pm.md 592, recommend.md 1005, spec-panel.md 435). Not canonical per SURFACE-MAP — every `/sc:*` is an alternative to a custom canonical command.
`commands/sc/README.md` (22 lines) → SUPPORTING.

`commands/bmad/*.md` (15 files): all **SUPPORTING**. Full BMAD Agile/product suite (architecture 595, dev-story 847, sprint-planning 706, create-ux-design 839, create-story 544, etc.). Cohesive product-management flow, unlikely to be invoked in engineering mode but self-contained.

### `hooks/` — 13 shell scripts

All scripts are cited in `settings.json` bindings. All CORE.

| Hook | Lines | Bucket | Rationale |
|------|------:|--------|-----------|
| `hooks/session-init.sh` | 112 | CORE | SessionStart hook (baseline) |
| `hooks/evolution-startup.sh` | 82 | CORE | SessionStart hook (self-evolution injector) |
| `hooks/evolution-sessionend.sh` | 33 | CORE | SessionEnd record hook |
| `hooks/session-metrics.sh` | 14 | CORE | Metrics fire on stop |
| `hooks/usage-logger.sh` | 35 | CORE | PreToolUse telemetry writer — evidence backbone |
| `hooks/mcp-security-gate.sh` | 94 | CORE | MCP whitelist enforcement, cited in CLAUDE.md |
| `hooks/context-guard.sh` | 97 | CORE | Context-budget safety |
| `hooks/preflight-context-guard.sh` | 46 | CORE | Pre-tool context guard |
| `hooks/loop-detector.sh` | 62 | CORE | Infinite-loop detector |
| `hooks/persistent-mode.sh` | 132 | CORE | Blocks premature Stop in autonomous mode |
| `hooks/stop-verification.sh` | 50 | CORE | Stop-time uncommitted-file check |
| `hooks/keyword-detector.sh` | 99 | CORE | Sensitive-path / dangerous-command blocker |
| `hooks/tool-failure-tracker.sh` | 78 | CORE | Failure log for postmortems |

### `recipes/` — 13 YAML (+README +lib) = 16 files

| Path | Lines | Bucket | Rationale |
|------|------:|--------|-----------|
| `recipes/README.md` | 37 | SUPPORTING | Navigation |
| `recipes/engineering/api-endpoint.yaml` | 64 | CORE | Primary parameterized workflow |
| `recipes/engineering/code-review.yaml` | 73 | CORE | Primary |
| `recipes/engineering/debug-investigation.yaml` | 75 | CORE | Primary |
| `recipes/engineering/refactor.yaml` | 85 | CORE | Primary |
| `recipes/engineering/test-suite.yaml` | 60 | CORE | Primary |
| `recipes/devops/deploy-check.yaml` | 79 | CORE | Primary |
| `recipes/security/secrets-scan.yaml` | 58 | CORE | Primary |
| `recipes/security/security-audit.yaml` | 81 | CORE | Primary |
| `recipes/trading/market-scan.yaml` | 60 | EXPERIMENTAL | Depends on aspirational `aster` MCP |
| `recipes/trading/position-review.yaml` | 55 | EXPERIMENTAL | Same |
| `recipes/sub/dep-audit.yaml` | 21 | CORE | Reusable sub-recipe |
| `recipes/sub/lint-check.yaml` | 20 | CORE | Reusable sub-recipe |
| `recipes/sub/test-run.yaml` | 20 | CORE | Reusable sub-recipe |
| `recipes/lib/recipe-runner.sh` | 133 | CORE | Executor — required by all recipes |
| `recipes/lib/mcp-whitelist.json` | 107 | CORE | Safety gate for recipes |

### `rules/` — 6 Markdown files

All are path-scoped rules referenced by CLAUDE.md and imports hierarchy.

| Rule | Lines | Bucket | Rationale |
|------|------:|--------|-----------|
| `rules/implementation.md` | 64 | CORE | Imported by global CLAUDE.md; universal |
| `rules/python.md` | 18 | CORE | Python path rule |
| `rules/typescript.md` | 19 | CORE | TS path rule |
| `rules/security.md` | 25 | CORE | Security path rule |
| `rules/testing.md` | 21 | CORE | Test path rule |
| `rules/infrastructure.md` | 23 | CORE | IaC path rule |

### `scripts/` — 3 shell scripts

| Script | Lines | Bucket | Rationale |
|--------|------:|--------|-----------|
| `scripts/inventory.sh` | 171 | CORE | Generates `docs/INVENTORY.md`; the source of truth |
| `scripts/validate.sh` | 133 | CORE | Drift/frontmatter/count validator; invoked by Makefile |
| `scripts/analyze-usage.sh` | 127 | CORE | Telemetry analyzer; invoked by Makefile |

### `docs/` — 27 reference docs (26 tracked + `_audit-workspace/`)

Elite Operations + remediation docs (all CORE):

| Doc | Lines | Bucket | Rationale |
|-----|------:|--------|-----------|
| `docs/INVENTORY.md` | 75 | CORE | Generated; single source of truth |
| `docs/OVERHEAD.md` | 62 | CORE | Honest context-cost analysis |
| `docs/SURFACE-MAP.md` | 52 | CORE | Canonical-entrypoint ruleset |
| `docs/COUNCIL-REMEDIATION.md` | 43 | CORE | Audit fix map |
| `docs/KB-STATUS.md` | 56 | CORE | KB honesty statement |
| `docs/DEMO.md` | 51 | CORE | Reproducible demo script |
| `docs/TELEMETRY.md` | 77 | CORE | Telemetry protocol |
| `docs/ELITE-OPS-README.md` | 96 | CORE | Elite Ops entry doc |
| `docs/ELITE-OPS-METHODOLOGY.md` | 189 | CORE | Methodology behind `/ship` etc. |

Reference / aspirational / legacy-inherited docs:

| Doc | Lines | Bucket | Rationale |
|-----|------:|--------|-----------|
| `docs/CAPABILITIES_REPORT.md` | 1180 | CANDIDATE_FOR_CONSOLIDATION | Huge capabilities summary — likely outdated vs generated inventory |
| `docs/CLAUDE_CODE_ARCHITECTURE.md` | 524 | SUPPORTING | Architecture narrative |
| `docs/CLAUDE_CODE_ECOSYSTEM.md` | 192 | SUPPORTING | Ecosystem landscape |
| `docs/AI_AGENT_LANDSCAPE.md` | 210 | SUPPORTING | External landscape doc |
| `docs/CURATED_TOOLS.md` | 225 | SUPPORTING | CLI list, mirrors CLAUDE.md CLI table |
| `docs/DATA_PLATFORM_GUIDE.md` | 165 | SUPPORTING | Reference content |
| `docs/DEVOPS_TOOLKIT.md` | 291 | SUPPORTING | Reference content |
| `docs/FINANCE_ML_STACK.md` | 217 | SUPPORTING | Reference content |
| `docs/FRONTEND_PATTERNS.md` | 305 | SUPPORTING | Reference content |
| `docs/LEARNING_ROADMAP.md` | 183 | SUPPORTING | Learning plan, aspirational |
| `docs/PRODUCT_EVALUATIONS.md` | 159 | SUPPORTING | Product-eval reference |
| `docs/RAG_LLM_REFERENCE.md` | 253 | SUPPORTING | Reference content |
| `docs/SECURITY_ARSENAL.md` | 184 | SUPPORTING | Security tool list |
| `docs/SECURITY_PLAYBOOK.md` | 709 | SUPPORTING | Full security playbook |
| `docs/OPERATING_FRAMEWORK.md` | 255 | CANDIDATE_FOR_CONSOLIDATION | Duplicates `skills/operating-framework/SKILL.md` |
| `docs/QUICKSTART.md` | 218 | SUPPORTING | Quickstart guide |
| `docs/prompt-reliability-playbook.md` | 85 | SUPPORTING | Companion to the prompt-reliability skill |

### `kb/` — 10 files (KB scaffold/pilot per `docs/KB-STATUS.md`)

| Path | Lines | Bucket | Rationale |
|------|------:|--------|-----------|
| `kb/CLAUDE.md` | 79 | CORE | Schema + workflow doc for the KB |
| `kb/wiki/INDEX.md` | 105 | EXPERIMENTAL | Index of pilot KB |
| `kb/wiki/b2c-app-playbook.md` | 129 | EXPERIMENTAL | Seed article |
| `kb/wiki/changelog.md` | 28 | EXPERIMENTAL | KB changelog |
| `kb/wiki/claude-usage-dashboard.md` | 86 | EXPERIMENTAL | Seed article |
| `kb/wiki/external-brain-kb-methodology.md` | 154 | EXPERIMENTAL | Methodology doc |
| `kb/wiki/impeccable-design-system.md` | 161 | EXPERIMENTAL | Seed article |
| `kb/wiki/log.md` | 26 | EXPERIMENTAL | Append log |
| `kb/outputs/` | empty | EXPERIMENTAL | Query output sink (empty) |
| `kb/raw/` | empty | EXPERIMENTAL | Ingest dropzone (empty) |

KB is explicitly labeled scaffold/pilot. Everything except `kb/CLAUDE.md` (the contract/schema) is EXPERIMENTAL until the exit criteria in KB-STATUS.md are met.

### `evolution/` — 17 files + empty dirs

| Path | Lines | Bucket | Rationale |
|------|------:|--------|-----------|
| `evolution/README.md` | 70 | CORE | Architecture doc for self-evolution layer |
| `evolution/config.yaml` | 24 | CORE | Kill switch + budget + thresholds |
| `evolution/stable/global.md` | 14 | CORE | Session-start operating contract |
| `evolution/stable/by-project/.gitkeep` | 0 | SUPPORTING | Directory marker |
| `evolution/schemas/candidate.yaml` | 21 | CORE | Candidate schema |
| `evolution/records/sessions.jsonl` | 2 | EXPERIMENTAL | Runtime-captured evidence; real but sparse |
| `evolution/bin/evolve-collect.sh` | 102 | CORE | Collector |
| `evolution/bin/evolve-demote.sh` | 36 | CORE | Demotion operator |
| `evolution/bin/evolve-promote.sh` | 97 | CORE | Promotion gate — critical path |
| `evolution/bin/evolve-prune.sh` | 41 | CORE | Pruning tool |
| `evolution/bin/evolve-regression.sh` | 60 | CORE | Regression detector |
| `evolution/bin/evolve-status.sh` | 44 | CORE | Status dashboard |
| `evolution/tests/smoke.sh` | 61 | CORE | Smoke test |
| `evolution/candidates/` | empty | EXPERIMENTAL | Candidate pool (empty at snapshot) |
| `evolution/rejected/` | empty | EXPERIMENTAL | Rejected archive (empty) |
| `evolution/reports/` | empty | EXPERIMENTAL | Report sink (empty) |

The evolution layer is **CORE infrastructure but EXPERIMENTAL outcome** — the pipeline is wired, the evidence store is sparse (2 session records), and no candidate has been promoted. Classification: infrastructure = CORE, outcome directories = EXPERIMENTAL.

---

## 3. Top 20 heaviest files by line count

| Path | Lines | Bucket | Notable |
|------|------:|--------|---------|
| `skills/n8n/czlonkowski/skills.png` | 7288 (file size) | SUPPORTING | Asset, not code — counted by `wc -l` as binary |
| `skills/timesfm-forecasting/examples/global-temperature/output/interactive_forecast.html` | 5939 | SUPPORTING | Demo artifact |
| `skills/timesfm-forecasting/examples/global-temperature/output/animation_data.json` | 5440 | SUPPORTING | Demo data |
| `skills/xlsx/scripts/office/schemas/ISO-IEC29500-4_2016/sml.xsd` | 4439 | SUPPORTING | OOXML schema — required by validator |
| `skills/hue/examples/halcyon/component-library.html` | 4359 | CORE | Hue demo — distinctive brand system demo |
| `skills/timesfm-forecasting/examples/global-temperature/output/forecast_animation.gif` | 4219 | SUPPORTING | Demo GIF |
| `skills/xlsx/scripts/office/schemas/ISO-IEC29500-4_2016/wml.xsd` | 3646 | SUPPORTING | OOXML schema |
| `skills/xlsx/scripts/office/schemas/ISO-IEC29500-4_2016/dml-main.xsd` | 3081 | SUPPORTING | OOXML schema |
| `skills/xlsx/scripts/office/schemas/ISO-IEC29500-4_2016/pml.xsd` | 1676 | SUPPORTING | OOXML schema |
| `skills/timesfm-forecasting/examples/covariates-forecasting/output/covariates_data.png` | 1569 | SUPPORTING | Binary asset |
| `skills/hue/examples/ledger/landing-page.html` | 1540 | CORE | Hue demo |
| `skills/xlsx/scripts/office/schemas/ISO-IEC29500-4_2016/dml-chart.xsd` | 1499 | SUPPORTING | OOXML schema |
| `skills/hue/examples/relay/landing-page.html` | 1459 | CORE | Hue demo |
| `skills/hue/examples/fizz/landing-page.html` | 1431 | CORE | Hue demo |
| `skills/hue/examples/kiln/landing-page.html` | 1408 | CORE | Hue demo |
| `skills/hue/examples/drift/landing-page.html` | 1386 | CORE | Hue demo |
| `skills/skill-creator/eval-viewer/viewer.html` | 1325 | SUPPORTING | Eval-viewer UI |
| `skills/hue/examples/solvent/landing-page.html` | 1295 | CORE | Hue demo |
| `skills/hue/examples/stint/app-screen.html` | 1278 | CORE | Hue demo |
| `skills/hue/examples/velvet/landing-page.html` | 1248 | CORE | Hue demo |

Observation: nine of the top twenty heaviest files are Hue demo brand pages. These are **not** bloat — they are the most concrete demo of generating a brand-specific design language skill (the repo's most distinctive extraction candidate). Keep them.

The OOXML schemas are legitimately required by `skills/xlsx` validators but could be slimmed to an on-demand reference if disk size matters.

---

## 4. Top 20 highest-leverage files

Leverage = how much outcome / positioning / extraction value this file carries per kilobyte.

| # | Path | Lines | Bucket | Leverage type |
|--:|------|------:|--------|---------------|
| 1 | `CLAUDE.md` | 335 | CORE | **Operational + Positioning** — the always-loaded contract that defines the whole system |
| 2 | `README.md` | 147 | CORE | **Positioning** — the public-facing "this is what this repo is" artifact, already rewritten post-council |
| 3 | `settings.json` | 247 | CORE | **Operational** — wires 21 hook entries that enforce the non-negotiables |
| 4 | `docs/INVENTORY.md` | 75 | CORE | **Operational + Positioning** — deterministic source of truth that kills count-drift |
| 5 | `scripts/inventory.sh` | 171 | CORE | **Operational** — the actual generator behind INVENTORY.md |
| 6 | `scripts/validate.sh` | 133 | CORE | **Operational** — pre-commit drift guard |
| 7 | `agents/REGISTRY.md` | 416 | CORE | **Operational + Positioning** — central dispatch table, proves the JARVIS-mirrored architecture |
| 8 | `skills/jarvis-core/SKILL.md` | 322 | CORE | **Operational + Extraction** — 10-stage governed pipeline, standalone skill candidate |
| 9 | `skills/governance-gate/SKILL.md` | 251 | CORE | **Operational + Extraction** — 5-layer safety gate, standalone candidate |
| 10 | `skills/hue/SKILL.md` + 19 demo brands | 807 + ~22k | CORE | **Demo + Extraction** — clearest "standalone product" candidate (brand → design-language generator) |
| 11 | `skills/elite-ops/SKILL.md` | 176 | CORE | **Positioning + Extraction** — headline differentiator ("owner-level engineer mode"); standalone |
| 12 | `skills/react-bits/SKILL.md` | 149 | CORE | **Extraction** — 130-component catalog; ships as-is |
| 13 | `skills/mcp-mastery/SKILL.md` + GAPS.md | 184+ | CORE | **Extraction** — 30-server catalog + task router; self-contained |
| 14 | `skills/market/SKILL.md` + 15 market-* skills + agents + /market commands | ~4200 | CORE | **Demo + Extraction** — full marketing suite; concrete demo, easy spin-off |
| 15 | `skills/jarvis-sec/SKILL.md` | 98 | CORE | **Positioning + Extraction** — autonomous security ecosystem |
| 16 | `evolution/bin/evolve-promote.sh` + `stable/global.md` + `config.yaml` | 97+14+24 | CORE | **Positioning** — the self-evolution layer is the repo's newest distinctive feature |
| 17 | `commands/plan.md` | 496 | CORE | **Operational** — the default planner, governs every complex task |
| 18 | `commands/ultraplan.md` | 576 | CORE | **Operational + Positioning** — enterprise-risk planner; 15-stage Sovereign pipeline |
| 19 | `docs/SURFACE-MAP.md` | 52 | CORE | **Operational** — disambiguates 5 overlapping planners / 3 design skills |
| 20 | `docs/COUNCIL-REMEDIATION.md` | 43 | CORE | **Positioning** — proof that criticism → deterministic fix, with verification |

---

## 5. Leverage-value map

Which zones of the repo carry which kind of value:

### Operational (used weekly by owner)
- `CLAUDE.md` + `rules/` (imports tree)
- `settings.json` + `hooks/*.sh` (18 live hook entries; ruff auto-fix, MCP gate, secrets block, force-push block, rm -rf block, audit log)
- `scripts/inventory.sh` + `validate.sh` + `analyze-usage.sh` (Makefile entrypoints)
- `commands/{plan, ship, audit-deep, fix-root, polish-ux, pr-prep, review, debug, test-gen, start-task, complete}` — the 11 canonical daily verbs
- Top-20 skills per CLAUDE.md (jarvis-core, governance-gate, operating-framework, coding-workflow, moyu, prompt-reliability-engine, n8n, etc.)
- `recipes/engineering/*.yaml` + `recipes/sub/*.yaml` + `recipes/lib/recipe-runner.sh` — parameterized workflows

### Demo
- `skills/hue/examples/*.html` (19 brand demos — the most concrete self-proof in the repo)
- `skills/timesfm-forecasting/examples/**` (forecast animations, covariates)
- `skills/market/*` (the 15-command marketing suite)
- `skills/skill-creator/eval-viewer/viewer.html` (eval-harness UI)
- `docs/DEMO.md` (reproducible `/audit-deep → /fix-root → /ship` script)
- `skills/n8n/czlonkowski/evaluations/*.json` (22 evaluation fixtures prove the n8n skill works)

### Positioning (makes the public repo distinctive)
- `README.md` + `docs/ELITE-OPS-README.md` + `docs/ELITE-OPS-METHODOLOGY.md`
- `docs/SURFACE-MAP.md` + `docs/OVERHEAD.md` + `docs/KB-STATUS.md` + `docs/COUNCIL-REMEDIATION.md` (the "honest audit" cluster — this is rare and sellable)
- `docs/TELEMETRY.md` + `hooks/usage-logger.sh` + `scripts/analyze-usage.sh` (measurement layer)
- `evolution/README.md` + `evolution/stable/global.md` + promotion gate (controlled-self-evolution narrative)
- `agents/REGISTRY.md` + `skills/jarvis-core/SKILL.md` + `skills/governance-gate/SKILL.md` (JARVIS-mirrored governance story)

### Extraction (could be pulled out as a standalone product)
| Candidate | What it is | Self-contained? |
|-----------|-----------|-----------------|
| Elite Ops layer | `skills/elite-ops/` + `docs/ELITE-OPS-*.md` + `commands/{ship,audit-deep,fix-root,polish-ux,council-review}.md` | Yes — ~12 files, one cohesive theme |
| Self-evolution layer | `evolution/` + `skills/{session-bootstrap,evidence-recorder,session-analyst,promotion-gate,pruning-view,skill-evolution}/` + `agents/{evolution-orchestrator,learning-curator,evaluation-judge}.md` + `commands/evolution.md` + 2 hooks | Yes — ~25 files, concept-complete |
| /market suite | `skills/market/` + 15 market-* skills + 5 market-* agents + `/market` commands (implicit via skill) | Yes — ~22 files + templates |
| JARVIS-sec | `skills/jarvis-sec/` + `commands/jarvis-sec.md` | Yes |
| Hue meta-skill | `skills/hue/` (SKILL.md + 19 example brands + references) | Yes — complete brand-generation toolkit |
| React-bits catalog | `skills/react-bits/` | Yes — standalone on DavidHDev's upstream |
| MCP-mastery catalog | `skills/mcp-mastery/` + `GAPS.md` | Yes |
| JARVIS-Core governance | `skills/{jarvis-core,governance-gate}/` + `agents/REGISTRY.md` | Yes |
| Anti-AI-slop filter | `skills/anti-ai-writing/` | Yes |
| n8n skill-set (czlonkowski) | `skills/n8n/` (94 files with LICENSE) | Yes — upstream-aligned |

---

## 6. Experimental zone callouts

### Self-evolution layer (`evolution/` + 5 skills + 3 agents + 2 hooks + /evolution)
- **Promising:** Explicit "observe → record → evaluate → promote" pipeline with hard evidence gates. Promotion script enforces `evidence ≥ 3`, distinct sessions ≥ 2, distinct projects ≥ 2, size budget, contradiction check. Kill switch (`/evolution disable` + `CLAUDE_EVOLUTION_BASELINE=1`). Schema + reports directory structured for provenance.
- **Unvalidated:** `records/sessions.jsonl` has 2 entries (out of expected dozens by now). `candidates/`, `rejected/`, `reports/` are empty. No candidate has ever been promoted. `stable/by-project/` holds only `.gitkeep`. Nothing proves the promotion gate has been exercised with real data.
- **What would change bucket:** Once there are 20+ session records, ≥3 candidate YAMLs, and one promoted learning with a verified regression check, move the layer from EXPERIMENTAL to SUPPORTING (and eventually CORE).

### KB (`kb/` — 10 files)
- **Promising:** Schema is clear, `/wiki-{ingest,query,lint}` commands are implemented, `docs/KB-STATUS.md` explicitly labels it scaffold with exit criteria (≥50 confidence-0.8 articles, weekly lint passing for 4 weeks, one decision materially faster).
- **Unvalidated:** 5 seed articles, `kb/raw/` and `kb/outputs/` empty, no cron scheduling for `/wiki-lint`, no real consumer beyond the owner.
- **What would change bucket:** meet the exit criteria in `docs/KB-STATUS.md`.

### Wave 1 stage agents (`agents/{10 domains}/{intel,gen,loop}/*.md` — 126 files)
- **Promising:** The 3-stage taxonomy (intelligence → generation → loop) mirrors proven JARVIS-FRESH patterns. Authority is declared (L6). Skills list is pre-populated.
- **Unvalidated:** Every file is ~13 lines — frontmatter + one description sentence. No orchestrator actually invokes them (the REGISTRY table enumerates the 66 core agents + department heads, not these 126). No commands depend on them. The capability is advertised, not built.
- **What would change bucket:** each stage agent gets ≥100 lines of working body + at least one invoking command/recipe OR registry citation. Otherwise, these are scaffolding and the honest move on next pruning pass is to consolidate per-domain into one agent per department with a stage field.

### Wave 2 surface agents (`agents/surfaces/{5 products}/{intel,gen,loop}/*.md` — 45 files)
- **Promising:** Surface-aware routing (different product lines trigger different target-market personas) is an interesting generalization.
- **Unvalidated:** The 5 surfaces (`command`, `forge`, `helios`, `nova`, `studio`) are not actual products in this repo or CLAUDE.md. Each of the 9 agent names is identical across surfaces; only `surface:`, `context:`, `target market` differ (17-line stubs). No consumer code references them.
- **What would change bucket:** the 5 surfaces each have a real product narrative in CLAUDE.md or a linked product doc, AND at least one command consumes the parameterized target-market metadata.

### MCP-gated skills (depend on aspirational MCPs not yet installed)
`aster-trading`, `aster-timesfm-pipeline`, `hermes-integration`, `sim-studio`, `aidesigner-frontend`, trading recipes. Labeled EXPERIMENTAL because they cannot execute their core flow until the MCP is connected. Promising once MCPs are added.

### Council-reports (not a directory in-repo, but referenced in COUNCIL-REMEDIATION.md)
The council reports live at `~/.claude/council-reports/` per `docs/COUNCIL-REMEDIATION.md`. **Not tracked in this repo.** Verified via `ls` — no such directory here. No EXPERIMENTAL callout needed for in-repo files.

### Autoresearch / self-improvement loop (`skills/autoresearch/` + `commands/autoresearch.md`)
- **Promising:** Iterates over a target, scores, keeps improvements. Good theoretical pattern.
- **Unvalidated:** Single template (aster-trading.md). No evidence of actual benchmarking runs.

---

## 7. ARCHIVAL candidates

Per brief: "zero files should be labeled ARCHIVAL unless genuinely superseded."

After walking every tracked file: **2 candidates**, both intentionally kept per system design rather than truly archival:

| Path | Reason | Verdict |
|------|--------|---------|
| `docs/OPERATING_FRAMEWORK.md` (255 lines) | Pre-dates `skills/operating-framework/SKILL.md` (447 lines). Both cover the same KhaledPowers methodology. The skill version is richer; the doc is the earlier inherited artifact. | **CANDIDATE_FOR_CONSOLIDATION**, not ARCHIVAL — still coherent, could be either merged or linked as a summary. Not superseded per se. |
| `docs/CAPABILITIES_REPORT.md` (1180 lines) | Huge standalone narrative of capabilities that pre-dates `docs/INVENTORY.md`. The generated inventory replaces the need for a hand-written capabilities doc. | **CANDIDATE_FOR_CONSOLIDATION**, not ARCHIVAL — contains narrative not present in INVENTORY (tool-by-tool rationale). Recommend rewriting as "why these" section linked from README, not deletion. |

**Confirmation: zero true ARCHIVAL files found in the tracked repo.** The `.gitignore` already prevents committed backups (`settings.local.json`, `projects/`, `audit.log`, `history.jsonl`, `usage.jsonl`, `.env`, `*.pem`, `*.key`, `__pycache__/`, `*.pyc`). The expected `CLAUDE.md.backup.*` files from typical `~/.claude/` setups are not in-repo, as intended.

The two items above are mis-filed as "legacy" rather than "superseded." They are honest CANDIDATE_FOR_CONSOLIDATION targets during the next audit iteration; they still pull weight as reference material and should not be deleted before the telemetry-pruning window closes.

---

## Appendix A — files counted but not individually listed

To keep the main tables reviewable, these clusters are aggregated above. Counts shown for completeness.

| Cluster | File count | Bucket distribution |
|---------|-----------:|---------------------|
| `skills/n8n/czlonkowski/evaluations/**/*.json` | 22 | 22 SUPPORTING (evaluation fixtures) |
| `skills/n8n/czlonkowski/docs/*.md` | ~15 | 15 SUPPORTING (vendor docs) |
| `skills/claude-api/{lang}/{api,agent-sdk}/*.md` | 28 | 6 CORE (shared/) + 22 SUPPORTING |
| `skills/ui-ux-pro-max/{scripts,data}/*` | 28 | 28 SUPPORTING (data-driven design catalog) |
| `skills/xlsx/scripts/office/schemas/**/*.xsd` | ~45 | 45 SUPPORTING (OOXML offline schemas) |
| `skills/pdf/scripts/*.py` + docs | 13 | 13 SUPPORTING (real working PDF toolkit) |
| `skills/timesfm-forecasting/examples/**` | 17 | 17 SUPPORTING (demo payload) |
| `skills/hue/examples/<brand>/*.html` | 19+ | 19 CORE (demo artifacts — highest leverage) |
| `skills/hue/references/*.md` | few | SUPPORTING |
| `skills/market/{scripts,templates}/*` | 10 | 10 SUPPORTING (marketing generators + templates) |
| `skills/skill-creator/{scripts,agents,eval-viewer}/*` | 12 | 12 SUPPORTING (eval harness) |
| `skills/understand/*-prompt.md` | 5 | 5 SUPPORTING (prompt library for understand skill) |
| Wave 1 stage agents | 126 | 126 EXPERIMENTAL |
| Wave 2 surface agents | 45 | 45 EXPERIMENTAL |
| `commands/sc/*.md` | 31 | 31 SUPPORTING (SuperClaude imports) |
| `commands/bmad/*.md` | 15 | 15 SUPPORTING (BMAD imports) |
| `skills/bmad/{bmm,bmb,cis,core}/**/SKILL.md` | 9 | 9 SUPPORTING (BMAD skill pairs) |
| `skills/{webapp-testing, algorithmic-art, web-artifacts-builder, pptx-generator, docx-generator, remotion-animation, video-ui-patterns}/**` | ~25 | 25 SUPPORTING |

Grand cluster totals line up with §1 summary counts (±5 from manual grouping boundaries).

## Appendix B — assumptions stated

1. Tiny (≤20 lines) agent stubs in Wave-1/Wave-2 directories are EXPERIMENTAL by default. If the repo author asserts they are wired to a dispatcher I missed, reclassify to SUPPORTING.
2. Demo output artifacts (HTML/JSON/GIF/PNG under `examples/output/`) are SUPPORTING unless they are the **defining proof** of the skill — then CORE (Hue's 19 brand demos meet that bar).
3. Aspirational MCP-dependent skills are EXPERIMENTAL until `claude mcp add` is run for the underlying server.
4. Reference docs inherited from March 15 (see mtimes — most pre-2026 docs are from that date) are SUPPORTING unless they duplicate a newer canonical file.
5. A skill that is the canonical entry per SURFACE-MAP is CORE. Non-canonical alternatives in the same intent group are CANDIDATE_FOR_CONSOLIDATION even if well-written.

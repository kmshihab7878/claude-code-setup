# Engineering — Domain Index

> Lazy-loaded index. Files are not moved; this doc points at their canonical locations so the operator can load only what the task needs.

## When to activate

Trigger keywords / intent patterns:

- *build, implement, ship, refactor, debug, test, deploy, design the system, architecture, API, database, migration, CI/CD, Docker, Kubernetes*
- File change patterns: `*.py`, `*.ts/tsx`, `*.js/jsx`, `Dockerfile`, `*.tf`, `docker-compose.yml`, `Makefile`, `.github/workflows/*`
- Domain classifier output: `engineering`, `infrastructure`, `security`, `quality`, `ai-ml`, `design` (all map here)

## Subdomains

Engineering is the broadest domain. It splits into six subdomains:

| Subdomain | Scope | See |
|-----------|-------|-----|
| [full-stack](./full-stack/SUBDOMAIN.md) | Backend + frontend + data | — |
| [devops](./devops/SUBDOMAIN.md) | CI/CD + Docker + K8s + Terraform + cloud | — |
| [security](./security/SUBDOMAIN.md) | Appsec + infra-sec + offensive + compliance | — |
| [quality](./quality/SUBDOMAIN.md) | Testing + code review + property-based + a11y | — |
| [ai-ml](./ai-ml/SUBDOMAIN.md) | LLM integration + RAG + MCP + agent orchestration | — |
| [design](./design/SUBDOMAIN.md) | Frontend design + UI + brand + animation | — |

The SUBDOMAIN.md files are secondary indexes; they exist so a deep-dive into one subdomain doesn't load sibling surfaces.

## Commands (canonical per `docs/SURFACE-MAP.md`)

| Intent | Canonical command | Alternatives |
|--------|-------------------|--------------|
| Full feature | `/ship` | `/start-task`, `/sc:implement` |
| Plan | `/plan` | `/ultraplan` (enterprise-risk), `/planUI` (UI-only), `/spec` |
| Fix bug | `/fix-root` | `/debug` |
| Code review | `/review` | `/sc:analyze` |
| Full audit | `/audit-deep` | `/repo-review`, `/sc:analyze`, `/setup-audit` |
| Security audit | `/security-audit` | — |
| Test generation | `/test-gen` | — |
| UX polish | `/polish-ux` | `impeccable-polish` skill |
| UI from scratch | (skill) `impeccable-design` | `frontend-design`, `interface-design`, `ui-ux-pro-max` (pending telemetry review) |
| UI audit | (skill) `impeccable-audit` | `baseline-ui`, `interface-design-audit` (pending telemetry) |
| PR prep | `/pr-prep` | — |

## Relevant agents (L0–L6)

**Orchestrators:** `system-architect` (L1), `architect` (L1), `pm-agent` (L0).

**Department heads (L2):** `backend-architect`, `frontend-architect`, `devops-architect`, `security-engineer`, `quality-engineer`, `ai-engineer`, `performance-engineer`.

**Specialists (L3):** `python-expert`, `docker-specialist`, `ci-cd-engineer`, `db-admin`, `infra-engineer`, `mobile-app-builder`, `api-designer`, `security-auditor`, `secrets-manager`, `compliance-officer`, `monorepo-manager`, `migration-specialist`, `prompt-engineer`, `observability-engineer`, `ux-designer`.

**Managers (L4):** `release-engineer`, `incident-responder`, `project-shipper`.

**Leaders (L5):** `performance-optimizer`, `cost-optimizer`, `refactoring-expert`, `root-cause-analyst`.

**Workers (L6):** `tester`, `debugger`, `refactorer`, `documenter`, `code-reviewer`, `technical-writer`, `api-tester`, `test-results-analyzer`.

**Wave 1 (stage-based, experimental):** `agents/engineering/{intel,gen,loop}/*.md`, `agents/infrastructure/**`, `agents/operations/**`, `agents/quality/**`, `agents/security/**`, `agents/documentation/**`, `agents/research/**` — 86 agents. Dispatched via dept-head expansion only (see `agents/REGISTRY.md`). Label: EXPERIMENTAL until telemetry validates invocation rate.

## Skill index (canonical engineering skills)

| Skill | Subdomain | Status | Notes |
|-------|-----------|--------|-------|
| `jarvis-core` | core/process | CORE | 10-stage pipeline |
| `governance-gate` | core/process | CORE | 5-layer safety gate |
| `operating-framework` | core/process | CORE | KhaledPowers framework |
| `elite-ops` | core/process | CORE | Owner-engineer execution posture |
| `moyu` | core/process | CORE | Anti-over-engineering guardrail |
| `coding-workflow` | full-stack | CORE | Pre-impl checklist + incremental workflow |
| `test-driven-development` | quality | CORE | RED-GREEN-REFACTOR |
| `testing-methodology` | quality | CORE | Test strategy |
| `git-workflows` | full-stack | CORE | Commit/branch/PR patterns |
| `api-design-patterns` | full-stack | CORE | REST + GraphQL |
| `python-quality-gate` | full-stack | CORE | Ruff + pyright + vulture |
| `security-review` | security | CORE | OWASP checklist + secrets |
| `clean-architecture-python` | full-stack | SUPPORTING | Hexagonal / DDD / ports |
| `database-patterns` | full-stack | SUPPORTING | Schema + migrations + indexing |
| `devops-patterns` | devops | SUPPORTING | Terraform + K8s + Docker |
| `github-actions-patterns` | devops | SUPPORTING | CI/CD |
| `local-dev-orchestration` | devops | SUPPORTING | Docker Compose + Tilt + mise |
| `container-security` | security/devops | SUPPORTING | Image hardening + K8s security context |
| `infrastructure-scanning` | security | SUPPORTING | Trivy + Checkov + Semgrep |
| `offensive-security` | security | SUPPORTING | Pentesting methodology |
| `osint-recon` | security | SUPPORTING | OSINT workflows |
| `gdpr-dsgvo-expert` | security/compliance | SUPPORTING | Privacy automation |
| `jarvis-sec` | security | CORE | Autonomous security ecosystem |
| `property-based-testing` | quality | SUPPORTING | Hypothesis strategies |
| `api-testing-suite` | quality | SUPPORTING | Bruno + Schemathesis |
| `webapp-testing` | quality | SUPPORTING | Playwright toolkit |
| `expect-testing` | quality | SUPPORTING | Adversarial browser tests |
| `test-gap-analyzer` | quality | SUPPORTING | Coverage gap detection |
| `structured-logging` | full-stack/devops | SUPPORTING | loguru / structlog |
| `production-monitoring` | devops | SUPPORTING | Grafana / Prometheus / Loki / OTel |
| `release-automation` | devops | SUPPORTING | Release Please + semver |
| `cost-optimization` | devops | SUPPORTING | Infracost + ccusage |
| `claude-api` | ai-ml | CORE | Anthropic SDK patterns |
| `multi-agent-patterns` | ai-ml | CORE | Supervisor/pipeline/swarm |
| `rag-patterns` | ai-ml | CORE | RAG architecture + optimization |
| `hybrid-search-implementation` | ai-ml | SUPPORTING | Vector + keyword retrieval |
| `mlops-engineer` | ai-ml | SUPPORTING | MLflow + Kubeflow |
| `mcp-mastery` | ai-ml | CORE | 30-server catalog + router |
| `mcp-builder` | ai-ml | CORE | MCP server development guide |
| `prompt-reliability-engine` | ai-ml | CORE | 9-mode reliability framework |
| `context-budget-audit` | ai-ml | SUPPORTING | Token-cost measurement |
| `ultrathink` | ai-ml/meta | CORE | Cognitive depth engine |
| `council` | ai-ml/meta | CORE | Multi-expert decision system |
| `agent-evaluation` | ai-ml | SUPPORTING | Eval harness for agents |
| `agent-orchestrator` | ai-ml | EXPERIMENTAL | Durable orchestration |
| `domain-driven-design` | full-stack | SUPPORTING | DDD planning |
| `data-analysis` | data/ai-ml | CORE | Natural language → SQL/pandas |
| `supabase-postgres-best-practices` | full-stack | SUPPORTING | Postgres perf |
| `responsive-design` | design | SUPPORTING | Mobile-first patterns |
| `framer-motion-patterns` | design | SUPPORTING | React animation |
| `web-artifacts-builder` | design | SUPPORTING | claude.ai HTML artifacts |
| `algorithmic-art` | design | SUPPORTING | p5.js seeded art |
| `impeccable-design` | design | CORE | Distinctive production UI (canonical) |
| `impeccable-audit` | design | CORE | UI audit (canonical) |
| `impeccable-polish` | design | CORE | Visual polish (canonical) |
| `hue` | design | CORE | Brand → design-language meta-skill |
| `react-bits` | design | CORE | 130-component catalog |
| `fixing-accessibility` | design | SUPPORTING | ARIA + keyboard + WCAG |
| `fixing-motion-performance` | design | SUPPORTING | Animation perf |
| `fixing-metadata` | design | SUPPORTING | SEO / OG / canonical tags |

Full skill count: ~120 engineering-adjacent. Full list on disk under `skills/`.

## Domain rules

1. **Python path rule** (`rules/python.md`) applies to any `*.py` write.
2. **TypeScript path rule** (`rules/typescript.md`) applies to any `*.ts`/`*.tsx` write.
3. **Testing path rule** (`rules/testing.md`) applies to any test file write.
4. **Infrastructure path rule** (`rules/infrastructure.md`) applies to Terraform / Helm / K8s manifests.
5. **Security path rule** (`rules/security.md`) applies to anything touching auth, secrets, or request-path code.
6. **Implementation rule** (`rules/implementation.md`) applies universally — file-change contract, prohibited patterns, required patterns.

## Recipes

| Recipe | Engine | Notes |
|--------|--------|-------|
| `recipes/engineering/api-endpoint.yaml` | `api-designer → backend-architect` | Full endpoint scaffold |
| `recipes/engineering/code-review.yaml` | `code-reviewer → python-expert` | Review with security-review + python-quality-gate |
| `recipes/engineering/debug-investigation.yaml` | `debugger → root-cause-analyst` | Investigation protocol |
| `recipes/engineering/refactor.yaml` | `refactorer → refactoring-expert` | Refactor with coding-workflow + python-quality-gate |
| `recipes/engineering/test-suite.yaml` | `tester → quality-engineer` | TDD + testing-methodology |
| `recipes/devops/deploy-check.yaml` | `devops-architect → ci-cd-engineer` | Deploy gate |
| `recipes/security/security-audit.yaml` | `security-engineer → security-auditor` | Full audit |
| `recipes/security/secrets-scan.yaml` | `security-auditor → code-reviewer` | Gitleaks + Trivy |
| `recipes/sub/lint-check.yaml` | — | Reusable lint primitive |
| `recipes/sub/test-run.yaml` | — | Reusable test primitive |
| `recipes/sub/dep-audit.yaml` | — | Reusable dep audit primitive |

## Notes

- **Extraction candidates in this domain:** Elite Ops layer, JARVIS-Core governance, JARVIS-sec, MCP-mastery, React-bits, Hue. See `docs/EXTRACTABLE-PRODUCTS.md` (forthcoming Phase 2).
- **Experimental zones:** Wave 1 stage agents (`agents/{dept}/{intel,gen,loop}/*.md`) — 86 engineering-adjacent files, ~13 lines each. Keep for extraction narrative; telemetry will decide pruning.
- **Aspirational MCP-gated skills:** `hermes-integration`, `sim-studio`, `aidesigner-frontend`, `paperclip*` — require Tier-3 MCPs not currently installed. Skills remain indexed but unexecutable until MCPs land.
- **Design-surface overlap:** 11 design-related skills fire on "build UI" trigger. Canonical is `impeccable-design`; see `docs/SURFACE-MAP.md` for disambiguation. Consolidation opportunities in AUDIT §5.2.

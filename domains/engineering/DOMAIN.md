# Engineering — Domain Index

> Lazy-loaded index. Files are not moved; this doc points at their canonical locations so the operator can load only what the task needs.

## When to activate

- Triggers: *build, implement, ship, refactor, debug, test, deploy, design the system, architecture, API, database, migration, CI/CD, Docker, Kubernetes*.
- File patterns: `*.py`, `*.ts/tsx`, `*.js/jsx`, `Dockerfile`, `*.tf`, `docker-compose.yml`, `Makefile`, `.github/workflows/*`.
- Domain classifier: `engineering`, `infrastructure`, `security`, `quality`, `ai-ml`, `design` (all map here).

## Subdomains

| Subdomain | Scope |
|-----------|-------|
| [full-stack](./full-stack/SUBDOMAIN.md) | Backend + frontend + data |
| [devops](./devops/SUBDOMAIN.md) | CI/CD + Docker + K8s + Terraform + cloud |
| [security](./security/SUBDOMAIN.md) | Appsec + infra-sec + offensive + compliance |
| [quality](./quality/SUBDOMAIN.md) | Testing + code review + property-based + a11y |
| [ai-ml](./ai-ml/SUBDOMAIN.md) | LLM integration + RAG + MCP + agent orchestration |
| [design](./design/SUBDOMAIN.md) | Frontend design + UI + brand + animation |

SUBDOMAIN.md files are secondary indexes — a deep-dive into one subdomain doesn't load siblings.

## Commands (canonical per `docs/SURFACE-MAP.md`)

| Intent | Canonical | Alternatives |
|--------|-----------|--------------|
| Full feature | `/ship` | `/start-task`, `/sc:implement` |
| Plan | `/plan` | `/ultraplan` (enterprise-risk), `/planUI` (UI-only), `/spec` |
| Fix bug | `/fix-root` | `/debug` |
| Code review | `/review` | `/sc:analyze` |
| Full audit | `/audit-deep` | `/repo-review`, `/sc:analyze`, `/setup-audit` |
| Security audit | `/security-audit` | — |
| Test generation | `/test-gen` | — |
| UX polish | `/polish-ux` | `impeccable-polish` skill |
| UI from scratch | (skill) `impeccable-design` | `frontend-design`, `interface-design`, `ui-ux-pro-max` (pending telemetry) |
| UI audit | (skill) `impeccable-audit` | `baseline-ui`, `interface-design-audit` (pending telemetry) |
| PR prep | `/pr-prep` | — |

## Relevant agents (L0–L6)

- **Orchestrators:** `system-architect` (L1), `architect` (L1), `pm-agent` (L0).
- **Dept heads (L2):** `backend-architect`, `frontend-architect`, `devops-architect`, `security-engineer`, `quality-engineer`, `ai-engineer`, `performance-engineer`.
- **Specialists (L3):** `python-expert`, `docker-specialist`, `ci-cd-engineer`, `db-admin`, `infra-engineer`, `mobile-app-builder`, `api-designer`, `security-auditor`, `secrets-manager`, `compliance-officer`, `monorepo-manager`, `migration-specialist`, `prompt-engineer`, `observability-engineer`, `ux-designer`.
- **Managers (L4):** `release-engineer`, `incident-responder`, `project-shipper`.
- **Leaders (L5):** `performance-optimizer`, `cost-optimizer`, `refactoring-expert`, `root-cause-analyst`.
- **Workers (L6):** `tester`, `debugger`, `refactorer`, `documenter`, `code-reviewer`, `technical-writer`, `api-tester`, `test-results-analyzer`.
- **Wave 1 (EXPERIMENTAL):** `agents/engineering/{intel,gen,loop}/*.md` + sibling departments (`infrastructure`, `operations`, `quality`, `security`, `documentation`, `research`) — 86 agents. Dispatched via dept-head expansion only (see `agents/REGISTRY.md`). Keep until telemetry validates invocation rate.

## Skill index (canonical engineering skills)

Status legend: **C** = CORE, **S** = SUPPORTING, **X** = EXPERIMENTAL.

### Core / process
`coremind-core` (C, 10-stage pipeline) · `governance-gate` (C, 5-layer safety gate) · `operating-framework` (C) · `elite-ops` (C, owner-engineer posture) · `moyu` (C, anti-over-engineering guardrail).

### Full-stack
`coding-workflow` (C, pre-impl checklist + incremental) · `git-workflows` (C, commit/branch/PR) · `api-design-patterns` (C, REST + GraphQL) · `python-quality-gate` (C, Ruff + pyright + vulture) · `clean-architecture-python` (S, hexagonal / DDD / ports) · `database-patterns` (S, schema + migrations + indexing) · `domain-driven-design` (S) · `structured-logging` (S, also devops) · `supabase-postgres-best-practices` (S, Postgres perf).

### Quality
`test-driven-development` (C, RED-GREEN-REFACTOR) · `testing-methodology` (C, test strategy) · `property-based-testing` (S, Hypothesis) · `api-testing-suite` (S, Bruno + Schemathesis) · `webapp-testing` (S, Playwright toolkit) · `expect-testing` (S, adversarial browser tests) · `test-gap-analyzer` (S, coverage gaps).

### DevOps
`devops-patterns` (S, Terraform + K8s + Docker) · `github-actions-patterns` (S, CI/CD) · `local-dev-orchestration` (S, Docker Compose + Tilt + mise) · `production-monitoring` (S, Grafana / Prometheus / Loki / OTel) · `release-automation` (S, Release Please + semver) · `cost-optimization` (S, Infracost + ccusage).

### Security
`security-review` (C, OWASP + secrets) · `coremind-sec` (C, autonomous security ecosystem) · `container-security` (S, image hardening + K8s security context; also devops) · `infrastructure-scanning` (S, Trivy + Checkov + Semgrep) · `offensive-security` (S, pentesting methodology) · `osint-recon` (S, OSINT workflows) · `gdpr-dsgvo-expert` (S, privacy automation; also compliance).

### AI/ML
`claude-api` (C, Anthropic SDK) · `multi-agent-patterns` (C, supervisor/pipeline/swarm) · `rag-patterns` (C, RAG architecture + optimization) · `mcp-mastery` (C, 30-server catalog + router) · `mcp-builder` (C, MCP server development guide) · `prompt-reliability-engine` (C, 9-mode framework) · `ultrathink` (C, cognitive depth; also meta) · `council` (C, multi-expert decision system; also meta) · `data-analysis` (C, NL → SQL/pandas; also data) · `hybrid-search-implementation` (S, vector + keyword) · `mlops-engineer` (S, MLflow + Kubeflow) · `context-budget-audit` (S, token-cost measurement) · `agent-evaluation` (S, eval harness) · `agent-orchestrator` (X, durable orchestration).

### Design
`impeccable-design` (C, distinctive production UI — canonical) · `impeccable-audit` (C, UI audit — canonical) · `impeccable-polish` (C, visual polish — canonical) · `hue` (C, brand → design-language meta-skill) · `react-bits` (C, 130-component catalog) · `responsive-design` (S, mobile-first) · `framer-motion-patterns` (S, React animation) · `web-artifacts-builder` (S, claude.ai HTML artifacts) · `algorithmic-art` (S, p5.js seeded art) · `fixing-accessibility` (S, ARIA + keyboard + WCAG) · `fixing-motion-performance` (S, animation perf) · `fixing-metadata` (S, SEO / OG / canonical tags).

Full skill count: ~120 engineering-adjacent. Canonical bodies on disk under `skills/`.

## Domain rules

1. **Python** (`rules/python.md`) — applies to any `*.py` write.
2. **TypeScript** (`rules/typescript.md`) — applies to any `*.ts` / `*.tsx` write.
3. **Testing** (`rules/testing.md`) — applies to any test file write.
4. **Infrastructure** (`rules/infrastructure.md`) — applies to Terraform / Helm / K8s manifests.
5. **Security** (`rules/security.md`) — applies to anything touching auth, secrets, or request-path code.
6. **Implementation** (`rules/implementation.md`) — applies universally (file-change contract, prohibited patterns, required patterns).

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

- **Extraction candidates in this domain:** Elite Ops layer, CoreMind-Core governance, CoreMind-sec, MCP-mastery, React-bits, Hue. See `docs/EXTRACTABLE-PRODUCTS.md` (forthcoming Phase 2).
- **Experimental zones:** Wave 1 stage agents (`agents/{dept}/{intel,gen,loop}/*.md`) — 86 engineering-adjacent files, ~13 lines each. Keep for extraction narrative; telemetry will decide pruning.
- **Aspirational MCP-gated skills:** `hermes-integration`, `sim-studio`, `aidesigner-frontend`, `paperclip*` — require Tier-3 MCPs not currently installed. Skills remain indexed but unexecutable until MCPs land.
- **Design-surface overlap:** 11 design-related skills fire on "build UI" trigger. Canonical is `impeccable-design`; see `docs/SURFACE-MAP.md` for disambiguation. Consolidation opportunities in AUDIT §5.2.

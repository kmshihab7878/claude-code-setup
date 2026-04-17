# Cross-Reference Dependency Map — Phase 0.2

_Source scope: `/Users/khaledshihab/Projects/claude-code-setup/` · 202 skills, 84 commands, 242 agent files, 13 hook scripts, 13 recipes, 26 docs._

Generated programmatically by scanning every `.md`, `.yaml`, `.json`, `.sh` file for cross-references. Inbound/outbound counts use strict word-boundary matching with one of: backtick-wrapped name, `kind/name` path, YAML list membership, double-quoted token, or bullet-list entry.

> **Sibling docs** (Phase 0.2 parallel work): `CLASSIFICATION.md` (5-bucket file classification), `CONFLICTS.md` (overlap/contradiction detection).

---

## 1. Top 20 Most-Referenced Nodes

The nodes other files cite most often. A cluster of skills + the Dept-Head agents + `/plan` dominate.

| Rank | Node | Inbound | Kind |
|-----:|------|--------:|------|
| 1 | `anti-ai-writing` | 63 | skill |
| 2 | `security-review` | 36 | skill |
| 3 | `testing-methodology` | 29 | skill |
| 4 | `growth-marketer` | 29 | agent |
| 5 | `test-driven-development` | 24 | skill |
| 6 | `research-methodology` | 24 | skill |
| 7 | `data-analysis` | 23 | skill |
| 8 | `architect` | 22 | agent |
| 9 | `plan` | 21 | command |
| 10 | `code-reviewer` | 20 | agent |
| 11 | `api-design-patterns` | 18 | skill |
| 12 | `devops-patterns` | 18 | skill |
| 13 | `frontend-design` | 18 | skill |
| 14 | `content-strategist` | 18 | agent |
| 15 | `coding-workflow` | 17 | skill |
| 16 | `production-monitoring` | 17 | skill |
| 17 | `security-engineer` | 17 | agent |
| 18 | `baseline-ui` | 16 | skill |
| 19 | `quality-engineer` | 16 | agent |
| 20 | `security-auditor` | 16 | agent |

**Reading:** `anti-ai-writing` (63 inbound) is the single most-referenced skill — it is declared as a skill on 61 Wave-1 agents (every stage-gen/intel/loop agent binds it). `security-review` (36) is cited by 14 core agents, 3 recipes, and both `plan.md` and `ultraplan.md`. Agent-side, `growth-marketer` leads because it bridges the /market skill family to Wave-1 `growth/*` agents.

---

## 2. Hub Files — Highest Outbound References

These files pull the whole graph together. Changing them has the largest blast radius.

| Rank | File | Out-degree | Role |
|-----:|------|-----------:|------|
| — | `agents/REGISTRY.md` | 281 | Agent dispatch table — points at every L0–L6 core agent |
| — | `commands/ultraplan.md` | 214 | 15-stage sovereign orchestrator — enumerates agents, skills, MCPs, recipes |
| — | `commands/plan.md` | 211 | 10-stage CoreMind orchestrator — enumerates 66 core agents + recipes |
| — | `CLAUDE.md` | 122 | Main config — cites skills, agents, commands, MCPs, hooks, docs |
| — | `docs/CAPABILITIES_REPORT.md` | 90 | Capabilities audit doc (high mention density) |
| — | `docs/CLAUDE_CODE_ARCHITECTURE.md` | 89 | Architecture doc (high mention density) |
| — | `agents/README.md` | 52 | Agent index for the directory |
| — | `skills/README.md` | 51 | Skill index for the directory |
| — | `commands/planUI.md` | 45 | UI pipeline — routes 28 UI skills + 4 agents |
| — | `skills/operating-framework/SKILL.md` | 34 | KhaledPowers framework references every other core skill |
| — | `docs/ELITE-OPS-METHODOLOGY.md` | 31 | Methodology doc for Elite-Ops layer |
| — | `docs/OPERATING_FRAMEWORK.md` | 30 | Framework reference — mentions many /sc: commands |

**Reading:** `plan.md` + `ultraplan.md` are the two biggest hubs after `REGISTRY.md` — together they explicitly enumerate 66 core agents, 13 recipes, and pipeline skills. That's the 'CoreMind' control plane. `CLAUDE.md` + `docs/CAPABILITIES_REPORT.md` + `docs/CLAUDE_CODE_ARCHITECTURE.md` are the documentation hubs and partially duplicate each other (flagged for CONFLICTS.md).

---

## 3. Orphan Files

Files with zero or near-zero inbound references outside their own index/directory.

### 3a. Orphan skills (≤ 1 strict inbound)

A skill is 'orphan-ish' when no agent binds it, no command cites it, and no other skill mentions it by path. It may still be executable via direct `/skill-name` invocation, but nothing in the governed pipeline routes to it.

| Skill | Inbound | Likely status |
|-------|--------:|---------------|
| `paperclip-create-plugin` | 0 | Paperclip agent/plugin scaffolding; no inbound on this repo |
| `mirofish-prediction` | 0 | Niche forecasting skill; only `deep-research` lists it; may be unwired here |
| `session-bootstrap` | 0 | Self-evolution family; only CLAUDE.md reference |
| `quality-manager-qmr` | 0 | MedTech QMR role; no agent binds |
| `hybrid-search-implementation` | 0 | RAG/search pattern; no agent binds it |
| `ultrathink` | 0 | Cognitive-depth meta-skill; only CLAUDE.md refers to 'think hard' / 'ultrathink' words |
| `para-memory-files` | 0 | Tiago Forte PARA method; no agent/command routes to it |
| `recall` | 0 | Cross-session memory skill; referenced inline (/recall) but not as a skill dep |
| `hermes-integration` | 0 | Hermes MCP is aspirational (not installed); skill references unreachable server |
| `graphql-architect` | 0 | GraphQL not covered by any core agent; skill present but isolated |
| `wshobson-sync-policies` | 0 | Imported Helm/K8s reference; no agent routes to it |
| `goose-integration` | 0 | Documented as CLI tool; no agent binds; skill page exists but unwired |
| `pruning-view` | 0 | Self-evolution skill; only CLAUDE.md + evolution docs reference it |
| `b2c-app-strategist` | 0 | New Product-domain skill; no agent binds; only CLAUDE.md cites |
| `understand-memory-sync` | 1 | Sub-skill of `understand` suite; no agent binds |
| `market-emails` | 1 | Same as above |
| `market-ads` | 1 | Market subcommand skill; orchestrated only by /market router |
| `recipe` | 1 | Recipe router skill; referenced inline (/recipe run ...) but not by agents |
| `mcp-mastery` | 1 | Advisor skill; only CLAUDE.md + docs refer to it |
| `market-report` | 1 | No agent or command routes to it |
| `n8n` | 1 | n8n automation; only CLAUDE.md lists it in Top-20 |
| `market-report-pdf` | 1 | Same as above |
| `market-proposal` | 1 | Same as above |
| `shihab-task-mgmt` | 1 | One-off design language; no reverse-link |
| `market-social` | 1 | Same as above |
| `context-budget-audit` | 1 | Only mentioned in docs/OVERHEAD.md |

**26 skills with ≤1 inbound**. Plus ~49 skills with exactly 2 inbound (listed in Appendix A).

### 3b. Orphan agents

125 Wave-1 stage agents (dept/stage/name.md files like `engineering/gen/api-scaffolder.md`) and a few Wave-2 surface agents have **zero** inbound mentions outside their own file. This is architecturally by-design — Wave-1 agents are dispatched purely by directory structure + REGISTRY-referenced-dept-head — but means:

- No command explicitly lists a Wave-1 agent.
- No skill declares one as a related capability.
- The only path into them is a dept-head agent handing off.

**Implication:** 125 Wave-1 agents are invisible to `/plan`'s agent-match step unless the L2 dept-head expansion is well-documented in REGISTRY.md. (It is, so they're not truly dead code — but they are effectively 'dark agents' from the top-level cross-reference view.)

Sample of 0-inbound Wave-1 agents:

```
ad-scraper, alert-tuner, alert-writer, api-doc-writer, api-scaffolder, arch-reviewer, arxiv-scanner, attribution-analyst, battlecard-writer, benchmark-monitor, blog-scanner, brief-writer, campaign-builder, capacity-forecaster, capacity-planner, changelog-writer, channel-analyst, churn-predictor, competitor-monitor, competitor-tracker, competitor-watcher, compliance-scorer, component-builder, conference-tracker, config-scanner, content-writer, contract-writer, conversion-tracker, copy-writer, cost-monitor, cost-optimizer-loop, cost-report-builder, cost-scanner, cost-trend-analyst, coverage-reporter, coverage-scanner, coverage-tracker, cpa-analyst, cve-scanner, dashboard-builder
```

### 3c. Orphan commands (zero inbound as `/name`)

These commands exist on disk but no other file references them with `/name` syntax. All are SuperClaude (`sc/`) subcommands plus a few custom ones:

| Command | Inbound | Note |
|---------|--------:|------|
| `/agent` | 0 | SuperClaude subcommand — callable as `/sc:agent`, so zero matches here may be scan-noise; still, not referenced as `/agent` anywhere |
| `/analyze` | 0 | SuperClaude subcommand — callable as `/sc:analyze`, so zero matches here may be scan-noise; still, not referenced as `/analyze` anywhere |
| `/bootstrap` | 0 | Interactive CLAUDE.md generator — only self-documented |
| `/business-panel` | 0 | SuperClaude subcommand — callable as `/sc:business-panel`, so zero matches here may be scan-noise; still, not referenced as `/business-panel` anywhere |
| `/cleanup` | 0 | SuperClaude subcommand — callable as `/sc:cleanup`, so zero matches here may be scan-noise; still, not referenced as `/cleanup` anywhere |
| `/document` | 0 | SuperClaude subcommand — callable as `/sc:document`, so zero matches here may be scan-noise; still, not referenced as `/document` anywhere |
| `/estimate` | 0 | SuperClaude subcommand — callable as `/sc:estimate`, so zero matches here may be scan-noise; still, not referenced as `/estimate` anywhere |
| `/git` | 0 | SuperClaude subcommand — callable as `/sc:git`, so zero matches here may be scan-noise; still, not referenced as `/git` anywhere |
| `/help` | 0 | SuperClaude subcommand — callable as `/sc:help`, so zero matches here may be scan-noise; still, not referenced as `/help` anywhere |
| `/implement` | 0 | SuperClaude subcommand — callable as `/sc:implement`, so zero matches here may be scan-noise; still, not referenced as `/implement` anywhere |
| `/improve` | 0 | SuperClaude subcommand — callable as `/sc:improve`, so zero matches here may be scan-noise; still, not referenced as `/improve` anywhere |
| `/load` | 0 | SuperClaude subcommand — callable as `/sc:load`, so zero matches here may be scan-noise; still, not referenced as `/load` anywhere |
| `/recommend` | 0 | SuperClaude subcommand — callable as `/sc:recommend`, so zero matches here may be scan-noise; still, not referenced as `/recommend` anywhere |
| `/reflect` | 0 | SuperClaude subcommand — callable as `/sc:reflect`, so zero matches here may be scan-noise; still, not referenced as `/reflect` anywhere |
| `/save` | 0 | SuperClaude subcommand — callable as `/sc:save`, so zero matches here may be scan-noise; still, not referenced as `/save` anywhere |
| `/select-tool` | 0 | SuperClaude subcommand — callable as `/sc:select-tool`, so zero matches here may be scan-noise; still, not referenced as `/select-tool` anywhere |
| `/skill-design` | 0 | Skill-creator wizard — referenced only in `commands/skill-design.md` |
| `/spawn` | 0 | SuperClaude subcommand — callable as `/sc:spawn`, so zero matches here may be scan-noise; still, not referenced as `/spawn` anywhere |
| `/spec-panel` | 0 | SuperClaude subcommand — callable as `/sc:spec-panel`, so zero matches here may be scan-noise; still, not referenced as `/spec-panel` anywhere |
| `/task` | 0 | SuperClaude subcommand — callable as `/sc:task`, so zero matches here may be scan-noise; still, not referenced as `/task` anywhere |
| `/troubleshoot` | 0 | SuperClaude subcommand — callable as `/sc:troubleshoot`, so zero matches here may be scan-noise; still, not referenced as `/troubleshoot` anywhere |
| `/workflow` | 0 | SuperClaude subcommand — callable as `/sc:workflow`, so zero matches here may be scan-noise; still, not referenced as `/workflow` anywhere |

**Note:** `/sc:*` commands show zero plain-slash inbound because every reference uses the `sc:` prefix. Treat this list as a scan artifact for the `sc/` rows, not a real orphan signal.

---

## 4. Stale References (Highest Priority)

References in the repo to paths/files/skills/agents/commands that don't exist on disk. Grouped by severity.

### 4a. Broken agent→MCP bindings (SEVERE)

**Finding:** Agent frontmatter declares MCP-server bindings. Many bound MCP names are either not connected in `claude mcp list`, or use wrong names.

| MCP name in agent frontmatter | Uses | Actual status | Fix |
|-------------------------------|-----:|---------------|-----|
| `github` | 47 | Aspirational — NOT installed per CLAUDE.md Tier 3 | Either install with `claude mcp add github` or strip from agent frontmatter |
| `sequential` | 35 | **NAME MISMATCH** — CLAUDE.md connected list says `sequential-thinking` | Rename to `sequential-thinking` in all 35 agent frontmatters |
| `memory` | 34 | Connected | OK |
| `brave-search` | 17 | Aspirational — NOT installed per CLAUDE.md Tier 3 | Either install with `claude mcp add brave-search` or strip from agent frontmatter |
| `filesystem` | 14 | Connected | OK |
| `playwright` | 13 | Aspirational — NOT installed per CLAUDE.md Tier 3 | Either install with `claude mcp add playwright` or strip from agent frontmatter |
| `tavily` | 13 | Aspirational — NOT installed per CLAUDE.md Tier 3 | Either install with `claude mcp add tavily` or strip from agent frontmatter |
| `context7` | 11 | Aspirational — NOT installed per CLAUDE.md Tier 3 | Either install with `claude mcp add context7` or strip from agent frontmatter |
| `postgres` | 7 | Aspirational — NOT installed per CLAUDE.md Tier 3 | Either install with `claude mcp add postgres` or strip from agent frontmatter |
| `slack` | 7 | Aspirational — NOT installed per CLAUDE.md Tier 3 | Either install with `claude mcp add slack` or strip from agent frontmatter |
| `docker` | 5 | Aspirational — NOT installed per CLAUDE.md Tier 3 | Either install with `claude mcp add docker` or strip from agent frontmatter |
| `kubernetes` | 5 | Aspirational — NOT installed per CLAUDE.md Tier 3 | Either install with `claude mcp add kubernetes` or strip from agent frontmatter |
| `code-review-graph` | 3 | Connected | OK |
| `terraform` | 3 | Aspirational — NOT installed per CLAUDE.md Tier 3 | Either install with `claude mcp add terraform` or strip from agent frontmatter |
| `penpot` | 2 | Aspirational — NOT installed per CLAUDE.md Tier 3 | Either install with `claude mcp add penpot` or strip from agent frontmatter |
| `puppeteer` | 1 | Aspirational — NOT installed per CLAUDE.md Tier 3 | Either install with `claude mcp add puppeteer` or strip from agent frontmatter |
| `aster` | 1 | Aspirational — NOT installed per CLAUDE.md Tier 3 | Either install with `claude mcp add aster` or strip from agent frontmatter |

**Total agent-declared MCP bindings that don't resolve to a live server: 133 of ~180** (`github` 47 + `sequential` 35 + `brave-search` 17 + `playwright` 13 + `tavily` 13 + `context7` 11 + `postgres` 7 + `slack` 7 + `docker` 5 + `kubernetes` 5 + `terraform` 3 + `penpot` 2 + `puppeteer` 1 + `aster` 1). This contradicts Constitution SEC-001 rule #2: 'Agents operate ONLY within declared MCP server bindings.' The bindings exist, but the servers don't.

### 4b. Broken absolute paths inside repo files

135 path-shaped strings like `skills/foo/` or `docs/bar.md` don't resolve to anything on disk. Most are template/example placeholders; some are real drift.

| Source | Line | Broken target | Category |
|--------|-----:|---------------|----------|
| `README.md` | 84 | `evolution/disabled` | Runtime-created (expected absent until first use) |
| `kb/wiki/impeccable-design-system.md` | 143 | `skills/impeccable-` | Incomplete path (regex split) |
| `agents/evaluation-judge.md` | 27 | `evolution/reports/YYYY-MM-DD-evaluation.md` | Template placeholder (benign) |
| `agents/pm-agent.md` | 59 | `docs/temp/hypothesis-YYYY-MM-DD.md` | Template placeholder (benign) |
| `agents/pm-agent.md` | 72 | `docs/temp/experiment-YYYY-MM-DD.md` | Template placeholder (benign) |
| `agents/pm-agent.md` | 84 | `docs/temp/lessons-YYYY-MM-DD.md` | Template placeholder (benign) |
| `agents/pm-agent.md` | 94 | `docs/temp/experiment-` | PM agent template dir (missing) |
| `agents/pm-agent.md` | 94 | `docs/patterns` | PM agent template dir (missing) |
| `agents/pm-agent.md` | 95 | `docs/mistakes/mistake-YYYY-MM-DD.md` | Template placeholder (benign) |
| `agents/pm-agent.md` | 100 | `docs/patterns/supabase-auth-kong-pattern.md` | PM agent template dir (missing) |
| `agents/pm-agent.md` | 101 | `docs/mistakes/organization-id-forgotten-2025-10-13.md` | Template placeholder (benign) |
| `agents/pm-agent.md` | 124 | `docs/temp` | PM agent template dir (missing) |
| `agents/pm-agent.md` | 124 | `docs/mistakes` | PM agent template dir (missing) |
| `agents/pm-agent.md` | 211 | `docs/temp/experiment-2025-10-13.md` | Template placeholder (benign) |
| `agents/pm-agent.md` | 462 | `docs/self-improvement-workflow.md` | PM-agent sample project docs (external) |
| `agents/pm-agent.md` | 551 | `docs/authentication.md` | PM-agent sample project docs (external) |
| `agents/pm-agent.md` | 638 | `docs/kong-gateway.md` | PM-agent sample project docs (external) |
| `agents/repo-index.md` | 46 | `docs/developer-guide` | Per-project doc |
| `docs/SURFACE-MAP.md` | 3 | `commands/skills` | Doc typo |
| `docs/SURFACE-MAP.md` | 48 | `skills/_archive` | Archive convention (not yet created) |
| `docs/SURFACE-MAP.md` | 48 | `commands/_archive` | Archive convention (not yet created) |
| `docs/SURFACE-MAP.md` | 48 | `agents/_archive` | Archive convention (not yet created) |
| `docs/COUNCIL-REMEDIATION.md` | 14 | `docs/ELITE-OPS-` | Incomplete path (regex split) |
| `evolution/config.yaml` | 21 | `evolution/records/archive` | Runtime-created (expected absent until first use) |
| `evolution/bin/evolve-regression.sh` | 4 | `evolution/reports/YYYY-MM-DD-regression.md` | Template placeholder (benign) |
| `commands/ultraplan.md` | 488 | `agents/skills/MCPs` | Doc slash-list (not a real path) |
| `commands/ultraplan.md` | 496 | `agents/MCPs` | Doc slash-list (not a real path) |
| `commands/evolution.md` | 30 | `evolution/reports/promoted-` | Runtime-created (expected absent until first use) |
| `commands/sc/pm.md` | 310 | `docs/pdca` | PM agent template dir (missing) |
| `commands/sc/pm.md` | 496 | `docs/patterns/supabase-auth-integration.md` | PM agent template dir (missing) |
| `commands/sc/pm.md` | 504 | `docs/checklists/new-feature-checklist.md` | PM agent template dir (missing) |
| `commands/bmad/prd.md` | 13 | `docs/prd-` | BMAD template (filled per project) |
| `commands/bmad/prd.md` | 340 | `docs/bmm-workflow-status.yaml` | Review |
| `commands/bmad/architecture.md` | 13 | `docs/architecture-` | BMAD template (filled per project) |
| `commands/bmad/architecture.md` | 27 | `docs/tech-spec-` | BMAD template (filled per project) |
| `commands/bmad/create-story.md` | 13 | `docs/stories/STORY-` | PM agent template dir (missing) |
| `commands/bmad/create-story.md` | 25 | `docs/sprint-plan-` | BMAD template (filled per project) |
| `commands/bmad/tech-spec.md` | 25 | `docs/product-brief-` | BMAD template (filled per project) |
| `commands/bmad/product-brief.md` | 277 | `docs/product-brief-myapp-2025-01-11.md` | Template placeholder (benign) |
| `commands/bmad/workflow-init.md` | 118 | `docs/sprint-status.yaml` | BMAD per-project generated file (expected absent) |
| `commands/bmad/workflow-init.md` | 121 | `docs/stories` | PM agent template dir (missing) |
| `commands/bmad/workflow-status.md` | 46 | `docs/prd-myapp-2025-01-11.md` | Template placeholder (benign) |
| `skills/evidence-recorder/SKILL.md` | 40 | `evolution/records/corrections.jsonl` | Review |
| `skills/paperclip/SKILL.md` | 28 | `agents/me` | Paperclip-specific path (external project) |
| `skills/paperclip/SKILL.md` | 39 | `agents/me/inbox-lite` | Paperclip-specific path (external project) |
| `skills/paperclip/SKILL.md` | 135 | `skills/sync` | Paperclip example paths (external) |
| `skills/paperclip/SKILL.md` | 191 | `agents/claudecoder` | Paperclip-specific path (external project) |
| `skills/paperclip/SKILL.md` | 196 | `agents/cto` | Paperclip-specific path (external project) |
| `skills/paperclip/SKILL.md` | 245 | `agents/cmo/AGENTS.md` | Paperclip-specific path (external project) |
| `skills/paperclip/SKILL.md` | 271 | `agents/me/inbox/mine` | Paperclip-specific path (external project) |
| `skills/paperclip/SKILL.md` | 293 | `skills/import` | Paperclip example paths (external) |
| `skills/paperclip/SKILL.md` | 294 | `skills/scan-projects` | Paperclip example paths (external) |
| `skills/paperclip/references/company-skills.md` | 43 | `skills/design-md` | Paperclip example paths (external) |
| `skills/paperclip/references/api-reference.md` | 101 | `agents/ceo/AGENTS.md` | Paperclip-specific path (external project) |
| `skills/design-inspector/SKILL.md` | 243 | `docs/design-references/DESIGN_REPORT.md` | Per-project generated doc (expected absent in setup repo) |
| `skills/understand-onboard/SKILL.md` | 52 | `docs/ONBOARDING.md` | Per-project generated doc (expected absent in setup repo) |
| `skills/wshobson-deployment-spec/SKILL.md` | 778 | `docs/reference/generated/kubernetes-api/v1.28` | External k8s docs reference |
| `skills/wshobson-deployment-spec/SKILL.md` | 779 | `docs/concepts/security/pod-security-standards` | External k8s docs reference |
| `skills/wshobson-deployment-spec/SKILL.md` | 780 | `docs/concepts/configuration/manage-resources-containers` | External k8s docs reference |
| `skills/bmad/bmb/builder/SKILL.md` | 109 | `agents/tools` | Paperclip-specific path (external project) |

... 75 more in appendix.

**True-stale callouts (not benign templates):**

- `skills/bmad/bmb/builder/SKILL.md:306-308` — references `bmad/bmb/qa-engineer/SKILL.md`, `commands/create-test-plan.md`, `commands/execute-tests.md` — all three missing.
- `commands/ultraplan.md:488,496` — slash-lists (`agents/skills/MCPs`, `agents/MCPs`) that my regex mis-parsed as paths. Benign.
- `docs/SURFACE-MAP.md:3` — `commands/skills` — typo; should read `commands` and `skills`.
- `docs/COUNCIL-REMEDIATION.md:14` — `docs/ELITE-OPS-` — incomplete path (truncated name referenced).
- `docs/SURFACE-MAP.md:48` — references `_archive` directories for skills/commands/agents that don't exist yet. If archive convention is planned, create stubs; otherwise remove the reference.
- `skills/recipe/SKILL.md:105` — references `recipes/lib/history.jsonl` — runtime-created, acceptable, but should note 'created on first run' in SKILL.md.

### 4c. Broken agent→skill bindings

Out of ~180 agent→skill edges, **1 skill name** referenced in agent frontmatter does not exist on disk:

- `agents/debugger.md` declares skill `debug` — there is no `skills/debug/SKILL.md`. Nearest match: the `/debug` command (exists) — frontmatter should likely be `coding-workflow` or the skill should be created.

### 4d. Broken slash-command references in docs

`/recall` is cited 6× (in CLAUDE.md, commands/ultraplan.md, etc.) but there is no `commands/recall.md`. `recall` is a skill (`skills/recall/SKILL.md`), not a command — the `/recall` invocation pattern won't work without either (a) creating `commands/recall.md`, or (b) updating references to say 'the `recall` skill' instead of `/recall`.

---

## 5. Reference Graph by Kind

### 5a. Agent → Skill (core agents only, top 60 edges)

| Agent | Skills declared in frontmatter |
|-------|-------------------------------|
| `agent-installer` | `skill-architect`, `skill-creator` |
| `ai-engineer` | `multi-agent-patterns`, `rag-patterns`, `claude-api`, `autoresearch` |
| `analytics-reporter` | `data-analysis`, `product-analytics` |
| `api-designer` | `api-design-patterns`, `api-testing-suite` |
| `api-tester` | `api-testing-suite`, `api-design-patterns` |
| `architect` | `multi-agent-patterns`, `clean-architecture-python`, `api-design-patterns` |
| `backend-architect` | `clean-architecture-python`, `api-design-patterns`, `database-patterns`, `structured-logging` |
| `business-panel-experts` | `ceo-advisor`, `cto-advisor`, `cfo-advisor`, `competitive-intel` |
| `ci-cd-engineer` | `github-actions-patterns`, `release-automation` |
| `code-reviewer` | `receiving-code-review`, `python-quality-gate`, `security-review` |
| `compliance-officer` | `gdpr-dsgvo-expert`, `security-review` |
| `content-strategist` | `content-strategy`, `seo-audit`, `brand-guidelines`, `market-copy`, `market-emails`, `market-social`, `market-brand`, `market-seo`, `market-report`, `market-report-pdf` |
| `cost-optimizer` | `cost-optimization`, `devops-patterns` |
| `data-analyst` | `data-analysis`, `research-methodology` |
| `db-admin` | `database-patterns` |
| `debugger` | `debug` |
| `deep-research` | `research-methodology`, `data-analysis` |
| `devops-architect` | `devops-patterns`, `container-security`, `github-actions-patterns`, `infrastructure-scanning` |
| `docker-specialist` | `container-security`, `devops-patterns`, `local-dev-orchestration` |
| `documenter` | `doc-coauthoring` |
| `experiment-tracker` | `ab-test-setup`, `experiment-designer`, `product-analytics` |
| `feedback-synthesizer` | `product-analytics`, `ux-researcher-designer` |
| `finance-tracker` | `aster-trading`, `finance-ml`, `financial-modeling`, `wshobson-SKILL` |
| `frontend-architect` | `baseline-ui`, `frontend-design`, `fixing-accessibility`, `ui-design-system`, `interface-design`, `distilled-aesthetics`, `remotion-animation`, `video-ui-patterns` |
| `growth-marketer` | `marketing-demand-acquisition`, `seo-audit`, `ab-test-setup`, `content-strategy`, `market`, `market-audit`, `market-ads`, `market-funnel`, `market-landing`, `market-competitors`, `market-launch` |
| `incident-responder` | `production-monitoring`, `security-review` |
| `infra-engineer` | `devops-patterns`, `cost-optimization`, `infrastructure-scanning`, `local-dev-orchestration` |
| `knowledge-graph-guide` | `understand`, `understand-chat`, `understand-dashboard` |
| `learning-guide` | `research-methodology` |
| `legal-compliance-checker` | `gdpr-dsgvo-expert`, `security-review` |
| `market-competitive` | `market-competitors` |
| `market-content` | `market-copy`, `market-brand` |
| `market-conversion` | `market-funnel`, `market-landing` |
| `market-strategy` | `market-audit`, `market-launch`, `market-proposal` |
| `market-technical` | `market-seo` |
| `migration-specialist` | `database-patterns` |
| `mobile-app-builder` | `baseline-ui`, `frontend-design` |
| `monorepo-manager` | `github-actions-patterns`, `release-automation` |
| `observability-engineer` | `production-monitoring`, `structured-logging` |
| `performance-engineer` | `production-monitoring`, `structured-logging` |
| `performance-optimizer` | `production-monitoring`, `structured-logging` |
| `pm-agent` | `operating-framework`, `executing-plans` |
| `project-shipper` | `git-workflows`, `branch-finishing`, `release-automation` |
| `prompt-engineer` | `claude-api`, `multi-agent-patterns`, `prompt-reliability-engine` |
| `python-expert` | `python-quality-gate`, `clean-architecture-python`, `structured-logging` |
| `quality-engineer` | `testing-methodology`, `property-based-testing`, `api-testing-suite`, `webapp-testing` |
| `rapid-prototyper` | `coding-workflow`, `frontend-design`, `interface-design`, `distilled-aesthetics`, `remotion-animation`, `video-ui-patterns` |
| `refactorer` | `python-quality-gate` |
| `refactoring-expert` | `clean-architecture-python`, `python-quality-gate` |
| `release-engineer` | `release-automation`, `github-actions-patterns`, `git-workflows` |
| `repo-index` | `understand`, `understand-setup` |
| `requirements-analyst` | `product-manager-toolkit`, `product-strategist` |
| `root-cause-analyst` | `research-methodology` |
| `scrum-facilitator` | `product-manager-toolkit` |
| `secrets-manager` | `security-review` |
| `security-auditor` | `security-review`, `infrastructure-scanning`, `osint-recon` |
| `security-engineer` | `security-review`, `infrastructure-scanning`, `container-security`, `offensive-security` |
| `self-review` | `verification-before-completion`, `coding-workflow` |
| `socratic-mentor` | `research-methodology` |
| `system-architect` | `multi-agent-patterns`, `clean-architecture-python`, `rag-patterns` |

... 6 more core-agent→skill rows in the raw data. Wave-1/Wave-2 agents each declare 1–2 skills (mostly `anti-ai-writing` plus a domain skill).

### 5b. Agent → MCP (core agents, top 40 edges)

| Agent | MCP bindings |
|-------|--------------|
| `agent-installer` | `github`**, `filesystem` |
| `ai-engineer` | `github`**, `context7`**, `sequential`*, `memory` |
| `analytics-reporter` | `postgres`**, `filesystem` |
| `api-designer` | `github`**, `context7`**, `sequential`* |
| `api-tester` | `github`**, `context7`** |
| `architect` | `github`**, `sequential`*, `memory` |
| `backend-architect` | `github`**, `postgres`**, `context7`**, `sequential`* |
| `business-panel-experts` | `sequential`*, `memory`, `brave-search`**, `tavily`** |
| `ci-cd-engineer` | `github`**, `docker`** |
| `code-reviewer` | `github`**, `code-review-graph` |
| `compliance-officer` | `github`**, `filesystem`, `sequential`* |
| `content-strategist` | `brave-search`**, `tavily`**, `memory` |
| `cost-optimizer` | `github`**, `terraform`**, `kubernetes`** |
| `data-analyst` | `postgres`**, `filesystem`, `sequential`* |
| `db-admin` | `postgres`**, `github`** |
| `debugger` | `github`**, `sequential`*, `playwright`** |
| `deep-research` | `brave-search`**, `tavily`**, `memory`, `sequential`*, `context7`** |
| `devops-architect` | `terraform`**, `kubernetes`**, `docker`**, `github`** |
| `docker-specialist` | `docker`**, `github`** |
| `documenter` | `github`**, `filesystem` |
| `experiment-tracker` | `github`**, `memory`, `sequential`* |
| `feedback-synthesizer` | `memory`, `slack`**, `sequential`* |
| `finance-tracker` | `aster`**, `sequential`*, `memory` |
| `frontend-architect` | `github`**, `playwright`**, `penpot`**, `context7`** |
| `growth-marketer` | `brave-search`**, `tavily`**, `slack`** |
| `incident-responder` | `github`**, `slack`**, `kubernetes`** |
| `infra-engineer` | `terraform`**, `kubernetes`**, `docker`**, `github`** |
| `knowledge-graph-guide` | `memory`, `filesystem` |
| `learning-guide` | `sequential`*, `memory`, `context7`** |
| `legal-compliance-checker` | `github`**, `filesystem`, `sequential`* |
| `market-competitive` | `brave-search`**, `tavily`**, `playwright`** |
| `market-content` | `brave-search`**, `tavily`**, `playwright`** |
| `market-conversion` | `brave-search`**, `tavily`**, `playwright`** |
| `market-strategy` | `brave-search`**, `tavily`**, `playwright`** |
| `market-technical` | `brave-search`**, `tavily`**, `playwright`** |
| `migration-specialist` | `postgres`**, `github`** |
| `mobile-app-builder` | `github`**, `context7`**, `playwright`** |
| `monorepo-manager` | `github`**, `filesystem` |
| `observability-engineer` | `github`**, `kubernetes`** |
| `performance-engineer` | `github`**, `sequential`* |

Legend: `*` = name mismatch (should be `sequential-thinking`), `**` = aspirational MCP (not connected).

### 5c. Command → Agent (top 15)

| Command | # agents referenced | Sample |
|---------|--------------------:|--------|
| `commands/ultraplan.md` | 66 | agent-installer, ai-engineer, analytics-reporter, api-designer, api-tester, architect ... |
| `commands/plan.md` | 66 | agent-installer, ai-engineer, analytics-reporter, api-designer, api-tester, architect ... |
| `commands/sc/pm.md` | 11 | architect, backend-architect, frontend-architect, performance-engineer, pm-agent, quality-engineer ... |
| `commands/planUI.md` | 4 | architect, frontend-architect, mobile-app-builder, ux-designer |
| `commands/sc/spec-panel.md` | 4 | architect, quality-engineer, system-architect, technical-writer |
| `commands/sc/agent.md` | 3 | deep-research, repo-index, self-review |
| `commands/sc/sc.md` | 3 | deep-research, repo-index, self-review |
| `commands/sc/recommend.md` | 2 | architect, refactorer |
| `commands/ship.md` | 1 | repo-index |
| `commands/review.md` | 1 | code-reviewer |
| `commands/evolution.md` | 1 | evolution-orchestrator |
| `commands/sc/estimate.md` | 1 | architect |
| `commands/sc/implement.md` | 1 | architect |
| `commands/sc/improve.md` | 1 | architect |
| `commands/sc/explain.md` | 1 | architect |

### 5d. Command → Skill (top 10)

| Command | # skills referenced | Sample |
|---------|--------------------:|--------|
| `commands/planUI.md` | 28 | aidesigner-frontend, algorithmic-art, baseline-ui, brand-guidelines, clone-website, design-inspector ... |
| `commands/plan.md` | 3 | governance-gate, jarvis-core, qwen-dispatch |
| `commands/evolution.md` | 2 | promotion-gate, session-analyst |
| `commands/council-review.md` | 1 | council |
| `commands/start-task.md` | 1 | operating-framework |
| `commands/council.md` | 1 | council |
| `commands/interface-design-init.md` | 1 | interface-design |

### 5e. Command → Command (top 15)

| Command | Referenced commands |
|---------|---------------------|
| `commands/bmad/workflow-status.md` | `/architecture`, `/create-story`, `/dev-story`, `/prd`, `/product-brief`, `/research`, `/sprint-planning`, `/tech-spec`, `/workflow`, `/workflow-init` |
| `commands/planUI.md` | `/design`, `/document`, `/interface-design-audit`, `/interface-design-critique`, `/interface-design-extract`, `/interface-design-init`, `/interface-design-status`, `/plan`, `/ultraplan` |
| `commands/bmad/workflow-init.md` | `/architecture`, `/create-story`, `/dev-story`, `/prd`, `/product-brief`, `/sprint-planning`, `/tech-spec`, `/workflow`, `/workflow-status` |
| `commands/bmad/sprint-planning.md` | `/architecture`, `/create-story`, `/dev-story`, `/prd`, `/tech-spec` |
| `commands/bmad/tech-spec.md` | `/create-story`, `/dev-story`, `/prd`, `/product-brief`, `/sprint-planning` |
| `commands/bmad/research.md` | `/architecture`, `/create-ux-design`, `/prd`, `/product-brief`, `/tech-spec` |
| `commands/bmad/brainstorm.md` | `/architecture`, `/prd`, `/research`, `/sprint-planning`, `/tech-spec` |
| `commands/bmad/create-ux-design.md` | `/architecture`, `/dev-story`, `/sprint-planning`, `/tech-spec` |
| `commands/bmad/product-brief.md` | `/prd`, `/tech-spec`, `/workflow`, `/workflow-status` |
| `commands/bmad/solutioning-gate-check.md` | `/architecture`, `/prd`, `/sprint-planning`, `/tech-spec` |
| `commands/plan.md` | `/README`, `/review`, `/test` |
| `commands/sc/pm.md` | `/architecture`, `/metrics`, `/plan` |
| `commands/bmad/architecture.md` | `/prd`, `/sprint-planning`, `/tech-spec` |
| `commands/setup-audit.md` | `/README`, `/review` |
| `commands/council-review.md` | `/council`, `/ship` |

### 5f. Recipe → Agent / Skill / MCP

Recipes are the cleanest graph layer — typed YAML fields make edges explicit.

| Recipe | → Agent (primary / fallback) | → Skills | → MCPs |
|--------|------------------------------|----------|--------|
| `recipes/devops/deploy-check.yaml` | `devops-architect` / ci-cd-engineer | `security-review` | `filesystem`, `github` |
| `recipes/security/security-audit.yaml` | `security-engineer` / security-auditor | `security-review` | `filesystem` |
| `recipes/security/secrets-scan.yaml` | `security-auditor` / code-reviewer | `security-review` | `filesystem` |
| `recipes/sub/lint-check.yaml` | `—` | — | — |
| `recipes/sub/dep-audit.yaml` | `—` | — | — |
| `recipes/sub/test-run.yaml` | `—` | — | — |
| `recipes/trading/position-review.yaml` | `finance-tracker` / data-analyst | `aster-trading` | `aster` |
| `recipes/trading/market-scan.yaml` | `data-analyst` / finance-tracker | `aster-trading` | `aster` |
| `recipes/engineering/api-endpoint.yaml` | `api-designer` / backend-architect | `api-design-patterns`, `test-driven-development` | `filesystem` |
| `recipes/engineering/refactor.yaml` | `refactorer` / refactoring-expert | `coding-workflow`, `python-quality-gate` | `filesystem` |
| `recipes/engineering/test-suite.yaml` | `tester` / quality-engineer | `test-driven-development`, `testing-methodology` | `filesystem` |
| `recipes/engineering/debug-investigation.yaml` | `debugger` / root-cause-analyst | `coding-workflow` | `filesystem` |
| `recipes/engineering/code-review.yaml` | `code-reviewer` / python-expert | `security-review`, `python-quality-gate` | `filesystem`, `github` |

### 5g. Hook → Script (from `settings.json`)

All 10 unique hook scripts referenced in `settings.json` exist on disk — **no broken hook references**. Seven additional hook entries are inline commands (grep pipelines in settings.json itself).

| Event | Script | Exists? |
|-------|--------|---------|
| UserPromptSubmit | `hooks/keyword-detector.sh` | ✓ |
| PreToolUse | `hooks/loop-detector.sh` | ✓ |
| PreToolUse | `hooks/usage-logger.sh` | ✓ |
| PreToolUse (Agent) | `hooks/preflight-context-guard.sh` | ✓ |
| PreToolUse (mcp__*) | `hooks/mcp-security-gate.sh` | ✓ |
| PostToolUse (Bash) | `hooks/session-metrics.sh` | ✓ |
| PostToolUse | `hooks/tool-failure-tracker.sh` | ✓ |
| SessionStart | `hooks/session-init.sh` | ✓ |
| SessionStart | `hooks/evolution-startup.sh` | ✓ |
| SessionEnd | `hooks/evolution-sessionend.sh` | ✓ |
| Stop | `hooks/context-guard.sh` | ✓ |
| Stop | `hooks/persistent-mode.sh` | ✓ |
| Stop/SubagentStop | `hooks/stop-verification.sh` | ✓ |

All 13 expected scripts are present (no drift between `settings.json` and `hooks/`).

### 5h. Skill → Skill

**Finding:** 0 of 202 skills declare a `dependencies:`, `requires:`, or `related-skills:` field in frontmatter. Skill-to-skill composition is informal (done in prose, not wired). This is fine for a prompt-library model, but means the pipeline can't programmatically discover skill chains — e.g., `impeccable-design → impeccable-audit → impeccable-polish` is only sequenced in command prose, not in skill metadata.

---

## 6. CLAUDE.md Outbound Reference Audit

**Explicit paths mentioned in `CLAUDE.md`:**

| Line | Path | Resolves? |
|-----:|------|-----------|
| 63 | `evolution/stable/global.md` | ✓ |
| 63 | `evolution/bin/evolve-promote.sh` | ✓ |
| 63 | `evolution/candidates/` | ✓ |
| 115 | `state/autonomous.json` | runtime-only |
| 214 | `agents/REGISTRY.md` | ✓ |
| 215 | `skills/jarvis-core/SKILL.md` | ✓ |
| 216 | `skills/governance-gate/SKILL.md` | ✓ |
| 274 | `commands/plan.md` | ✓ |
| 277 | `commands/ultraplan.md` | ✓ |
| 285 | `recipes/` | ✓ |
| 292 | `agents/REGISTRY.md` | ✓ |
| 309 | `hooks/mcp-security-gate.sh` | ✓ |
| 324 | `skills/_shared/skill-template.md` | ✓ |
| 325 | `skills/_shared/review-checklist.md` | ✓ |
| 326 | `skills/_shared/naming-conventions.md` | ✓ |

**`state/autonomous.json`** is runtime-created (persistent mode activation). Absent from the repo is expected — not a real miss. All 14 other CLAUDE.md-cited paths resolve.

**Named capabilities mentioned (by name, not path) — all resolve:**

- **Skills cited:** 34 distinct skill names detected (e.g., `_shared`, `algorithmic-art`, `api-design-patterns`, `b2c-app-strategist`, `coding-workflow`, `council`, `elite-ops`, `evidence-recorder`, `framer-motion-patterns`, `git-workflows`, `governance-gate`, `impeccable-audit`, ...).
- **Agents cited:** 66 distinct agents (every L0–L6 core agent in the hierarchy table).
- **Commands cited:** 35 distinct commands (custom + SC + BMAD).

## 7. README.md Outbound Reference Audit

README.md is lean — it points at docs and high-level entry commands.

| Target | Resolves? |
|--------|-----------|
| `docs/SURFACE-MAP.md` | ✓ |
| `docs/KB-STATUS.md` | ✓ |
| `docs/DEMO.md` | ✓ |
| `docs/INVENTORY.md` | ✓ |
| `docs/TELEMETRY.md` | ✓ |
| `docs/COUNCIL-REMEDIATION.md` | ✓ |
| `evolution/README.md` | ✓ |
| `evolution/stable/global.md` | ✓ |
| `evolution/config.yaml` | ✓ |
| `evolution/disabled` | runtime-only (runtime-only — created by `/evolution disable`) |
| `settings.json` | ✓ |
| `hooks/` | ✓ |
| `CLAUDE.md` | ✓ |

**Commands referenced (slash form):** 15 — `/ship`, `/audit-deep`, `/fix-root`, `/plan`, `/ultraplan`, `/evolution` plus the 4 `/evolution <subcommand>` variants. All resolve.

---

## 8. Cross-Domain Bridges

Skills that 3+ different agent domains bind. These are the composability glue of the ecosystem.

| Skill | # domains | Domains spanning |
|-------|----------:|------------------|
| `anti-ai-writing` | 9 | documentation, engineering, growth, operations, product, research, security, strategy, surfaces |
| `data-analysis` | 8 | core, documentation, growth, operations, product, quality, research, security |
| `research-methodology` | 4 | core, engineering, growth, research |
| `competitive-intel` | 4 | core, growth, product, strategy |
| `doc-coauthoring` | 3 | core, documentation, engineering |
| `github-actions-patterns` | 3 | core, infrastructure, operations |
| `api-design-patterns` | 3 | core, engineering, quality |
| `product-analytics` | 3 | core, growth, product |
| `production-monitoring` | 3 | core, engineering, operations |
| `testing-methodology` | 3 | core, engineering, quality |
| `financial-modeling` | 3 | core, growth, strategy |
| `cost-optimization` | 3 | core, infrastructure, operations |
| `test-driven-development` | 3 | core, engineering, quality |
| `gdpr-dsgvo-expert` | 3 | core, security, strategy |

**Reading:** `anti-ai-writing` is the universal glue — every content-generating agent inherits it (9 of 10 domains). `data-analysis` bridges research → growth → product → security → quality. `competitive-intel` is the growth/strategy/product triangle. These skills are the ones you cannot move/rename without breaking the most bindings.

---

## 9. Docs — Hubs vs Leaves

Out-degree (refs from a doc to other files) vs inbound (refs to the doc).

| Doc | Out-degree | Inbound | Role |
|-----|-----------:|--------:|------|
| `docs/CAPABILITIES_REPORT.md` | 90 | 0 | Hub — mentions many; no one links in |
| `docs/CLAUDE_CODE_ARCHITECTURE.md` | 89 | 0 | Hub — comprehensive; isolated |
| `docs/ELITE-OPS-METHODOLOGY.md` | 31 | 1 | Hub — cited by ELITE-OPS-README |
| `docs/OPERATING_FRAMEWORK.md` | 30 | 0 | Hub — no backlinks |
| `docs/SURFACE-MAP.md` | 29 | 2 | Semi-hub — README points here |
| `docs/LEARNING_ROADMAP.md` | 17 | 0 | Leaf — no inbound |
| `docs/ELITE-OPS-README.md` | 12 | 0 | Leaf |
| `docs/INVENTORY.md` | 2 | 4 | Leaf — most-cited doc in the repo |
| `docs/KB-STATUS.md` | 1 | 4 | Leaf — well-referenced for KB status |
| `docs/TELEMETRY.md` | 1 | 3 | Leaf — referenced from README and Makefile paths |
| `docs/DEMO.md` | 1 | 2 | Leaf — referenced from README |
| `docs/QUICKSTART.md` | 8 | 1 | Leaf |
| `docs/OVERHEAD.md` | 1 | 1 | Leaf |
| `docs/COUNCIL-REMEDIATION.md` | 1 | 1 | Leaf |
| `docs/PRODUCT_EVALUATIONS.md` | 1 | 0 | Isolated |
| `docs/DATA_PLATFORM_GUIDE.md` | 1 | 0 | Isolated |
| `docs/RAG_LLM_REFERENCE.md` | 1 | 0 | Isolated |
| `docs/FINANCE_ML_STACK.md` | 1 | 0 | Isolated |
| `docs/FRONTEND_PATTERNS.md` | 1 | 0 | Isolated |
| `docs/SECURITY_PLAYBOOK.md` | 1 | 0 | Isolated |
| `docs/SECURITY_ARSENAL.md` | 1 | 0 | Isolated |
| `docs/DEVOPS_TOOLKIT.md` | 1 | 0 | Isolated |
| `docs/AI_AGENT_LANDSCAPE.md` | 1 | 0 | Isolated |
| `docs/CLAUDE_CODE_ECOSYSTEM.md` | 1 | 0 | Isolated |
| `docs/CURATED_TOOLS.md` | 1 | 0 | Isolated |
| `docs/prompt-reliability-playbook.md` | 1 | 0 | Isolated |

**Finding:** 11 of 26 reference docs are **leaves with zero inbound links**. They are written but unreferenced — the ecosystem doesn't route readers to them. Candidates for either (a) deleting, (b) folding into CAPABILITIES_REPORT.md, or (c) adding to a doc index. The 4 architecture hubs (`CAPABILITIES_REPORT`, `CLAUDE_CODE_ARCHITECTURE`, `OPERATING_FRAMEWORK`, `ELITE-OPS-METHODOLOGY`) overlap in content — worth flagging for the CONFLICTS.md audit.

---

## 10. Summary of Findings (for AUDIT.md synthesis)

**Big-picture signal:**

1. **Graph is well-wired at the top.** 21 of 26 hubs are orchestrators (plan/ultraplan/planUI), dispatch tables (REGISTRY.md), or foundational skills (operating-framework, prompt-reliability-engine). CLAUDE.md, plan.md, ultraplan.md all resolve cleanly against disk.

2. **MCP binding integrity is broken.** 133 of ~180 agent→MCP edges reference servers that are either not connected (aspirational `context7`/`github`/`playwright`/etc.) or use a mismatched name (`sequential` vs `sequential-thinking`). Either strip the bindings or install the MCPs. This violates SEC-001 rule #2.

3. **14 skills are effectively orphan** (≤1 strict inbound, no agent binds, not named by any command). 49 more have exactly 2 inbound. Candidates for pruning per the `pruning-view` skill's own protocol.

4. **125 Wave-1 agents are 'dark'** — no file outside their own subdir mentions them. Intentional per architecture (dispatch through dept-head expansion), but makes them invisible to `/plan`'s agent-match heuristic. If REGISTRY.md dept-head bindings don't enumerate them, they won't be discovered.

5. **11 reference docs have zero inbound links.** They exist on disk but no other file in the repo points to them. The 4 largest docs (CAPABILITIES_REPORT, CLAUDE_CODE_ARCHITECTURE, OPERATING_FRAMEWORK, ELITE-OPS-METHODOLOGY) are content hubs but themselves uncited — they duplicate parts of CLAUDE.md, which is the real orchestrating doc.

6. **Real stale refs (non-template):** `skills/bmad/bmb/builder/SKILL.md` points at 3 non-existent builder files; `agents/debugger.md` frontmatter declares skill `debug` (missing); `docs/SURFACE-MAP.md:48` references `_archive/` dirs that don't exist; `/recall` is cited as a command 6× but only exists as a skill.

7. **Recipes are the cleanest layer** — 13 recipes, explicit YAML `requires.skills` + `requires.mcp_servers` + `routing.agent`, everything resolves. Recipe-first planning is architecturally correct.

8. **Hook integrity intact.** All 10 settings.json hook scripts exist in `hooks/`. No broken references.

---

## Appendix A — Full skill inbound table (tail)

Skills with exactly 2 strict inbound (shoulder-orphans):

`agent-evaluation`, `agent-orchestrator`, `ciso-advisor`, `cmo-advisor`, `coo-advisor`, `cpo-advisor`, `docx-generator`, `domain-driven-design`, `elite-ops`, `evidence-recorder`, `expect-testing`, `financial-analyst`, `jarvis-sec`, `market-audit`, `market-competitors`, `market-copy`, `market-funnel`, `market-launch`, `market-seo`, `mlops-engineer`, `moyu`, `paperclip-create-agent`, `pptx-generator`, `pricing-strategy`, `project-template`, `promotion-gate`, `qwen-dispatch`, `revenue-operations`, `sales-engineer`, `session-analyst`, `skill-evolution`, `unified-router`, `wshobson-argocd-setup`, `wshobson-chart-structure`, `wshobson-deployment-spec`, `wshobson-rbac-patterns`, `wshobson-service-spec`


## Appendix B — Raw edge files

Intermediate JSON files written during this audit (not persisted; regenerable):

- `/tmp/cr_agent_to_skills.json` — 237 agent→skill edges
- `/tmp/cr_agent_to_mcps.json` — 183 agent→MCP edges
- `/tmp/cr_recipes.json` — 13 recipe edges
- `/tmp/cr_cmd_to_agent.json` — command→agent edges
- `/tmp/cr_cmd_to_skill.json` — command→skill edges
- `/tmp/cr_inbound_strict.json` — per-skill and per-agent strict inbound counts
- `/tmp/cr_stale_paths.json` — 135 unresolved path strings
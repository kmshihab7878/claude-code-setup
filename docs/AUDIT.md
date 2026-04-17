# AUDIT — Phase 0: Inventory, Dependency Map, Conflicts

_Generated 2026-04-17 at HEAD `8157457`. Synthesis of three parallel audit passes. Full workspace evidence at:_

- [`docs/_audit-workspace/CLASSIFY.md`](./_audit-workspace/CLASSIFY.md) — 5-bucket classification of 986 files
- [`docs/_audit-workspace/CROSSREF.md`](./_audit-workspace/CROSSREF.md) — dependency graph across skills/agents/commands/hooks/recipes/docs
- [`docs/_audit-workspace/CONFLICTS.md`](./_audit-workspace/CONFLICTS.md) — overlap/contradiction detection

---

## 0. Executive summary

**The repo is healthier than the user prompt implies.** It is not bloated with dead weight — it is bloated with *unvalidated scaffolding*, *unreconciled drift*, and *five co-existing routing authorities* for overlapping intents. Those are fixable without mass deletion.

**Five findings that shape Phase 1+:**

1. **Fabrication, not drift — CLAUDE.md:235 lists 5 L6 worker agents (`market-content`, `market-conversion`, `market-competitive`, `market-technical`, `market-strategy`) that don't exist as files.** REGISTRY.md's L6 row correctly lists 8 different agents. Any user (or model) that tries to delegate to them fails.
2. **133 of ~180 agent→MCP bindings don't resolve** — they point at Tier-3 aspirational servers (`github`, `context7`, `playwright`, `tavily`, `brave-search`, `postgres`, `docker`, `kubernetes`, `terraform`, `slack`, `aster`, `penpot`, `puppeteer`) that are not connected, or use a misspelled name (`sequential` × 35 uses, should be `sequential-thinking`). This violates Constitution SEC-001 rule #2.
3. **Count drift persists in 10+ files despite [COUNCIL-REMEDIATION.md](./COUNCIL-REMEDIATION.md) row 1 claiming reconciliation.** `commands/plan.md`, `commands/ultraplan.md`, `docs/OVERHEAD.md`, `docs/DEMO.md`, `docs/ELITE-OPS-*.md` all carry "197 skills / 237 agents" banners; `docs/CLAUDE_CODE_ARCHITECTURE.md` and `docs/CAPABILITIES_REPORT.md` are frozen at "40/56/34" from 2026-03-15. `make validate` catches drift in CLAUDE.md and REGISTRY.md but not in the rest.
4. **The ecosystem has real extraction value and it is visible.** Nine clusters are already self-contained enough to ship as standalone artifacts: Elite Ops layer (12 files), self-evolution layer (~25 files), `/market` suite (~22 files), JARVIS-Core governance (jarvis-core + governance-gate + REGISTRY), Hue meta-skill (SKILL + 19 brand demos — biggest concrete demo in the repo), React-bits catalog, MCP-mastery, anti-ai-writing filter, JARVIS-sec.
5. **Experimental zones dominate the file count but not the leverage.** 171 of 986 files (17%) are Wave-1/Wave-2 agent stubs (~13–17 lines each, no invoking commands). The self-evolution layer has 2 session records in `records/sessions.jsonl` and zero promoted candidates. These are promising architecturally but honest classification is EXPERIMENTAL, not CORE.

**Honest limits of this audit:**
- No telemetry yet — `~/.claude/usage.jsonl` doesn't exist, so "zero invocations in 14 days" pruning data is unavailable. All orphan/hub claims use static cross-ref, not runtime usage.
- MCP reachability checks are based on CLAUDE.md Tier-3 labels, not a live `claude mcp list` query.
- Classification of Wave-1 agents as EXPERIMENTAL assumes "no dispatcher routes to them outside REGISTRY dept-head expansion." If you assert an expansion path exists that I missed, reclassify to SUPPORTING.

---

## 1. Inventory and classification

### 1.1 Totals

986 non-hidden files under `/Users/redacted-username/Projects/claude-code-setup/` (excluding `.git`, `.DS_Store`).

Disk-verified surface counts (from `scripts/inventory.sh`):

| Surface | Count |
|---------|------:|
| Skills (SKILL.md) | **202** |
| Skill total lines | 46,237 |
| Commands | **84** (38 custom + 31 SuperClaude + 15 BMAD) |
| Agent definitions | **242** (240 agents + REGISTRY.md + README.md) |
| Agents — core L0–L6 | 69 |
| Agents — Wave 1 stage | 126 |
| Agents — Wave 2 surface | 45 |
| Hook scripts | 13 |
| Hook entries in settings.json | 21 (14 script refs + 7 inline) |
| Recipes | 13 (10 primary + 3 sub) |
| Rules | 6 |
| Reference docs | 26 |
| KB wiki articles | 7 |
| MCPs — connected / auth-pending / aspirational | 8 / 2 / 20 |

### 1.2 Bucket classification

| Bucket | Count | % | Defend-as |
|--------|------:|--:|-----------|
| **CORE** | 118 | 12.0% | Actively useful, integrated, daily workflow, differentiated |
| **SUPPORTING** | 612 | 62.1% | Useful plumbing or reference content; not always-central |
| **CANDIDATE_FOR_CONSOLIDATION** | 42 | 4.3% | Overlaps with another file; merge target |
| **EXPERIMENTAL** | 212 | 21.5% | Promising but not validated/integrated |
| **ARCHIVAL** | 2 | 0.2% | Genuinely superseded — but both are closer to consolidation than to deletion |

Drivers:
- **EXPERIMENTAL** is dominated by 126 Wave-1 + 45 Wave-2 agent stubs (171 total, ~17% of repo) plus the self-evolution layer (~17 files), KB scaffold (~7 files), aspirational-MCP-gated skills (~10), and a handful of speculative routing/research skills.
- **CANDIDATE_FOR_CONSOLIDATION** (42): design-surface cluster (11 members), understand-family over-fragmentation (9), marketing duplication (multiple stacks), 4 interface-design-* commands, `docs/OPERATING_FRAMEWORK.md` vs `skills/operating-framework/SKILL.md`.
- **ARCHIVAL = 2**: `docs/CAPABILITIES_REPORT.md` (1180 lines, frozen at 2026-03-15) and `docs/OPERATING_FRAMEWORK.md` (255 lines, duplicates the skill). Honest call: both are CONSOLIDATION candidates, not archival. Zero truly dead files — `.gitignore` already excludes committed backups.

Full per-directory breakdown in [`CLASSIFY.md`](./_audit-workspace/CLASSIFY.md) §2.

### 1.3 Top 10 heaviest files

| Path | Lines | Bucket | Leverage |
|------|------:|--------|----------|
| `skills/n8n/czlonkowski/skills.png` | 7288 (binary) | SUPPORTING | Evaluation asset |
| `skills/timesfm-forecasting/examples/.../interactive_forecast.html` | 5939 | SUPPORTING | Demo artifact |
| `skills/timesfm-forecasting/examples/.../animation_data.json` | 5440 | SUPPORTING | Demo data |
| `skills/xlsx/scripts/office/schemas/.../sml.xsd` | 4439 | SUPPORTING | OOXML offline validator |
| **`skills/hue/examples/halcyon/component-library.html`** | **4359** | **CORE** | **Hue demo** — highest-leverage single-file demo |
| `skills/xlsx/scripts/office/schemas/.../wml.xsd` | 3646 | SUPPORTING | OOXML schema |
| `skills/xlsx/scripts/office/schemas/.../dml-main.xsd` | 3081 | SUPPORTING | OOXML schema |
| `skills/xlsx/scripts/office/schemas/.../pml.xsd` | 1676 | SUPPORTING | OOXML schema |
| `skills/hue/examples/ledger/landing-page.html` | 1540 | CORE | Hue demo |
| `skills/hue/examples/relay/landing-page.html` | 1459 | CORE | Hue demo |

**Nine of the top twenty are Hue brand demo HTMLs.** These are not bloat — they are the most concrete proof-of-capability in the repo. Keep. Full top-20 in [`CLASSIFY.md`](./_audit-workspace/CLASSIFY.md) §3.

### 1.4 Top 10 highest-leverage files

Ranked by operational / demo / positioning / extraction value per kilobyte:

| # | Path | Leverage type |
|--:|------|---------------|
| 1 | `CLAUDE.md` | **Operational + Positioning** — always-loaded contract |
| 2 | `agents/REGISTRY.md` | **Operational + Positioning** — central dispatch table, the JARVIS-mirrored architecture proof |
| 3 | `scripts/inventory.sh` + `scripts/validate.sh` + `Makefile` | **Operational** — pre-commit drift guards |
| 4 | `docs/INVENTORY.md` | **Operational + Positioning** — generated single source of truth |
| 5 | `skills/jarvis-core/SKILL.md` + `skills/governance-gate/SKILL.md` | **Operational + Extraction** — 10-stage pipeline + 5-layer safety gate |
| 6 | `skills/hue/` (SKILL + 19 brand demos) | **Demo + Extraction** — clearest standalone-product candidate |
| 7 | `skills/elite-ops/SKILL.md` + `docs/ELITE-OPS-METHODOLOGY.md` + `/ship` / `/audit-deep` / `/fix-root` / `/polish-ux` / `/council-review` | **Positioning + Extraction** — headline differentiator |
| 8 | `skills/market/` + 15 `market-*` skills + 5 `market-*` agents | **Demo + Extraction** — full marketing suite |
| 9 | `evolution/` layer (scripts + stable/global.md + config.yaml + /evolution) | **Positioning** — controlled-self-evolution narrative |
| 10 | `settings.json` + `hooks/*.sh` | **Operational** — 14 live hook scripts enforcing non-negotiables |

Full ranking and leverage-value zone map in [`CLASSIFY.md`](./_audit-workspace/CLASSIFY.md) §4–5.

---

## 2. Dependency findings

### 2.1 Top 10 most-referenced nodes

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

**`anti-ai-writing` is the universal binder** — every Wave-1 stage-gen/intel/loop agent declares it. Renaming or moving it breaks 61 agents' frontmatter. Full top-20 in [`CROSSREF.md`](./_audit-workspace/CROSSREF.md) §1.

### 2.2 Orphans

- **14 skills with ≤1 strict inbound** (no agent binds them, no command cites them): `paperclip-create-plugin`, `mirofish-prediction`, `session-bootstrap`, `quality-manager-qmr`, `hybrid-search-implementation`, `ultrathink`, `para-memory-files`, `recall`, `hermes-integration`, `graphql-architect`, `wshobson-sync-policies`, `goose-integration`, `pruning-view`, `b2c-app-strategist`.
- **49 skills with exactly 2 inbound** (shoulder-orphans) — listed in [`CROSSREF.md`](./_audit-workspace/CROSSREF.md) Appendix A.
- **125 of 126 Wave-1 agents are "dark"** — zero inbound outside their own subdir. Intentional per architecture (dispatched via dept-head expansion), but means no `/plan` agent-match step discovers them directly.
- **11 of 26 reference docs have zero inbound links.** Four of the largest (`CAPABILITIES_REPORT.md` 1180 lines, `CLAUDE_CODE_ARCHITECTURE.md` 524 lines, `OPERATING_FRAMEWORK.md` 255 lines, `ELITE-OPS-METHODOLOGY.md` 189 lines) are high-out-degree hubs that nothing links to — they duplicate content that CLAUDE.md is the real orchestrator for.

### 2.3 Hubs (highest outbound)

| File | Out-degree | Role |
|------|-----------:|------|
| `agents/REGISTRY.md` | 281 | Agent dispatch table |
| `commands/ultraplan.md` | 214 | 15-stage sovereign orchestrator |
| `commands/plan.md` | 211 | 10-stage CoreMind orchestrator |
| `CLAUDE.md` | 122 | Main config |
| `docs/CAPABILITIES_REPORT.md` | 90 | Large out-degree, zero in-degree |
| `docs/CLAUDE_CODE_ARCHITECTURE.md` | 89 | Same pattern |

`plan.md` + `ultraplan.md` + `REGISTRY.md` is the control plane. The two big architecture docs compete with CLAUDE.md for the same audience.

### 2.4 Stale references — **highest priority fix**

#### 2.4.1 Agent→MCP binding integrity (severe)

133 of ~180 declared agent→MCP edges don't resolve:

| MCP in agent frontmatter | Uses | Actual status |
|--------------------------|-----:|---------------|
| `github` | 47 | Tier 3 (aspirational) |
| `sequential` | 35 | **Name mismatch** — should be `sequential-thinking` |
| `brave-search` | 17 | Tier 3 |
| `playwright` | 13 | Tier 3 |
| `tavily` | 13 | Tier 3 |
| `context7` | 11 | Tier 3 |
| `postgres` | 7 | Tier 3 |
| `slack` | 7 | Tier 3 |
| `docker` | 5 | Tier 3 |
| `kubernetes` | 5 | Tier 3 |
| `terraform` | 3 | Tier 3 |
| `penpot` | 2 | Tier 3 |
| `puppeteer` | 1 | Tier 3 |
| `aster` | 1 | Tier 3 |

Connected MCPs that agents correctly reference: `memory` (34), `filesystem` (14), `code-review-graph` (3). The bindings exist but the servers don't — `mcp-security-gate.sh` will block these at runtime while the routing docs still point there.

**Violates Constitution SEC-001 rule #2:** *"Agents operate ONLY within declared MCP server bindings."*

#### 2.4.2 Other broken references

- **`agents/debugger.md`** declares skill `debug` — no `skills/debug/` exists. Should be `coding-workflow` or create the skill.
- **`/recall`** is cited 6× as a command but only exists as a skill. Either create `commands/recall.md` or update references.
- **`skills/bmad/bmb/builder/SKILL.md:306-308`** references 3 missing builder files.
- **`docs/SURFACE-MAP.md:48`** references `skills/_archive/`, `commands/_archive/`, `agents/_archive/` — archive convention exists in the SURFACE-MAP guidance but the directories have never been created.
- **`CLAUDE.md:235`** lists 5 `market-*` agents at L6 that don't exist as files.
- **`CLAUDE.md:262`** claims "18 hook entries (10 scripts + 7 inline)" — 10+7=17, off-by-one.

Full stale-ref table in [`CROSSREF.md`](./_audit-workspace/CROSSREF.md) §4.

### 2.5 Hook integrity ✓

All 10 unique hook scripts referenced in `settings.json` exist in `hooks/`. No broken hook references. The hook layer is the cleanest in the repo.

### 2.6 Recipe integrity ✓

All 13 recipes have typed YAML `routing.agent`, `requires.skills`, `requires.mcp_servers` fields. All agent/skill references resolve. The only recipes with aspirational-MCP dependencies are `recipes/trading/*.yaml` (depend on `aster` — honestly flagged EXPERIMENTAL).

### 2.7 Cross-domain bridges

Skills that bind across 3+ agent domains (composability glue — rename with care):

| Skill | Domains | Note |
|-------|--------:|------|
| `anti-ai-writing` | 9 | Universal filter |
| `data-analysis` | 8 | Research → growth → product → quality → security |
| `research-methodology` | 4 | |
| `competitive-intel` | 4 | Growth + product + strategy |
| `api-design-patterns` | 3 | |
| `github-actions-patterns` | 3 | |
| `production-monitoring` | 3 | |
| `testing-methodology` | 3 | |
| `test-driven-development` | 3 | |

---

## 3. Major conflicts

### 3.1 Severity-ranked top 10

| # | Conflict | Type | User impact |
|--:|----------|------|-------------|
| 1 | **CLAUDE.md:235** cites 5 L6 `market-*` agents that don't exist as files | Fabrication | Any delegation to those agents fails silently |
| 2 | REGISTRY + plan + ultraplan route agents to Tier-3 MCPs as if connected (133 edges) | Routing | Runtime blocks + user debugs "why won't this run" |
| 3 | Counts contradict across 10+ files despite `make validate` passing | Trust | Reader sees the codebase inconsistent with its own self-description |
| 4 | **`/ultraplan`** opener says *"absorbs /plan entirely"* while CLAUDE.md/README/SURFACE-MAP say "use `/plan` by default" | Routing | Users default to `/ultraplan` and burn enterprise-stage context on simple tasks |
| 5 | `docs/CLAUDE_CODE_ARCHITECTURE.md` + `docs/CAPABILITIES_REPORT.md` frozen at 2026-03-15 with "40/56/34" counts | Misleading | 4-week-stale doc with wrong counts still sits in `docs/` |
| 6 | **Marketing suite sprawl:** 16 `market-*` + 3 `ad-*` + 5 legacy marketing skills, no canonical routing | Operational confusion | "Write ad copy" routes arbitrarily |
| 7 | Design surface overlap (11 members) — SURFACE-MAP covers 4, misses 7 | Duplicated effort | Model picks differently each session |
| 8 | **"The pipeline" declared in 9 files with 10/13/15-stage variants** (plan=10, ELITE-OPS=13, ultraplan=15, jarvis-core=10, ...) | Operational confusion | No single answer to "what's the pipeline?" |
| 9 | 8 architecture/overview docs; only `INVENTORY.md` is generated | Stale-drift | Hand-maintained docs guarantee future drift |
| 10 | `docs/ELITE-OPS-METHODOLOGY.md` install instructions tell you to paste blocks that CLAUDE.md already contains | Misleading | Reader follows install steps that rewrite what's already correct |

### 3.2 Overlap clusters not (fully) in SURFACE-MAP

| Cluster | Members | SURFACE-MAP covers? | Canonical candidate |
|---------|---------|--------------------|--------------------|
| Frontend design | 11 skills (impeccable-design + frontend-design + interface-design + ui-ux-pro-max + ui-design-system + distilled-aesthetics + baseline-ui + aidesigner-frontend + web-artifacts-builder + react-bits + clone-website + design-inspector) | 4 members | `impeccable-design` (per SURFACE-MAP); needs keyword-gating for siblings |
| Polish | `/polish-ux` + impeccable-polish + fixing-accessibility + fixing-metadata + fixing-motion-performance | 2 members | `/polish-ux` orchestrates the three `fixing-*` sub-skills |
| Audit | `/audit-deep` + `/repo-review` + `/setup-audit` + `/sc:analyze` + `/security-audit` + impeccable-audit + context-budget-audit + interface-design-audit + `/council-review` | Partial | `/audit-deep` for full; scoped audits remain distinct |
| Marketing | 16 `market-*` + 3 `ad-*` + 5 legacy (marketing-demand-acquisition, marketing-strategy-pmm, competitive-intel, content-strategy, cold-email) + cmo-advisor + brand-guidelines + seo-audit | No | `/market` orchestrator; merge overlaps case-by-case |
| CXO advisors | 7 CXO + business-panel-experts + council | No | Fine hierarchy, but `business-panel-experts` only binds 3 of 7 CXOs |
| Skill-creation meta | skill-architect + skill-creator + skill-evolution + `/skill-design` + hue + mcp-builder | No | skill-architect vs skill-creator needs merge or relabel |
| Review agents | code-reviewer + security-auditor + security-engineer + self-review + quality-engineer + refactorer | No | Tier-based — needs pick rule in REGISTRY |
| Pipeline authorities | plan + ultraplan + jarvis-core + CLAUDE.md + ELITE-OPS-METHODOLOGY + governance-gate + operating-framework + REGISTRY + OPERATING_FRAMEWORK doc | No | `skills/jarvis-core/SKILL.md` should be the single source; others link to it |
| Governance surfaces | 14 surfaces with overlapping rules (CLAUDE.md Constitution = REGISTRY.md Constitution verbatim) | No | Dedupe Constitution; rename operating-framework to "operating-doctrine" |

### 3.3 Duplicated triggers

14 keywords fire 3+ skills. Worst offenders:
- "design" / "build UI" → 10 skills
- "audit" → 10 skills / commands
- "competitor" → 6 skills
- "review" → 7 commands + agents
- "SEO" → 4 skills
- "ad copy" → 7 skills across 3 parallel marketing stacks

Full trigger-collision table in [`CONFLICTS.md`](./_audit-workspace/CONFLICTS.md) §C.

### 3.4 Contradictions inside CLAUDE.md

- **Line 209:** "237 total / 66 core / 126 Wave 1 / 45 Wave 2"
- **Line 218:** "Authority Hierarchy (66 agents, 7 levels)"
- **Line 235:** "L6 Workers (13)" — REGISTRY.md:16 says "L6 Workers (8)"
- **Line 259:** "240 agents / 69 core"

Lines 209 and 259 of the same file contradict each other. `make validate` passes (it checks CLAUDE.md against its own stated counts, but doesn't catch the two-location contradiction).

---

## 4. Leverage-value map

### 4.1 Operational zones (used weekly by owner)

- `CLAUDE.md` + `rules/` (imports tree) — the always-loaded contract
- `settings.json` + `hooks/*.sh` — 14 live hook scripts
- `scripts/inventory.sh` / `validate.sh` / `analyze-usage.sh` + `Makefile`
- Canonical command set: `/plan`, `/ship`, `/audit-deep`, `/fix-root`, `/polish-ux`, `/pr-prep`, `/review`, `/debug`, `/test-gen`, `/start-task`, `/complete`
- Top-20 skills (jarvis-core, governance-gate, operating-framework, coding-workflow, moyu, prompt-reliability-engine, test-driven-development, git-workflows, security-review, api-design-patterns, python-quality-gate, n8n, council)
- Recipe runner: `recipes/engineering/*.yaml` + `recipes/sub/*.yaml` + `recipes/lib/recipe-runner.sh`

### 4.2 Demo zones (show off the system)

- `skills/hue/examples/*.html` — 19 brand demos, biggest single concrete artifact in the repo
- `skills/timesfm-forecasting/examples/**` — forecast animations with covariates
- `skills/market/*` — 15-command marketing suite
- `skills/skill-creator/eval-viewer/viewer.html` — eval-harness UI
- `skills/n8n/czlonkowski/evaluations/*.json` — 22 evaluation fixtures prove n8n skill works
- `docs/DEMO.md` — reproducible `/audit-deep → /fix-root → /ship` script (not yet recorded)

### 4.3 Positioning zones (make the public repo distinctive)

- `README.md` + `docs/ELITE-OPS-README.md` + `docs/ELITE-OPS-METHODOLOGY.md`
- **The "honest audit" cluster** — `docs/SURFACE-MAP.md` + `docs/OVERHEAD.md` + `docs/KB-STATUS.md` + `docs/COUNCIL-REMEDIATION.md` + this `AUDIT.md`. This is rare in public Claude Code setups and sellable.
- `docs/TELEMETRY.md` + `hooks/usage-logger.sh` + `scripts/analyze-usage.sh` — the measurement layer
- `evolution/` layer — controlled-self-evolution narrative
- `agents/REGISTRY.md` + `skills/jarvis-core/SKILL.md` + `skills/governance-gate/SKILL.md` — JARVIS-mirrored governance story

### 4.4 Extraction candidates (could be pulled as standalone products)

| Candidate | Scope | Self-contained? | Files |
|-----------|-------|-----------------|-------|
| **Elite Ops layer** | Owner-engineer execution posture | Yes | ~12 files: `skills/elite-ops/` + `docs/ELITE-OPS-*.md` + 5 commands |
| **Self-evolution layer** | Observe → record → evaluate → promote | Yes | ~25 files: `evolution/` + 5 skills + 3 agents + `/evolution` + 2 hooks |
| **/market suite** | Full marketing automation | Yes | ~22 files: `skills/market/` + 15 `market-*` + 5 agents |
| **Hue meta-skill** | Brand URL → design-language skill | Yes | 1 SKILL + 19 brand demos + references |
| **JARVIS-sec** | Autonomous security ecosystem | Yes | `skills/jarvis-sec/` + `/jarvis-sec` command |
| **JARVIS-Core governance** | 10-stage pipeline + 5-layer safety gate | Yes | `skills/{jarvis-core,governance-gate}/` + `agents/REGISTRY.md` |
| **React-bits catalog** | 130-component shadcn-CLI install | Yes | `skills/react-bits/` |
| **MCP-mastery** | 30-server catalog + task-to-MCP router | Yes | `skills/mcp-mastery/` + GAPS.md |
| **Anti-AI-slop filter** | Universal filter | Yes | `skills/anti-ai-writing/` |
| **n8n skill-set (czlonkowski)** | Automation with eval harness | Yes | `skills/n8n/` + LICENSE |

### 4.5 Experimental zones (clearly labeled, not touched in Phase 1)

| Zone | Files | What's promising | What's unvalidated |
|------|------:|------------------|-------------------|
| **Self-evolution layer** | ~17 + 5 skills + 3 agents | Explicit evidence gates, kill switch, schema-validated candidates | 2 session records, 0 promoted candidates, empty `candidates/`, `rejected/`, `reports/` |
| **KB (`kb/`)** | 10 | Schema clear, `/wiki-{ingest,query,lint}` wired, honesty doc labeled | 5 seed articles, `kb/raw/` and `kb/outputs/` empty |
| **Wave 1 agents (10 domains × intel/gen/loop)** | 126 | 3-stage taxonomy mirrors proven JARVIS-FRESH pattern | ~13-line stubs, no invoking command, dispatched only via REGISTRY dept-head expansion |
| **Wave 2 surface agents (5 products × 3 stages × 3 agents)** | 45 | Surface-aware routing concept | The 5 surfaces aren't actual products in this repo; 17-line parameterized templates |
| **MCP-gated skills** (aster-*, hermes-*, sim-studio, aidesigner-frontend) | ~8 | Real content; clear extraction path if MCPs land | Tier-3 MCPs not installed |
| **Autoresearch** | 2 | Good pattern — iterate, score, keep wins | One template only (aster-trading.md) |

---

## 5. Recommendations

### 5.1 Keep as-is

- All 14 hook scripts — cleanest layer in the repo, all references resolve
- All 13 recipes — typed YAML, no drift
- All 6 rules (path-scoped)
- Canonical commands (SURFACE-MAP's picks): `/plan`, `/ship`, `/audit-deep`, `/fix-root`, `/polish-ux`, `/council-review`, `/review`, `/debug`, `/test-gen`, `/pr-prep`, `/start-task`, `/complete`, `/wiki-{ingest,query,lint}`, `/evolution`
- Top-20 CORE skills (the actually-used set)
- Hue skill and 19 brand demos
- /market suite as a cohesive extraction product (but see 5.2 for dedupe within)
- The "honest audit" doc cluster (SURFACE-MAP, OVERHEAD, KB-STATUS, COUNCIL-REMEDIATION, this AUDIT) — retain and promote
- `scripts/inventory.sh` + `validate.sh` (and strengthen — see 5.5)
- `anti-ai-writing` (don't rename — 63 inbound)

### 5.2 Consolidate

**Skills merges (evidence-driven):**
- `frontend-design` → merge into `impeccable-design` (description is a literal duplicate)
- `ui-design-system` / `distilled-aesthetics` → relabel with orthogonal keyword gates or merge into `impeccable-design`
- `marketing-demand-acquisition` + `marketing-strategy-pmm` → merge into `/market` suite orchestration
- `market-brand` → merge into `brand-guidelines`
- `market-seo` → merge into `seo-audit`
- `cold-email` + `market-emails` → unify scope; one owns lifecycle, one owns cold outreach (explicitly)
- `competitive-intel` vs `market-competitors` → pick one canonical, delete or alias the other
- `skill-architect` + `skill-creator` → merge OR relabel one as "audit/measure" vs the other "scaffold"
- `understand-jarvis` + `understand-memory-sync` → consolidate into `understand-chat` and `understand` respectively (niche variants)

**Commands merges:**
- `/repo-review` → one-line redirect to `/audit-deep` (or delete)
- `interface-design-*` (5 commands) → consolidate into `/planUI` sub-flows
- Consider merging `/council-review` and `/council` (one is a 7-line alias)

**Docs consolidation (highest leverage):**
- `docs/CAPABILITIES_REPORT.md` → replace with a short pointer to `INVENTORY.md` + a narrative "why these tools" section. 1180 lines → ~80 lines.
- `docs/CLAUDE_CODE_ARCHITECTURE.md` → replace with a pointer to CLAUDE.md's "JARVIS-Mirrored Architecture" section + REGISTRY.md. 524 lines → ~40 lines.
- `docs/OPERATING_FRAMEWORK.md` → delete or redirect to `skills/operating-framework/SKILL.md`. 255 lines → 10 lines.
- `docs/ELITE-OPS-README.md` → merge into `docs/ELITE-OPS-METHODOLOGY.md` (they're near-duplicates).
- Add a `docs/INDEX.md` or strengthen README to link the 11 leaf docs so they stop being orphans.

### 5.3 Relocate

- The 5 extraction candidates (Elite Ops, self-evolution, /market, Hue, JARVIS-sec) are good candidates for Phase 1's `domains/` regrouping — but in-place is fine; what matters is making their boundaries obvious.
- Consider moving `docs/DATA_PLATFORM_GUIDE.md`, `docs/DEVOPS_TOOLKIT.md`, `docs/FINANCE_ML_STACK.md`, `docs/FRONTEND_PATTERNS.md`, `docs/SECURITY_PLAYBOOK.md`, `docs/RAG_LLM_REFERENCE.md` into `kb/wiki/` — they are reference content, not operating docs.
- `docs/LEARNING_ROADMAP.md` → fits `kb/wiki/` better than `docs/`.
- `docs/prompt-reliability-playbook.md` → already companion to a skill; move inside `skills/prompt-reliability-engine/references/`.

### 5.4 Archive (literal)

After this audit, **zero tracked files meet the "truly superseded" bar**. The two near-misses (`CAPABILITIES_REPORT.md`, `OPERATING_FRAMEWORK.md`) belong in CONSOLIDATE, not ARCHIVE — they carry narrative that isn't in INVENTORY.md.

If Phase 1 creates `skills/_archive/`, `commands/_archive/`, `agents/_archive/` conventions (referenced in SURFACE-MAP.md:48 but don't exist), the Wave-1/Wave-2 agent stubs become candidates once telemetry runs for 14+ days per TELEMETRY.md exit criteria.

### 5.5 Promote for visibility

Things the repo does well but buries:

- **The self-evolution layer** — the most distinctive engineering story in the repo. Deserves a README section of its own + a reproducible demo.
- **Hue meta-skill + 19 brand demos** — the most concrete capability demonstration. Link from README's "Proof" section with a gallery.
- **`scripts/validate.sh` + `make validate`** — drift detection that catches count-contradictions is unusual and sellable. Promote alongside the audit doc cluster.
- **The 13 recipes with typed YAML + `mcp-whitelist.json`** — recipe-first planning architecture. Under-advertised.
- **Elite Ops command set** (`/ship`, `/audit-deep`, `/fix-root`, `/polish-ux`, `/council-review`) — already in README but deserves a side-by-side vs stock Claude Code comparison.
- **`docs/COUNCIL-REMEDIATION.md` + this `AUDIT.md`** — showing "here's the criticism, here's the deterministic fix with verification" is the repo's best trust-building artifact.

---

## 6. First-wave fixes (before Phase 1 begins)

Low-effort, high-leverage fixes that should happen *before* restructuring into `domains/`. These are all the "non-structural" findings that would otherwise contaminate Phase 1 measurements.

| Priority | Fix | File(s) | Effort |
|---------:|-----|---------|-------:|
| 1 | Remove 5 fabricated `market-*` L6 agent citations in CLAUDE.md:235 | CLAUDE.md | 2 min |
| 2 | Reconcile CLAUDE.md:209 vs :259 (240/69 is correct) | CLAUDE.md | 2 min |
| 3 | Fix CLAUDE.md:262 hook count arithmetic | CLAUDE.md | 1 min |
| 4 | Rename `sequential` → `sequential-thinking` in 35 agent frontmatters | `agents/**/*.md` | sed-script, ~5 min |
| 5 | Annotate Tier-3 MCP mentions in REGISTRY.md (e.g., `postgres [T3]`) | `agents/REGISTRY.md` + `commands/plan.md` + `commands/ultraplan.md` + `commands/sc/*.md` | ~30 min |
| 6 | Update "197 skills / 237 agents" banners in `plan.md`, `ultraplan.md`, `ELITE-OPS-*.md`, `OVERHEAD.md`, `DEMO.md` | 5 files | ~15 min |
| 7 | Replace `CLAUDE_CODE_ARCHITECTURE.md` + `CAPABILITIES_REPORT.md` with pointers to INVENTORY.md + CLAUDE.md | 2 docs | ~20 min |
| 8 | Soften `commands/ultraplan.md` opener — remove "absorbs /plan entirely" | ultraplan.md | 5 min |
| 9 | Strengthen `scripts/validate.sh` to scan all tracked markdown for stale count patterns (not just CLAUDE.md + REGISTRY.md) | `scripts/validate.sh` | ~30 min |
| 10 | Fix `agents/debugger.md` skill binding (`debug` → `coding-workflow`) | 1 file | 2 min |
| 11 | Fix `/recall` references — either create `commands/recall.md` or update the 6 citations | ~6 files | ~15 min |

Expected total: ~2 hours of deterministic mechanical work. These are not "Phase 1" changes — they are the cleanup that makes Phase 1 measurement honest.

---

## 7. Strongest leverage clusters (summary)

If Phase 1–7 were to stall, the following minimum subset would preserve the repo's distinctive value:

1. `CLAUDE.md` + `rules/` + `settings.json` + `hooks/*.sh` + `scripts/*.sh` + `Makefile` — the operating kernel
2. `agents/REGISTRY.md` + top-20 core agents + `skills/{jarvis-core, governance-gate, operating-framework, elite-ops, moyu, prompt-reliability-engine, coding-workflow}/` — the governance/planning stack
3. Canonical command set (14 commands from SURFACE-MAP) — the verbs
4. `skills/hue/` + 19 demos + `skills/react-bits/` + `skills/mcp-mastery/` + `skills/market/` + 15 `market-*` — the extraction/demo surface
5. `evolution/` layer + `docs/TELEMETRY.md` + usage-logger hook — the self-improvement spine
6. The honest-audit doc cluster (`docs/SURFACE-MAP.md` + `docs/OVERHEAD.md` + `docs/KB-STATUS.md` + `docs/COUNCIL-REMEDIATION.md` + this `AUDIT.md`) — the trust-building surface
7. `docs/INVENTORY.md` (generated) + `scripts/inventory.sh` — the drift-prevention mechanism

Everything else is SUPPORTING, EXPERIMENTAL, or CONSOLIDATION material — valuable, but not load-bearing.

---

## 8. Pause — Phase 1 review gate

Per the original prompt: **this audit halts before Phase 1.**

Before proceeding to Phase 1 (Core Architecture), these questions need user decisions:

1. **Scope of the restructure** — does it land in the git repo (`~/Projects/claude-code-setup/`), the runtime (`~/.claude/`), or both? They drift: the repo has 3 agents and 1 command the runtime doesn't, and CLAUDE.md/README.md differ. Recommendation: land in the repo, re-sync to runtime once Phase 7 validates.
2. **First-wave fixes (§6) — apply them now, or bundle into Phase 1?** Applying first means Phase 1 works against a clean baseline; bundling means one less commit-cycle.
3. **Wave-1 + Wave-2 agents (171 files, ~17% of repo)** — keep as EXPERIMENTAL scaffolding in the `domains/` layout (labeled), or consolidate to one agent per department with a `stage` field? The latter preserves the narrative while cutting file count.
4. **Extraction candidates (§4.4)** — in Phase 1, should Elite Ops, self-evolution, Hue, `/market`, etc. live under `domains/` by functional domain, or under a top-level `products/` (or similar) directory that makes "extractable" status explicit?
5. **Target directory structure from Phase 1.1** — the prompt's outline has `engineering`, `finance`, `marketing` domains. The repo has no dedicated `finance/` surface yet (finance-tracker + finance-ml + financial-modeling + aster-* are present but scattered). Confirm `finance` is a first-class domain.
6. **Backup** — `~/.claude.backup.YYYYMMDD` per the prompt wasn't created this session. `~/.claude.backup/` exists from Apr 13 (4 days old) and `~/.claude.bak.20260413/` from the same date. Create a fresh timestamped backup before Phase 1 mutations? Recommended: yes.
7. **Telemetry window** — the original prompt's bigger-picture decisions ("prune zero-invocation surfaces") need 14+ days of `~/.claude/usage.jsonl` data, which hasn't started accruing. Phase 1–3 can proceed without it; Phase 6 pruning should wait for real data per the COUNCIL-REMEDIATION "deferred" list.

Answer the above before Phase 1, or say "proceed with your defaults."

# Phase 0.2 — Conflict, Overlap & Contradiction Audit

**Scope:** conflict/overlap/contradiction detection across `~/.claude/` repo. Does **not** duplicate classification (Phase 0.1) or cross-ref mapping (Phase 0.3).

**Method:** static analysis — grep over frontmatter, descriptions, count claims, and routing tables. Spot-checked; not exhaustive file reads.

**Baseline:** `docs/SURFACE-MAP.md` (canonical entrypoints) and `docs/COUNCIL-REMEDIATION.md` (prior findings) are treated as settled. Anything below is either (a) additional detail on a known cluster or (b) net-new.

---

## A. Overlapping Scopes

### A.1 — Frontend/UI design surfaces (extension of SURFACE-MAP)

SURFACE-MAP flags `impeccable-design` vs `frontend-design` vs `interface-design` vs `ui-ux-pro-max`. Below are additional members of the same cluster that SURFACE-MAP missed:

| Cluster member | File | One-line scope | Real distinction? |
|---|---|---|---|
| `impeccable-design` | skills/impeccable-design/SKILL.md | "distinctive, production-grade frontend interfaces" | **Canonical per SURFACE-MAP** |
| `frontend-design` | skills/frontend-design/SKILL.md | "distinctive, production-grade frontend interfaces with high design quality" — description is near-verbatim copy of impeccable-design | **No** — description line is a literal duplicate |
| `interface-design` | skills/interface-design/SKILL.md | "dashboards, admin panels, apps, tools" (NOT marketing) | Slight — scope carve-out ("not marketing"), but no keyword guard to enforce |
| `ui-ux-pro-max` | skills/ui-ux-pro-max/SKILL.md | 50 styles × 21 palettes × 50 font pairings catalog | Meaningful but overlaps triggering ("design", "build UI") |
| `ui-design-system` | skills/ui-design-system/SKILL.md | design tokens + component docs + handoff | Partial — tokens overlap impeccable-design's output |
| `distilled-aesthetics` | skills/distilled-aesthetics/SKILL.md | "frontend aesthetics enforcement" — bans AI-slop UI | Partial — prescriptive rules overlap impeccable-design's implicit taste |
| `baseline-ui` | skills/baseline-ui/SKILL.md | "animation durations, typography scale, accessibility" | **Yes** — pure validation, not generation. Good boundary. |
| `aidesigner-frontend` | skills/aidesigner-frontend/SKILL.md | MCP-backed "AI design engine" | Depends on an **auth-pending** MCP — see D.1 |
| `web-artifacts-builder` | skills/web-artifacts-builder/SKILL.md | "complex claude.ai HTML artifacts, shadcn/ui" | Narrow enough |
| `react-bits` | skills/react-bits/SKILL.md | Catalog + installer for 130 animated components | **Yes** (canonical per SURFACE-MAP) |
| `clone-website` | skills/clone-website/SKILL.md | "reverse-engineer and clone any website" | **Yes** — distinct input (URL) |
| `design-inspector` | skills/design-inspector/SKILL.md | "extract design tokens from a live website" | Partial — overlaps with `hue` Stage 1 and `clone-website` extraction step |

**Recommendation**: merge `frontend-design` into `impeccable-design` (description text is already duplicated). Relabel `interface-design` with explicit keyword gating ("dashboard", "admin", "tool UI" only). Keep `ui-ux-pro-max`, `baseline-ui`, `distilled-aesthetics` as complementary (catalog, validator, style-guide) **only if** trigger keywords are made orthogonal — current descriptions all fire on "design" / "build UI".

### A.2 — Polish surfaces

| Cluster member | File | Scope | Distinction? |
|---|---|---|---|
| `/polish-ux` | commands/polish-ux.md | microstates + copy + a11y + visual coherence | **Canonical per SURFACE-MAP** |
| `impeccable-polish` | skills/impeccable-polish/SKILL.md | "alignment, spacing, consistency, micro-detail" | Visual only — matches SURFACE-MAP's carve-out |
| `fixing-accessibility` | skills/fixing-accessibility/SKILL.md | ARIA + keyboard + contrast + WCAG | Subset of `/polish-ux` a11y branch |
| `fixing-metadata` | skills/fixing-metadata/SKILL.md | page titles, OG tags, canonical URLs | Narrow — no overlap |
| `fixing-motion-performance` | skills/fixing-motion-performance/SKILL.md | jank, compositor layer issues | Narrow — no overlap |

**Recommendation**: `/polish-ux` should explicitly dispatch to `fixing-accessibility`, `fixing-motion-performance`, `fixing-metadata`, and `impeccable-polish` as sub-steps. Currently they operate independently with overlapping trigger language.

### A.3 — Audit/review surfaces

| Cluster member | File | Scope |
|---|---|---|
| `/audit-deep` | commands/audit-deep.md | **Canonical** — 6-dim full-stack audit |
| `/repo-review` | commands/repo-review.md | project structure + code quality + deps + git + docs |
| `/setup-audit` | commands/setup-audit.md | `~/.claude/` health check specifically |
| `/review` | commands/review.md | diff code review |
| `/sc:analyze` | commands/sc/analyze.md | "quality, security, performance, architecture" |
| `/security-audit` | commands/security-audit.md | security only |
| `/council-review` | commands/council-review.md | multi-perspective before-build review |
| `impeccable-audit` | skills/impeccable-audit/SKILL.md | a11y + perf + theming + responsive + anti-patterns |
| `interface-design-audit` | commands/interface-design-audit.md | interface code vs design system |
| `context-budget-audit` | skills/context-budget-audit/SKILL.md | token overhead measurement |

**Real distinction?** `/setup-audit`, `/security-audit`, `context-budget-audit`, `interface-design-audit` — **yes**. `/audit-deep` vs `/repo-review` vs `/sc:analyze` — **no**, three different doors to the same room. SURFACE-MAP already names `/audit-deep` canonical; recommendation is to add a one-line redirect at the top of `repo-review.md` and `sc/analyze.md` pointing to it.

### A.4 — "Understand" skill family

`understand`, `understand-chat`, `understand-dashboard`, `understand-diff`, `understand-explain`, `understand-jarvis`, `understand-memory-sync`, `understand-onboard`, `understand-setup` — nine skills. All share the knowledge-graph subsystem.

**Real distinction?** Yes — they are a CLI-like surface (subcommand pattern). No overlap after inspection. **Keep as-is.** But mention in SURFACE-MAP that this is a family, not overlap, so future audits don't flag it.

### A.5 — Marketing skills (net-new cluster not in SURFACE-MAP)

Two parallel marketing stacks exist:

| Stack 1 (`market-*` BMAD-like suite) | Stack 2 (`ad-*` Eddie-inspired) |
|---|---|
| `market` (orchestrator) | `ad-research` |
| `market-ads` | `ad-script-generator` |
| `market-audit` | `ad-performance-loop` |
| `market-brand` | |
| `market-competitors` | |
| `market-copy` | |
| `market-emails` | |
| `market-funnel` | |
| `market-landing` | |
| `market-launch` | |
| `market-proposal` | |
| `market-report` | |
| `market-report-pdf` | |
| `market-scanner` | |
| `market-seo` | |
| `market-social` | |

Plus: `marketing-demand-acquisition`, `marketing-strategy-pmm`, `competitive-intel`, `content-strategy`, `cold-email`, `brand-guidelines`, `seo-audit`, `cmo-advisor`.

**Overlap:**
- `market-ads` ↔ `ad-script-generator` ↔ `market-copy` — all generate ad/copy variations
- `market-competitors` ↔ `competitive-intel` ↔ `ad-research` — all do competitor scraping/intel
- `market-brand` ↔ `brand-guidelines` ↔ `hue` — all define brand tokens/voice
- `market-emails` ↔ `cold-email` — email copy
- `market-seo` ↔ `seo-audit` — SEO teardown
- `cmo-advisor` ↔ `marketing-strategy-pmm` ↔ `market` — high-level marketing strategy

**Verdict:** **Real mess, not in SURFACE-MAP.** The `market-*` suite (16 skills) and `ad-*` suite (3 skills) appear to be imported from two different upstreams and never reconciled. Without routing, the model will pick arbitrarily on "write me ad copy" / "audit my marketing".

**Recommendation**: add a MARKETING-MAP.md section to SURFACE-MAP with canonical picks (proposed: `/market` as orchestrator, keep `ad-*` only if distinct scope; merge `market-brand` into `brand-guidelines`; merge `market-seo` into `seo-audit`).

### A.6 — CXO advisor cluster

`ceo-advisor`, `cto-advisor`, `cfo-advisor`, `cmo-advisor`, `ciso-advisor`, `coo-advisor`, `cpo-advisor` — 7 "advisor" skills. Plus `business-panel-experts` (L1 agent), `council` skill.

**Distinction?** CXO advisors = single-perspective deep domain view. `council` = 5-advisor adversarial review. `business-panel-experts` = L1 agent that wraps CXO skills. **Legitimate hierarchy, but** `business-panel-experts` agent binds to `ceo-advisor, cto-advisor, cfo-advisor, competitive-intel, market-scanner, paperclip` skills (only 3 of 7 CXOs). Rest are orphaned from the agent layer.

**Recommendation**: either bind all 7 CXO skills to `business-panel-experts`, or document why only 3 are promoted.

### A.7 — Skill-creation meta-skills

| Skill | Role |
|---|---|
| `skill-architect` | "Build, validate, improve skills. Design-first workflow with YAML frontmatter validation, progressive disclosure" |
| `skill-creator` | "Create new skills, modify existing, measure performance" |
| `skill-evolution` | "Self-evolving skill lifecycle with three triggers: post-execution fix, degradation detection, periodic metric review" |
| `/skill-design` command | "Guide user through designing and creating a new skill" |
| `hue` | Generates **design-language** skills specifically |
| `mcp-builder` | Generates **MCP server** code specifically |

**Distinction?** `skill-architect` vs `skill-creator` — no clear boundary from descriptions. Both "create/modify/improve skills". `skill-evolution` is lifecycle-focused (distinct). `/skill-design` is the user-facing command. `hue` and `mcp-builder` are domain-specific (distinct).

**Recommendation**: merge `skill-architect` and `skill-creator` or relabel one as "audit/measure" vs "scaffold".

### A.8 — Agents with similar review responsibility

| Agent | Skills | Overlap |
|---|---|---|
| `code-reviewer` (L6) | receiving-code-review, python-quality-gate, security-review | Reviews code quality + security |
| `security-auditor` (L3) | security-review, infrastructure-scanning, osint-recon | Reviews security |
| `security-engineer` (L2) | security-review, infrastructure-scanning, container-security, offensive-security, threat-intelligence-feed | Reviews security + leads strategy |
| `self-review` (L0) | verification-before-completion, coding-workflow | Reviews outputs for completion |
| `quality-engineer` (L2) | testing-methodology, property-based-testing, api-testing-suite, webapp-testing, test-gap-analyzer | Reviews test coverage |
| `refactorer` (L6) | python-quality-gate | Reviews for refactor opportunity |

**Distinction?** Authority-tier-based. But all three security agents share `security-review` skill. That's a functional overlap — picking between security-auditor vs security-engineer is ambiguous for anything smaller than a program.

**Recommendation**: keep as-is (hierarchy is intentional) but add a single-line pick rule to REGISTRY.md: "single finding → security-auditor; program design → security-engineer; program strategy + CISO reporting → ciso-advisor".

### A.9 — Doc duplication cluster (large)

| Doc | Lines | Scope |
|---|---|---|
| `docs/CLAUDE_CODE_ARCHITECTURE.md` | ~500 | "Directory tree, MCP, agents, commands, skills, hooks, memory, projects" |
| `docs/CLAUDE_CODE_ECOSYSTEM.md` | ~200 | "Tool deep dives, MCP reference, community patterns" |
| `docs/CAPABILITIES_REPORT.md` | ~? | "Environment at a glance, end-to-end scenario" |
| `docs/ELITE-OPS-README.md` | ~100 | Install guide for elite-ops |
| `docs/ELITE-OPS-METHODOLOGY.md` | ~200 | Same content, different framing |
| `CLAUDE.md` § "JARVIS-Mirrored Architecture" + § "Capabilities Summary" | inline | Same inventory, different counts |
| `README.md` § "What's real today" | inline | Same inventory, tier-labeled |
| `docs/INVENTORY.md` | generated | Same inventory, correct numbers |

**Distinction?** INVENTORY.md is the only generated + correct source. The rest are hand-maintained and contradict each other (see B.1).

**Recommendation**: archive `docs/CLAUDE_CODE_ARCHITECTURE.md`, `docs/CAPABILITIES_REPORT.md`, and `docs/ELITE-OPS-README.md` (dupe of METHODOLOGY). Replace content with a single-line pointer to INVENTORY.md.

---

## B. Contradictory Rules / Conflicting Routing Authorities

### B.1 — Count contradictions within CLAUDE.md itself

| Line | Claim | Correct (per INVENTORY) |
|---|---|---|
| CLAUDE.md:209 | "237 total: 66 core + 126 Wave 1 + 45 Wave 2" | 240 / 69 / 126 / 45 |
| CLAUDE.md:218 | "Authority Hierarchy (66 agents, 7 levels)" | 69 (self-evolution trio added) |
| CLAUDE.md:235 | "L6 Workers (13)" | REGISTRY.md:16 says **L6 Workers (8)** |
| CLAUDE.md:259 | "240 agents — 69 core" | Correct |

**Severity:** lines 209 and 259 of the same file contradict each other. `make validate` apparently does not catch this (passed after the d753627 commit that "reconciled" counts).

### B.2 — Count contradictions across files

| File | Claim |
|---|---|
| `CLAUDE.md:209` | 237 total agents |
| `CLAUDE.md:259` | 240 agents |
| `commands/plan.md:129` | "237 total agents" |
| `commands/ultraplan.md:5` | "237 agents, 197 skills" |
| `commands/ultraplan.md:276` | "Full Skill Governance (197 skills)" |
| `docs/ELITE-OPS-METHODOLOGY.md:5` | "197 skills, 83 commands, 239 agent definitions" |
| `docs/ELITE-OPS-README.md:4` | "197-skill, 239-agent-definition setup" |
| `docs/ELITE-OPS-README.md:64` | "197 skills (includes elite-ops)" |
| `docs/OVERHEAD.md:15` | "197 SKILL.md files" |
| `docs/OVERHEAD.md:27` | "197 skills × ~140 chars" |
| `docs/DEMO.md:49` | "197 skills, 239 agents" |
| `docs/CLAUDE_CODE_ARCHITECTURE.md:14-16` | **40 agents / 56 commands / 34 skills** (2026-03-15) |
| `docs/CAPABILITIES_REPORT.md:21-23` | **40 agents / 43 skills / 56 commands** (2026-03-15) |
| `docs/INVENTORY.md` (generated) | **240 agents / 202 skills / 84 commands / 242 agent-files** |
| `agents/REGISTRY.md:3` | "240 agents" ✓ |
| `README.md` | avoids specific numbers — defers to CLAUDE.md Tier 1 / INVENTORY |

**Severity: critical.** COUNCIL-REMEDIATION row 1 claims counts were reconciled, but plan.md, ultraplan.md, ELITE-OPS-\*, OVERHEAD.md, DEMO.md, CLAUDE_CODE_ARCHITECTURE.md, CAPABILITIES_REPORT.md all still carry stale numbers. `make validate` either doesn't check these files or its anti-regression patterns are incomplete.

### B.3 — Planning authority contradiction

| File | Claim |
|---|---|
| `CLAUDE.md:270-278` | "/plan is the 10-stage default. /ultraplan for enterprise-complexity." |
| `SURFACE-MAP.md:10` | "/plan is the 10-stage governed default. Use /ultraplan only for enterprise-risk." |
| `README.md:25` | "/plan is canonical (/ultraplan for enterprise-risk only). Pick one." |
| `commands/ultraplan.md:9` | "**ULTRAPLAN absorbs /plan entirely.** Every stage of /plan is present here, elevated." |

Ultraplan's "absorbs /plan entirely" creates a de-facto-always-use-ultraplan message that contradicts the "enterprise-risk only" guidance. A user reading ultraplan.md directly would reasonably conclude: "if it absorbs /plan, why not always use it?"

**Recommendation**: soften ultraplan.md opening to "extends /plan for enterprise-risk work" and remove "absorbs entirely" framing.

### B.4 — L6 Worker count mismatch: REGISTRY vs CLAUDE.md

| Source | L6 count |
|---|---|
| `CLAUDE.md:235` | 13 (includes market-content, market-conversion, market-competitive, market-technical, market-strategy) |
| `agents/REGISTRY.md:16` | 8 (tester, debugger, refactorer, documenter, code-reviewer, technical-writer, api-tester, test-results-analyzer) |

CLAUDE.md claims 5 `market-*` workers at L6, but REGISTRY.md lists only 8 total workers with **none of them market-***. The 5 `market-*` entries in CLAUDE.md do not exist as agent files in `agents/`.

**Severity: high — fabrication risk.** CLAUDE.md cites agents that do not exist.

### B.5 — MCP routing to uninstalled servers

Per CLAUDE.md Tier 3, **~20 MCP servers are aspirational** (not installed): `context7`, `github`, `playwright`, `puppeteer`, `postgres`, `notion`, `slack`, `stripe`, `brave-search`, `tavily`, `google-maps`, `docker`, `kubernetes`, `terraform`, `aster`, `obsidian`, `sim-studio`, `hermes`, `penpot`, `aidesigner`.

However:

- `agents/REGISTRY.md` binds agents to every one of these as if they were available
  - e.g. `backend-architect` → `postgres, context7` (Tier 3)
  - `frontend-architect` → `playwright, penpot, context7, aidesigner` (Tier 3)
  - `devops-architect` → `terraform, kubernetes, docker` (Tier 3)
  - `data-analyst` → `postgres, aster` (Tier 3)
  - `growth-marketer` → `brave-search, tavily, slack` (Tier 3)
  - `finance-tracker` → `aster` (Tier 3)
- `commands/plan.md:58,206,207,328` — routes to `brave-search`, `tavily`, `context7`, `playwright`, `aster`, `stripe`, `k8s`, `terraform`, `slack`, `postgres`, `docker`
- `commands/ultraplan.md:34,108,186` — routes to `obsidian`, `context7`, `postgres`
- `commands/sc/pm.md`, `sc/research.md`, `sc/brainstorm.md`, `sc/task.md` frontmatter lists `tavily, context7, magic, playwright, morphllm, serena` — none connected

**Severity: critical.** The operating contract (CLAUDE.md) warns "Do not assume access to auth-pending or aspirational servers — they are not connected unless `claude mcp list` says so." But the registry, plan, ultraplan, and SuperClaude commands all assume access. The `mcp-security-gate.sh` hook will block these at runtime, but the routing docs still point there.

**Recommendation**: annotate Tier-3 MCP mentions in REGISTRY.md with an `[aspirational]` tag or add a capability-check stage to plan/ultraplan.

### B.6 — ELITE-OPS duplication contradiction

`docs/ELITE-OPS-METHODOLOGY.md:43-55` says: *"Step 2: Append identity layer to CLAUDE.md"* and gives the exact `## Execution Posture` block to paste.

CLAUDE.md:10-14 **already contains** a nearly-identical `### Execution Posture` block (slightly different wording). METHODOLOGY.md presents this as a pending install step.

**Verdict**: METHODOLOGY.md's install instructions are stale — they describe a state that already happened. Either the install is complete and the doc should say so, or it's partial and CLAUDE.md lines 10-14 were added by another path.

### B.7 — "Agents: `66 core`" vs "Agents: `69 core`" (self-evolution trio)

- `CLAUDE.md:209` → "66 core"
- `CLAUDE.md:218` → "Authority Hierarchy (66 agents, 7 levels)"
- `CLAUDE.md:259` → "69 core (L0-L6 + self-evolution trio)"
- `REGISTRY.md` → authority table lists 5+3+10+18+8+9+8 = **61 agents** in L0-L6 tables (not 66 or 69)
- `docs/INVENTORY.md` → "69 core (L0–L6)"

The 66 vs 69 vs 61 spread suggests the self-evolution trio was added without updating all three authority-count callouts. REGISTRY.md's underlying tables haven't been updated to add the trio at all.

---

## C. Duplicated Triggers

Keywords that fire 3+ skills (observed from description grep):

| Trigger keyword | Skills that claim it | Suggested resolution |
|---|---|---|
| "design" / "build UI" / "web components" | `impeccable-design`, `frontend-design`, `interface-design`, `ui-ux-pro-max`, `ui-design-system`, `hue`, `web-artifacts-builder`, `react-bits`, `distilled-aesthetics`, `aidesigner-frontend` | See A.1 — SURFACE-MAP covers partially. Canonical is `impeccable-design`; add orthogonal keyword guards to the rest. |
| "audit" | `/audit-deep`, `/repo-review`, `/setup-audit`, `/security-audit`, `/sc:analyze`, `impeccable-audit`, `market-audit`, `seo-audit`, `context-budget-audit`, `interface-design-audit` | Narrow by domain noun ("security audit", "setup audit", "marketing audit") vs bare "audit" → route to `/audit-deep`. |
| "review" | `/review`, `/council-review`, `/sc:analyze`, `code-reviewer` agent, `self-review` agent, `receiving-code-review` skill, `repo-review` | Bare "review" → `/review`. "Council review" / "pressure-test" → `/council-review`. |
| "polish" | `/polish-ux`, `impeccable-polish` | Already scoped per SURFACE-MAP. |
| "competitor" / "competitive" | `competitive-intel`, `market-competitors`, `ad-research`, `strategy-gen-battlecard-writer`, `product-intel-competitor-tracker`, `trend-researcher` | Canonical: `competitive-intel` for general analysis; delete or merge `market-competitors`. |
| "brand" | `brand-guidelines`, `market-brand`, `hue`, `ad-script-generator` | `brand-guidelines` for rules; `hue` for new brand design-language generation. Merge `market-brand` into `brand-guidelines`. |
| "SEO" | `seo-audit`, `market-seo`, `content-strategy`, `growth-intel-landing-analyzer` | Canonical: `seo-audit`. Merge `market-seo` in. |
| "ad" / "ad script" / "ad copy" | `ad-research`, `ad-script-generator`, `ad-performance-loop`, `market-ads`, `market-copy`, `growth-gen-copy-writer`, `growth-gen-hook-generator` | Three parallel stacks. No canonical declared. |
| "experiment" / "A/B test" | `ab-test-setup`, `experiment-designer`, `experiment-tracker` (agent), `product-gen-experiment-designer-agent` | `ab-test-setup` for setup; `experiment-designer` for planning; `experiment-tracker` agent for tracking. Three is justified but descriptions don't differentiate. |
| "email" | `cold-email`, `market-emails`, `ciso-advisor` (incidental), `brand-guidelines` (incidental) | `cold-email` vs `market-emails` overlap — `cold-email` explicitly states "NOT for lifecycle emails", implying `market-emails` owns lifecycle. But `market-emails` description doesn't say so. Add reciprocal guard. |
| "create a skill" / "new skill" | `skill-creator`, `skill-architect`, `/skill-design` command | See A.7 — merge. |
| "plan" | `/plan`, `/ultraplan`, `/planUI`, `/spec`, `bmad:tech-spec`, `bmad:prd`, `sc:workflow` | Already flagged in SURFACE-MAP. |
| "security" audit/review | `/security-audit`, `security-review` skill, `/sc:analyze --security`, `security-auditor` agent, `security-engineer` agent, `ciso-advisor`, `jarvis-sec` | Tier by risk: small diff → `/review`; repo pass → `/security-audit`; strategy → `ciso-advisor`. Document in SURFACE-MAP. |
| "research" | `/sc:research`, `bmad:research`, `deep-research` agent, `research-methodology` skill, `paper-scanner`, `research-intel-*` (10 agents) | Canonical: `deep-research` agent. `/sc:research` and `bmad:research` compete for the same verb. |
| "understand" | `understand`, `understand-chat`, 7 other `understand-*` skills | Family pattern — OK; see A.4. |

---

## D. Stale or Misleading References

### D.1 — `aidesigner-frontend` skill references auth-pending/aspirational MCP

Skill description (skills/aidesigner-frontend/SKILL.md): *"AI design engine via MCP. Generates production-ready inline-Tailwind HTML from natural language prompts with full repo context."*

`aidesigner` MCP is Tier 3 (aspirational) per CLAUDE.md:183. The skill exists but has no backing. Either install the MCP or remove the skill.

### D.2 — `aster-trading`, `aster-timesfm-pipeline` reference Tier-3 MCP

Both skills require `aster` MCP (Tier 3). `finance-tracker` and `data-analyst` agents bind to `aster`. No installation path.

### D.3 — `sim-studio`, `hermes-integration`, `paperclip`, `paperclip-create-*` skills reference Tier-3 MCPs

Skills exist. MCPs do not. `pm-agent` and `ai-engineer` bind to `hermes`.

### D.4 — "Last verified 2026-04-17" in CLAUDE.md MCP section

No script regenerates that date. CLAUDE.md:137 says: *"Live status: `claude mcp list`. This table is hand-maintained; regenerate counts via `scripts/inventory.sh`."*

`scripts/inventory.sh` updates `docs/INVENTORY.md`, not CLAUDE.md. The "verified" date is a bare assertion without backing.

### D.5 — `docs/CLAUDE_CODE_ARCHITECTURE.md` is frozen at 2026-03-15

- "40 agents (13 custom + 20 SuperClaude + 6 domain + 1 installer)" — was true a month ago
- "56 commands (10 custom + 31 SuperClaude + 15 BMAD)" — was true a month ago
- "34 skill directories" — was true a month ago
- "3 hooks" — was true a month ago

Current: 240 / 84 / 202 / 18. This file is a time bomb — anyone reading it in isolation will get a wildly wrong mental model.

### D.6 — `docs/CAPABILITIES_REPORT.md` same issue

Same stale counts (40/43/56/3) and specific MCP claims ("penpot, memory, filesystem, sequential, github, context7, docker, aster" — six of these are now Tier 3).

### D.7 — `docs/ELITE-OPS-README.md` / `ELITE-OPS-METHODOLOGY.md` stale counts

"197-skill, 239-agent-definition setup" — current is 202 / 242. And "83 commands" is now 84.

### D.8 — `docs/OVERHEAD.md:15,27` stale counts

"197 SKILL.md files" — current is 202. The token math downstream is off by ~2.5%.

### D.9 — `docs/DEMO.md:49` stale counts

"197 skills, 239 agents" — current is 202 / 240 real agents.

### D.10 — `commands/plan.md`, `commands/ultraplan.md` stale count banners

Ultraplan.md opening: *"All 237 agents, 197 skills, 8 connected MCP servers"* — stale at both counts.

### D.11 — Tier 2 "auth pending" drift

`google-calendar`, `google-drive` flagged auth-pending. No scripted re-auth check. User has to remember.

### D.12 — `CLAUDE.md:262` "**18 hook entries** (10 scripts + 7 inline"

Math: 10 + 7 = 17, not 18. Off-by-one. `INVENTORY.md:18` says "Hook entries (total) | 21 | ... 7 are inline commands" — counts don't reconcile. This is the kind of thing `make validate` should catch.

---

## E. Multiple Routing Authorities

### E.1 — "The pipeline" — who owns it?

| File | Claim |
|---|---|
| `CLAUDE.md:205-253` | Describes 10-stage governed pipeline (SANITIZE → DELIVER) as "JARVIS-Mirrored Architecture" |
| `CLAUDE.md:270-308` | "Planning & Autonomous Execution Protocol (MANDATORY)" — 13 numbered steps |
| `commands/plan.md` | **10-stage** pipeline, authoritative for /plan |
| `commands/ultraplan.md` | **15-stage** pipeline, authoritative for /ultraplan, claims "absorbs /plan entirely" |
| `skills/jarvis-core/SKILL.md` | "10-stage governed orchestration pipeline mirroring JARVIS-FRESH CoreMind" |
| `docs/ELITE-OPS-METHODOLOGY.md:63-81` | Describes pipeline with slightly different stage names: "SANITIZE → PARSE → POLICY GATE → GOAL → PLAN → POLICY GATE → DELEGATE → EXECUTE → REFLECT → TRACK → WORLD STATE → VALIDATE → DELIVER" (13 stages, not 10) |
| `skills/governance-gate/SKILL.md` | Policy-gate component of the pipeline, but written as if standalone |
| `skills/operating-framework/SKILL.md` | "KhaledPowers Ultimate Operating Framework v1.0" — another pipeline overlay |
| `docs/OPERATING_FRAMEWORK.md` | Reference doc for operating-framework skill |

**Count of "the pipeline" authorities:** 9 locations. **Stages disagree:** 10 (plan, jarvis-core, CLAUDE.md-section1) vs 13 (ELITE-OPS) vs 15 (ultraplan) vs "13 numbered steps" (CLAUDE.md protocol section) vs "KhaledPowers framework" (operating-framework).

**Recommendation**: declare one source of truth (jarvis-core SKILL.md is the obvious pick — it's an L0 skill). All other pipeline descriptions should defer to it.

### E.2 — "Governance" — who owns it?

| File | Scope |
|---|---|
| `skills/governance-gate/SKILL.md` | "5 safety layers, 7 policy constraints, 4 escalation tiers" — the mechanical enforcer |
| `skills/operating-framework/SKILL.md` | "KhaledPowers Ultimate Operating Framework" — behavioral rules |
| `docs/OPERATING_FRAMEWORK.md` | Reference for operating-framework |
| `CLAUDE.md § Non-Negotiables` (lines 40-53) | 11 hard rules |
| `CLAUDE.md § Operating Philosophy` (lines 54-68) | 13 rules |
| `CLAUDE.md § Constitution (SEC-001)` (lines 248-253) | 5 constitution rules |
| `agents/REGISTRY.md § Constitution Rules` (bottom) | 5 SEC-001 equivalent rules (duplicate of above) |
| `rules/implementation.md` | Implementation-specific rules |
| `rules/security.md` | Security-specific rules (not read in this audit — assumed analogous) |
| `rules/python.md`, `rules/typescript.md`, `rules/testing.md`, `rules/infrastructure.md` | Lang/domain rules |
| `hooks/mcp-security-gate.sh` | Runtime governance for MCP calls |
| `hooks/sensitive-file-block.sh` (referenced via settings.json) | Runtime governance for file writes |
| `council-reports/*.html` | Retrospective governance output |
| `evolution/stable/global.md` | Self-evolution governance — injected at SessionStart |

**Total governance surfaces:** 14. Many overlap:
- `CLAUDE.md § Constitution` and `REGISTRY.md § Constitution` are the same 5 rules, stated twice.
- `CLAUDE.md § Non-Negotiables` (11 items), `§ Operating Philosophy` (13 items), `rules/implementation.md` are three parallel doctrinal lists with overlapping content (e.g., "no TODO markers" is in both NonNegs #10 and implementation.md).
- `governance-gate` skill and `operating-framework` skill both describe "governance" but at different levels (policy vs behavior).

**Recommendation**: rename `operating-framework` → "operating-doctrine" to disambiguate from `governance-gate`. Deduplicate CLAUDE.md §Constitution and REGISTRY.md §Constitution — keep one, reference from the other.

### E.3 — Planning protocol stated 3 times

`CLAUDE.md:270-308` restates the 13-step planning protocol that `commands/plan.md` already owns. The two are ~80% overlapping but not identical (CLAUDE.md adds "parallelize with limits — max 3 background agents", `plan.md` does not — see plan.md:80ish for concurrency rules). A reader following CLAUDE.md gets a slightly different protocol than the one following /plan.

---

## Severity Ranking — Top 10 Conflicts by User Impact

| # | Conflict | Type | Impact |
|---|---|---|---|
| 1 | **B.4** — CLAUDE.md cites 5 `market-*` L6 agents that don't exist | Fabrication | Breaks every attempt to delegate to those agents |
| 2 | **B.5** — REGISTRY + plan + ultraplan route to Tier-3 MCPs as if connected | Operational | Plans will cite tools that will be blocked at runtime; user debugs "why won't this run" |
| 3 | **B.1–B.2** — Counts contradict across 10+ files despite council-remediation | Trust | Any reader sees the codebase is inconsistent with its own self-description |
| 4 | **B.3** — `/ultraplan` says "absorbs /plan entirely" while CLAUDE.md says "use /plan by default" | Routing | User defaults to /ultraplan and burns enterprise-stage context for simple tasks |
| 5 | **D.5–D.6** — `CLAUDE_CODE_ARCHITECTURE.md`, `CAPABILITIES_REPORT.md` frozen at 2026-03-15 | Misleading | 4-week-stale doc with wildly wrong counts is still linked from docs/ |
| 6 | **A.5** — Marketing: 16 `market-*` + 3 `ad-*` + 5 legacy marketing skills, no canonical | Operational confusion | "Write ad copy" routes to arbitrary skill |
| 7 | **A.1** — Design skills overlap (11 members) with partial SURFACE-MAP coverage | Duplicated effort | User and model both pick differently each session |
| 8 | **E.1** — "The pipeline" declared in 9 files with 10/13/15-stage variants | Operational confusion | No single answer to "what's the pipeline?" |
| 9 | **A.9** — 8 overview/architecture docs, only INVENTORY is generated | Stale-drift | Hand-maintained docs guarantee future drift |
| 10 | **B.6** — ELITE-OPS-METHODOLOGY.md install instructions are stale; CLAUDE.md already has them | Misleading | Reader follows install steps that rewrite what's already correct |

---

## Already-Addressed Conflicts (Point to SURFACE-MAP / COUNCIL-REMEDIATION)

These are flagged elsewhere — this audit only extends them:

| Conflict | Flagged in | This audit's addition |
|---|---|---|
| `impeccable-design` vs `frontend-design` vs `interface-design` vs `ui-ux-pro-max` | SURFACE-MAP "Frontend design" row | A.1 adds 7 more cluster members (distilled-aesthetics, ui-design-system, baseline-ui, aidesigner-frontend, web-artifacts-builder, design-inspector, clone-website) |
| `/plan` vs `/ultraplan` vs `/planUI` vs `/spec` | SURFACE-MAP "Plan before building" | B.3 adds the ultraplan-self-contradiction ("absorbs /plan") |
| `/audit-deep` vs `/sc:analyze` vs `/repo-review` vs `/setup-audit` | SURFACE-MAP "Full-stack audit" | A.3 confirms + adds `impeccable-audit`, `interface-design-audit`, `context-budget-audit` |
| `/polish-ux` vs `impeccable-polish` | SURFACE-MAP "Tighten UX" | A.2 adds `fixing-accessibility`, `fixing-metadata`, `fixing-motion-performance` as sub-overlaps |
| Count drift (282/195/171 claimed, 237/197/126 actual) | COUNCIL-REMEDIATION row 1 | B.1, B.2, D.5–D.10 — the remediation did not stick; new counts (240/202) are still wrong in 10+ files |
| Aspirational MCP mixed with connected | COUNCIL-REMEDIATION row 5 | B.5, D.1–D.3 — the CLAUDE.md table is now tiered, but **REGISTRY.md, plan.md, ultraplan.md, sc/*.md still route to Tier-3 as if connected** |
| Overlapping surfaces not rationalized | COUNCIL-REMEDIATION row 7 | A.5 (marketing), A.6 (CXO), A.7 (skill meta), A.8 (review agents) — net-new clusters |
| No setup lint / drift detection | COUNCIL-REMEDIATION row 8 | D.12 — `make validate` missed the `10 + 7 = 17 ≠ 18` off-by-one, and B.1–B.2 show it missed the count propagation to non-CLAUDE.md files |

---

## Net-New Conflicts (Not in SURFACE-MAP or COUNCIL-REMEDIATION)

| # | Conflict | Category |
|---|---|---|
| N1 | B.4 — CLAUDE.md cites 5 `market-*` L6 workers that are not agent files | Fabrication |
| N2 | B.5 — REGISTRY.md binds agents to Tier-3 MCPs contradicting CLAUDE.md Tier-3 warning | Routing |
| N3 | B.1 — CLAUDE.md internally contradicts (line 209 vs 259) | Self-contradiction |
| N4 | B.4 — CLAUDE.md L6 count (13) ≠ REGISTRY L6 count (8) | Self-contradiction |
| N5 | A.5 — Marketing suite (16 market-\* + 3 ad-\* + 5 legacy) has zero canonical routing | Overlap |
| N6 | A.6 — `business-panel-experts` only binds 3 of 7 CXO advisors | Incomplete wiring |
| N7 | A.7 — `skill-architect` vs `skill-creator` have near-identical descriptions | Overlap |
| N8 | E.1 — 9 authorities describe "the pipeline" with 10/13/15 stage variants | Routing |
| N9 | E.2 — 14 governance surfaces, many overlapping (CLAUDE.md Constitution duplicated in REGISTRY.md) | Routing |
| N10 | E.3 — CLAUDE.md restates the planning protocol differently from plan.md | Routing |
| N11 | D.5, D.6 — `CLAUDE_CODE_ARCHITECTURE.md` and `CAPABILITIES_REPORT.md` frozen at 2026-03-15 | Stale |
| N12 | D.11 — Tier-2 "auth pending" has no scripted check | Stale |
| N13 | D.12 — `CLAUDE.md:262` "18 hook entries (10 scripts + 7 inline)" — 10+7≠18 | Arithmetic |
| N14 | B.6 — ELITE-OPS-METHODOLOGY.md install instructions are for a state that already exists | Stale |
| N15 | D.1 — `aidesigner-frontend` skill has Tier-3 MCP dependency with no install path | Dead skill |
| N16 | A.3 — `/repo-review` and `/sc:analyze` have no redirect to canonical `/audit-deep` | Overlap |
| N17 | A.2 — `/polish-ux`, `fixing-accessibility`, `fixing-motion-performance`, `fixing-metadata`, `impeccable-polish` all fire on "polish" / "fix UX" without orchestration | Overlap |
| N18 | B.7 — "66 core" vs "69 core" vs "61 in REGISTRY table" | Self-contradiction |
| N19 | A.4 — `understand-*` family (9 skills) is a CLI-subcommand pattern, not overlap — but it's not documented as such anywhere | Undocumented pattern |
| N20 | A.8 — Three security agents (security-auditor L3, security-engineer L2, ciso-advisor skill) with overlapping `security-review` skill and no pick rule | Overlap |

---

## Recommended First-Wave Fixes (ordered by leverage per minute of work)

1. **Fix CLAUDE.md line 209** to match line 259 (240 total, not 237). 1-line edit. Closes N3.
2. **Fix CLAUDE.md line 235** L6 list — remove the 5 `market-*` phantoms. Closes N1, N4.
3. **Fix CLAUDE.md line 262** off-by-one in hook count. Closes N13.
4. **Replace `docs/CLAUDE_CODE_ARCHITECTURE.md` and `docs/CAPABILITIES_REPORT.md`** with a single-line pointer to `INVENTORY.md`. Closes N11.
5. **Update plan.md, ultraplan.md, ELITE-OPS-*, OVERHEAD.md, DEMO.md** count banners to match INVENTORY.md. Add these to `make validate` file list. Closes count-drift residual.
6. **Annotate Tier-3 MCP mentions in REGISTRY.md** (e.g., `postgres [aspirational]`). Closes N2.
7. **Soften ultraplan.md opener** — remove "absorbs /plan entirely", replace with "extends /plan for enterprise-risk work". Closes severity #4.
8. **Declare `jarvis-core` SKILL.md as the single pipeline source of truth**, have other files link to it. Closes N8.
9. **Add MARKETING-MAP.md** section to SURFACE-MAP declaring canonical routing for ad/market skills. Closes N5.
10. **Delete or merge `skill-architect` / `skill-creator`**. Closes N7.

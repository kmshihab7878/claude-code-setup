---
name: planUI
description: UI-focused CoreMind pipeline. Routes a design brief through UI-adjacent skills, agents, and MCPs — from brand decisions to tokens to components to audit to polish. Use when building interfaces (dashboards, apps, marketing sites, landing pages) or generating design systems. Narrower and faster than /plan.
---

# /planUI — CoreMind UI Pipeline

Specialization of `/plan` for UI and design work. Orchestrates the UI surface (skills, agents, MCPs, sub-commands) around an 8-stage design pipeline.

> **When to use** — `/planUI` for pure UI/design tasks; `/plan` when UI is one piece of a cross-domain task; `/ultraplan` for enterprise-scale cross-system UI with governance requirements.

## References

- Full UI surface inventory, surface routing, build playbooks, audit chain, success criteria, one-line routing cheat sheet: [`commands/references/plan-ui-reference.md`](./references/plan-ui-reference.md).
- Shared `/plan` schemas, rules, and risk tiers: [`commands/references/plan-reference.md`](./references/plan-reference.md).
- UI agents: [`agents/REGISTRY.md`](../agents/REGISTRY.md). Live counts: [`docs/INVENTORY.md`](../docs/INVENTORY.md). Pipeline core: [`skills/coremind-core/SKILL.md`](../skills/coremind-core/SKILL.md). Primary skills: `skills/hue/`, `skills/interface-design/`, `skills/react-bits/`.

---

## UI surface (snapshot)

- **Skills:** brand+system (`hue`, `brand-guidelines`, `ui-design-system`), direction+craft (`interface-design`, `impeccable-design`, `distilled-aesthetics`, `ui-ux-pro-max`, `frontend-design`), components+motion (`react-bits`, `framer-motion-patterns`, `responsive-design`, `baseline-ui`, `video-ui-patterns`, `remotion-animation`, others), audit+fix (`impeccable-audit`, `impeccable-polish`, `fixing-accessibility`, `fixing-motion-performance`, `fixing-metadata`), research+extraction (`ux-researcher-designer`, `design-inspector`, `clone-website`), marketing UI (`market-landing`, `market-brand`).
- **Agents:** `frontend-architect` (L2), `ux-designer` (L3), `mobile-app-builder` (L3).
- **MCPs:** `chrome-devtools`, `playwright`, `aidesigner`, `penpot` — live status via `claude mcp list`.
- **Sub-commands:** `/interface-design-{init, extract, audit, critique, status}`.

Full inventory and routing tables: [`plan-ui-reference.md`](./references/plan-ui-reference.md#ui-surface-inventory).

---

## The pipeline — 8 stages

### Stage 1: BRIEF — understand the human and the job

Answer in concrete terms before touching files:

- **Who is this human?** Specifics. A teacher at 7am with coffee. A developer debugging at midnight.
- **What verb must they accomplish?** "Grade submissions." "Find the broken deployment." Not "use the dashboard."
- **What should this feel like?** Words with meaning — *"warm like a notebook"*, *"cold like a terminal"*, *"dense like a trading floor"*. Not "clean" or "modern."

If you cannot answer these, stop and ask. **Do not guess. Do not default.**

Surface-type routing table (dashboard, marketing, design-system, brand application, reference extraction, video): [`plan-ui-reference.md`](./references/plan-ui-reference.md#stage-1-brief--surface-routing).

### Stage 2: ROUTE — pick the directional path

Pick one before doing anything else. **A) Brand-first** (hue → brand child skill → /interface-design-init → impeccable-audit → impeccable-polish). **B) System-first** (ui-design-system → /interface-design-init → react-bits → impeccable-audit → impeccable-polish). **C) Component-first** (react-bits OR impeccable-design → responsive-design + framer-motion-patterns → baseline-ui → impeccable-polish). Detail: [`plan-ui-reference.md`](./references/plan-ui-reference.md#stage-2-route--directional-paths).

### Stage 3: DIRECTION — establish the feel before code

State Intent, Palette, Depth, Surfaces, Typography, Spacing, Motion, Hero preset (marketing only) — each with WHY. **Every choice must be explainable.** "It's common" or "it works" means you defaulted, not chose. Full schema and the sameness-test: [`plan-ui-reference.md`](./references/plan-ui-reference.md#stage-3-direction--schema).

### Stage 4: SYSTEM — generate or load tokens

- **Brand-first** → invoke `hue` (writes `~/.claude/skills/<brand>/` with tokens + components + hero stage + icon kit).
- **System-first** → invoke `ui-design-system` (tokens, type scale, spacing grid, components, dev handoff).
- **Component-first** → skip to Stage 5 with inferred tokens.

Token taxonomy reference: `~/.claude/skills/hue/references/tokens-template.md`. Detail: [`plan-ui-reference.md`](./references/plan-ui-reference.md#stage-4-system--tokens).

### Stage 5: BUILD — assemble the surfaces

Surface-specific playbooks (dashboard, marketing/landing, video UI) and Next.js notes: [`plan-ui-reference.md`](./references/plan-ui-reference.md#stage-5-build--surface-playbooks).

### Stage 6: AUDIT — technical quality gates

Run in order. Do not skip. `impeccable-audit` → `baseline-ui` → `fixing-accessibility` (WCAG 2.2 AA minimum) → `fixing-motion-performance` → `fixing-metadata` (marketing only) → `/interface-design-audit` (against project's `system.md`). Record findings. Fix P0/P1 before ship. Detail: [`plan-ui-reference.md`](./references/plan-ui-reference.md#stage-6-audit--quality-chain).

### Stage 7: POLISH — final micro-detail pass

Run `impeccable-polish` (alignment, spacing rhythm, cross-surface consistency, hover/focus/disabled/loading states). Run `/interface-design-critique` once more: "where did I default?".

### Stage 8: SHIP — verify + deliver

Evidence: screenshots (desktop + tablet + mobile), Lighthouse, a11y output. Verify reduced-motion (`prefers-reduced-motion`), dark-mode parity if brand has both, offline support if PWA-ready. Tests: visual regression snapshot if tooling exists; smoke flow via `webapp-testing` for critical paths. Save patterns: `"Want me to save these patterns to .interface-design/system.md?"`.

---

## Typed-clarification (UI-specific)

`MISSING_INFO` (brand URL / target audience / primary verb), `AMBIGUOUS` (marketing landing vs in-app dashboard), `APPROACH_CHOICE` (brand-first vs system-first), `RISK_CONFIRM` (perf-impacting decisions), `SUGGESTION` (non-blocking).

## Guardrails

1. Don't spray components — minimum set. One hero background, one headline treatment, one CTA effect.
2. Don't sacrifice a11y for aesthetics.
3. Don't stack heavy canvas backgrounds without profiling.
4. Don't skip the audit.
5. Don't guess at brand — ask.
6. Reference, don't copy — Hue examples are inspiration, not drop-in templates.

## Hard rules (inherited from /plan)

Understand before building. Match capabilities (right skill, no duplicate work). Parallelize independent work (max 3 background subagents). Test everything (visual proof, Lighthouse, a11y, responsive). Simplicity compounds. Evidence, not assertions. Never break main. Deliver complete work. Route before burning tokens (Qwen for scaffold/explore; Claude for orchestration + governance).

Full inherited 18-rule list: [`plan-reference.md`](./references/plan-reference.md#hard-rules--full-18).

---

## One-line task routing

Quick cheat sheet of common UI requests (landing page, design-system generation, dashboard build, animation, token extraction, pixel-perfect clone, a11y fix, performance fix, audit, polish, video, brand application, user research, generative art): [`plan-ui-reference.md`](./references/plan-ui-reference.md#one-line-task-routing).

## Success criteria

A `/planUI` run is complete when the brief is answered (who / what / feel), direction stated with WHY, tokens exist, components built with the minimum set, audit passed, polish ran, evidence collected, patterns saved back to `system.md` if new ones emerged.

Full checklist: [`plan-ui-reference.md`](./references/plan-ui-reference.md#success-criteria).

---

*Cross-references: `/plan` (full-stack), `/ultraplan` (enterprise/cross-system), `~/.claude/skills/hue/references/hero-stage.md` (9 hero presets), `~/.claude/skills/react-bits/SKILL.md`.*

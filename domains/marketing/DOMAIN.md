# Marketing — Domain Index

> Lazy-loaded index for growth, content, brand, ads, and positioning work. Files are not moved; this doc points at their canonical locations.

## When to activate

Trigger keywords / intent patterns:

- *market, marketing, growth, content, brand, ad, ads, ad copy, cold email, SEO, landing page, conversion, funnel, campaign, launch, positioning, messaging, PMM, CRO, lifecycle email*
- File change patterns: any `*.html` under a landing-page path, content plan docs, pricing pages, marketing collateral
- Domain classifier output: `growth`, `marketing`, `content`, `product-marketing`

## Subdomains

| Subdomain | Scope | See |
|-----------|-------|-----|
| [growth](./growth/SUBDOMAIN.md) | Acquisition + conversion + retention loops | — |
| [content](./content/SUBDOMAIN.md) | Copy + SEO + social + email | — |
| [brand](./brand/SUBDOMAIN.md) | Voice + visual identity + positioning | — |
| [ads](./ads/SUBDOMAIN.md) | Paid media + ad research + creative generation | — |

## Commands

The `/market` suite is the canonical entry point.

| Command | Purpose |
|---------|---------|
| `/market` | Orchestrator — routes to specific marketing workflows |
| Implicit sub-invocations via the `market` skill: `/market audit`, `/market copy`, `/market emails`, `/market social`, `/market ads`, `/market funnel`, `/market landing`, `/market launch`, `/market proposal`, `/market report`, `/market report-pdf`, `/market brand`, `/market competitors`, `/market scanner`, `/market seo` |

The 15 sub-workflows are implemented as skills (the `market-*` family) orchestrated by the top-level `market` skill.

## Relevant agents

**Department head (L2):** `growth-marketer` — binds `brave-search`, `tavily`, `slack` (Tier-3 aspirational). Depends on `marketing-demand-acquisition`, `seo-audit`, `ab-test-setup`, `content-strategy`, `ad-research`, `ad-script-generator`, `ad-performance-loop`.

**Specialist (L3):** `content-strategist` — binds `brave-search`, `tavily`, `memory`. Depends on `content-strategy`, `seo-audit`, `brand-guidelines`, `ad-script-generator`, `anti-ai-writing` + the full `market-*` suite.

**L6 workers — `/market audit` engine (the 5 agents added to REGISTRY in Phase 1.0):**

- `market-content` — content & messaging analysis
- `market-conversion` — funnel + landing analysis
- `market-competitive` — competitor teardown
- `market-technical` — SEO + tracking audit
- `market-strategy` — strategy + pricing evaluation

**Executive (L1):** `business-panel-experts` invokes `cmo-advisor` for strategic marketing framing.

**Wave 1 stage agents under `agents/growth/**`:** 17 stage agents (5 intel + 5 gen + 7 loop). The most-developed Wave 1 department — growth-loop agents compute ROAS/CAC/attribution. EXPERIMENTAL per AUDIT classification until telemetry validates.

## Skill index

### Canonical — the `/market` suite (routed by `skills/market/`)

| Skill | Subdomain | Status | Notes |
|-------|-----------|--------|-------|
| `market` | growth | CORE | Orchestrator |
| `market-audit` | growth | SUPPORTING | Full audit — launches 5 subagents in parallel |
| `market-ads` | ads | SUPPORTING | Ad creative + copy generation |
| `market-brand` | brand | SUPPORTING | Brand voice analysis (overlaps with `brand-guidelines`) |
| `market-competitors` | growth | SUPPORTING | Competitive intel (overlaps with `competitive-intel`) |
| `market-copy` | content | SUPPORTING | Copywriting with proven frameworks |
| `market-emails` | content | SUPPORTING | Email sequences + timing + segmentation |
| `market-funnel` | growth | SUPPORTING | Funnel mapping + drop-off analysis |
| `market-landing` | growth | SUPPORTING | Landing-page CRO, section-by-section |
| `market-launch` | growth | SUPPORTING | Launch playbook generator |
| `market-proposal` | growth/ops | SUPPORTING | Client proposal generator |
| `market-report` | growth | SUPPORTING | Markdown report compiler |
| `market-report-pdf` | growth | SUPPORTING | PDF with charts + score gauges |
| `market-scanner` | growth | SUPPORTING | Automated market/competitive intel |
| `market-seo` | content | SUPPORTING | SEO content audit (overlaps with `seo-audit`) |
| `market-social` | content | SUPPORTING | 30-day content calendar |

### Ad-specific (parallel stack)

| Skill | Status | Notes |
|-------|--------|-------|
| `ad-research` | SUPPORTING | Autonomous competitor ad intelligence |
| `ad-script-generator` | SUPPORTING | 100+ ad script variations from intel |
| `ad-performance-loop` | SUPPORTING | Closed-loop CPA/ROAS optimization |

### Legacy / pre-`/market` (CONSOLIDATION candidates per AUDIT §5.2)

| Skill | Status | Notes |
|-------|--------|-------|
| `marketing-demand-acquisition` | SUPPORTING | Paid + SEO + budget allocation |
| `marketing-strategy-pmm` | SUPPORTING | Positioning + GTM + launches |
| `competitive-intel` | SUPPORTING | Competitor tracking |
| `content-strategy` | SUPPORTING | Content planning + SEO |
| `cold-email` | SUPPORTING | B2B cold outreach |
| `brand-guidelines` | SUPPORTING | Brand voice + visual guidelines |
| `seo-audit` | SUPPORTING | SEO teardown |
| `cmo-advisor` | SUPPORTING | Strategic marketing advisor (C-suite) |

### Cross-domain skills used by marketing

- `anti-ai-writing` (universal filter, 63 inbound)
- `data-analysis` (CORE engineering) — attribution / LTV analysis
- `ab-test-setup` + `experiment-designer` (CORE ai-ml) — growth experimentation
- `impeccable-design` / `hue` (CORE design) — landing-page and brand-system generation
- `clone-website` (CORE design) — competitor landing-page deconstruction

## Domain rules

1. **Anti-slop enforcement applies doubly here.** Marketing copy is the highest-risk surface for AI-generated slop. All copy output must pass the `anti-ai-writing` filter. Never use the banned words list (`core/identity.md`).
2. **Evidence over claims.** Marketing claims need supporting data — traffic, conversion, engagement — not adjectives. If a campaign analysis lacks metrics, flag it.
3. **Competitor analysis cites sources.** `market-competitors` / `ad-research` / `competitive-intel` outputs must include dated URLs for every claim.
4. **Brand voice consistency.** If `brand-guidelines` or a `hue`-generated child skill exists for the target, new copy/ad output must pass the declared voice rules.
5. **Attribution honesty.** ROAS / CAC / LTV formulas must state assumptions. The `growth/loop/attribution-analyst` agent is the source-of-truth on attribution definitions.

## Recipes

No dedicated marketing recipes in `recipes/marketing/` yet. The `/market` orchestrator fulfills the composable-workflow role.

Cross-domain applicable:

- `recipes/sub/dep-audit.yaml` — if generating email code or tracking pixels
- `recipes/engineering/code-review.yaml` — if shipping marketing infrastructure

## Notes

- **Biggest overlap cluster in the repo** — per AUDIT §3.2, marketing has 24 skills with no declared canonical routing. `/market` is treated as canonical but pre-`/market` skills (`cold-email`, `competitive-intel`, `marketing-strategy-pmm`, etc.) still fire on overlapping triggers. Phase 3 consolidation targets listed in AUDIT §5.2.
- **Extraction candidate:** the full `/market` suite (15 skills + 5 agents + orchestrator + templates) is one of the repo's cleanest standalone products. See `docs/EXTRACTABLE-PRODUCTS.md` (forthcoming Phase 2).
- **Experimental zones:** `agents/growth/{intel,gen,loop}/*.md` — 17 stage agents. Most-developed Wave 1 department.
- **Aspirational MCPs:** most marketing agents bind `brave-search` + `tavily` (Tier-3 not installed). Runtime gated; skills still index-able.
- **Brand visuals gateway:** when a user wants a brand-specific design language, route to `hue` (meta-skill in engineering/design subdomain) — it generates brand-specific child skills under `skills/<brand>/`.

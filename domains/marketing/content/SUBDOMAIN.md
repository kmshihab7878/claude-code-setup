# Marketing — Content

Copy, SEO, social, email sequences.

## Skills

- `market-copy` — Copy analysis + generation with proven frameworks
- `market-emails` — Email sequences with subject lines, timing, segmentation
- `market-social` — 30-day platform-specific content calendars
- `market-seo` — SEO content audit (CONSOLIDATION candidate — overlaps with `seo-audit`)
- `content-strategy` — Content planning + SEO strategy
- `cold-email` — B2B cold outreach sequences (CONSOLIDATION candidate — scope vs `market-emails` ambiguous)
- `seo-audit` — On-page + E-E-A-T + keyword + technical SEO
- `anti-ai-writing` — Universal anti-slop filter (MUST run on all generated copy)

## Agents

- **L3:** `content-strategist`
- **L6:** `market-content`, `market-technical` (SEO-side of `/market audit`)

## Commands

Implicit: `/market copy`, `/market emails`, `/market social`, `/market seo` (via `market` orchestrator).

## Rules

- All output passes `anti-ai-writing` filter.
- Claims cite sources.
- Brand voice consistency if a `brand-guidelines` skill or `hue`-generated child skill exists for the target.

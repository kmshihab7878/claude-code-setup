# Channel and Funnel Audits — Phase 2 detail

Per-subagent evaluation checklists for all five subagents. SKILL.md keeps the
subagent index with scoring categories; this file holds the full checklists.

## Subagent 1: market-content

**Focus**: Content quality, messaging clarity, copy effectiveness.

Evaluates:

- Headline clarity and specificity (does it pass the 5-second test?).
- Value proposition strength (is the unique value immediately obvious?).
- Body copy persuasion (does it speak to pain points and desired outcomes?).
- Social proof quality (testimonials, logos, case studies, numbers).
- Content depth and authority (blog quality, thought leadership).
- Brand voice consistency across pages.

**Score**: Content & Messaging (0–100).

## Subagent 2: market-conversion

**Focus**: CRO, funnels, landing pages, signup flows.

Evaluates:

- CTA effectiveness (clarity, placement, contrast, urgency).
- Form friction (number of fields, progressive disclosure, inline validation).
- Page layout and visual hierarchy (does the eye flow toward conversion?).
- Trust signals near conversion points (guarantees, security badges, testimonials).
- Mobile conversion experience.
- Signup/checkout flow steps and drop-off risk.
- Pricing page effectiveness (anchoring, packaging, FAQ).

**Score**: Conversion Optimization (0–100).

## Subagent 3: market-competitive

**Focus**: Competitive positioning, market landscape.

Evaluates:

- Unique positioning clarity (how differentiated is the messaging?).
- Competitor awareness signals (comparison pages, "vs" pages, alternatives pages).
- Market category definition (are they creating or joining a category?).
- Pricing relative to likely competitors.
- Feature differentiation signals.
- Review/reputation presence on third-party sites.

**Score**: Competitive Positioning (0–100).

## Subagent 4: market-technical

**Focus**: Technical SEO, site architecture, page speed, accessibility.

Evaluates:

- Title tags, meta descriptions, header hierarchy.
- URL structure and internal linking.
- Image optimization (alt tags, file sizes, modern formats).
- Mobile responsiveness.
- Page load speed indicators (DOM size, resource count, render-blocking).
- Schema markup / structured data.
- Sitemap and robots.txt.
- Core Web Vitals signals (where detectable).
- Accessibility basics (contrast, form labels, skip navigation).

**Score**: SEO & Discoverability (0–100).

## Subagent 5: market-strategy

**Focus**: Overall strategy, pricing, growth opportunities, brand trust.

Evaluates:

- Business model clarity.
- Pricing strategy (value-based, competitor-based, cost-plus).
- Growth loops (referral, viral, content, sales-led).
- Retention signals (loyalty programs, community, email nurture).
- Expansion revenue opportunities (upsells, cross-sells, tiers).
- Market timing and trends alignment.
- Brand trust signals (about page, team, mission, social proof depth).

**Scores**: Brand & Trust (0–100), Growth & Strategy (0–100).

## Cross-Subagent Funnel View

Even though subagents run independently, the aggregator can construct a
funnel view by stitching outputs:

| Funnel stage | Primary subagent | Secondary signal |
|--------------|------------------|------------------|
| Discovery | market-technical (SEO) | market-content (topical depth) |
| Click decision | market-content (headline/value prop) | market-competitive (differentiation) |
| Landing experience | market-conversion (layout, CTA) | market-content (body copy) |
| Trust check | market-strategy (brand/about/team) | market-conversion (proof near CTA) |
| Conversion | market-conversion (form, checkout) | market-content (objection handling) |
| Retention | market-strategy (loops, upsells, email) | market-content (newsletter, content cadence) |

Use this view to highlight where a single broken stage degrades downstream scores.

# Audit Workflow — Phase 1 + 2 detail

Full step-by-step procedures for Phase 1 (discovery) and Phase 2 (subagent
launch). The compact phase outlines live in `SKILL.md`.

## Phase 1: Discovery (pre-analysis)

### 1.1 Fetch the target URL

Use `WebFetch` to retrieve the homepage and up to 5 key interior pages
(pricing, about, product/features, blog, contact). Store raw content for
subagent consumption.

### 1.2 Detect business type

Classify the business into one of these categories. Classification shapes
every subagent's analysis focus.

| Business Type | Detection Signals | Analysis Focus |
|---------------|-------------------|----------------|
| **SaaS / Software** | Free trial CTA, pricing tiers, feature pages, "login" link, API docs | Trial-to-paid conversion, onboarding, feature differentiation, churn signals |
| **E-commerce** | Product listings, cart, checkout, product categories, reviews | Product pages, cart abandonment, upsells, reviews, AOV optimization |
| **Agency / Services** | Case studies, portfolio, "work with us", testimonials, contact forms | Trust signals, case studies, positioning, lead qualification |
| **Local Business** | Address, phone number, hours, "near me", Google Maps embed | Local SEO, Google Business Profile, reviews, NAP consistency |
| **Creator / Course** | Lead magnets, email capture, course listings, community links | Email capture rate, funnel design, testimonials, content quality |
| **Marketplace** | Two-sided messaging, buyer/seller flows, listing pages | Supply/demand balance, trust mechanisms, network effects |

### 1.3 Identify key pages

Map the site architecture to identify:

- Homepage.
- Primary landing pages.
- Pricing page (if exists).
- Product/feature pages.
- About/team page.
- Blog/content hub.
- Contact/signup/trial page.
- Legal pages (privacy, terms).

Store this page map for all subagents to reference.

## Phase 2: Analysis (parallel subagent execution)

Launch **all 5 subagents simultaneously**. Each subagent receives the business
type, page map, and fetched content. Full per-subagent evaluation checklists
in `references/channel-and-funnel-audits.md`.

| # | Subagent | Focus | Score produced |
|---|----------|-------|----------------|
| 1 | `market-content` | Content quality, messaging clarity, copy effectiveness | Content & Messaging (0–100) |
| 2 | `market-conversion` | CRO, funnels, landing pages, signup flows | Conversion Optimization (0–100) |
| 3 | `market-competitive` | Competitive positioning, market landscape | Competitive Positioning (0–100) |
| 4 | `market-technical` | Technical SEO, site architecture, page speed, accessibility | SEO & Discoverability (0–100) |
| 5 | `market-strategy` | Overall strategy, pricing, growth opportunities, brand trust | Brand & Trust (0–100) + Growth & Strategy (0–100) |

### Subagent independence

Each subagent works from the same brief but produces its own findings.
Do not let one subagent's output bias another. Synthesize at Phase 3.

### Partial data handling

If a subagent fails or a page is gated, note the gap in the report — do not
fabricate the missing analysis. The aggregator continues with the remaining
subagents and flags the gap in the executive summary.

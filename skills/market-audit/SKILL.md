---
name: market-audit
description: Full marketing audit orchestrator launching 5 parallel subagents and aggregating into a unified client-ready report.
---

# Marketing Audit Orchestrator

You are the marketing audit engine for `/market audit <url>`. You orchestrate a comprehensive analysis by launching 5 specialist subagents in parallel, then synthesize their findings into a single client-ready marketing audit report. This is the most complex marketing skill — it produces the highest-value deliverable.

## When This Skill Is Invoked

The user runs `/market audit <url>`. Fetch the target URL, classify the business, launch 5 specialist subagents in parallel, aggregate findings into a unified report saved to `MARKETING-AUDIT.md`, and display a terminal summary.

## Reference map

| When | Read |
|---|---|
| Phase 1 discovery — business-type detection signals + key-page map | [`references/audit-framework.md`](references/audit-framework.md) |
| Phase 2 — per-subagent evaluation checklists | [`references/channel-audits.md`](references/channel-audits.md) |
| Phase 3.2–3.3 — recommendation classification + revenue impact framework | [`references/benchmarks-and-prioritization.md`](references/benchmarks-and-prioritization.md) |
| Phase 3.4 — competitor comparison example | [`references/output-examples.md`](references/output-examples.md) |

## Compliance, claims, and audit-integrity constraints

- **No fabricated competitive data.** Competitor scores, named results, and comparison entries must come from real observation of competitor URLs or marked illustrative examples.
- **Revenue impact estimates are scenarios, not promises.** Always use conservative / moderate / aggressive ranges with confidence labels (High / Medium / Low). Never imply guaranteed outcomes.
- **Industry benchmarks must be cited or labeled as estimates.** "Industry benchmark CR is 2–4%" needs a source or a 🟡 estimate tag.
- **Don't recommend dark patterns** (hidden costs revealed late, manipulative opt-outs, forced continuity, "Yes / No-thanks" guilt copy). FTC-banned and damaging long-term.
- **WCAG 2.2 AA accessibility is non-negotiable** in any recommendation — contrast ≥ 4.5:1 body / ≥ 3:1 large text, ≥ 16px body, keyboard nav, alt text, focus indicators.
- **Privacy compliance (GDPR / CCPA)** — explicit opt-in for marketing, no pre-checked boxes, privacy policy near forms, no PII targeting in copy.
- **Subagent independence.** Each subagent works from the same brief but produces its own findings — don't have one subagent's output bias another. Synthesize at Phase 3.
- **Handle partial-data gracefully.** If a subagent fails or a page is gated, note the gap in the report — don't fabricate the missing analysis.
- **Mobile-first.** Recommendations must work on the 60%+ of traffic that's mobile.

---

## Phase 1: Discovery (pre-analysis)

### 1.1 Fetch the target URL

`WebFetch` the homepage and up to 5 key interior pages (pricing, about, product/features, blog, contact). Store raw content for subagent consumption.

### 1.2 Detect business type

Classification shapes every subagent's analysis focus.

| Business Type | Analysis focus |
|---|---|
| **SaaS / Software** | Trial-to-paid conversion, onboarding, feature differentiation, churn signals |
| **E-commerce** | Product pages, cart abandonment, upsells, reviews, AOV optimization |
| **Agency / Services** | Trust signals, case studies, positioning, lead qualification |
| **Local Business** | Local SEO, Google Business Profile, reviews, NAP consistency |
| **Creator / Course** | Email capture rate, funnel design, testimonials, content quality |
| **Marketplace** | Supply/demand balance, trust mechanisms, network effects |

Full detection-signal table per type (free-trial CTA, product listings, case studies, address/hours, lead magnets, two-sided messaging): [`references/audit-framework.md`](references/audit-framework.md).

### 1.3 Identify key pages

Map: homepage, primary landing pages, pricing page (if exists), product/feature pages, about/team, blog/content hub, contact/signup/trial, legal (privacy, terms). Store the page map for all subagents.

---

## Phase 2: Analysis (parallel subagent execution)

Launch **all 5 subagents simultaneously**. Each subagent receives the business type, page map, and fetched content. Full per-subagent evaluation checklists in [`references/channel-audits.md`](references/channel-audits.md).

| # | Subagent | Focus | Score produced |
|---|----------|-------|----------------|
| 1 | **market-content** | Content quality, messaging clarity, copy effectiveness | Content & Messaging (0–100) |
| 2 | **market-conversion** | CRO, funnels, landing pages, signup flows | Conversion Optimization (0–100) |
| 3 | **market-competitive** | Competitive positioning, market landscape | Competitive Positioning (0–100) |
| 4 | **market-technical** | Technical SEO, site architecture, page speed, accessibility | SEO & Discoverability (0–100) |
| 5 | **market-strategy** | Overall strategy, pricing, growth opportunities, brand trust | Brand & Trust (0–100) + Growth & Strategy (0–100) |

---

## Phase 3: Synthesis (aggregation and scoring)

### 3.1 Scoring methodology

Composite Marketing Score uses weighted averages:

```
Marketing Score = (
    Content_Score      * 0.25 +
    Conversion_Score   * 0.20 +
    SEO_Score          * 0.20 +
    Competitive_Score  * 0.15 +
    Brand_Score        * 0.10 +
    Growth_Score       * 0.10
)
```

**Score interpretation:**

| Score Range | Grade | Meaning |
|-------------|-------|---------|
| 85–100 | A | Excellent — minor optimizations only |
| 70–84 | B | Good — clear opportunities for improvement |
| 55–69 | C | Average — significant gaps to address |
| 40–54 | D | Below average — major overhaul needed |
| 0–39 | F | Critical — fundamental marketing issues |

### 3.2 Aggregate recommendations

Classify each recommendation by effort-to-impact:

- **Quick Wins** — < 1 week, low effort, high impact (copy / CTAs / missing meta / trust signals / broken links / urgency).
- **Strategic Recommendations** — 1–4 weeks, medium effort, high impact (pricing page redesign, comparison pages, lead magnets, email sequences, A/B tests).
- **Long-Term Initiatives** — 1–3 months, high effort, transformative (content strategy overhaul, SEO gap campaign, funnel redesign, brand repositioning, new growth channel).

Full per-tier example recommendation lists: [`references/benchmarks-and-prioritization.md`](references/benchmarks-and-prioritization.md#aggregate-recommendations).

### 3.3 Revenue impact estimates

```
Revenue Impact = Monthly Traffic × Conversion Rate Improvement × Avg Deal Value
Example: 10,000 visitors × 0.5% conv lift × $99 ARPU = $4,950/mo
```

Always provide conservative / moderate / aggressive ranges. Classify each recommendation:

| Impact level | Monthly revenue lift | Confidence |
|---|---|---|
| **High** | >$5,000/mo or >20% improvement | Based on clear evidence from audit |
| **Medium** | $1,000–$5,000/mo or 5–20% | Based on industry benchmarks |
| **Low** | <$1,000/mo or <5% | Incremental optimization |

Full framework + worked examples: [`references/benchmarks-and-prioritization.md`](references/benchmarks-and-prioritization.md#revenue-impact).

### 3.4 Competitor comparison

If the competitive subagent identified competitors, build a comparison table scoring across factors (headline clarity, value prop strength, trust signals, CTA effectiveness, pricing clarity, content depth) on a 0–10 scale per competitor.

Full template + worked example: [`references/output-examples.md`](references/output-examples.md).

---

## Output Format: MARKETING-AUDIT.md

Write the final report to `MARKETING-AUDIT.md` in the current directory:

```markdown
# Marketing Audit: [Business Name]
**URL:** [url]
**Date:** [current date]
**Business Type:** [detected type]
**Overall Marketing Score: [X]/100 (Grade: [letter])**

---

## Executive Summary

[3-5 paragraph summary for a non-technical stakeholder. Lead with the score,
highlight the biggest strength, the biggest gap, and the top 3 actions
that would move the needle most. Include estimated revenue impact of
implementing all recommendations.]

---

## Score Breakdown

| Category | Score | Weight | Weighted Score | Key Finding |
|----------|-------|--------|---------------|-------------|
| Content & Messaging | X/100 | 25% | X | [one-line finding] |
| Conversion Optimization | X/100 | 20% | X | [one-line finding] |
| SEO & Discoverability | X/100 | 20% | X | [one-line finding] |
| Competitive Positioning | X/100 | 15% | X | [one-line finding] |
| Brand & Trust | X/100 | 10% | X | [one-line finding] |
| Growth & Strategy | X/100 | 10% | X | [one-line finding] |
| **TOTAL** | | **100%** | **X/100** | |

---

## Quick Wins (This Week)

[Numbered list of 5-10 quick wins with specific implementation steps.
Each should include: what to change, where to change it, why it matters,
and estimated impact.]

## Strategic Recommendations (This Month)

[Numbered list of 3-7 strategic recommendations with rationale,
implementation steps, and expected outcomes.]

## Long-Term Initiatives (This Quarter)

[Numbered list of 2-5 long-term initiatives with business case,
resource requirements, and projected ROI.]

---

## Detailed Analysis by Category

### Content & Messaging Analysis
[Full findings from market-content subagent]

### Conversion Optimization Analysis
[Full findings from market-conversion subagent]

### SEO & Discoverability Analysis
[Full findings from market-technical subagent]

### Competitive Positioning Analysis
[Full findings from market-competitive subagent]

### Brand & Trust Analysis
[Full findings from market-strategy subagent — brand section]

### Growth & Strategy Analysis
[Full findings from market-strategy subagent — growth section]

---

## Competitor Comparison

[Comparison table from Section 3.4]

---

## Revenue Impact Summary

| Recommendation | Est. Monthly Impact | Confidence | Timeline |
|---------------|-------------------|------------|----------|
| [recommendation 1] | $X,XXX | High/Med/Low | X weeks |
| [recommendation 2] | $X,XXX | High/Med/Low | X weeks |
| ... | | | |
| **Total Potential** | **$XX,XXX/mo** | | |

---

## Next Steps

1. [Most critical action item]
2. [Second priority]
3. [Third priority]

*Generated by AI Marketing Suite — `/market audit`*
```

---

## Terminal Output

```
=== MARKETING AUDIT COMPLETE ===

Business: [name] ([type])
URL: [url]
Marketing Score: [X]/100 (Grade: [letter])

Score Breakdown:
  Content & Messaging:     [XX]/100 ████████░░
  Conversion Optimization: [XX]/100 ██████░░░░
  SEO & Discoverability:   [XX]/100 ███████░░░
  Competitive Positioning: [XX]/100 █████░░░░░
  Brand & Trust:           [XX]/100 ████████░░
  Growth & Strategy:       [XX]/100 ██████░░░░

Top 3 Quick Wins:
  1. [win]
  2. [win]
  3. [win]

Top 3 Strategic Moves:
  1. [move]
  2. [move]
  3. [move]

Estimated Revenue Impact: $X,XXX-$XX,XXX/month

Full report saved to: MARKETING-AUDIT.md
```

---

## Error Handling

- If the URL is unreachable, report the error and suggest checking the URL.
- If a subagent fails, continue with remaining subagents and note the gap in the report.
- If the site is behind authentication, note what was accessible and recommend manual review for gated content.
- If the site has very little content (single page), adapt the analysis accordingly and note limited scope.

## Cross-Skill Integration

- If `COMPETITOR-REPORT.md` exists in the current directory, incorporate its findings.
- If `BRAND-VOICE.md` exists, use it to contextualize content analysis.
- Reference other available analyses in the executive summary.

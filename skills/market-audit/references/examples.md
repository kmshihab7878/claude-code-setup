# Examples — Worked Audit Outputs

Worked examples for competitor comparison, score-band executive summaries,
and recommendation packaging.

## Competitor Comparison Table

If the competitive subagent identified competitors, include a comparison.

```markdown
| Factor | [Target] | Competitor A | Competitor B | Competitor C |
|--------|----------|--------------|--------------|--------------|
| Headline Clarity     | 6/10 | 8/10 | 5/10 | 7/10 |
| Value Prop Strength  | 5/10 | 7/10 | 6/10 | 8/10 |
| Trust Signals        | 7/10 | 9/10 | 4/10 | 6/10 |
| CTA Effectiveness    | 4/10 | 8/10 | 6/10 | 7/10 |
| Pricing Clarity      | 6/10 | 7/10 | 8/10 | 5/10 |
| Content Depth        | 5/10 | 9/10 | 3/10 | 6/10 |
```

Scoring is 0–10 per factor. Competitor scores must come from real observation
of competitor URLs or be explicitly marked as illustrative.

## Executive Summary — B-grade SaaS example

```
Overall Marketing Score: 76 / 100 (Grade: B)

This is a credible mid-stage SaaS site with a clear value proposition and a
working signup flow. The biggest strength is technical SEO (88) — meta, schema,
and Core Web Vitals are clean. The biggest gap is competitive positioning (61);
the site is missing a "vs" page and "alternatives to" content, both of which
likely cost SQL volume against active competitors searching the bottom of the
funnel.

Top three actions that would move the needle most:
1. Ship a "Compared to [Top Competitor]" page (Strategic, 2 weeks, est.
   $3.2k-$8.5k/mo).
2. Add inline social proof + a guarantee strip on the pricing page
   (Quick Win, 2-3 days, est. $1.1k-$3.4k/mo).
3. Build a 4-email trial-onboarding sequence (Strategic, 3 weeks, est.
   $2.8k-$6.2k/mo).

Implementing all recommendations carries an estimated combined impact of
$22k-$48k / month at the midpoint, with the trial-to-paid conversion lift as
the single largest line item.
```

## Quick Win — well-formed entry

```
Quick Win 3 — Add proof bar above pricing CTA

What:   Insert a single-row band above the primary "Start free trial" CTA
        showing 3-5 customer logos + the count of active teams.
Where:  Pricing page (line ~ above the .pricing-cta block).
Why:    The page currently has zero proof above the conversion action;
        bench data shows 8-14% trial-form lift from a single proof element
        within 200 px of the CTA.
Impact: Est. $1.1k-$3.4k / month at current traffic. Confidence: medium.
```

## Strategic Recommendation — well-formed entry

```
Strategic 2 — "Compared to [Competitor]" page

Rationale:
  - 22% of organic search hits originate from queries containing "[brand] vs"
    or "[brand] alternatives" — none currently routes to a tailored page.
  - Competitor A already ranks on these queries with a dedicated comparison page.

Implementation steps:
  1. Pull the last 90 days of "vs" / "alternatives" queries from search console.
  2. Identify the top 2 competitors driving query volume.
  3. Build a single comparison page (feature table + honest tradeoffs +
     three customer quotes that name the competitor by category, not by name).
  4. Add internal links from the pricing and features pages.

Expected outcome:
  - 1-3 ranked positions within 8-12 weeks.
  - $3.2k-$8.5k / month at conversion-rate parity with the pricing page.

Confidence: medium (based on competitor ranking patterns and internal SQL data
that was visible during the audit).
```

## Long-Term Initiative — well-formed entry

```
Long-Term 1 — Content cluster on [primary jobs-to-be-done]

Business case:
  Organic traffic to non-branded queries is 18% of current monthly visitors;
  the comparable benchmark for this SaaS category is 35-45%. Closing half the
  gap supports the next stage's pipeline without proportional paid spend.

Resource requirements:
  - One technical writer (12 weeks).
  - 1.5 hours / week from product or customer success for SME interviews.
  - SEO review of cluster architecture before publishing first piece.

Projected ROI:
  - 4-6 months to first measurable organic lift.
  - $14k-$28k / month estimated by month 9, compounding.
```

## Partial-Data Disclosure example

```
Note on coverage: the market-competitive subagent could not complete its run
because three competitor URLs returned 403. Their analysis is therefore
limited to two observed competitors plus public review data. The competitive
positioning score (61) is calibrated to the smaller comparison set; the
recommendation set is otherwise unaffected.
```

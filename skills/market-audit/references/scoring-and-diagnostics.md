# Scoring and Diagnostics — Phase 3.1 + 3.2 detail

Composite scoring methodology, grade interpretation, and the recommendation
classification framework. The compact formula and grade table live in `SKILL.md`.

## 3.1 Composite Marketing Score

```
Marketing Score = (
    Content_Score      × 0.25 +
    Conversion_Score   × 0.20 +
    SEO_Score          × 0.20 +
    Competitive_Score  × 0.15 +
    Brand_Score        × 0.10 +
    Growth_Score       × 0.10
)
```

Weights total 100%. Round the final score to the nearest integer.

### Grade interpretation

| Score Range | Grade | Meaning |
|-------------|-------|---------|
| 85–100 | A | Excellent — minor optimizations only |
| 70–84 | B | Good — clear opportunities for improvement |
| 55–69 | C | Average — significant gaps to address |
| 40–54 | D | Below average — major overhaul needed |
| 0–39 | F | Critical — fundamental marketing issues |

A grade is descriptive of current state, not predictive. A C-grade business
that ships the recommended remediation can move to B within a quarter.

### Score-band response patterns

| Grade | Aggregator emphasis |
|-------|---------------------|
| A | Lead with maintenance + experimentation roadmap; quick wins are diminishing-returns territory |
| B | Lead with the 2-3 highest-impact recommendations; map a 90-day plan |
| C | Lead with the executive summary risk framing; recommend a focused 30-day quick-wins sprint |
| D | Lead with the most damaging single gap (e.g., conversion < 30); pause new marketing spend until basics fixed |
| F | Lead with structural issues (positioning, value prop) before tactical tuning |

## 3.2 Aggregate Recommendations

Collect all recommendations from subagents and classify each by effort and impact.

### Quick Wins (< 1 week, low effort, high impact)

- Copy changes to headlines and CTAs.
- Adding missing meta descriptions.
- Adding trust signals near CTAs.
- Fixing broken links or images.
- Adding urgency or social proof.

### Strategic Recommendations (1–4 weeks, medium effort, high impact)

- Redesigning the pricing page.
- Building comparison / "alternatives to" pages.
- Creating lead magnets or content upgrades.
- Email-sequence implementation.
- Landing-page A/B test designs.

### Long-Term Initiatives (1–3 months, high effort, transformative)

- Content marketing strategy overhaul.
- SEO content-gap campaign.
- Funnel redesign.
- Brand repositioning.
- New growth-channel development.

## Diagnostic Heuristics

When a category score is unexpectedly low, run these diagnostics before
assuming the worst.

| Category low | Probable causes | Cross-check |
|--------------|-----------------|-------------|
| Content | Generic value prop, no social proof, brand voice drift | Pull 3 page headlines; rate clarity 1-5 |
| Conversion | Friction in form/checkout, weak CTAs, no trust signals | Trace the primary conversion path step by step |
| SEO | Missing meta, slow LCP, weak internal linking | Run a 5-URL spot check on title/meta/H1 |
| Competitive | No "vs" or "alternatives" pages, no third-party reviews | Search the brand name + competitor; observe SERP |
| Brand | Thin About page, no team, missing trust signals near pricing | Audit the homepage + pricing + about as a trust triad |
| Growth | No referral, no email capture, no retention loop | Map the 5 most common post-purchase paths |

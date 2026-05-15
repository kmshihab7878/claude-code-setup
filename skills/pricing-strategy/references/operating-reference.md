# Pricing Strategy Operating Reference

Purpose: Detailed startup checklist, proactive triggers, output artifact catalog, communication standard, and related-skill routing for the pricing strategy skill.

## Before Starting

Check for `marketing-context.md` before asking questions. Use that context and only ask for what is missing.

### Current State

- Existing plans, price points, and billing model.
- Trial/free to paid conversion rate, if known.
- Average revenue per customer.
- Monthly churn rate.

### Business Context

- B2B or B2C.
- Self-serve or sales-assisted.
- Best customers vs casual users.
- Competitors and their pricing.
- Cost to serve one customer per month.

### Goals

- Designing, optimizing, or planning an increase.
- Constraints such as grandfathered customers, contracts, and channel partner margins.

## Proactive Triggers

Surface these without being asked:

- Conversion rate above 40% trial-to-paid: likely underpriced; consider testing a 20-30% increase.
- All customers on the middle tier: no upsell path; consider enterprise tier or feature gatekeeping.
- Customers ask for features outside their tier: expansion revenue may be left on the table.
- Monthly churn above 5%: fix churn before raising prices.
- Price unchanged for 2+ years: flag for strategic review.
- Only one pricing option: no anchoring and no upsell path.

Treat these as diagnostic triggers, not deterministic proof.

## Output Artifacts

| Request | Output |
|---|---|
| Design pricing | Three-tier structure with value metric, feature grid, price points, and rationale |
| Audit pricing | Pricing scorecard, conversion benchmarks, gap analysis, quick wins |
| Plan a price increase | Increase strategy, communication templates, risk model, 90-day rollout |
| Design a pricing page | Above-fold layout spec, feature comparison table, CTA copy, FAQ copy |
| Research pricing | Van Westendorp questions and MaxDiff framework |
| Model pricing scenarios | Run or prepare inputs for `scripts/pricing_modeler.py` |

## Communication Standard

- Bottom line first: recommendation before justification.
- What + why + how for each recommendation.
- Actions should have owners and deadlines when implementation planning is requested.
- Confidence-tag numbers: verified benchmark, estimated, or assumed.

## Related Skills

- `product-strategist`: broader roadmap and monetization strategy.
- `copywriting`: pricing page copy polish.
- `churn-prevention`: retention work before raising prices.
- `ab-test-setup`: testing price points or pricing-page layouts.
- `customer-success-manager`: expansion revenue through upselling.
- `competitor-alternatives`: competitive comparison pages that complement pricing pages.

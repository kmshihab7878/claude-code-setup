# Market Ads Compliance and Validation Reference

Use this reference for deeper campaign review, compliance checks, troubleshooting, and failure modes.

## Compliance Review

Before handing off campaigns:

- Check whether the category is regulated or sensitive.
- Confirm targeting does not rely on protected class, sensitive trait, or inferred hardship.
- Remove or flag any ad copy that implies knowledge of personal attributes.
- Verify testimonials, metrics, guarantees, endorsements, awards, prices, and discounts are sourced or explicitly approved.
- Avoid unrealistic income, health, weight, financial, or guaranteed-outcome claims.
- Keep urgency honest: deadlines, inventory, and scarcity must be real.
- Use neutral language for sensitive categories.
- Keep platform-specific policy review as a launch prerequisite for high-risk categories.

## Public-Safe Output Rules

- Do not include account IDs, pixel IDs, real customer private data, unpublished analytics, credential names, or private audience exports.
- Use placeholders for missing data: `[approved testimonial]`, `[verified metric]`, `[offer deadline]`.
- Do not copy competitor ad text verbatim.
- Do not include private research notes in the final campaign file.
- Mark assumptions clearly.

## Validation Checklist

Run this review before completion:

- Does every platform recommendation include rationale?
- Is there a clear campaign objective for each platform?
- Are audience definitions specific enough to launch?
- Is each ad variation meaningfully distinct?
- Are CTAs aligned with the landing page?
- Are character limits respected where the platform has known limits?
- Are budget recommendations tied to business type, funnel stage, and platform?
- Are CPA/ROAS targets labeled as estimates?
- Are unsupported claims removed or marked for approval?
- Are regulated-category risks flagged?
- Does `AD-CAMPAIGNS.md` include strategy, targeting, campaign structure, variations, budgets, tests, benchmarks, landing page alignment, and creative brief?

## Landing Page Review

Flag any of these issues:

- Ad promise is not visible above the fold.
- Landing page CTA differs from ad CTA.
- Page asks for too much commitment relative to the ad funnel stage.
- Pricing, trial, or offer terms are unclear.
- Mobile experience is weak for social traffic.
- Load speed is likely to waste paid spend.
- Form has unnecessary fields.
- Proof in ad is missing from landing page.

## Troubleshooting

| Symptom | Likely Cause | Response |
|---|---|---|
| Campaign feels generic | Weak offer or missing audience detail | Return to offer, audience, proof, and objection analysis |
| Too many platforms recommended | No channel prioritization | Rank by intent, budget, creative supply, and compliance risk |
| Ad copy repeats itself | Angles are not distinct | Rebuild around pain, proof, comparison, objection, demo, and offer |
| CPA targets look unrealistic | Benchmarks used without margin or ACV context | Label assumptions and provide ranges |
| Landing page mismatch | Ads promise a different outcome than the page | Rewrite ads or recommend landing page changes |
| Compliance risk is high | Regulated category or sensitive targeting | Flag manual review and reduce claim strength |
| Weak TikTok output | No native video concept | Add hook, visual problem, product demo, proof, and CTA beats |
| Weak LinkedIn output | Consumer-style copy | Shift to business outcome, role pain, ROI, and credibility |

## Review Language

Use clear launch-readiness labels:

- `Ready`: safe to hand to a media buyer after normal account setup.
- `Needs approval`: proof, legal, brand, or offer detail must be approved before launch.
- `Needs landing page work`: paid traffic is likely to underperform until the page is fixed.
- `Needs tracking`: conversion tracking or audience setup is missing.
- `Policy risk`: platform or legal review required before spend.

## Failure Modes to Avoid

- Creating fake customers, quotes, or metrics.
- Treating planning benchmarks as guaranteed outcomes.
- Recommending every platform without budget discipline.
- Writing platform copy without checking format limits.
- Using the same copy angle across all ad variations.
- Ignoring landing page message match.
- Producing launch-ready language for regulated categories without review.
- Hiding important assumptions in prose instead of listing them.

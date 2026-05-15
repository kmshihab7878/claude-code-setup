# Market Ads Campaign Examples

Use this reference for full output templates and handoff examples.

## AD-CAMPAIGNS.md Template

Write the full campaign packet to `AD-CAMPAIGNS.md`.

```markdown
# Ad Campaigns: [Business Name]

**URL:** [url]
**Date:** [current date]
**Business Type:** [type]
**Primary Objective:** [objective]
**Recommended Platforms:** [platforms]

---

## Campaign Strategy Overview

[2-3 paragraph overview of the ad strategy]

## Audience Targeting

[Detailed audience definitions for each platform]

## Campaign 1: [Platform Name]

### Ad Group 1: [Theme]

**Targeting:** [audience parameters]
**Budget:** [recommended daily/monthly]
**Objective:** [campaign objective]

#### Ad Variation 1

- **Angle:** [pain/proof/comparison/demo/etc.]
- **Headline:** [text]
- **Primary Text:** [text]
- **Description:** [text]
- **CTA:** [button text]
- **Visual:** [creative description]
- **Landing Page:** [URL/page]

[Repeat for each variation]

[Repeat for each ad group and platform]

## Retargeting Strategy

[Three-stage funnel with ad variations]

## Budget Allocation

[Platform and funnel stage breakdown]

## Testing Plan

[Prioritized A/B tests]

## Performance Benchmarks

[ROAS and CPA targets by platform]

## Landing Page Alignment

[Message match assessment and recommendations]

## Creative Brief for Designers

[Visual specifications, brand guidelines, image/video requirements]

## Compliance Notes

[Unsupported claims, regulated-category flags, required approvals, placeholder proof]
```

## Terminal Output Template

```text
=== AD CAMPAIGNS GENERATED ===

Business: [name]
Platforms: [list]
Total Ad Variations: [count]

Campaign Structure:
  Google Ads: [X] ad groups, [X] variations
  Meta Ads: [X] ad sets, [X] variations
  LinkedIn: [X] campaigns, [X] variations

Budget Recommendation: $[X,XXX]/month
Expected CPA: $[XX]-$[XX]
Target ROAS: [X]:1

Full campaigns saved to: AD-CAMPAIGNS.md
```

## Minimal Example: B2B SaaS

```markdown
## Campaign 1: Google Search

### Ad Group 1: Workflow Automation

**Targeting:** High-intent search terms around workflow automation software.
**Budget:** $150/day initial test.
**Objective:** Demo bookings.

#### Ad Variation 1

- **Angle:** Pain point.
- **Headline:** Replace Manual Workflows
- **Primary Text:** Stop routing approvals through spreadsheets. [Product] gives operations teams a single place to track, approve, and report work.
- **Description:** Build approval workflows without engineering tickets.
- **CTA:** Book Demo
- **Visual:** Search ad only.
- **Landing Page:** [demo page URL]
```

## Minimal Example: E-commerce

```markdown
## Campaign 1: Meta Prospecting

### Ad Set 1: Problem-Aware Buyers

**Targeting:** Interest and lookalike audiences based on category buyers.
**Budget:** $100/day initial test.
**Objective:** Purchases.

#### Ad Variation 1

- **Angle:** Before/after.
- **Headline:** Better [category] in minutes
- **Primary Text:** Before: [painful routine]. After: [desired result]. [Product] helps you get there without [common objection].
- **Description:** Try the customer-approved favorite.
- **CTA:** Shop Now
- **Visual:** Split-screen before/after product use.
- **Landing Page:** [product page URL]
```

## Handoff Checklist

- Campaign names are clear.
- Each platform has objective, audience, budget, and measurement fields.
- Every ad variation has copy, CTA, creative direction, and landing page.
- Proof placeholders are marked for approval.
- Compliance notes are visible before launch.
- Testing plan names one primary variable per test.

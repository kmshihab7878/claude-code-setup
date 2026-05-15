# Brand Voice Workflow — full 10-step procedure

Detailed step-by-step for the brand voice analysis and guideline generation
workflow. The compact step list lives in `SKILL.md`.

## Step 1: Gather Source Material

Examine content from multiple sources.

**Primary (must analyze):** Homepage, About page, Product/service pages.

**Secondary (if available):** Blog posts (3-5 recent), social media profiles
(bio + recent posts + engagement), email newsletters (welcome + recent sends),
customer-facing copy (errors, onboarding, help docs).

**Tertiary:** Job postings, press releases, ad copy, video/podcast transcripts.

Use browser tools or `analyze_page.py` for web content. For social, check the
website for social links and analyze those profiles.

## Step 2: Voice Dimension Analysis

Map the brand's voice along the four primary dimensions (Formal↔Casual,
Serious↔Playful, Technical↔Simple, Reserved↔Bold). Score 1-10 per dimension.

Full signal tables for each dimension: `references/voice-tone-and-identity.md`.

## Step 3: Tone Spectrum Mapping

Map how the brand's tone shifts across 8 contexts: Homepage, Product
description, Blog post, Social media, Error/404 page, Email subject lines,
CTA buttons, Customer support.

Full context table with example quotes: `references/voice-tone-and-identity.md`.

## Step 4: Brand Personality Framework

Map the brand to one of five core archetypes (brands may blend 1-2):
Authority, Innovator, Friend, Rebel, Guide.

Assessment output: Primary archetype, Secondary archetype (if applicable),
Archetype fit (Strong / Moderate / Weak).

Full archetype profiles (characteristics, voice, industries, example brands,
key phrases): `references/voice-tone-and-identity.md`.

## Step 5: Vocabulary Analysis

Identify 15-20 most characteristic words/phrases organized into:

- **Action words** (verbs): e.g., "build", "scale", "transform", "streamline".
- **Descriptive words** (adjectives): e.g., "powerful", "simple", "enterprise-grade", "effortless".
- **Value words**: e.g., "transparent", "sustainable", "inclusive", "innovative".
- **Industry-specific terms**: e.g., "workflow", "pipeline", "conversion", "engagement".

Then capture **words they avoid**:

- Words too casual for the brand (if formal).
- Words too technical for the brand (if simple).
- Competitor terminology deliberately avoided.
- Industry clichés sidestepped.

And **signature phrases**: tagline, recurring phrases, linguistic patterns
(e.g., always starts sentences with verbs, uses dashes frequently, favors
short paragraphs).

Full vocabulary detail: `references/positioning-and-messaging.md`.

## Step 6: Competitor Voice Comparison

Compare the brand's voice to 2-3 key competitors using the same four
dimensions + archetype.

Then assess:

- How distinct from competitors.
- Where voices overlap (differentiation opportunity).
- What voice territory is unoccupied.
- Specific differentiation recommendations.

If the user previously ran `/market competitors`, reuse that data.

Full matrix and differentiation playbook:
`references/competitive-diagnostics-and-validation.md`.

## Step 7: Consistency Audit

Score voice consistency across all analyzed channels: Homepage, About,
Blog, Social, Email, Product pages.

Per-channel rating: `Consistent / Mostly / Inconsistent` with specific
observations. **Overall Consistency Score: X/10.**

Common issues catalog and audit table:
`references/competitive-diagnostics-and-validation.md`.

## Step 8: Brand Messaging Hierarchy

Document messaging from most distilled to most expanded:

1. **Tagline** — under 10 words. Most compressed brand message.
2. **Value Propositions** — 3-5 core props, one sentence each.
3. **Elevator Pitch** — 30 seconds / ~75 words.
4. **Boilerplate** — 100-150 words. Standard "about us" paragraph.
5. **Full Brand Story** — 300-500 words. Complete narrative.

For each: current status (Exists / Partial / Missing) + improvement recommendations.

If any layer is missing, flag it; do not fabricate.

## Step 9: Generate Brand Voice Documentation

Create the comprehensive Do's and Don'ts guide:

- **Voice Chart** — `OUR VOICE IS` ↔ `OUR VOICE IS NOT` paired columns.
- **Writing Do's** — specific instructions backed by the analysis.
- **Writing Don'ts** — specific anti-patterns from the analysis.

Full chart template and Do's/Don'ts examples:
`references/positioning-and-messaging.md`.

## Step 10: Copy Samples in Identified Voice

Provide 5-8 sample copy pieces. Required types:

1. Homepage Headline.
2. Product Description Paragraph.
3. Blog Post Opening.
4. Social Media Post.
5. Email Subject Line.
6. CTA Button Text.
7. Error Message.
8. Customer Thank You Message.

Sample templates with placeholders: `references/positioning-and-messaging.md`.

Worked sample examples by voice profile: `references/examples.md`.

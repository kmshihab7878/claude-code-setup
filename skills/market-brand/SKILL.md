---
name: market-brand
description: Brand voice analysis and guidelines generation examining communication patterns across channels.
---

# Brand Voice Analysis and Guidelines Generation

## Skill Purpose

Analyze a brand's voice, tone, and messaging across all available channels and generate a comprehensive brand voice guidelines document. This skill examines how a brand communicates, identifies patterns and inconsistencies, and produces actionable guidelines that any writer or marketer can follow to maintain brand consistency.

## When to Use

- User wants to understand or document a brand's voice.
- User needs brand voice guidelines for a team, freelancers, or agency.
- User wants to ensure consistency across marketing channels.
- User is rebranding or refining their brand identity.
- User wants to compare their brand voice to competitors.
- Triggered by `/market brand <url>` or `/market brand`.

## Reference map

| When | Read |
|---|---|
| Scoring voice dimensions (Step 2) + tone-by-context mapping (Step 3) | [`references/voice-dimensions.md`](references/voice-dimensions.md) |
| Selecting brand archetypes (Step 4) | [`references/archetypes.md`](references/archetypes.md) |
| Vocabulary analysis (Step 5) + consistency audit framework (Step 7) | [`references/vocabulary-and-audit.md`](references/vocabulary-and-audit.md) |
| Voice chart, Do's/Don'ts, and copy-sample templates (Steps 9 & 10) | [`references/voice-docs-templates.md`](references/voice-docs-templates.md) |

## Claims and source-quality constraints

- Every dimension score, archetype assessment, and consistency rating must be **evidence-backed** with 3–5 quoted examples from the source material. No invented quotes.
- Don't fabricate a tagline, boilerplate, or brand story — if missing, flag as "Missing" or "Partial" in the messaging hierarchy and recommend creation.
- Don't extrapolate brand voice from a single page. If sources are insufficient (homepage only, no blog/social/email), state that limitation explicitly in the output.
- Voice and tone are different — voice is the consistent personality; tone shifts by context. Don't conflate them.
- Frame consistency issues as opportunities, not failures. Consistency drift is common and fixable.

## How to Execute

### Step 1: Gather source material

Examine content from multiple sources. Prioritize:

**Primary (must analyze):** Homepage, About page, Product/service pages.

**Secondary (analyze if available):** Blog posts (3–5 recent), social media profiles (bio + recent posts + engagement), email newsletters (welcome + recent sends), customer-facing copy (errors, onboarding, help docs).

**Tertiary:** Job postings, press releases, ad copy, video/podcast transcripts.

Use browser tools or `analyze_page.py` for web content. For social, check the website for social links and analyze those profiles.

### Step 2: Voice dimension analysis

Map the brand's voice along four primary dimensions. Each dimension is a **spectrum, not a binary** — score 1–10:

| # | Dimension | 1 ←————→ 10 |
|---|-----------|--------------|
| 1 | **Formality** | Formal ←————→ Casual |
| 2 | **Levity** | Serious ←————→ Playful |
| 3 | **Complexity** | Technical ←————→ Simple |
| 4 | **Personality** | Reserved ←————→ Bold |

**Evidence required:** quote 3–5 specific examples per dimension from the source material. Full signal-detection tables (contractions, sentence structure, vocabulary, greetings, humor, slang for Formality; tone, metaphors, exclamation marks, emoji, wordplay, error-message style for Levity; jargon, acronyms, detail-level, audience assumption, statistics for Complexity; claim hedging, opinion strength, competitive references, promises, controversy for Personality) — see [`references/voice-dimensions.md`](references/voice-dimensions.md).

### Step 3: Tone spectrum mapping

Beyond the four dimensions, map how the brand's tone shifts across **8 contexts**: Homepage, Product description, Blog post, Social media, Error/404 page, Email subject lines, CTA buttons, Customer support. Full per-context template with example quotes: [`references/voice-dimensions.md`](references/voice-dimensions.md#step-3-tone-spectrum-mapping).

### Step 4: Brand personality framework

Map the brand to **one of five core archetypes** (brands may blend 1–2):

1. **The Authority** — expert, trustworthy, data-driven (McKinsey, IBM, Mayo Clinic).
2. **The Innovator** — forward-thinking, disruptive, visionary (Tesla, Stripe, Notion).
3. **The Friend** — warm, approachable, helpful (Mailchimp, Slack, Duolingo).
4. **The Rebel** — bold, challenging conventions, irreverent (Nike, Oatly, Cards Against Humanity).
5. **The Guide** — wise, patient, methodical (HubSpot, Khan Academy, Ahrefs).

For each archetype, full characteristics + voice + fit industries + key phrases: [`references/archetypes.md`](references/archetypes.md).

**Assessment output:** Primary archetype, Secondary archetype (if applicable), Archetype fit (Strong / Moderate / Weak).

### Step 5: Vocabulary analysis

Identify 15–20 most characteristic words/phrases in four categories: **action** verbs, **descriptive** adjectives, **value** words, **industry-specific** terms. Plus **words they avoid** (too casual / too technical / competitor terminology / industry clichés sidestepped). Plus **signature phrases** (tagline, recurring phrases, linguistic patterns). Full template: [`references/vocabulary-and-audit.md`](references/vocabulary-and-audit.md#step-5-vocabulary-analysis).

### Step 6: Competitor voice comparison

Compare the brand's voice to 2–3 key competitors using the same four dimensions + archetype scoring:

| Dimension | [Brand] | Comp 1 | Comp 2 | Comp 3 |
|---|---|---|---|---|
| Formal ↔ Casual | X/10 | X/10 | X/10 | X/10 |
| Serious ↔ Playful | X/10 | X/10 | X/10 | X/10 |
| Technical ↔ Simple | X/10 | X/10 | X/10 | X/10 |
| Reserved ↔ Bold | X/10 | X/10 | X/10 | X/10 |
| Primary archetype | [type] | [type] | [type] | [type] |

Then assess: how distinct from competitors, where voices overlap (differentiation opportunity), what voice territory is unoccupied, specific differentiation recommendations.

If the user previously ran `/market competitors`, reuse that data.

### Step 7: Consistency audit

Score voice consistency across all analyzed channels: Homepage, About page, Blog, Social media, Email, Product pages — `Consistent / Mostly / Inconsistent` per channel with specific observations. **Overall Consistency Score: X/10.** Common-issue catalog + full audit table: [`references/vocabulary-and-audit.md`](references/vocabulary-and-audit.md#step-7-consistency-audit).

### Step 8: Brand messaging hierarchy

Document messaging from most distilled to most expanded:

1. **Tagline** — under 10 words. Most compressed brand message.
2. **Value Propositions** — 3–5 core props, one sentence each.
3. **Elevator Pitch** — 30 seconds / ~75 words.
4. **Boilerplate** — 100–150 words. Standard "about us" paragraph.
5. **Full Brand Story** — 300–500 words. Complete narrative.

For each: current status (Exists / Partial / Missing) + improvement recommendations.

### Step 9: Generate brand voice documentation

Create the comprehensive **Do's and Don'ts guide** including:

- **Voice Chart** — `OUR VOICE IS` ↔ `OUR VOICE IS NOT` paired columns (e.g., "Confident" / "Arrogant"; "Helpful" / "Condescending"; "Clear" / "Dumbed down"; "Bold" / "Aggressive").
- **Writing Do's** — specific instructions backed by the analysis ("use contractions", "lead with the benefit", "active voice in CTAs", etc.).
- **Writing Don'ts** — specific anti-patterns ("don't use jargon without explaining", "don't use passive in CTAs", etc.).

Full chart and example Do's/Don'ts: [`references/voice-docs-templates.md`](references/voice-docs-templates.md).

### Step 10: Copy samples in identified voice

Provide **5–8 sample copy pieces** so the team has concrete references. Required types:

1. Homepage Headline
2. Product Description Paragraph
3. Blog Post Opening
4. Social Media Post
5. Email Subject Line
6. CTA Button Text
7. Error Message
8. Customer Thank You Message

Full template with placeholder slots: [`references/voice-docs-templates.md`](references/voice-docs-templates.md#step-10-copy-samples-in-identified-voice).

## Output Format

Generate a file called `BRAND-VOICE.md` with:

```markdown
# Brand Voice Guidelines
## [Brand Name]
### Analysis Date: [Date]

---

## Voice Summary
[2-3 sentence summary of the brand voice, personality, and key characteristics]

---

## Voice Dimensions

### Formal <-----> Casual: [X/10]
[Evidence and explanation]

### Serious <-----> Playful: [X/10]
[Evidence and explanation]

### Technical <-----> Simple: [X/10]
[Evidence and explanation]

### Reserved <-----> Bold: [X/10]
[Evidence and explanation]

### Visual Voice Map
```
Formal                                    Casual
|----[X]----------------------------------|
Serious                                   Playful
|--------[X]------------------------------|
Technical                                 Simple
|------------------[X]--------------------|
Reserved                                  Bold
|------------[X]--------------------------|
```

---

## Brand Personality
- Primary Archetype: [Archetype]
- Secondary Archetype: [Archetype]
- [Explanation and evidence]

---

## Tone by Context
| Context | Tone | Example |
|---|---|---|
| [context] | [tone] | "[example]" |

---

## Vocabulary

### Words We Use
[Organized word lists]

### Words We Avoid
[Words that don't fit the brand]

### Signature Phrases
[Recurring patterns and phrases]

---

## Voice Chart
| Our Voice IS | Our Voice IS NOT |
|---|---|
| [trait] | [anti-trait] |

---

## Writing Guidelines

### Do's
- [specific guidelines]

### Don'ts
- [specific anti-patterns]

---

## Brand Messaging Hierarchy

### Tagline
[tagline]

### Value Propositions
1. [value prop]

### Elevator Pitch
[pitch]

### Boilerplate
[boilerplate]

---

## Copy Samples
[8 examples of copy in the brand voice]

---

## Competitor Voice Comparison
[Comparison matrix and differentiation analysis]

---

## Consistency Audit
[Channel-by-channel assessment]
- Overall Consistency Score: [X/10]

---

## Recommendations
### Immediate Actions
1. [recommendation]

### Voice Evolution Opportunities
1. [recommendation]

### Consistency Improvements
1. [recommendation]
```

## Key Principles

- Brand voice analysis requires reading like a detective. Every word choice, punctuation decision, and sentence structure reveals something about how the brand wants to be perceived.
- Always provide EVIDENCE for every assessment. Don't just say "the brand is casual" — quote specific examples that prove it.
- The brand voice guide should be usable by someone who has never worked with the brand before. A new copywriter should be able to read this document and write on-brand content.
- Copy samples are the most valuable part of the deliverable. People learn voice by example, not by description. Make the samples diverse (headlines, body copy, social, email, error messages) so writers have references for every context.
- Voice and tone are different. Voice is the consistent personality. Tone shifts based on context (a customer complaint response is different from a product launch announcement, but both should be in the same voice).
- If the brand's voice is inconsistent across channels, frame it as an opportunity to strengthen their brand, not as a failure. Consistency issues are common and fixable.
- If the user has run `/market competitors` previously, use that data for the competitor voice comparison section.

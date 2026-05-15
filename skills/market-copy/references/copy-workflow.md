# Copy Workflow And Report Structure

Purpose: detailed workflow for copy discovery, scoring, value proposition analysis, and full report generation.

## Discovery

When analyzing a URL or source document, extract:

- Primary headline.
- Subheadline or supporting headline.
- Hero section copy.
- Section headlines.
- Body copy paragraphs.
- CTA button text and placement.
- Navigation labels.
- Footer copy.
- Meta title and meta description.
- Social proof elements: testimonials, stats, logos, customer counts, awards, or press mentions.

## Page Type Detection

| Page Type | Primary Goal | Copy Priority |
|-----------|--------------|---------------|
| Homepage | Communicate value proposition and route visitors | Headline clarity, navigation clarity, CTA hierarchy |
| Landing page | Drive one conversion action | Headline-CTA alignment, objection handling, proof |
| Pricing page | Drive plan selection | Plan naming, feature framing, anchoring, FAQ |
| About page | Build trust and connection | Story, mission, team credibility, values |
| Product page | Demonstrate value of a specific product | Feature-to-benefit translation, social proof, specs |
| Feature page | Explain a specific capability | Problem-solution framing, use cases, comparison |
| Blog post | Educate and capture leads | Headline hook, intro engagement, CTA placement |
| Contact/demo page | Capture lead information | Form headline, friction reduction, trust signals |

## Voice Profile

Document a profile so generated copy matches the brand unless there is a clear reason to diverge:

- Formality: casual to formal, 1-5.
- Emotion: neutral to passionate, 1-5.
- Complexity: simple to technical, 1-5.
- Humor: serious to playful, 1-5.
- Authority: peer to expert, 1-5.

Flag any divergence from observed or documented voice.

## Scoring Rubric

Score the page across five dimensions:

| Dimension | Score | What It Measures |
|-----------|-------|------------------|
| Clarity | 0-10 | Can a new reader understand what the offer does? |
| Persuasion | 0-10 | Does the copy move the reader toward action and handle objections? |
| Specificity | 0-10 | Are claims concrete and supportable rather than vague? |
| Emotion | 0-10 | Does the copy connect to pain, desire, identity, or aspiration? |
| Action | 0-10 | Are CTAs clear, compelling, low-friction, and well placed? |

Total copy score: `X/50`, multiplied by 2 for a `0-100` summary.

## Value Proposition Canvas

```text
TARGET CUSTOMER:  [Who specifically is this for?]
PROBLEM:          [What painful problem do they have?]
SOLUTION:         [How does this product solve it?]
UNIQUE MECHANISM: [What approach, method, or technology is distinct?]
KEY BENEFIT:      [What is the primary outcome?]
PROOF:            [What evidence supports the claims?]
```

Flag missing or weak elements.

## Terminal Summary

```text
=== COPY ANALYSIS: [URL] ===

Page Type: [type]
Voice Profile: [casual/formal], [neutral/passionate], [simple/technical]

Copy Score: X/50 (X/100)
  Clarity:     X/10
  Persuasion:  X/10
  Specificity: X/10
  Emotion:     X/10
  Action:      X/10

Top 3 Copy Fixes:
  1. [fix with before/after]
  2. [fix with before/after]
  3. [fix with before/after]

Full report saved to: COPY-SUGGESTIONS.md
```

## COPY-SUGGESTIONS.md Structure

```markdown
# Copy Analysis & Suggestions: [URL]
**Date:** [current date]
**Page Type:** [type]
**Copy Score:** X/100

## Executive Summary
[2-3 paragraphs summarizing copy quality, key strengths, and priority fixes]

## Voice & Tone Profile
[Voice analysis results with recommendations]

## Score Breakdown
[Full scoring rubric with justifications]

## Value Proposition Analysis
[Value proposition canvas with gaps identified]

## Headline Recommendations
[Current headline and ranked alternatives with framework labels]

## Section-by-Section Copy Suggestions
[For each major section: current copy, issue, recommended copy, rationale]

## CTA Optimization
[Every CTA analyzed with recommendations]

## Before/After Examples
[At least 5 before/after pairs]

## Swipe File
[Headline, subheadline, CTA, meta, and proof-framing alternatives]

## Implementation Priority
[Ranked changes by impact]
```

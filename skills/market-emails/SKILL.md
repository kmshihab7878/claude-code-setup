---
name: market-emails
description: Email marketing engine generating complete ready-to-send sequences with subject lines, timing, and segmentation strategies.
---

# Email Sequence Generation

You are the email marketing engine for `/market emails <topic/url>`. You generate complete, ready-to-send email sequences with subject lines, body copy, timing, and segmentation strategies. Every sequence is built on proven email frameworks and calibrated to industry benchmarks.

## When This Skill Is Invoked

The user runs `/market emails <topic/url>`. If a URL is provided, fetch the site to understand the business, product, audience, and voice. If a topic is provided, work from the topic description and ask clarifying questions if needed. Output complete sequences to `EMAIL-SEQUENCES.md`.

## Reference map

| When | Read |
|---|---|
| Writing the body copy — frameworks, subject lines, send timing (Phase 2) | [`references/email-frameworks.md`](references/email-frameworks.md) |
| Generating full per-email templates — Welcome / Cold Outreach / Cart Abandonment (Phase 3) | [`references/sequence-templates.md`](references/sequence-templates.md) |
| Segmentation strategy + A/B testing plan (Phase 4) | [`references/segmentation-and-testing.md`](references/segmentation-and-testing.md) |
| Industry benchmark table for Phase 5 + EMAIL-SEQUENCES.md output | [`references/benchmarks.md`](references/benchmarks.md) |

## Compliance and deliverability constraints

These are **legal-risk** and **deliverability-risk** rules. Apply to every sequence generated.

- **CAN-SPAM (US):**
  - Physical mailing address required in every email.
  - Clear unsubscribe link required (must work within 10 business days).
  - "From" name and email must be accurate.
  - Subject line must not be deceptive.
- **GDPR (EU):**
  - Requires **explicit opt-in consent** (no pre-checked boxes).
  - Must document consent (when, how, what they agreed to).
  - Right to be forgotten — must delete on request.
  - Data processing agreement needed with the ESP.
- **CASL (Canada):**
  - Express consent required for commercial messages.
  - Implied consent allowed for existing business relationships (24 months).
  - Sender identification required.
- **Deliverability hygiene:**
  - Avoid spam triggers in subject lines: "free", "guarantee", "act now", "limited time" used in excess.
  - Personalize first name only ~20–30% of emails — not every send.
  - One emoji can lift opens 2–5%; overuse hurts.
  - Preheader (preview text) is as important as the subject line — always write both.
  - Cold-outreach (B2B prospecting) is a different consent regime from opt-in lifecycle email; flag this distinction when running both kinds.
  - SPF / DKIM / DMARC must be configured before scaling sends.
- **Don't fabricate testimonials, customer names, results, or social proof.** Use real data only or clearly marked placeholders ("[customer name]", "[specific result]").
- **Always recommend the user verify compliance with their legal counsel.** This skill is not legal advice.

---

## Phase 1: Context gathering

### 1.1 Business understanding

Establish before writing any emails:

| Context element | How to determine | Why it matters |
|----------------|-----------------|----------------|
| **Business type** | Fetch URL or ask user | Determines sequence type and tone |
| **Target audience** | Infer from site copy or ask | Shapes language, pain points, examples |
| **Product/service** | Fetch product/pricing pages | Drives value propositions in emails |
| **Price point** | Check pricing page | Higher price = longer nurture |
| **Primary CTA** | Identify main conversion action | Every email builds toward this |
| **Lead magnet** | Check for download offers, free trials | Determines welcome sequence entry point |
| **Voice and tone** | Analyze existing copy (or pull from `BRAND-VOICE.md` if present) | Emails must match brand voice |

### 1.2 Sequence type selection

Recommend the appropriate sequence(s) based on context. **Generate at least 2 sequence types unless the user specifies one.**

| Sequence type | When to use | Emails | Goal |
|---------------|-------------|--------|------|
| **Welcome** | New subscriber / lead magnet download | 5–7 | Build trust, deliver value, introduce product |
| **Nurture** | Warm leads not yet ready to buy | 6–8 | Educate, build authority, overcome objections |
| **Launch** | New product or feature release | 8–12 | Build anticipation, drive purchases |
| **Re-engagement** | Inactive subscribers (30–90 days) | 3–4 | Win back attention or clean list |
| **Onboarding** | New trial users or new customers | 5–7 | Drive activation, reduce churn, show value |
| **Cart Abandonment** | E-commerce abandoned checkout | 3–4 | Recover lost sales |
| **Cold Outreach** | B2B prospecting | 3–5 | Book meetings, start conversations |

---

## Phase 2: Email frameworks

Core philosophy: **One email, one job.** ONE main idea, ONE primary CTA, ONE desired reader action. Combining asks is the #1 cause of low CTR.

Three structure frameworks (full templates in [`references/email-frameworks.md`](references/email-frameworks.md)):

- **Value Before Ask** — Welcome / Nurture. Approx. 3:1 value-to-ask ratio across the sequence.
- **Story-Driven** — Nurture and sophisticated audiences. Hook → Bridge → Lesson → CTA.
- **Problem-Agitate-Solution** — Launch and cart abandonment.

Subject-line essentials (full 10-formula table + rules in the reference):

- Keep under 50 characters (40 ideal). Front-load important words.
- Numbers outperform; odd numbers outperform even.
- Avoid spam-trigger over-use (see Compliance section above).
- Test emojis (1 = lift; 2+ = drop). Always write the preheader.

Send-cadence essentials (full per-sequence table in the reference):

- Welcome: 5–7 emails over 8–14 days.
- Cart Abandonment: 1hr, 24hr, 72hr (+ 7-day final).
- Cold Outreach: Day 1, Day 4, Day 8, optional Day 14 + Day 21 breakup.
- Best send times: B2B Tue–Thu 9–11 AM local; B2C Tue–Thu 10 AM or 7–9 PM local; avoid Mon morning / Fri afternoon / weekends (except e-commerce promo).

---

## Phase 3: Sequence templates

Full ready-to-customize per-email templates (timing + subject + body purpose + CTA) for the three core sequences in [`references/sequence-templates.md`](references/sequence-templates.md):

- **Welcome (5–7 emails)** — Deliver+Introduce → Story → Educate → Social Proof → Direct Pitch → Urgency (opt) → Transition (opt).
- **Cold Outreach (3–5 emails)** — Relevance+Value → Follow-up+Social Proof → Breakup+Value Drop → Re-approach (opt) → Final Breakup (opt).
- **Cart Abandonment (3–4 emails)** — Reminder (1hr) → Objection Handling (24hr) → Incentive (72hr) → Last Chance (7d, opt).

When asked for Nurture / Launch / Re-engagement / Onboarding sequences, build from the frameworks in Phase 2 and the cadence table in `references/email-frameworks.md`.

---

## Phase 4: Segmentation and personalization

Recommend segments using **6 bases**: Behavior, Engagement, Source, Stage, Interest, Value. Full segmentation table and per-base "how to use" examples: [`references/segmentation-and-testing.md`](references/segmentation-and-testing.md).

**A/B testing hierarchy** (test in this order for maximum learning):

1. Subject lines (biggest impact on open rate).
2. CTA and offer (biggest impact on click rate).
3. Send timing.
4. Email length and format.

For each sequence, suggest specific tests (subject variants, send time, CTA text, length, plain vs HTML, image use, personalization on/off). Full A/B variant catalog: [`references/segmentation-and-testing.md`](references/segmentation-and-testing.md#42-ab-testing-recommendations).

---

## Phase 5: Metrics and benchmarks

Include **industry benchmarks** in every output. General ranges:

- Open rate: 15–28% (industry-dependent).
- Click rate: 2–5%.
- Conversion rate: 0.5–3%.

Full per-industry table (SaaS, E-commerce, Agency, Education, Health, Finance, Media): [`references/benchmarks.md`](references/benchmarks.md).

Compliance notes (CAN-SPAM / GDPR / CASL) are stated in the constraints section at the top of this file. Include the compliance checklist in every EMAIL-SEQUENCES.md output.

---

## Output Format: EMAIL-SEQUENCES.md

Write the full output to `EMAIL-SEQUENCES.md`:

```markdown
# Email Sequences: [Business/Topic Name]
**Date:** [current date]
**Business Type:** [type]
**Target Audience:** [description]
**Sequences Generated:** [list of sequence types]

---

## Sequence 1: [Sequence Type]

### Overview
- **Goal:** [primary goal]
- **Emails:** [count]
- **Duration:** [total days]
- **Expected Open Rate:** [benchmark]%
- **Expected Click Rate:** [benchmark]%

### Email 1: [Email Name]
**Send:** [timing]
**Subject Line:** [primary subject]
**Subject Line B (A/B test):** [alternative subject]
**Preview Text:** [preheader text]

---

[Full email body copy here — ready to paste into an ESP]

---

**CTA:** [button text]
**CTA Link:** [where it should point]
**Goal:** [what this email should accomplish]
**Segmentation Notes:** [who should receive this]

[Repeat for each email in the sequence]

---

## Segmentation Strategy
[Recommended segments and how to use them]

## A/B Testing Plan
[Prioritized tests to run]

## Metrics to Track
[KPIs with industry benchmarks]

## Compliance Checklist
[CAN-SPAM, GDPR, CASL requirements]

## Implementation Notes
[ESP recommendations, automation setup, tagging strategy]
```

---

## Terminal Output

```
=== EMAIL SEQUENCES GENERATED ===

Business: [name]
Sequences: [list]
Total Emails: [count]

Sequence Overview:
  Welcome (7 emails, 14 days) — Build trust and convert
  Cart Abandonment (3 emails, 7 days) — Recover lost sales

Key Metrics Targets:
  Open Rate: 22-25%
  Click Rate: 3-4%
  Conversion Rate: 1.5-2%

Full sequences saved to: EMAIL-SEQUENCES.md
```

---

## Cross-Skill Integration

- If `BRAND-VOICE.md` exists, match all email copy to the documented voice.
- If `FUNNEL-ANALYSIS.md` exists, align email sequences to funnel stages.
- If `COPY-SUGGESTIONS.md` exists, reuse value propositions and CTA language.
- If `MARKETING-AUDIT.md` exists, reference conversion and content scores.
- Suggest follow-up: `/market copy` for website copy, `/market funnel` for conversion path analysis.

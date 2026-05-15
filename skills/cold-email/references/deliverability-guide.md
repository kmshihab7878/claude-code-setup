# Cold Email Deliverability Guide

Purpose: Keep deliverability setup checks, compliance cues, and proactive review triggers out of the main operating file while preserving safety guidance.

## Deliverability Basics

A strong email sent from a flagged domain may never land. Check:

- Dedicated sending domain: do not send cold outreach from the primary domain. Use a subdomain or separate sending domain.
- SPF, DKIM, and DMARC: all three should be configured and passing.
- Domain warmup: new domains need a gradual ramp, often 4-6 weeks.
- Plain text or minimal HTML: heavy templates can trigger filters and look like marketing.
- Unsubscribe mechanism: required in many jurisdictions and useful for trust.
- Sending limits: keep daily volume conservative until reputation is established.
- Bounce rate: above 5% can hurt deliverability; verify lists before sending.

## Warmup Notes

- Start with low daily volume.
- Increase gradually only when bounce and complaint rates are healthy.
- Avoid large one-day jumps.
- Separate cold outbound from core customer and transactional mail.
- Pause or reduce sends if bounces, spam complaints, or domain reputation problems appear.

## Compliance Cues

Ask about jurisdiction and company policy when outreach touches regulated markets or personal data. At minimum:

- Provide a simple opt-out when required.
- Do not use misleading sender identity, subject lines, or claims.
- Do not include scraped sensitive personal data.
- Do not imply a relationship, referral, or customer result that does not exist.

## Proactive Triggers

Surface these issues without waiting for the user:

- Email opens with "My name is" or "I'm reaching out because": rewrite the opener to lead with the prospect's world.
- First email exceeds 150 words: flag word count and offer a tighter version.
- No personalization beyond first name: ask for a trigger or account signal.
- Follow-up says "just checking in" or "circling back": replace with a new angle.
- HTML-heavy email: recommend plain text.
- CTA asks for a 30-45 minute meeting in email 1: suggest a lower-friction ask.

## Review Checklist

- Authentication is in place.
- Sending domain is warmed up or volume is low.
- Bounce risk is controlled.
- Plain text is used unless there is a reason not to.
- Opt-out language is included when needed.
- No deceptive subject line or sender claim is present.

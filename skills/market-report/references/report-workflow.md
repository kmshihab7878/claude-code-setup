# Marketing Report Workflow Reference

This reference contains the detailed workflow for building a client-ready marketing report from source audit data.

## Data Collection

Before generating the report, inspect available audit outputs:

- `MARKETING-AUDIT.md` from `/market audit`.
- `LANDING-CRO.md` from `/market landing`.
- `SEO-AUDIT.md` from `/market seo`.
- `BRAND-VOICE.md` from `/market brand`.
- `COMPETITOR-ANALYSIS.md` from `/market competitors`.
- `FUNNEL-ANALYSIS.md` from `/market funnel`.
- `CONTENT-AUDIT.md` from content analysis.
- `AD-AUDIT.md` from `/market ads`.
- `SOCIAL-AUDIT.md` from `/market social`.
- `EMAIL-AUDIT.md` from `/market emails`.

If source data is missing, offer:

1. Run a quick audit first.
2. Generate a report from user-provided information.
3. Create a fill-in report template.

## Category Deep Dives

For each category, provide:

1. Score and rating.
2. Key findings with evidence.
3. What is working.
4. Gaps and issues with severity.
5. Recommendations ranked by impact.
6. Revenue impact estimate with confidence, or insufficient-data note.

## Competitor Comparison

When competitor data exists, include:

| Factor | Client | Competitor 1 | Competitor 2 | Competitor 3 |
|---|---|---|---|---|
| Website Quality | X/10 | X/10 | X/10 | X/10 |
| SEO Visibility | X/10 | X/10 | X/10 | X/10 |
| Content Quality | X/10 | X/10 | X/10 | X/10 |
| Social Presence | X/10 | X/10 | X/10 | X/10 |
| Overall Position | Xth/4 | Xth/4 | Xth/4 | Xth/4 |

Also summarize:

- Competitive advantages.
- Competitive gaps.
- Opportunities competitors are not addressing.

## Content Quality Assessment

Summarize:

- Website copy: clarity, persuasiveness, brand alignment.
- Blog content: depth, expertise, SEO optimization, publishing cadence.
- Social media content: engagement quality, brand consistency, platform fit.
- Email content: subject lines, body copy, CTA strength.
- Ad creative: messaging clarity, visual quality, offer presentation.

## Conversion Optimization Summary

Compile:

- Primary conversion paths.
- Funnel leaks.
- CRO quick wins.
- A/B testing opportunities with hypotheses.
- Benchmark comparison where data exists.

## SEO Snapshot

Use a scannable format:

```text
SEO Health Snapshot:
- Title Tags: [Optimized / Needs Work / Missing]
- Meta Descriptions: [Optimized / Needs Work / Missing]
- H1 Tags: [Proper / Issues / Missing]
- Image Alt Text: [Complete / Partial / Missing]
- Page Speed: [Fast / Moderate / Slow]
- Mobile-Friendly: [Yes / Partially / No]
- Schema Markup: [Present / Partial / Missing]
- Robots.txt: [Configured / Issues / Missing]
- Sitemap: [Present / Issues / Missing]
- HTTPS: [Yes / No]
- Core Web Vitals: [Pass / Needs Work / Fail]
```

## Appendix

Include methodology notes:

- How each category was evaluated.
- Data sources used.
- Benchmarks referenced.
- Limitations and assumptions.
- Date of analysis.
- Tools or scripts used, such as `scripts/analyze_page.py` when applicable.
- Glossary of marketing terms used in the report.

# PDF Report JSON Schema and Fields

This reference contains the full JSON contract expected by `scripts/generate_pdf_report.py`.

## Full Structure

```json
{
  "url": "https://example.com",
  "date": "March 1, 2026",
  "brand_name": "Example Co",
  "overall_score": 62,
  "executive_summary": "A 2-4 sentence summary of marketing health, key opportunities, and estimated impact.",
  "categories": {
    "Content & Messaging": { "score": 68, "weight": "25%" },
    "Conversion Optimization": { "score": 52, "weight": "20%" },
    "SEO & Discoverability": { "score": 74, "weight": "20%" },
    "Competitive Positioning": { "score": 48, "weight": "15%" },
    "Brand & Trust": { "score": 70, "weight": "10%" },
    "Growth & Strategy": { "score": 55, "weight": "10%" }
  },
  "findings": [
    { "severity": "Critical", "finding": "Description of the most important finding" },
    { "severity": "High", "finding": "Description of a high-priority finding" },
    { "severity": "Medium", "finding": "Description of a medium-priority finding" },
    { "severity": "Low", "finding": "Description of a lower-priority finding" }
  ],
  "quick_wins": ["First quick win action item"],
  "medium_term": ["First medium-term action item"],
  "strategic": ["First strategic action item"],
  "competitors": [
    {
      "name": "Competitor A",
      "positioning": "Their market position",
      "pricing": "Their pricing model",
      "social_proof": "Their trust signals",
      "content": "Their content approach"
    }
  ]
}
```

## Required Fields

### `url`

Full target URL including protocol.

### `date`

Report date. Use a clear human-readable format, such as `March 1, 2026`.

### `brand_name`

Company or brand name. Used in the report and competitor table.

### `overall_score`

Integer from 0 to 100.

```text
overall_score = (content * 0.25) + (conversion * 0.20) + (seo * 0.20) + (competitive * 0.15) + (brand * 0.10) + (growth * 0.10)
```

### `executive_summary`

2-4 sentences covering:

- Current marketing health.
- Top 1-2 findings.
- Estimated impact if supported by data.
- Recommended first step.

### `categories`

Exactly six categories:

| Category | Measures | Scoring Guidance |
|---|---|---|
| Content & Messaging | Copy, value proposition, CTA text, brand voice | 80+ clear and specific; 60-79 adequate; below 60 vague |
| Conversion Optimization | Proof, forms, CTA placement, objections, urgency | 80+ optimized; 60-79 some elements; below 60 missing critical elements |
| SEO & Discoverability | Titles, meta, headers, schema, links, speed | 80+ optimized; 60-79 gaps; below 60 major issues |
| Competitive Positioning | Differentiation, pricing, comparison content | 80+ clear; 60-79 partial; below 60 unclear |
| Brand & Trust | Design quality, trust signals, credibility | 80+ strong trust; 60-79 adequate; below 60 weak |
| Growth & Strategy | Lead capture, email, content, acquisition | 80+ multi-channel; 60-79 some channels; below 60 unclear |

### `findings`

Use 5-10 findings. Each needs `severity` and `finding`.

Severity levels:

- `Critical`: directly losing revenue or customers.
- `High`: significant growth impact.
- `Medium`: meaningful improvement opportunity.
- `Low`: useful but lower priority.

Effective findings are specific, quantified when possible, benchmarked when possible, and evidence-backed.

### Action Arrays

Use 3-5 specific action items in each:

- `quick_wins`: implementable within one week.
- `medium_term`: 1-3 months.
- `strategic`: 3-6 months.

### `competitors`

Optional. Include up to three competitor objects. If no competitor data exists, omit the field so the script skips that section.

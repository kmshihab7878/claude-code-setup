# PDF Report Examples and Integration

This reference contains public-safe examples and integration guidance for PDF marketing reports.

## Recommended Workflow

1. Run `/market audit <url>` to generate comprehensive audit data.
2. Run `/market competitors <url>` to add competitor comparison data.
3. Run `/market seo <url>` to add SEO findings.
4. Run `/market landing <url>` to add CRO findings.
5. Run `/market report-pdf <url>` to compile everything into a PDF.

The PDF skill looks for output files from these skills and incorporates their data into the report JSON.

## Example Request

```text
/market report-pdf https://example.com
```

Expected result:

```text
MARKETING-REPORT-example-com.pdf
```

## Minimal JSON Snippet

```json
{
  "url": "https://example.com",
  "date": "March 1, 2026",
  "brand_name": "Example Co",
  "overall_score": 62,
  "executive_summary": "Example Co has a functional marketing foundation with clear opportunities in conversion and positioning. The fastest improvement path is to sharpen the homepage value proposition and add stronger proof near primary CTAs.",
  "categories": {
    "Content & Messaging": { "score": 68, "weight": "25%" },
    "Conversion Optimization": { "score": 52, "weight": "20%" },
    "SEO & Discoverability": { "score": 74, "weight": "20%" },
    "Competitive Positioning": { "score": 48, "weight": "15%" },
    "Brand & Trust": { "score": 70, "weight": "10%" },
    "Growth & Strategy": { "score": 55, "weight": "10%" }
  },
  "findings": [
    { "severity": "High", "finding": "Primary CTA is visible but the value proposition requires multiple sections to understand." }
  ],
  "quick_wins": ["Rewrite the homepage headline around the buyer's primary outcome."],
  "medium_term": ["Build a comparison page for the highest-intent competitor category."],
  "strategic": ["Create a quarterly content and conversion testing program."]
}
```

## Client-Facing Principles

- Treat the PDF as a first impression.
- Use the PDF for client/prospect presentation; use Markdown for deeper follow-up.
- Keep cover-page copy tight.
- Make opportunities compelling and realistic.
- Ensure every score can be explained.
- Avoid fake certainty or invented data.

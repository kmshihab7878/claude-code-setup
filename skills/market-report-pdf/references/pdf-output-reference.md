# PDF Output Reference

This reference describes generated PDF contents, colors, score mapping, and output expectations.

## PDF Contents

### Page 1: Cover Page

- Title: `Marketing Audit Report`.
- Target URL.
- Generation date.
- Overall score gauge with color coding.
- Grade letter from A+ through F.
- Executive summary.

### Page 2: Score Breakdown

- Horizontal bar chart for six category scores.
- Score table with category names, scores, weights, and status labels.
- Score color coding.

### Page 3: Key Findings

- Findings table with severity labels.
- Color-coded severity indicators.
- Ordered from most to least severe.

### Page 4: Prioritized Action Plan

- Quick wins: this week.
- Medium-term: 1-3 months.
- Strategic: 3-6 months.
- Numbered action items.

### Page 5: Competitive Landscape

Included only when competitor data exists.

- Client vs up to three competitors.
- Rows: positioning, pricing, social proof, content.

### Final Page: Methodology

- Scoring methodology.
- Category weights and criteria.
- Footer identifying the generator.

## Color Scheme

| Element | Color | Hex |
|---|---|---|
| Primary | Dark Navy | `#1B2A4A` |
| Accent | Blue | `#2D5BFF` |
| Highlight | Orange | `#FF6B35` |
| Success | Green | `#00C853` |
| Warning | Amber | `#FFB300` |
| Danger | Red | `#FF1744` |
| Light background | Light Gray | `#F5F7FA` |
| Body text | Dark Gray | `#2C3E50` |
| Secondary text | Medium Gray | `#7F8C9B` |
| Borders | Light Border | `#E0E6ED` |

## Score-to-Color Mapping

- 80-100: green, strong performance.
- 60-79: blue, solid with room to improve.
- 40-59: amber, needs attention.
- 0-39: red, critical issues.

## Output

- File: `MARKETING-REPORT-<domain>.pdf`.
- Location: project root by default.
- Typical size: 200KB-500KB.
- Typical length: 5-7 pages depending on competitor data and optional sections.

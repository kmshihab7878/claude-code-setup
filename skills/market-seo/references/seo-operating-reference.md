# SEO Operating Reference

Bulky audit rubrics, tables, templates, and detailed workflows extracted from
`../SKILL.md`. Load this file when performing a full SEO audit or when you need
specific criteria for a section.

## Automated Analysis Inputs

Run:

```bash
python3 scripts/analyze_page.py <url>
```

This script extracts:

- Title tag and meta description
- Open Graph tags
- Heading hierarchy (H1-H6)
- Links (internal and external)
- Images and alt text status
- Forms and CTAs
- Schema/structured data
- Social links
- Tracking scripts
- Viewport meta tag (mobile-friendliness indicator)
- Canonical tag
- Robots meta directives

Capture the JSON output and use it as the foundation for the manual analysis.

## On-Page SEO Checklist

Evaluate each element and score it as Pass, Needs Work, or Fail.

### Title Tag

| Criteria | Best Practice | Check |
|---|---|---|
| Exists | Every page must have a unique title tag | Pass/Fail |
| Length | 50-60 characters (displays fully in SERPs) | Pass/Needs Work/Fail |
| Primary keyword | Contains the primary target keyword | Pass/Needs Work/Fail |
| Keyword position | Primary keyword appears near the beginning | Pass/Needs Work/Fail |
| Brand name | Includes brand name, typically at the end | Pass/Needs Work/Fail |
| Uniqueness | Different from other pages on the site | Pass/Fail |
| Compelling | Would a searcher want to click this? | Pass/Needs Work/Fail |

Common title tag mistakes:

- Too long and truncated in search results
- Missing primary keyword
- Keyword stuffing
- Same title across multiple pages
- Generic titles such as "Home", "Welcome", or "Page 1"
- Missing brand name

### Meta Description

| Criteria | Best Practice | Check |
|---|---|---|
| Exists | Every page should have a meta description | Pass/Fail |
| Length | 150-160 characters | Pass/Needs Work/Fail |
| Primary keyword | Naturally includes the target keyword | Pass/Needs Work/Fail |
| Call to action | Includes a reason to click | Pass/Needs Work/Fail |
| Unique | Different from other pages | Pass/Fail |
| Compelling | Acts as ad copy for the search result | Pass/Needs Work/Fail |

### Heading Hierarchy

| Criteria | Best Practice | Check |
|---|---|---|
| H1 exists | Exactly one H1 per page | Pass/Fail |
| H1 contains keyword | Primary keyword in the H1 | Pass/Needs Work/Fail |
| H1 differs from title | H1 and title tag differ but relate | Pass/Needs Work/Fail |
| Logical hierarchy | H2 under H1, H3 under H2; no skipped levels | Pass/Needs Work/Fail |
| Descriptive subheadings | H2s/H3s describe content sections clearly | Pass/Needs Work/Fail |
| Keywords in subheadings | Secondary keywords appear naturally | Pass/Needs Work/Fail |
| Not overused | Headers are structure, not styling | Pass/Needs Work/Fail |

### Image Optimization

| Criteria | Best Practice | Check |
|---|---|---|
| Alt text | Every image has descriptive alt text | Pass/Needs Work/Fail |
| Alt text quality | Describes the image and uses keywords naturally | Pass/Needs Work/Fail |
| File names | Descriptive filenames, not generic camera names | Pass/Needs Work/Fail |
| File size | Images optimized for web; WebP preferred | Pass/Needs Work/Fail |
| Lazy loading | Below-fold images use lazy loading | Pass/Needs Work/Fail |
| Responsive images | Uses srcset or picture element | Pass/Needs Work/Fail |
| Decorative images | Decorative images use empty `alt=""` | Pass/Needs Work/Fail |

### Internal Linking

| Criteria | Best Practice | Check |
|---|---|---|
| Internal links present | Page links to other relevant site pages | Pass/Needs Work/Fail |
| Anchor text | Descriptive, not "click here" | Pass/Needs Work/Fail |
| Deep linking | Links go to specific pages, not just homepage | Pass/Needs Work/Fail |
| Relevant context | Links fit surrounding content | Pass/Needs Work/Fail |
| Reasonable count | 3-10 internal links per 1,000 words | Pass/Needs Work/Fail |
| Broken links | No broken internal links | Pass/Fail |

### URL Structure

| Criteria | Best Practice | Check |
|---|---|---|
| Readable | Human-readable and descriptive | Pass/Needs Work/Fail |
| Keywords | Contains relevant keywords | Pass/Needs Work/Fail |
| Length | Under 75 characters; ideally under 60 | Pass/Needs Work/Fail |
| Hyphens | Words separated by hyphens, not underscores | Pass/Fail |
| Lowercase | All lowercase characters | Pass/Fail |
| No parameters | Clean URL without unnecessary query parameters | Pass/Needs Work/Fail |
| Trailing slashes | Consistent use | Pass/Needs Work/Fail |

## Content Quality Assessment: E-E-A-T

Evaluate content against Google's experience, expertise, authoritativeness, and
trustworthiness framework.

### Experience

Does the content demonstrate first-hand experience with the topic?

Check for:

- Personal anecdotes, case studies, or real-world examples
- Screenshots, photos, or evidence of hands-on experience
- Specific details that only someone with experience would know
- "I did X and here's what happened" style content

Score: Strong / Present / Weak / Missing

### Expertise

Does the author have demonstrated knowledge in this subject?

Check for:

- Author bio with relevant credentials
- Depth of content
- Accurate information and data
- Proper industry terminology
- Links to authoritative sources

Score: Strong / Present / Weak / Missing

### Authoritativeness

Is the website or author recognized as an authority on this topic?

Check for:

- Author bylines with real names and bios
- About page with company background
- Industry awards or certifications
- Backlinks from authoritative sites
- Media mentions or press coverage
- Guest posts on industry publications

Score: Strong / Present / Weak / Missing

### Trustworthiness

Can users trust this content and this website?

Check for:

- HTTPS
- Privacy policy and terms of service
- Physical address and contact information
- Customer reviews and testimonials
- Security badges and certifications
- Transparent business practices
- Accurate, up-to-date information
- Properly sourced claims and statistics

Score: Strong / Present / Weak / Missing

## Keyword Analysis

### Primary Keyword Assessment

| Element | Evaluation |
|---|---|
| Primary keyword identified | What keyword is this page targeting? |
| Search intent alignment | Does the content match informational, commercial, transactional, or navigational intent? |
| Keyword in title | Presence, position, natural usage |
| Keyword in H1 | Presence and natural usage |
| Keyword in first 100 words | Appears early in the content |
| Keyword in subheadings | Appears in at least one H2 or H3 |
| Keyword in meta description | Present and natural |
| Keyword in URL | Present |
| Keyword density | 1-2% is ideal; over 3% is stuffing |

### Secondary Keywords

Identify 5-10 related keywords that should be naturally included:

- Synonyms and variations of the primary keyword
- Long-tail variations
- Related questions
- Latent semantic indexing terms

### Search Intent Analysis

| Intent Type | User Goal | Content Should Be |
|---|---|---|
| Informational | Learn something | Blog post, guide, tutorial, FAQ |
| Commercial | Compare options | Comparison page, review, list |
| Transactional | Buy something | Product page, pricing page, checkout |
| Navigational | Find a specific page | Homepage, login page, specific tool |

Misalignment is a ranking killer. If the user searches "how to do X" and lands
on a sales page, they bounce.

## Technical SEO Quick Check

### Robots.txt

Check whether `/robots.txt` exists and is properly configured:

- [ ] robots.txt is accessible
- [ ] Not blocking important pages or resources
- [ ] Points to sitemap.xml
- [ ] Not blocking CSS/JS

### XML Sitemap

Check whether `/sitemap.xml` exists:

- [ ] Sitemap exists and is accessible
- [ ] Contains all important pages
- [ ] No broken URLs in sitemap
- [ ] Submitted to Google Search Console
- [ ] Last modified dates are accurate

### Canonical Tags

- [ ] Canonical tag present on the page
- [ ] Points to the correct URL
- [ ] Consistent with robots.txt and sitemap

### Page Speed

| Metric | Good | Needs Work | Poor |
|---|---|---|---|
| Largest Contentful Paint (LCP) | Under 2.5s | 2.5-4.0s | Over 4.0s |
| First Input Delay (FID) | Under 100ms | 100-300ms | Over 300ms |
| Cumulative Layout Shift (CLS) | Under 0.1 | 0.1-0.25 | Over 0.25 |
| Time to First Byte (TTFB) | Under 200ms | 200-500ms | Over 500ms |
| First Contentful Paint (FCP) | Under 1.8s | 1.8-3.0s | Over 3.0s |

Common speed issues to flag:

- Unoptimized images; recommend WebP format and compression
- Render-blocking JavaScript or CSS
- Missing browser caching headers
- Missing CDN
- Excessive third-party scripts
- Unminified CSS and JavaScript
- Missing gzip or brotli compression

### Mobile-Friendliness

- [ ] Viewport meta tag present
- [ ] Text readable without zooming, minimum 16px body text
- [ ] Tap targets at least 48x48px
- [ ] No horizontal scrolling required
- [ ] Responsive images
- [ ] Forms usable on mobile

## Content Gap Analysis

Methodology:

1. Identify the main topic cluster.
2. Map existing content.
3. Identify missing subtopics competitors cover.
4. Analyze People Also Ask questions.
5. Check related searches.

| Missing Topic | Search Volume Potential | Competition | Content Type Needed | Priority |
|---|---|---|---|---|
| [Topic] | High/Med/Low | High/Med/Low | Blog/Guide/Tool/Page | 1-5 |

## Featured Snippet Optimization

Types:

1. Paragraph snippet: answer in 40-60 words after a clear question heading.
2. List snippet: use ordered or unordered lists with the target query in an H2.
3. Table snippet: use HTML tables with clear headers.
4. Video snippet: include video with descriptive title and timestamps.

Checklist:

- [ ] Target question-based queries
- [ ] Place answer immediately after the question heading
- [ ] Keep paragraph answers between 40-60 words
- [ ] Use structured lists and tables where appropriate
- [ ] Include the target query in an H2 or H3

## Schema Markup Audit

| Schema Type | Applicable To | Status |
|---|---|---|
| Organization | Homepage, About page | Present/Missing |
| LocalBusiness | Local businesses | Present/Missing/N/A |
| Product | Product pages | Present/Missing/N/A |
| Article | Blog posts, news | Present/Missing/N/A |
| FAQ | FAQ sections | Present/Missing |
| HowTo | Tutorial content | Present/Missing/N/A |
| Review/AggregateRating | Reviews, testimonials | Present/Missing/N/A |
| BreadcrumbList | Pages with breadcrumbs | Present/Missing |
| WebSite/SearchAction | Homepage | Present/Missing |
| Event | Event pages | Present/Missing/N/A |

Implementation guidance:

- Use JSON-LD format.
- Validate with Google's Rich Results Test.
- Do not mark up content that is not visible on the page.
- Keep schema data consistent with on-page content.

## Internal Linking Opportunities

Identify:

1. Orphan pages with no internal links pointing to them.
2. Hub pages that should link to related content.
3. Topical clusters and linking structures.
4. CTA links from content to product or service pages.
5. Footer/sidebar links to important pages.

Architecture pattern:

```text
Homepage
  |-- Category/Service Pages (Pillar Content)
       |-- Individual Blog Posts/Articles (Cluster Content)
            |-- Back-links to Pillar Content
  |-- Key Conversion Pages (Pricing, Signup, Contact)
       |-- Linked from relevant content
```

## Core Web Vitals Impact Assessment

Research-backed impacts:

- Sites passing all Core Web Vitals see fewer page abandonments.
- A 100ms decrease in LCP can correlate with higher conversion rates.
- Reducing CLS can correlate with lower bounce rate.
- Pages loading within 2 seconds usually retain users better than slow pages.

| Metric | If Failing | Typical Fixes |
|---|---|---|
| LCP | Over 2.5s | Optimize hero image, preload critical resources, use CDN, reduce server response time |
| FID/INP | Over 100ms | Reduce JavaScript execution, defer non-critical scripts, use web workers |
| CLS | Over 0.1 | Set image dimensions, reserve space for embeds, avoid inserting content above existing content |

## Blog and Content Strategy Recommendations

Recommend:

1. Publishing cadence based on competition and resources.
2. Content types: blog posts, guides, tools, videos, infographics.
3. Keyword targeting balance between high-volume and long-tail.
4. Content length benchmarked against top-ranking content.
5. Content update strategy.
6. Distribution plan beyond organic search.

| Content Idea | Search Volume | Competition | Business Value | Priority Score |
|---|---|---|---|---|
| [Topic] | High/Med/Low | High/Med/Low | High/Med/Low | 1-10 |

Scoring: high volume + low competition + high business value = highest
priority.

## SEO-AUDIT.md Template

```markdown
# SEO Content Audit
## [URL]
### Date: [Date]

---

## SEO Health Score: [X/100]

---

## On-Page SEO Checklist

### Title Tag
- Status: [Pass/Needs Work/Fail]
- Current: "[current title]"
- Recommended: "[improved title]"
- Issues: [list issues]

### Meta Description
- Status: [Pass/Needs Work/Fail]
- Current: "[current meta]"
- Recommended: "[improved meta]"

### Heading Hierarchy
[H1-H6 structure analysis]

### Image Optimization
[Alt text audit results]

### Internal Linking
[Link analysis]

### URL Structure
[URL assessment]

---

## Content Quality (E-E-A-T)
| Dimension | Score | Evidence |
|---|---|---|
| Experience | [Strong/Present/Weak/Missing] | [details] |
| Expertise | [Strong/Present/Weak/Missing] | [details] |
| Authoritativeness | [Strong/Present/Weak/Missing] | [details] |
| Trustworthiness | [Strong/Present/Weak/Missing] | [details] |

---

## Keyword Analysis
- Primary Keyword: [keyword]
- Search Intent: [type]
- Keyword Placement: [checklist results]
- Secondary Keywords: [list]

---

## Technical SEO
[Quick check results]

---

## Content Gap Analysis
[Missing topics table]

---

## Featured Snippet Opportunities
[Specific opportunities]

---

## Schema Markup
[Current vs recommended]

---

## Internal Linking Opportunities
[Specific recommendations]

---

## Core Web Vitals
[Performance assessment with revenue impact]

---

## Content Strategy Recommendations
[Publishing plan, content priorities]

---

## Prioritized Recommendations

### Critical (Fix Immediately)
1. [recommendation with expected impact]

### High Priority (This Month)
1. [recommendation]

### Medium Priority (This Quarter)
1. [recommendation]

### Low Priority (When Resources Allow)
1. [recommendation]
```

## Key Principles

- SEO audits should be educational, not just diagnostic.
- Always provide the before state and recommended after state.
- Tie SEO improvements to business outcomes.
- Use automated script data as a starting point, then add interpretation.
- Prioritize recommendations by effort-to-impact ratio.
- Cross-reference `/market audit` or `/market landing` findings when relevant.

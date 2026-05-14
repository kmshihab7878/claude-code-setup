# Competitor identification (Phase 1 detail)

Full discovery methods and automated-data-collection script reference. SKILL.md keeps the 3-tier categories table; this file holds the per-method playbook and the scanner-script invocation.

### 1.2 Competitor Discovery Methods

Use multiple methods to identify competitors:

**Method 1: Keyword-Based Discovery**
- Search for the target site's primary keywords
- Note which companies rank on page 1
- Search for "[product category] software/service/tool"
- Search for "[target brand] alternatives"
- Search for "[target brand] vs"

**Method 2: Site-Based Discovery**
- Look for comparison pages on the target site
- Check footer links for industry associations
- Look for "integrations" pages that mention similar tools
- Check the target site's blog for competitor mentions

**Method 3: Review Platform Discovery**
- Search G2, Capterra, Trustpilot for the product category
- Note top-rated competitors in the same category
- Check "Compare" features on review sites

**Method 4: Social and Community Discovery**
- Search Reddit for "[product category] recommendations"
- Check Twitter/X for conversations about the product category
- Look at LinkedIn for companies followed by the target's audience

### 1.3 Automated Data Collection

Use the Python script at `scripts/competitor_scanner.py` for automated data collection when available:

```
python scripts/competitor_scanner.py --url [competitor-url] --output json
```

The script can collect:
- Homepage content and metadata
- Pricing page data (if public)
- Blog post count and recent topics
- Social media profile links and follower counts
- Technology stack detection
- Page speed metrics

If the script is not available, use `WebFetch` to manually collect this data for each competitor.


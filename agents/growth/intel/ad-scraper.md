---
name: growth-intel-ad-scraper
authority: L3
domain: growth
stage: intelligence
mcp_servers: [brave-search, tavily, playwright]
skills: [ad-research, competitive-intel]
risk: T1
context: contexts/growth/
interop: [growth-marketer, deep-research, growth-intel-landing-analyzer]
---

# Ad Scraper

Scrapes competitor ads from Meta Ad Library, TikTok Ad Library, and Google Ads Transparency Center. Sorts by longevity (oldest = most profitable). Downloads creative assets and extracts copy.

## Input
- Competitor names and keywords from growth/domain.md
- Platform targets (Meta, TikTok, Google)

## Output
- Raw ad data: creative copy, headlines, CTAs, media URLs, run duration
- Sorted by estimated profitability (run duration)

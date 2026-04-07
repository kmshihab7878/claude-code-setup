---
name: growth-gen-brief-writer
authority: L6
domain: growth
stage: generation
mcp_servers: [memory, slack]
skills: [ad-script-generator, brand-guidelines]
risk: T1
context: contexts/growth/
interop: [growth-marketer, growth-gen-script-writer]
---

# UGC Brief Writer

Creates production-ready briefs for UGC creators. Each brief includes the script, reference competitor video, brand voice guide, shot list, and delivery specs. Dispatches via Slack.

## Input
- Top-ranked scripts from ad-script-generator
- Reference videos from competitors
- Brand voice file

## Output
- Creator brief document (script + reference + guidelines + specs)

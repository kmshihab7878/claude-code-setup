# Pricing models (value metric deep dives + tier design)

Per-metric SaaS examples, choice criteria, red flags, and full Good-Better-Best tier design principles. SKILL.md keeps the 6-row value-metric decision table and the per-tier essentials; this file holds the deeper rationale and the full feature-category matrix.

### Common Value Metrics for SaaS

| Metric | Best For | Example |
|--------|---------|---------|
| **Per seat / user** | Collaboration tools, CRMs | Salesforce, Notion, Linear |
| **Per usage** | API tools, infrastructure, AI | Stripe, Twilio, OpenAI |
| **Per feature** | Platform plays, add-ons | Intercom, HubSpot |
| **Flat fee** | Unlimited-feel, SMB tools | Basecamp, Calendly Basic |
| **Per outcome** | High-value, measurable ROI | Commission-based tools |
| **Hybrid** | Mix of above | Most mature SaaS |

### How to Choose

Answer these questions:

1. **What makes a customer willing to pay more?** → That's your value metric
2. **Does the metric scale with their success?** → If they grow, you grow
3. **Is it easy to understand?** → Complexity kills conversion
4. **Is it hard to game?** → Customers shouldn't be able to work around it

**Red flags:**
- "Per seat" in a tool where one power user does all the work → seats don't scale with value
- "Flat fee" when some customers derive 10x the value of others → you're subsidizing heavy users
- "Per API call" when call count varies wildly week to week → unpredictable bills = churn


## Good-Better-Best Tier Structure

Three tiers is the standard. Not because of tradition — because it anchors perception.

### Tier Design Principles

**Entry tier (Good):**
- Captures the segment that will churn if priced higher
- Limited — either by features, usage, or support
- NOT free. Free is a separate strategy (freemium), not a tier.
- Should cover your costs at minimum

**Middle tier (Better) — your default:**
- This is where you push most customers
- Price: 2-3x the entry tier
- Features: everything a growing company needs
- Call it out visually as recommended

**Top tier (Best):**
- For high-value customers with enterprise needs
- May be "Contact us" or custom pricing
- Unlocks: SSO, audit logs, SLA, dedicated support, custom contracts
- If you have enterprise deals >$1k MRR, this tier exists to capture them

### What Goes in Each Tier

| Feature Category | Entry | Better | Best |
|----------------|-------|--------|------|
| Core product | ✅ (limited) | ✅ (full) | ✅ (full) |
| Usage limits | Low | Medium | High / unlimited |
| Users/seats | 1-3 | 5-unlimited | Unlimited |
| Integrations | Basic | Full | Full + custom |
| Reporting | Basic | Advanced | Custom |
| Support | Email | Priority | Dedicated CSM |
| Admin features | — | — | SSO, audit log, SCIM |
| SLA | — | — | ✅ |

See [references/pricing-models.md](references/pricing-models.md) for model deep dives and SaaS examples.

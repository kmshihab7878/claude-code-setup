# Funnel discovery and mapping (Phase 1 detail)

Full 8-row funnel-type decision table, the per-step mapping schema, and the visual funnel-map template. SKILL.md keeps the funnel-type names + mapping fields; this file holds the full tables and example map.

## Phase 1: Funnel Discovery and Mapping

### 1.1 Identify the Funnel Type

Detect which funnel type the site uses:

| Funnel Type | Business Model | Typical Steps | Key Metric |
|-------------|---------------|---------------|------------|
| **Lead Gen** | Services, agencies, B2B | Landing page -> Form -> Thank you -> Nurture -> Sales call | Lead-to-close rate |
| **SaaS Trial** | SaaS products | Homepage -> Pricing -> Signup -> Onboarding -> Upgrade | Trial-to-paid rate |
| **SaaS Demo** | Enterprise SaaS | Homepage -> Features -> Demo request -> Sales call -> Close | Demo-to-close rate |
| **E-commerce** | Online stores | Product page -> Cart -> Checkout -> Upsell -> Thank you | Cart-to-purchase rate |
| **Webinar** | Courses, coaches, SaaS | Opt-in -> Confirmation -> Reminder -> Live -> Offer -> Checkout | Webinar-to-sale rate |
| **Application** | Premium services, programs | Info page -> Application form -> Review -> Interview -> Accept | Application-to-accept rate |
| **Community** | Memberships, communities | Landing -> Free trial/preview -> Engage -> Paid membership | Free-to-paid rate |
| **Content** | Media, publishers | Blog -> Email capture -> Nurture -> Premium content -> Subscribe | Reader-to-subscriber rate |

### 1.2 Map Every Funnel Step

For each page in the funnel, document:

```
STEP [#]: [Page Name]
  URL: [url]
  Page Type: [landing/product/pricing/cart/checkout/form/thank-you]
  Primary Action: [what the user should do on this page]
  Next Step: [where the user should go next]
  Exit Points: [where users might leave instead]
  Friction Elements: [anything that slows or confuses]
  Trust Elements: [anything that builds confidence]
  Load Time: [estimated based on page complexity]
```

### 1.3 Visual Funnel Map

Create an ASCII funnel map showing the flow:

```
VISITOR JOURNEY MAP
===================

Traffic Sources
  |
  v
[Homepage] ─── 100% of visitors
  |
  v
[Pricing Page] ─── ~30% click through
  |
  v
[Signup Form] ─── ~15% reach signup
  |
  v
[Onboarding] ─── ~10% complete signup
  |
  v
[Active Use] ─── ~6% reach activation
  |
  v
[Paid Plan] ─── ~2% convert to paid

Overall: 2% visitor-to-paid conversion
```

Adjust this template to match the actual funnel discovered on the site.

---

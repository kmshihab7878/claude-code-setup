# Form, mobile, and page-speed audits (Steps 4–6 detail)

Form-optimization rules (field count, labels, button text, validation, multi-step, required/optional, auto-fill, field types), mobile responsiveness checklist (thumb-reach, readability, tap targets, sticky CTA), page-speed conversion-impact benchmark table (0–8s+) and common speed issues. SKILL.md keeps the headline rules and conversion-impact summary; this file holds the full audit checklists.

### Step 4: Form Optimization Audit
If the page has a form, evaluate:

| Element | Best Practice |
|---|---|
| Field count | Every additional field reduces conversion ~7%. Lead capture: 3-5 fields max. |
| Labels | Use inline labels or floating labels. Avoid placeholder-only labels. |
| Button text | Match the value proposition. "Get My Free Guide" > "Submit". |
| Error handling | Inline validation. Specific error messages. Don't clear the entire form on error. |
| Multi-step | Break long forms into steps with progress indicator. |
| Required vs optional | Mark optional fields, not required ones. |
| Auto-fill | Enable browser auto-fill for standard fields. |
| Field types | Use appropriate input types (email, tel, url) for mobile keyboards. |

### Step 5: Mobile Responsiveness Audit
Mobile accounts for 60%+ of web traffic. Check:

- [ ] CTA is thumb-reachable (bottom half of screen)
- [ ] Text is readable without zooming (16px minimum body text)
- [ ] Forms are usable on mobile (large tap targets, appropriate keyboards)
- [ ] Images resize properly and don't break layout
- [ ] No horizontal scrolling required
- [ ] Page loads under 3 seconds on 4G
- [ ] Click-to-call for phone numbers
- [ ] Sticky CTA bar on scroll (if applicable)

### Step 6: Page Speed Impact Assessment
Reference these conversion impact benchmarks:

| Load Time | Conversion Impact |
|---|---|
| 0-2 seconds | Baseline (optimal) |
| 2-3 seconds | -7% conversion rate |
| 3-5 seconds | -20% conversion rate |
| 5-8 seconds | -35% conversion rate |
| 8+ seconds | -50%+ conversion rate |

Check for common speed issues:
- Unoptimized images (use WebP, lazy loading)
- Render-blocking JavaScript
- Missing browser caching
- No CDN
- Excessive third-party scripts
- Unminified CSS/JS

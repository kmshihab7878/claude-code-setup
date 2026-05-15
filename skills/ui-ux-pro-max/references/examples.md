# UI/UX Pro Max Examples

This reference contains public-safe examples for using the skill.

## Landing Page Example

User request:

```text
Create a landing page for a professional skincare service.
```

Analysis:

- Product type: service landing page.
- Industry: beauty and wellness.
- Style: elegant, calm, professional.
- Stack: default `html-tailwind` unless specified.

Search:

```bash
python3 scripts/search.py "beauty spa wellness service elegant" --design-system -p "Example Spa"
python3 scripts/search.py "animation accessibility" --domain ux
python3 scripts/search.py "elegant luxury serif" --domain typography
python3 scripts/search.py "layout responsive form" --stack html-tailwind
```

Output should include a design system, page structure, CTA strategy, accessible implementation, and validation notes.

## Dashboard Review Example

User request:

```text
Review this analytics dashboard for UI/UX issues.
```

Review path:

1. Inspect layout, chart types, tables, filters, states, and responsiveness.
2. Check contrast, focus states, labels, and keyboard paths.
3. Check loading, empty, and error states.
4. Report findings by severity with evidence and fixes.

Useful searches:

```bash
python3 scripts/search.py "analytics dashboard chart accessibility" --design-system -p "Dashboard Review"
python3 scripts/search.py "chart table dashboard" --domain chart
python3 scripts/search.py "keyboard focus data table" --domain ux
```

## Component Fix Example

User request:

```text
Fix the mobile navbar, modal focus state, and button hover behavior.
```

Execution path:

1. Inspect existing component patterns.
2. Keep existing style and token conventions.
3. Fix layout and interaction defects.
4. Validate mobile width, keyboard focus, hover, and reduced motion.
5. Report files changed and checks performed.

## Final Report Pattern

```text
Scope: [screen/component/page]
Design system: [new/existing/not needed]
Changes: [files or design decisions]
Accessibility checks: [contrast/focus/labels/motion]
Responsive checks: [viewports]
Validation: [commands/screenshots/browser notes]
Remaining risks: [known gaps]
```

# UI/UX Pro Max Critique and Troubleshooting Reference

This reference contains critique rubrics, failure modes, and repair guidance.

## Critique Priority

Review in this order:

1. Broken interaction or navigation.
2. Accessibility blockers.
3. Mobile layout defects.
4. Readability and contrast.
5. Information architecture and task flow.
6. Loading, empty, and error states.
7. Visual hierarchy and spacing.
8. Motion, polish, and brand expression.

## Critique Rubric

For each issue, report:

- Location.
- User impact.
- Severity.
- Evidence.
- Recommended fix.
- Validation method.

Prefer concrete findings over taste-only feedback.

## Common Failure Modes

| Symptom | Likely Cause | Fix |
|---|---|---|
| Page feels generic | No product-specific visual language | Revisit product type, audience, style, and differentiation |
| Mobile has horizontal scroll | Fixed widths or overflowing tables | Use responsive grids, wrapping, and table alternatives |
| UI looks low contrast | Muted text or transparent surfaces too light | Raise contrast and test both themes |
| Clickable cards feel dead | No cursor or hover/focus feedback | Add pointer cursor and state changes |
| Layout jumps while loading | Async content lacks reserved space | Add skeletons or stable dimensions |
| Animations feel heavy | Long durations or layout-affecting properties | Use transform/opacity and shorter timing |
| Icons feel inconsistent | Mixed icon sets or emoji icons | Use one SVG icon family |
| Form feels hard to use | Missing labels, weak errors, poor focus order | Add labels, inline errors, and keyboard review |
| Chart is hard to read | Wrong chart type or inaccessible colors | Match chart to data question and add table fallback |

## Troubleshooting Flow

1. Reproduce the issue at the relevant viewport.
2. Identify whether it is layout, state, accessibility, performance, or data clarity.
3. Inspect existing design-system conventions.
4. Apply the smallest fix that preserves the product style.
5. Validate at mobile and desktop widths.
6. Re-check keyboard and focus behavior for interactive changes.
7. Document any residual risk.

## Accessibility Repair Patterns

- Missing label: add visible label or appropriate accessible name.
- Weak focus: add high-contrast focus ring.
- Small tap target: increase hit area without disrupting layout.
- Color-only state: add text, icon, shape, or pattern.
- Motion issue: add reduced-motion fallback.
- Modal issue: trap focus, label dialog, and restore focus on close.

## Visual Repair Patterns

- Weak hierarchy: adjust size, weight, spacing, and grouping before adding decoration.
- Crowded layout: increase section rhythm and reduce competing elements.
- Unclear CTA: make one primary action visually dominant.
- Inconsistent cards: standardize padding, border radius, border, and elevation.
- Overstyled UI: remove effects that do not support task clarity.

## Review Language

Use clear verdicts:

- `Blocking`: prevents use or violates accessibility.
- `High`: likely harms conversion, comprehension, or task completion.
- `Medium`: noticeable quality or consistency issue.
- `Low`: polish or preference, not user-blocking.

Avoid unsupported claims. Tie feedback to observed UI, code, screenshots, or known accessibility rules.

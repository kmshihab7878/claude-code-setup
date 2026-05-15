# UI/UX Pro Max Accessibility and Validation Reference

This reference contains accessibility requirements and pre-delivery validation checks.

## Accessibility Requirements

- Text contrast: 4.5:1 minimum for normal text and 3:1 minimum for large text.
- Focus states: every interactive element must have visible keyboard focus.
- Keyboard navigation: tab order should match visual order and all controls must be reachable.
- Touch targets: interactive targets should be at least 44x44px.
- Labels: form inputs need programmatic labels.
- Errors: validation errors should be clear, located near the field, and announced when possible.
- Images: meaningful images need alt text; decorative images should be ignored by assistive tech.
- Icon buttons: icon-only controls need accessible names.
- Motion: respect `prefers-reduced-motion`.
- Color: do not use color as the only state or data indicator.

## Responsive Validation

Check realistic widths:

- 375px mobile.
- 768px tablet.
- 1024px laptop.
- 1440px desktop.

Verify:

- No horizontal scroll on mobile.
- Text does not overlap or clip.
- Fixed and floating elements do not cover content.
- Navigation remains usable.
- Tables, cards, charts, and forms adapt without layout breakage.
- Tap targets remain usable.

## Visual Quality Checklist

- No emojis used as UI icons.
- Icons come from a consistent SVG set.
- Brand logos are correct and sourced.
- Hover states do not cause layout shift.
- Theme colors are applied consistently.
- Text hierarchy is clear.
- Spacing is consistent.
- Empty, loading, and error states are designed.

## Interaction Checklist

- Clickable elements have pointer cursor.
- Hover states provide visible feedback.
- Focus states are visible.
- Transitions are smooth and not excessive.
- Async buttons show loading state and prevent duplicate submission.
- Destructive actions require confirmation or clear friction.

## Light and Dark Mode Checklist

- Light mode text has sufficient contrast.
- Transparent or glass elements remain visible in light mode.
- Borders remain visible in both modes.
- Shadows and elevation work in both themes.
- Disabled, hover, active, and focus states are readable.

## Accessibility Checklist

- Images have alt text where meaningful.
- Form inputs have labels.
- Color is not the only indicator.
- Focus states are visible.
- Reduced motion is respected.
- Headings are hierarchical.
- ARIA is used only where semantic HTML is insufficient.

## Validation Evidence

Use the strongest available evidence:

- Browser screenshots.
- Browser interaction checks.
- Automated accessibility report.
- Unit or component tests.
- Responsive viewport inspection.
- Manual keyboard navigation notes.
- Command output for build, lint, test, or typecheck.

Do not claim verification that was not performed.

# Interface Accessibility and Validation Reference

This reference contains usability, accessibility, responsive, and pre-delivery validation checks for interface design work.

## Usability Constraints

- The primary task should be visible without reading the whole screen.
- Controls should reveal their affordance through shape, label, cursor, hover, and focus state.
- Dense interfaces still need hierarchy: grouping, spacing, dividers, and type levels.
- Loading, empty, and error states must be designed, not left as afterthoughts.
- Data presentation should answer a user question or enable an action.
- Fixed and floating elements must not hide content.

## Accessibility Constraints

- Maintain readable contrast for all text and critical UI states.
- Do not communicate meaning with color alone.
- Keep keyboard focus visible.
- Preserve logical tab and reading order.
- Use semantic controls where possible.
- Provide labels for form inputs and accessible names for icon-only controls.
- Make destructive actions clear and recoverable where possible.
- Respect reduced-motion preferences.

## Responsive Checks

Check at relevant widths:

- 375px mobile.
- 768px tablet.
- 1024px laptop.
- 1440px desktop.

Confirm:

- No horizontal scroll on mobile.
- Tables, filters, cards, and sidebars adapt intentionally.
- Fixed navigation does not cover content.
- Touch targets remain usable.
- Text does not overlap, clip, or shrink below readable sizes.

## Mandate Checks

Run before showing the user:

- Swap test: replacing type, layout, palette, or component treatment with common defaults should materially change feel.
- Squint test: hierarchy should remain visible without harsh lines.
- Signature test: identify five concrete places where the signature appears.
- Token test: token names and values should fit the product's world.
- System consistency check: if `.interface-design/system.md` exists, values should match it.

## Pre-Delivery Checklist

- Intent, palette, depth, typography, and spacing are coherent.
- States exist for interactive and data elements.
- Navigation context is clear.
- Spacing follows a grid or base unit.
- Surface hierarchy is consistent.
- Text hierarchy has enough levels.
- Accessibility constraints are checked.
- Responsive behavior is checked.
- The final report includes validation evidence and residual risks.

For deeper critique protocol, see [critique.md](critique.md) and [validation.md](validation.md).

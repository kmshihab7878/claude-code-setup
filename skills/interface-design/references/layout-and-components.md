# Interface Layout and Component Reference

This reference contains layout, component, token, state, navigation, and visual-system guidance for crafted product interfaces.

## Contents

- [Craft Foundations](#craft-foundations)
- [Design Principles](#design-principles)
- [Avoid](#avoid)
- [Component Intent Checkpoint](#component-intent-checkpoint)

## Craft Foundations

- Subtle layering: surfaces stack through quiet lightness shifts. Sidebars often share the canvas background; dropdowns sit one level above parent; inputs are inset.
- Borders: borders should disappear when not needed and be findable when structure matters. Prefer low-opacity rgba and a 4-step progression.
- Squint test: blur the interface and confirm hierarchy remains visible without harsh lines.
- Infinite expression: architecture and components should emerge from this task and data, not a template.
- Color lives somewhere: palette should feel sourced from the product's world, not selected as generic decoration.

For full prose and examples, see [craft-foundations.md](craft-foundations.md).

## Design Principles

| # | Topic | Essentials |
|---|---|---|
| 1 | Token architecture | Every color traces back to primitives. Avoid random hex values. |
| 2 | Text hierarchy | Use at least primary, secondary, tertiary, and muted text levels. |
| 3 | Border progression | Build standard, soft, emphasis, and focus levels. |
| 4 | Control tokens | Dedicated tokens for controls, borders, and focus states. |
| 5 | Spacing | Use a base unit and multiples across micro, component, section, and major spacing. |
| 6 | Padding | Symmetrical unless content naturally requires asymmetry. |
| 7 | Depth | Pick one depth strategy and commit. |
| 8 | Border radius | Sharper feels technical; rounder feels friendly. Use a scale. |
| 9 | Typography | Combine size, weight, spacing, and numeric treatment. Data often needs tabular numbers. |
| 10 | Card layouts | Vary internal structure by content type while keeping surface treatment consistent. |
| 11 | Controls | Custom select/date controls need explicit state management when native styling is insufficient. |
| 12 | Iconography | Icons clarify; remove icons that add no meaning. Use one set. |
| 13 | Animation | Fast micro-interactions with deceleration easing; avoid bounce in professional tools. |
| 14 | States | Cover default, hover, active, focus, disabled, loading, empty, and error. |
| 15 | Navigation context | Screens need grounding: where am I, where can I go, and who am I as. |
| 16 | Dark mode | Lean on borders and adjusted semantic colors; do not only invert light mode. |

For full per-topic detail, see [design-principles.md](design-principles.md) and [principles.md](principles.md).

## Avoid

- Harsh borders that dominate before content.
- Dramatic surface jumps.
- Inconsistent spacing.
- Mixed depth strategies.
- Missing interaction states.
- Heavy decorative shadows.
- Large radius on small elements.
- Pure white cards on colored backgrounds.
- Thick decorative borders.
- Gradients or color used only as decoration.
- Multiple competing accent colors.
- Different hues for different surface levels unless the product domain demands it.

## Component Intent Checkpoint

Before writing a component, state:

```text
Intent:     [who this human is, what they must do, how it should feel]
Palette:    [colors from the domain and why they fit]
Depth:      [border, shadow, or surface strategy and why]
Surfaces:   [elevation scale and color temperature]
Typography: [typeface and hierarchy rationale]
Spacing:    [base unit and density rationale]
```

If any answer is "common", "clean", or "it works", the component is defaulting.

## Navigation Guidance

- Navigation is part of the product, not chrome around it.
- Ground every screen with location, available paths, and current role or context where relevant.
- Sidebars should generally share canvas background and use border separation instead of unrelated colors.
- Data-heavy tools need fast scanning and stable control placement.

## Data Guidance

- A number is not design until it communicates meaning and action.
- Choose progress rings, badges, stacked labels, tables, or charts based on the user's decision.
- Preserve density where experts need comparison.
- Use chart alternatives and table fallbacks for accessibility and precision.

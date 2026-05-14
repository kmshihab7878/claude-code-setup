# Design principles (full catalog)

Per-topic design principles: token architecture, spacing, padding, depth, border radius, typography, card layouts, controls, iconography, animation, states, navigation context, dark mode. SKILL.md keeps a compact list of the 13 topics with one-line summaries; this file holds the full per-topic rules.

# Design principles

## Token architecture

Every color traces back to a small set of primitives: foreground (text hierarchy), background (surface elevation), border (separation hierarchy), brand, semantic (destructive, warning, success). No random hex — everything maps to primitives.

### Text hierarchy

Four levels — primary, secondary, tertiary, muted. Each serves a role: default text, supporting text, metadata, disabled/placeholder. Use all four consistently. Two levels = flat hierarchy.

### Border progression

Borders aren't binary. Build a scale matching intensity to importance — standard separation, softer separation, emphasis, max emphasis. Not every boundary deserves the same weight.

### Control tokens

Form controls have specific needs. Don't reuse surface tokens — create dedicated control backgrounds, control borders, focus states. Tune interactive elements independently from layout surfaces.

## Spacing

Base unit + multiples. Build scale per context — micro (icon gaps), component (inside buttons/cards), section (between groups), major (between distinct areas). Random values = no system.

## Padding

Symmetrical. If one side has a value, others match unless content naturally requires asymmetry.

## Depth

Choose ONE approach and commit:
- **Borders-only** — clean, technical. Dense tools.
- **Subtle shadows** — soft lift. Approachable products.
- **Layered shadows** — premium, dimensional. Cards needing presence.
- **Surface color shifts** — background tints establish hierarchy without shadows.

Don't mix.

## Border radius

Sharper = technical. Rounder = friendly. Build a scale — small for inputs/buttons, medium for cards, large for modals. Don't mix sharp + soft randomly.

## Typography

Distinct levels distinguishable at a glance. Headlines: weight + tight tracking for presence. Body: comfortable weight for readability. Labels: medium weight that works at small sizes. Data: monospace + tabular numbers for alignment. Don't rely on size alone — combine size, weight, letter-spacing.

## Card layouts

Metric ≠ plan ≠ settings card internally. Design each card's structure for its content — but keep surface treatment consistent: same border weight, shadow depth, corner radius, padding scale.

## Controls

Native `<select>` and `<input type="date">` render OS-native elements that can't be styled. Build custom — trigger buttons with positioned dropdowns, calendar popovers, styled state management.

## Iconography

Icons clarify, not decorate — if removing loses no meaning, remove it. One icon set, stick with it. Give standalone icons presence with subtle background containers.

## Animation

Fast micro-interactions, smooth easing. Larger transitions can be slightly longer. Deceleration easing. Avoid spring/bounce in professional interfaces.

## States

Every interactive element: default, hover, active, focus, disabled. Data: loading, empty, error. Missing states feel broken.

## Navigation context

Screens need grounding. A data table floating in space feels like a component demo. Include navigation showing where you are, location indicators, user context. Sidebars: same background as main content with border separation, not different colors.

## Dark mode

Different needs. Shadows are less visible — lean on borders for definition. Semantic colors often need slight desaturation. The hierarchy system still applies, just with inverted values.

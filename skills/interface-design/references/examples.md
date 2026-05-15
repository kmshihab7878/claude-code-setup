# Interface Design Examples

This reference contains public-safe examples for using the interface-design skill.

## Direction Proposal Example

```text
Domain:     incident rooms, escalation ladders, signal noise, ownership, time pressure
Color world: dim command-center screens, amber warnings, slate panels, status green, muted red
Signature:  timeline rail that turns each incident into a living command log
Rejecting:  generic KPI cards -> operational status strips,
            colorful dashboard tiles -> muted priority bands,
            floating page shell -> grounded command workspace

Direction: A dense incident command interface that feels calm under pressure,
with compact hierarchy, precise type, muted surfaces, and a timeline-centered
layout that keeps ownership and next action visible.
```

## Component Intent Example

```text
Intent:     On-call lead deciding what needs attention now.
Palette:    Slate canvas, amber escalation, muted green recovery, soft red failure.
Depth:      Borders-only; calm, low-drama operational feel.
Surfaces:   Canvas, panel, inset control, elevated popover.
Typography: Compact sans with tabular numbers for time and counts.
Spacing:    4px base, dense component rhythm.
```

## Critique Example

```text
Issue: KPI cards look interchangeable and do not imply action.
Impact: The operator cannot tell which metric deserves attention.
Evidence: All cards use equal size, equal border, and similar accent treatment.
Fix: Group by operational priority, add status strip, and reserve the strongest accent for active incidents.
Validation: Squint test should reveal active incident priority before individual labels are read.
Severity: High
```

## Final Report Pattern

```text
Intent: [human, task, feel]
Direction: [domain-grounded approach]
Changed: [files/components]
Validation: [swap/squint/signature/token/responsive checks]
Accessibility: [focus/contrast/labels/states]
System file: [read/updated/not present/offered]
Risks: [remaining gaps]
```

## Save Pattern Example

```markdown
# Interface Design System

## Direction
[Product-specific feel and intent]

## Depth Strategy
[Borders-only / subtle shadows / layered shadows / surface shifts]

## Spacing
[Base unit and density guidance]

## Tokens
[Palette, text hierarchy, surface levels, semantic colors]

## Component Patterns
[Reusable cards, tables, nav, forms, states]
```

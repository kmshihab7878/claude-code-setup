# Interface Design Workflow Reference

This reference holds the detailed interface design workflow. Keep `SKILL.md` as the operating contract and load this file when the task needs deeper process detail.

## Contents

- [Problem](#problem)
- [Intent First](#intent-first)
- [Product Domain Exploration](#product-domain-exploration)
- [Proposal Requirements](#proposal-requirements)
- [Workflow](#workflow)
- [System File Behavior](#system-file-behavior)
- [Saving Patterns](#saving-patterns)

## Problem

Interface design defaults are strong because common dashboard, admin, and app patterns are heavily represented in training data. A model can explore a domain, name a signature, state intent, and still produce a template. Process helps, but the work is catching where defaults win.

Defaults hide inside things that feel like infrastructure:

- Typography feels like a container, but type carries personality before anyone reads.
- Navigation feels like scaffolding, but it defines where the user is and what matters.
- Data feels like presentation, but a metric only matters when it clarifies meaning and action.
- Token names feel like implementation detail, but they are design decisions.

There are no neutral structural decisions. The moment "why this?" disappears, defaults take over.

## Intent First

Before touching code, answer:

- Who is this human? Where are they, what just happened, and what is on their mind?
- What must they accomplish? Name the verb, not just the screen type.
- What should this feel like? Use specific language grounded in the domain.

If these cannot be answered specifically, ask or state assumptions before proceeding.

## Product Domain Exploration

Generic output moves from task type to visual template to theme.
Crafted output moves from task type to product domain to signature to structure and expression.

Before proposing direction, produce:

- Domain: at least 5 product-world concepts, metaphors, vocabulary, or operational realities.
- Color world: at least 5 colors, materials, light sources, or physical references from the product's world.
- Signature: one visual, structural, or interaction element that could only belong to this product.
- Defaults: 3 obvious visual or structural choices to avoid or replace.

## Proposal Requirements

Direction must explicitly reference:

- Domain concepts explored.
- Colors from the color-world exploration.
- The signature element.
- What replaces each default.

Test the proposal by removing the product name. If the product cannot be inferred, keep exploring.

## Workflow

### Communication

Be direct and do not announce modes. Make suggestions with reasoning.

### Suggest and Ask

Lead with exploration and a recommendation, then confirm:

```text
Domain:     [5+ concepts from the product's world]
Color world:[5+ colors or materials from this domain]
Signature:  [one element unique to this product]
Rejecting:  [default 1] -> [alternative], [default 2] -> [alternative], [default 3] -> [alternative]

Direction:  [approach that connects to the above]
```

Ask whether the direction feels right before large implementation work when the design direction is not already established.

## System File Behavior

### If `.interface-design/system.md` Exists

Read it and apply it. Treat its durable decisions as already made unless the user requests a change.

### If No System Exists

1. Explore the domain and produce the four required outputs.
2. Propose a direction tied to those outputs.
3. Confirm when needed.
4. Build using the design principles.
5. Evaluate with mandate checks before showing.
6. Offer to save durable patterns.

## Saving Patterns

After completing a task, offer:

```text
Want me to save these patterns for future sessions?
```

If yes, write to `.interface-design/system.md`:

- Direction and feel.
- Depth strategy.
- Spacing base unit.
- Key component patterns.
- Token and color decisions.
- Reusable state and layout decisions.

Save when a component is used more than once, is reusable across the project, or has measurements worth preserving. Do not save one-off experiments or variations better handled with props.

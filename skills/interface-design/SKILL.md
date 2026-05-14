---
name: interface-design
description: This skill is for interface design — dashboards, admin panels, apps, tools, and interactive products. NOT for marketing design (landing pages, marketing sites, campaigns).
---

# Interface Design

Build interfaces with craft and consistency.

## Scope

- **Use for:** dashboards, admin panels, SaaS apps, tools, settings pages, data interfaces.
- **Not for:** landing pages, marketing sites, campaigns — redirect to `/frontend-design`.

---

# The problem

You will generate generic output. Training has seen thousands of dashboards; the patterns are strong.

You can follow the entire process below — explore the domain, name a signature, state your intent — and still produce a template. Warm colors on cold structures. Friendly fonts on generic layouts. "Kitchen feel" that looks like every other app. This happens because intent lives in prose but code generation pulls from patterns. The gap is where defaults win. Process helps but doesn't guarantee craft — you have to catch yourself.

---

# Where defaults hide

Defaults disguise themselves as infrastructure — parts that feel like they just need to work, not be designed.

- **Typography feels like a container.** But typography isn't holding your design — it IS the design. The weight of a headline, personality of a label, texture of a paragraph shape how the product feels before anyone reads. A bakery tool and a trading terminal both want "clean, readable type" — but the warm/handmade type isn't the cold/precise type. Reaching for your usual font = not designing.
- **Navigation feels like scaffolding.** It isn't around the product — it IS the product. Where you are, where you can go, what matters most. A page floating in space is a component demo, not software.
- **Data feels like presentation.** A number on screen isn't design. The question is what it means to the viewer and what they'll do with it. Progress ring vs stacked label both show "3 of 10" — one tells a story, one fills space.
- **Token names feel like implementation detail.** Your CSS variables are design decisions. `--ink` / `--parchment` evoke a world; `--gray-700` / `--surface-2` evoke a template. Someone reading only your tokens should guess what product this is.

There are no structural decisions. Everything is design. The moment you stop asking "why this?" is the moment defaults take over.

---

# Intent first

Before touching code, answer these — out loud, to yourself or the user.

- **Who is this human?** Not "users". The actual person — where are they when they open this? What's on their mind? What did they do 5 minutes ago? A teacher at 7am ≠ a developer at midnight ≠ a founder between meetings.
- **What must they accomplish?** Not "use the dashboard". The verb. Grade submissions. Find the broken deployment. Approve the payment. Determines what leads, follows, hides.
- **What should this feel like?** Specific words. "Clean and modern" means nothing — every AI says that. Warm like a notebook? Cold like a terminal? Dense like a trading floor? Calm like a reading app?

If you can't answer with specifics, stop. Ask. Don't guess. Don't default.

## Every choice must be a choice

For every decision, explain WHY. Why this layout? Color temperature? Typeface? Spacing scale? Hierarchy?

If your answer is "it's common" or "it's clean" or "it works" — you defaulted, not chose. Defaults are invisible. Invisible choices compound into generic output.

**The test:** swap your choices for the most common alternatives. If the design didn't feel meaningfully different, you never made real choices.

## Sameness is failure

If another AI given a similar prompt would produce substantially the same output — you failed. Not "different for its own sake" — the interface must emerge from the specific problem, user, and context.

## Intent must be systemic

"Warm" + cold colors = not following through. Intent is a constraint that shapes every decision: warm → all surfaces, text, borders, accents, semantic colors, typography warm. Dense → all spacing, type size, IA dense. Calm → all motion, contrast, saturation calm.

Check your output against your stated intent. Does every token reinforce it?

---

# Product domain exploration

This is where defaults get caught — or don't.

- **Generic output:** task type → visual template → theme.
- **Crafted output:** task type → product domain → signature → structure + expression.

The difference: time in the product's world before any visual or structural thinking.

## Required outputs

Don't propose any direction until you produce all four:

- **Domain:** concepts, metaphors, vocabulary from the product's world. Not features — territory. Minimum 5.
- **Color world:** colors that exist naturally in this product's domain. If this product were a physical space, what would you see? What materials, what light, what objects? List 5+.
- **Signature:** one element — visual, structural, interaction — that could only exist for THIS product. If you can't name one, keep exploring.
- **Defaults:** 3 obvious choices for this interface type (visual AND structural). You can't avoid patterns you haven't named.

## Proposal requirements

Your direction must explicitly reference:
- Domain concepts you explored.
- Colors from your color-world exploration.
- Your signature element.
- What replaces each default.

**The test:** read your proposal with the product name removed. Could someone identify what this is for? If not, explore deeper.

---

# The mandate

**Before showing the user, look at what you made.**

Ask: "If they said this lacks craft, what would they mean?" That thing you just thought of — fix it first. Your first output is probably generic; catching it is the work.

## The checks

Run before presenting:

- **Swap test:** swap typeface for your usual one — would anyone notice? Swap layout for a standard dashboard template — would it feel different? Where swapping wouldn't matter is where you defaulted.
- **Squint test:** blur your eyes. Can you still perceive hierarchy? Is anything jumping out harshly? Craft whispers.
- **Signature test:** can you point to five specific elements where your signature appears? Not "the overall feel" — actual components. A signature you can't locate doesn't exist.
- **Token test:** read your CSS variables out loud. Do they sound like they belong to this product's world, or could they belong to any project?

If any check fails, iterate before showing.

---

# Craft foundations

Three foundational craft rules that apply regardless of direction, product type, or visual style. Full prose with key decisions, worked examples, and the squint test: [`references/craft-foundations.md`](references/craft-foundations.md).

- **Subtle layering** — surfaces stack with whisper-quiet lightness shifts (a few percentage points per level). Sidebars share the canvas background; dropdowns sit one level above parent; inputs are inset (slightly darker, not lighter).
- **Borders** — should disappear when you're not looking, be findable when you need structure. Use low-opacity rgba, not solid hex. Build a 4-step progression: standard / softer separation / emphasis / focus ring.
- **Squint test** — blur your eyes; still perceive hierarchy, no harsh lines, no jarring color shifts. Separates professional from amateur.
- **Infinite expression** — no interface should look the same. Every pattern has infinite expressions; architecture and components emerge from THIS task and data, not a template.
- **Color lives somewhere** — palette should feel like it came FROM the product's world. Temperature is one axis among many (quiet/loud, dense/spacious, serious/playful, geometric/organic). Gray builds structure; color communicates meaning.

---

# Before writing each component

**Every time** you write UI code — even small additions — state:

```
Intent:    [who is this human, what must they do, how should it feel]
Palette:   [colors from your exploration — WHY they fit this product's world]
Depth:     [borders / shadows / layered — WHY this fits the intent]
Surfaces:  [your elevation scale — WHY this color temperature]
Typography:[your typeface — WHY it fits the intent]
Spacing:   [your base unit]
```

This checkpoint is mandatory. Forces you to connect every technical choice back to intent.

If you can't explain WHY for each choice, you're defaulting. Stop and think.

---

# Design principles

13 design-principle topics. The compact reference is below — load [`references/design-principles.md`](references/design-principles.md) for the full per-topic rules with examples.

| # | Topic | Essentials |
|---|-------|-----------|
| 1 | **Token architecture** | Every color traces back to primitives (foreground, background, border, brand, semantic). No random hex. |
| 2 | **Text hierarchy** | 4 levels: primary, secondary, tertiary, muted. Two levels = flat hierarchy. |
| 3 | **Border progression** | Build a 4-step scale (standard / softer / emphasis / max). Match intensity to importance. |
| 4 | **Control tokens** | Dedicated tokens for form-control backgrounds, borders, focus — don't reuse surface tokens. |
| 5 | **Spacing** | Base unit + multiples. Scale per context (micro / component / section / major). Random values = no system. |
| 6 | **Padding** | Symmetrical unless content naturally requires asymmetry. |
| 7 | **Depth** | Pick ONE: borders-only / subtle shadows / layered shadows / surface-color shifts. **Don't mix.** |
| 8 | **Border radius** | Sharper = technical. Rounder = friendly. Build a scale; don't mix sharp + soft randomly. |
| 9 | **Typography** | Distinct levels at a glance. Headlines tight-tracked; body comfortable; data monospace + tabular numbers. Combine size + weight + letter-spacing — don't rely on size alone. |
| 10 | **Card layouts** | Different internal structure per content type; **consistent surface treatment** (border weight, shadow depth, radius, padding). |
| 11 | **Controls** | Native `<select>` and `<input type="date">` can't be styled — build custom (trigger button + positioned dropdown / calendar popover) with explicit state management. |
| 12 | **Iconography** | Icons clarify, not decorate — remove if removing loses no meaning. One icon set. Subtle background containers for standalone icons. |
| 13 | **Animation** | Fast micro-interactions, deceleration easing. Avoid spring/bounce in professional interfaces. |
| 14 | **States** | Every interactive: default / hover / active / focus / disabled. Data: loading / empty / error. Missing states feel broken. |
| 15 | **Navigation context** | Screens need grounding — where am I, where can I go, who am I as. Sidebars share canvas background with border separation, not different colors. |
| 16 | **Dark mode** | Different needs — shadows less visible (lean on borders), semantic colors often need desaturation. Hierarchy system applies with inverted values. |

---

# Avoid

- **Harsh borders** — if borders are the first thing you see, too strong.
- **Dramatic surface jumps** — elevation changes should whisper.
- **Inconsistent spacing** — clearest sign of no system.
- **Mixed depth strategies** — pick one and commit.
- **Missing interaction states** — hover, focus, disabled, loading, error.
- **Dramatic drop shadows** — subtle, not attention-grabbing.
- **Large radius on small elements.**
- **Pure white cards on colored backgrounds.**
- **Thick decorative borders.**
- **Gradients and color for decoration** — color should mean something.
- **Multiple accent colors** — dilutes focus.
- **Different hues for different surfaces** — keep the same hue, shift only lightness.

---

# Workflow

## Communication

Be invisible. Don't announce modes or narrate process.
- **Never:** "I'm in ESTABLISH MODE", "Let me check system.md..."
- **Instead:** jump into work. State suggestions with reasoning.

## Suggest + ask

Lead with exploration and recommendation, then confirm:

```
Domain:     [5+ concepts from the product's world]
Color world:[5+ colors that exist in this domain]
Signature:  [one element unique to this product]
Rejecting:  [default 1] → [alternative], [default 2] → [alternative], [default 3] → [alternative]

Direction:  [approach that connects to the above]
```

Ask: "Does that direction feel right?"

## If project has system.md

Read `.interface-design/system.md` and apply. Decisions are made.

## If no system.md

1. Explore domain — produce all four required outputs.
2. Propose — direction must reference all four.
3. Confirm — get user buy-in.
4. Build — apply principles.
5. **Evaluate** — run the mandate checks before showing.
6. Offer to save.

---

# After completing a task

Always offer to save: *"Want me to save these patterns for future sessions?"*

If yes, write to `.interface-design/system.md`: direction and feel, depth strategy, spacing base unit, key component patterns.

### What to save

Add when a component is used 2+ times, is reusable across the project, or has specific measurements worth remembering. Don't save one-off components, temporary experiments, or variations better handled with props.

### Consistency checks

If system.md defines values, check against them: spacing on the defined grid, depth using the declared strategy throughout, colors from the defined palette, documented patterns reused instead of reinvented.

This compounds — each save makes future work faster and more consistent.

---

# Deep dives

- [`references/craft-foundations.md`](references/craft-foundations.md) — full prose for subtle layering, borders, infinite expression, color-lives-somewhere.
- [`references/design-principles.md`](references/design-principles.md) — full per-topic detail for the 16-topic design-principles catalog.
- [`references/principles.md`](references/principles.md) — code examples, specific values, dark mode.
- [`references/validation.md`](references/validation.md) — memory management, when to update `system.md`.
- [`references/critique.md`](references/critique.md) — post-build craft critique protocol.
- [`references/example.md`](references/example.md) — worked example.

# Commands

- `/interface-design:status` — current system state.
- `/interface-design:audit` — check code against system.
- `/interface-design:extract` — extract patterns from code.

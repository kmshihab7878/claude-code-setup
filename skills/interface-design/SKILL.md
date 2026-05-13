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

## Subtle layering

The backbone. Regardless of direction, product type, or style — applies to everything. You should barely notice the system working. Vercel's dashboard: you don't think "nice borders", you just understand structure. Craft is invisible — that's how you know it's working.

### Surface elevation

Surfaces stack. Dropdown sits above a card sits above the page. Numbered system — base, then increasing elevation levels. Dark mode: higher = slightly lighter. Light mode: higher = slightly lighter or uses shadow. Each jump = a few percentage points of lightness. Barely visible in isolation, but the hierarchy emerges when surfaces stack.

Key decisions:
- **Sidebars:** same background as canvas, not different. Different colors fragment the visual space. A subtle border is enough separation.
- **Dropdowns:** one level above their parent. Same level = dropdown blends into the card.
- **Inputs:** slightly darker than surroundings, not lighter. Inputs are "inset" — they receive content.

### Borders

Borders should disappear when you're not looking but be findable when you need structure. Low-opacity rgba blends with background; solid hex looks harsh.

Build a progression — standard borders, softer separation, emphasis borders, max for focus rings. Match intensity to importance.

**Squint test:** still perceive hierarchy, nothing jumping out, no harsh lines, no jarring color shifts. Just quiet structure. This separates professional from amateur. Get it wrong and nothing else matters.

## Infinite expression

Every pattern has infinite expressions. **No interface should look the same.**

A metric display can be a hero number, inline stat, sparkline, gauge, progress bar, comparison delta, trend badge, or something new. Dashboards can emphasize density, whitespace, hierarchy, or flow differently. Even sidebar + cards has infinite variations.

Before building: what's the ONE thing users do most here? What products solve similar problems brilliantly — study them. Why would this interface feel designed for its purpose, not templated?

**NEVER produce identical output.** Same sidebar width, same card grid, same icon-left-number-big-label-small metric box every time signals AI-generated. Forgettable.

The architecture and components emerge from task and data, executed freshly. Linear's cards don't look like Notion's. Vercel's metrics don't look like Stripe's. Same concepts, infinite expressions.

## Color lives somewhere

Every product exists in a world with colors. Before reaching for a palette, spend time in the product's world. What would you see in its physical version? What materials? What light? What objects?

Your palette should feel like it came FROM somewhere — not applied TO something.

- **Beyond warm and cold.** Temperature is one axis. Is this quiet or loud? Dense or spacious? Serious or playful? Geometric or organic? A trading terminal and meditation app are both "focused" — different kinds of focus.
- **Color carries meaning.** Gray builds structure; color communicates — status, action, emphasis, identity. Unmotivated color is noise. One accent used with intention beats five used without thought.

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

- `references/principles.md` — code examples, specific values, dark mode.
- `references/validation.md` — memory management, when to update system.md.
- `references/critique.md` — post-build craft critique protocol.

# Commands

- `/interface-design:status` — current system state.
- `/interface-design:audit` — check code against system.
- `/interface-design:extract` — extract patterns from code.

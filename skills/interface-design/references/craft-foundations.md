# Craft foundations (full detail)

Subtle layering (surface elevation, borders), infinite expression, color-lives-somewhere — the foundational craft principles that apply regardless of direction. SKILL.md keeps a compact list with the squint-test rule; this file holds the prose with key decisions and worked examples.

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


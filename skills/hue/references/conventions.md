# Conventions: Quality, Tone, Iteration

Reference detail for sections 3, 5, and 6 of `SKILL.md`.

## Quality standards (per-section detail)

Non-negotiable. Every generated skill must meet all of them.

- **Preview** — `preview.html` looks like a real app dashboard with real content, proper hierarchy, proper density.
- **Philosophy** — 2–4 sentences capturing *attitude*, not aesthetics. Reference real-world lineage. Include the primary tension.
- **Design principles** — 5–7 falsifiable, bold-titled rules; no platitudes.
- **Craft rules** — 5–6 *how-to-compose* instructions covering hierarchy, typography discipline, spacing semantics, color strategy, composition; include the squint test or equivalent.
- **Anti-patterns** — 8–12 specific bans. Each starts with "No". Both visual (gradients, shadows) and behavioral (toast popups, skeleton screens).
- **Colors** — coherent palette, every color has a *role*. Verify contrast (body ≥ 4.5:1, large ≥ 3:1). Light + dark, derived (not inverted). Semantic colors required: accent, success, warning, error.
- **Fonts** — display + body + mono, always three. Google Fonts (web) or system fonts (SwiftUI). Fallback stacks. State *why* each font fits. Decide `mono_for_code` and `mono_for_metrics` independently by inspecting the brand's actual site.
- **Type scale** — 8+ sizes (display through label) with px / line-height / letter-spacing / weight / use case per size.
- **Spacing** — 8px base grid, scale `2xs`–`4xl`, every value has a semantic use case.
- **Radii** — separate values for cards / buttons / inputs / tags-pills. State corner philosophy: sharp (0–4px), soft (8–16px), round (20–24px), pill (999px). iOS: `RoundedRectangle(cornerRadius:, style: .continuous)`.
- **Elevation** — pick ONE strategy: flat / subtle / glow / material.
- **Motion** — pick ONE personality: mechanical / smooth / playful / none.
- **Platform mapping** — REAL, copy-paste-ready CSS `:root` (with `[data-theme="dark"]` or `prefers-color-scheme` for dark mode), SwiftUI `Color`/`Font` extensions and `ViewModifier`s, Tailwind `extend` block.
- **Components** — every component lists when-to-use, variants, and exact token mapping per variant. Minimum: cards, buttons (4 variants), inputs, lists, navigation, tags/chips, overlays (modal + bottom sheet), and states (empty/loading/error/disabled).

Full per-section detail including the semantic token-name table, brand-type vs `mono_for_*` table, type-scale schema, elevation strategy table, and motion personality table: [quality-standards.md](quality-standards.md).

**Platform mapping** emits every semantic token; `--bg` is an alias for `--background`; emit `--border-visible` alongside `--border`; use `--accent-subtle` (not deprecated `--accent-bg`). See [platform-mapping-template.md](platform-mapping-template.md).

## Tone & voice (for generated skills)

Write generated skills like a senior designer briefing a junior. Authoritative, specific, opinionated.

| Good | Bad |
|------|-----|
| "Shadows are banned. Depth comes from border + background change. If something needs to float, use a 1px border at 8% opacity, not a shadow." | "Consider using subtle borders instead of heavy shadows for a cleaner look." |
| "Max 2 chromatic colors per screen. The neutral canvas makes each color arrival feel special." | "Try to limit the number of colors for a more cohesive design." |

Good instructions are falsifiable, specific, leave no room for interpretation. Bad instructions are suggestions that Claude will interpret inconsistently.

## Iteration (what to change vs preserve)

| Request | What to change | What NOT to change |
|---------|---------------|-------------------|
| "More contrast" | Text/background delta, accent saturation | Fonts, spacing, components |
| "Warmer" / "Cooler" | Gray palette undertones, accent hue | Structure, typography, motion |
| "Different font" | Font stack + type scale adjustments | Colors, spacing, components |
| "More playful" | Motion personality, corner radii, elevation | Color palette, anti-patterns |
| "More minimal" | Reduce components, increase spacing, flatten elevation | Core philosophy |
| "Add glow/glass" | Elevation strategy, surface treatment | Typography, spacing |

Apply changes to the specific files and sections affected. Never regenerate from scratch unless the user asks for a completely different direction.

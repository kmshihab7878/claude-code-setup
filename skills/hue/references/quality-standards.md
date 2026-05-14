# Quality standards (full detail)

Non-negotiable. Every generated skill must meet all of them. SKILL.md links here for the per-section detail; this file holds the long tables and per-token rules.

## Preview

- `preview.html` must look like a real app dashboard, not a component library. Real-looking content, proper hierarchy, proper density.

## Philosophy

- 2–4 sentences capturing the *attitude*, not just aesthetics. "Subtract, don't add" is a philosophy. "Clean and modern" is not.
- Reference the design lineage — real-world objects, brands, movements, eras.
- Include the primary tension that gives the language its character.

## Design principles

- 5–7 principles. Each: **Bold Title.** + one sentence.
- Every principle must be falsifiable — you can point at a screen and say "this violates principle 3."
- No platitudes. "User-friendly" is not a principle. "Type does the heavy lifting — hierarchy comes from scale and weight, never color or icons" is.

## Craft rules

- 5–6 rules in Section 2 of generated SKILL.md. Each is a *how-to-compose* instruction.
- Include: visual hierarchy layers, typography discipline (font budget per screen), spacing semantics, color strategy, composition approach.
- Use tables for layer/hierarchy — scannable, unambiguous.
- Include the squint test or equivalent.

## Anti-patterns

- 8–12 specific bans. Each starts with "No" and names the exact thing.
- Precise: "No border-radius > 16px on cards", not "avoid large corners."
- Include both visual (gradients, shadows) and behavioral (toast popups, skeleton screens).
- Anti-patterns prevent generic output. They're the immune system.

## Colors

- Coherent palette. Every color has a *role*, not just a hex.
- Verify contrast: body text ≥ 4.5:1, large text ≥ 3:1.
- Both light and dark values. Derive secondary mode from primary — don't just invert. Warm light needs warm dark.
- Include semantic colors: accent, success, warning, error.

Token names:

| Token | Role |
|-------|------|
| `--background` | Page/canvas background |
| `--bg` | Alias for `--background` (short form used in hero/landing) |
| `--surface1` | Primary elevated surface (cards) |
| `--surface2` | Secondary surface (nested) |
| `--surface3` | Tertiary surface (inputs, wells) |
| `--border` | Subtle/decorative |
| `--border-visible` | Intentional borders |
| `--text1` | Primary text |
| `--text2` | Secondary text |
| `--text3` | Tertiary text |
| `--text4` | Disabled |
| `--accent` | Primary interactive |
| `--accent-subtle` | Tinted backgrounds for accent |
| `--success` | Positive states |
| `--warning` | Caution |
| `--error` | Destructive/error |

**Platform mapping must emit all tokens above.** `--bg` is an alias — emit both. `--border-visible` alongside `--border`. `--accent-subtle` (not `--accent-bg`, that's deprecated). See `platform-mapping-template.md`.

## Fonts

- Display, body, mono roles. Always three.
- **Google Fonts only** for web. Name exact font and weights.
- **System fonts** for SwiftUI (SF Pro, SF Rounded, SF Mono, New York).
- Include fallback stacks.
- State *why* the font fits. "Geometric sans with humanist details" tells Claude how to judge edge cases.
- **`mono_for_code` + `mono_for_metrics`:** two independent flags. `mono_for_code` covers code/paths/shell/inline technical tokens; `mono_for_metrics` covers pricing/counts/timestamps/percentages/IDs. Many brands use mono for code but not metrics (e.g. Cursor: mono inside IDE screenshots, `$20` pricing stays sans). Decide each by checking the brand's actual site.

| Brand type | Example | `mono_for_code` | `mono_for_metrics` |
|------------|---------|-----------------|--------------------|
| Dev-tool / terminal | Linear, Nothing | true | true |
| Dev-tool with editorial marketing | Cursor, Vercel, Raycast | true | false |
| Consumer / editorial | Apple, mymind, Notion | false | false |

**Backwards-compat:** older skills may have `mono_for_data: true/false`. Treat true as both new flags true, false as both false.

- **`locked_weight`** (optional, top-level): set only when the brand uses one weight across all text (h1 through body). Most brands don't. If set, ALL type scale rows use this weight.

## Type scale

- 8 sizes minimum: display, h1, h2, h3, body, body-sm, caption, label.
- Every size: px, line-height ratio, letter-spacing, weight, use case.

| Token | Size | Line Height | Letter Spacing | Weight | Use |
|-------|------|-------------|----------------|--------|-----|
| `--display` | Npx | ratio | em | weight | use case |
| `--h1` | … | … | … | … | … |
| `--h2` | … | … | … | … | … |
| `--h3` | … | … | … | … | … |
| `--body` | … | … | … | … | … |
| `--body-sm` | … | … | … | … | … |
| `--caption` | … | … | … | … | … |
| `--label` | … | … | … | … | … |

- **Locked-weight variant:** if `locked_weight` is set, the Weight column becomes a single row at the top (e.g. "All sizes: weight 400") or every cell becomes `—`. Use only for brands genuinely running one weight (Cursor).

## Spacing

- 8px base grid. Always.
- Scale: `2xs` (2), `xs` (4), `sm` (8), `md` (16), `lg` (24), `xl` (32), `2xl` (48), `3xl` (64), `4xl` (96).
- Every value has a semantic use case.

## Radii

- Define separately: cards, buttons, inputs, tags/pills.
- State the corner philosophy — sharp (0–4px), soft (8–16px), round (20–24px), pill (999px).
- iOS: note `RoundedRectangle(cornerRadius:, style: .continuous)`.

## Elevation

| Strategy | When | How |
|----------|------|-----|
| **Flat** | Industrial, minimal | No shadows. Borders or background change only. |
| **Subtle** | Warm, friendly | Small y-offset (1–3px), diffused blur, low opacity. |
| **Glow** | Dark-mode-forward, premium | Colored shadow matching accent, no y-offset. |
| **Material** | Glass, depth-heavy | Blur + transparency + saturation. |

## Motion

| Personality | Easing | Duration | Behavior |
|-------------|--------|----------|----------|
| **Mechanical** | `ease-out` or linear | 120–200ms | Precise, no overshoot. Click, not swoosh. |
| **Smooth** | `ease-in-out` | 200–350ms | Calm transitions, no bounce. |
| **Playful** | Spring (damping 0.7–0.8) | 300–500ms | Overshoot + settle. |
| **None** | Instant | 0–100ms | Content appears, no choreography. |

## Platform mapping

- REAL, valid, copy-paste-ready code. Not pseudocode.
- CSS: `:root` block with all custom properties. Dark mode via `[data-theme="dark"]` or `@media (prefers-color-scheme: dark)`.
- SwiftUI: `Color` extension, `Font` extension, relevant `ViewModifier`s.
- Tailwind: `extend` block in `tailwind.config.js` mapping all tokens.

## Components

- Every component gets: when to use, variants, exact token mapping per variant.
- Minimum: cards, buttons (4 variants), inputs, lists, navigation, tags/chips, overlays (modal + bottom sheet), state patterns (empty, loading, error, disabled).
- Use tables for variant specifications.

# Workflow Phases (1–16)

Sequence is mandatory. No shortcuts. Read the phase entry before executing.

## Phase 1: Deep analysis

Gather and *understand the system* — not just tokens:
- Colors (background, surface, text, accent, semantic).
- Fonts (display, body, mono) + why they fit.
- Spacing feel + density.
- Corner radii + philosophy.
- Surface depth + elevation.
- Motion character.
- Overall attitude + primary tension.
- What's ABSENT that you'd expect? Absence = design decision.

**Classify the brand type.** This changes strategy:

| Type | Signal | Differentiation lives in | Examples |
|------|--------|---------------------------|----------|
| **UI-rich** | Many visible components, distinctive shapes, strong colors, unique interactions | Components, colors, craft effects | Linear, Notion, Spotify |
| **Content-rich** | Full-bleed photography, minimal UI chrome, few distinctive components | Typography, spacing, surface temperature, restraint | Tesla, Nike, Porsche, luxury brands |

For **UI-rich**: lean into component distinctiveness — pill shapes, glows, colored indicators, dense grids, signature interactions. These translate to Bento Grid widgets.

For **content-rich**: UI is intentionally invisible. Levers (not rules):
- **Typography** is the primary visual tool. Match brand's exact type — size, weight, spacing. Reproduce faithfully, don't impose direction.
- **Spacing** carries more identity weight when visual elements are few. Match brand's actual density.
- **Surface temperature** matters more when color is sparse. Warm blacks ≠ cool blacks ≠ pure blacks.
- **Accent restraint** — reproduce how sparingly the brand uses color. Don't add color that isn't there.
- **Domain-specific widget content** — "396 mi range" feels authentic; "12 tasks" feels generic. Specificity compensates for visual simplicity.

State the type to the user: "This is a content-rich brand — the design language is more about typography and restraint than distinctive components. The preview will be subtler."

Document findings — they feed the Design Model in Phase 7.

## Phase 2: Component inventory

**Critical step.** Before generating anything, inventory which UI components the brand actually has.

For each standard component type, check: does the brand have it? What does it look like?

| Component | Check for | Where to look |
|-----------|-----------|---------------|
| Buttons | Primary, secondary, ghost variants | CTAs, forms, nav |
| Cards | Content cards, feature cards | Homepage, features |
| Inputs | Text fields, search bars | Login, search, forms |
| Toggles/Switches | Settings, filters | Product UI, settings |
| Tags/Badges | Status, categories | Product UI, blog |
| Lists | Data lists, nav lists | Product UI, pricing |
| Progress | Bars, rings, gauges | Product UI, onboarding |
| Navigation | Header, sidebar, tabs | All pages |
| Overlays | Modals, dropdowns, tooltips | Product interactions |

For each component the brand HAS, create a **Tear-Down Sheet** — extract CSS as precisely as possible (exact from source when available, estimated from visual otherwise):

> **Tear-Down: Button (Primary)**
> - **Source:** `brand.com` CTA button
> - **Observed:** `background: #5E5CE6`, `color: #FFF`, `font-size: 15px`, `font-weight: 500`, `padding: 10px 16px`, `border-radius: 8px`, `box-shadow: none`
> - **Hover:** `background: #4E4CD5`
> - **Conclusion:** Generated primary button uses these values as baseline.

For components the brand DOESN'T have, create a **Derived Design** with explicit justification:

> **Derived: Toggle Switch**
> - **Source:** Not found
> - **Derived design:** Flat, rectangular, sharp corners, no shadow.
> - **Justified by:** Principle 1 ("flat, not deep") + Principle 3 ("geometric forms only"). Consistent with existing input fields (0px radius, border-only depth).

Name the specific principles. No guessing — reason from the system.

## Phase 3: Icon kit selection

**We cannot copy proprietary icons.** Maintain a pool of freely-licensed kits in `references/icon-kits.md` and pick the closest fit.

1. **Observe brand icons.** Pull 4–6 distinct glyphs (nav, features, product UI). Describe in prose: *"~1.75px stroke, rounded terminals, slightly irregular curves, outline-only, humanist."*
2. **Score on five criteria**: `stroke_weight` (thin/regular/medium/bold/filled), `corner_treatment` (sharp/soft/fully-round), `fill_style` (outline/solid/duotone/mixed), `form_language` (geometric/humanist/hand-drawn), `visual_density` (minimal/balanced/detailed).
3. **Read `references/icon-kits.md`** and compare against each kit's profile. Use the Decision Matrix as quick-pick but justify with criteria.
4. **Pick ONE kit** (never mix). Tie-break on closer stroke weight and form language — those are the most visually load-bearing.
5. **Write `match_reasoning`** — 2–3 sentences naming what matches, what doesn't, and why this kit beats second-best. If the gap is large (brand is hand-drawn but no kit is truly hand-drawn), say so.
6. **Never claim the brand uses the kit.** YAML fields: `observed_style` (brand's reality) and `fallback_kit` (what we rendered). The `disclaimer` makes this explicit.

Get its own YAML block — see Phase 7 schema.

## Phase 4: Hero stage analysis (MANDATORY)

Every brand gets a `hero_stage` block, even if it collapses to `subject: none` + `medium: absent`. The slot is never skipped — it's a major identity signal.

A **hero stage** = composed visual behind the landing hero: a *background field*, optionally a *hero subject* in front, and a defined *relation* (how light bleeds, how shadows fall). Read `references/hero-stage.md` for the full dial reference and preset library.

1. **Observe the brand's hero stage as a whole** — describe background + subject (if any) + relation. Examples: *"glowing light-ball centered on radial gradient in brand reds/purples; bleeds warm light into field"* (Raycast-era); *"floating app-window offset right of muted purple mesh; flat, no light interaction"* (Linear); *"machined aluminum cylinder on dark stage under tight top spotlight, grounded by soft contact shadow"* (B&O); *"diagonal 3D glass bars fill viewport; no centered subject"* (current Raycast); *"hand-painted warm landscape; no foreground subject"* (mymind); *"faint dot grid on dark with code panel centered, drop shadow, no glow"* (Vercel).

2. **Pick a starting preset** from the 9 in `hero-stage.md`: `luminous-on-gradient`, `device-on-mesh`, `painterly-no-hero`, `grid-on-dark`, `object-on-spotlight`, `editorial-photo`, `shader-ambient`, `flat-blank`, `sculptural-field`. Or set `preset: null` and fill dials manually.

3. **Tune four dial groups.** Defaults must stay `subtle` unless brand is genuinely loud.
   - **Background:** `medium` (gradient / mesh / painterly / shader / pattern / bokeh / sculptural / noise / photo / absent), `color_mode`, `saturation`, `light_source`, `falloff`, `vignette`, `texture`, `motion`, `intensity`, `safe_zone`, `color_palette` (3–5 hues).
   - **Hero:** `subject` by intent — `none` / `luminous` (CSS-rendered light emitter) / `object` (concrete product → generic warm metallic placeholder, user swaps for real 3D render) / `device` (product window, CSS) / `composition` (arranged elements, CSS) / `photo-cutout` (prose placeholder). Plus `form` (only for `luminous`: sphere / disc / ring / torus), `placement`, `scale`, `tint`.
   - **Relation:** `type` (flat / glow / halo / reflection / emissive / shadow-only), `bleed` (0–100).

4. **Sanity-check via the subject × relation compat matrix in `hero-stage.md`.** Disallowed: `device+emissive`, `object+emissive`, `composition+emissive`, `luminous+shadow-only`.

   **Honesty rule for `object`:** never CSS-simulate a concrete product. Render as a generic warm metallic form (vertical pill, horizontal disc, soft capsule) that holds the slot. Make no attempt to represent the actual product. User swaps for real render/photo before shipping. The stage (spotlight, vignette, floor, contact shadow) is fully composed so the swap is trivial.

5. **Decide motion:** `static` / `drift` / `pulse` / `reactive`. Default `static`. Only `drift` or `pulse` if the brand's own site visibly animates.

6. **Opt into `medium: shader`** only if the brand clearly uses animated WebGL as primary identity and one of the shader presets fits. See `references/background-shaders.md`. Default to CSS/SVG. Shader defaults are also `subtle`.

7. **Write the `hero_stage` YAML block** — see Phase 7. Include `observed_style` (prose), three dial groups, and a `disclaimer` when real-brand assets are proprietary.

**Photo-hero rule:** `medium: photo` or `subject: photo-cutout` renders a labeled prose placeholder, never fake stock imagery.

**Subtle-by-default rule:** every dial defaults to its calmest value. `intensity: subtle`, `vignette: off`, `bleed: ≤ 30`. Maximalist-looking brands still read as `subtle` in our fallback — hero copy sits on top and legibility is non-negotiable.

## Phase 5: Confirm direction

Summarize the aesthetic direction in 2–3 sentences. Include the primary tension that defines this language (e.g., "Industrial precision softened by warm grays", "Playful shapes with serious typography"). Wait for confirmation before generating files.

> **Direction:** Swiss-industrial with a single accent color as signal device. Monochrome palette, tight grids, mechanical motion. The contrast between clinical precision and one moment of color creates visual tension. Type-driven hierarchy via geometric sans + monospace pair.
>
> Proceed?

## Phase 6: Token preview

After approval, present core foundational tokens for a final check:

> **Proposed core tokens:**
> - Background: `#0A0A0B`
> - Accent: `#5E6AD2`
> - Body: Inter 14px / weight 400
> - Display: Inter 36px / weight 500
> - Base radius: 8px
> - Base spacing: 8px grid
> - Elevation: flat (no shadows, glow on hover)
>
> Confirm or adjust?

Low-cost opportunity to correct a foundational value before it cascades.

## Phase 7: Build design model

Create `design-model.yaml` in the skill folder as the **Single Source of Truth**. All subsequent files (tokens.md, components.md, platform-mapping.md, previews) are generated FROM this model.

Two token layers: **primitives** (raw ramps) and **semantic** (role-based tokens referencing primitives).

**Top-level keys:** `name`, `philosophy`, `primary_mode`, `brand_domain`, `brand_type` (`ui-rich` | `content-rich`), `mono_for_code`, `mono_for_metrics`, optional `locked_weight`.

**Sections:** `primitives` (color ramps + spacing + radii), `tokens` (semantic colors light/dark, spacing, radii, typography, elevation, motion, `hero_stage`, `iconography`), `components`, `app_screen`.

**Generating primitives:**
- **Neutral ramp:** extract brand gray temperature (warm/cool/pure) and generate 50–950 to match.
- **Brand ramp:** accent = 500; generate lighter (50–400) and darker (600–950).
- **Status colors:** minimal ramps (50/500/900) — enough for bg-tint + foreground + dark-mode.
- **Spacing/radii primitives:** a superset; semantic tokens pick from it.
- **Radii audit:** after generating semantic tokens, drop any primitive value not referenced. Pill-first → `[0,4,8,999]`; sharp/hard-edge → `[0,2,4]`; soft/not-round → `[0,4,8,12,16]`.

**Hero stage block is mandatory** — preset (or `null` + manual dials) + `observed_style` + `background` dials + `hero` (subject by intent, `form` only for `luminous`) + `relation` (`type` + `bleed`). Honesty rule for `subject: object`: render as a generic warm metallic placeholder, never CSS-simulate a real product. Add a `disclaimer` for proprietary brand assets.

**Iconography is dual-track:** `observed_style` (truth about the brand's icons) + `fallback_kit` (the kit the generated preview uses) + `disclaimer`. Never claim the brand uses the kit.

**`app_screen` block (Phase 13):** `archetype` (`dashboard` | `editor` | `list-detail` | `feed` | `conversational` | `canvas`), `frame` (`browser` | `phone` | `desktop` | `tablet`), `frame_params`, `content_seed`, `required_tokens_checklist`.

**Backwards-compat:** older skills may have `mono_for_data: true/false`. Treat true as both new flags true, false as both false.

Full annotated YAML schema with every field, comments, and examples: see [design-model-template.md](design-model-template.md).

Write the YAML first. Then generate all other files by reading from it.

## Phase 8: Generate files from design model

Read `design-model.yaml` and generate all 4 files. Fill every placeholder. No empty sections, no TODOs.

| File | Template | Purpose |
|------|----------|---------|
| `SKILL.md` | `skill-template.md` | Philosophy, craft rules, anti-patterns, workflow |
| `references/tokens.md` | `tokens-template.md` | Colors, fonts, spacing, motion, iconography |
| `references/components.md` | `components-template.md` | Buttons, cards, inputs, lists, navigation, overlays |
| `references/platform-mapping.md` | `platform-mapping-template.md` | CSS custom properties, SwiftUI, Tailwind |

**Every value must come from the design model.** If a value isn't in the YAML, add it first, then reference it. No hardcoding.

**Components are based on Phase 2's inventory.** Each component has `source: observed` or `source: derived` — traces back to Tear-Down Sheets.

## Phase 9: Write files

Default location: `~/.claude/skills/{skill-name}-design/`. If the user specifies a different path, use that.

```
{skill-name}-design/
  design-model.yaml         ← Single Source of Truth
  SKILL.md
  references/
    tokens.md
    components.md
    platform-mapping.md
```

## Phase 10: Visual preview (Bento Grid)

Create `preview.html` in the skill folder — a standalone Bento Grid dashboard rendered in the generated design language. Read `preview-template.md` for the spec. **All CSS values must come from `design-model.yaml`** — re-read the YAML before writing CSS to prevent drift.

Open with `open preview.html`. This is the magic moment.

## Phase 11: Component library

Generate `component-library.html` — every component on its own canvas with exact token values in a spec table. Read `component-library-template.md` for full spec.

Rules:
1. **Two-column layout.** Sticky TOC left (~240px), scrollable main right (max-width ~960px). TOC active-state via IntersectionObserver.
2. **Required sections** defined in the template — follow category tabs and section list. Skip a section only if the brand genuinely has no concept.
3. **Each section has:** heading + one-line description; Canvas with live components (variants + states side-by-side, no hover requirement); Spec table with exact token values.
4. **State rendering.** Multiple states (default/hover/active/focus/disabled) render **all at once** via static `.is-hover`, `.is-focused`, etc. Never rely on actual hover.
5. **Round stroke caps.** Progress rings, bars, dashed — `stroke-linecap: round` unless brand mandates flat (rare).
6. **Same floating Light/Dark bar** as Bento Grid — copy the pattern.
7. **All values from `design-model.yaml`.** Re-read before writing CSS.

Open after generating. Bento Grid answers "what does it feel like?"; Component Library answers "what are the exact values?".

## Phase 12: Landing page

Generate `landing-page.html` — editorial typography, narrative rhythm, alternating feature sections. Read `landing-page-template.md`.

Rules:
1. **Required sections in order:** Header, Hero, Feature 1, Feature 2, Feature 3, (optional) pull quote, (optional) pricing, Final CTA, Footer. Skip optional sections only if the brand genuinely doesn't fit.
2. **No lorem ipsum.** Every piece of copy must be specific to the brand in its observed voice. Decide voice in 2–3 adjectives (warm/poetic, clinical/precise, witty/direct) and commit. Specifics: "press cmd+k and find a note from three years ago by remembering one word from it" beats "powerful search features".
3. **Hero dominance.** Display headline feels 2–3× larger than any other type. `clamp(40px, 7vw, 72px)` works well.
4. **Alternating features.** Text-left / visual-right, then swap. Prevents single-column drift.
5. **Visual elements are suggestive, never literal.** Pick ONE approach: styled mini card stacks (UI-rich), type-as-image (editorial), icon+text combos (hybrid), color compositions (content-rich). Never stock photos, never fake logos.
6. **Restraint on surface tints.** Body on `var(--bg)`. `--surface1` / `--surface2` for at most one or two rhythm-break sections — never more.
7. **Same floating Light/Dark bar.**
8. **All values from `design-model.yaml`.** Re-read before writing CSS.

**Pre-ship verification — run before declaring done:**
1. **Every CSS class-selector must hit ≥1 element.** Grep selector names against HTML. If you introduce a wrapper like `.hero-content`, update every matching selector.
2. **Flex parents need explicit child widths.** A hero with `display: flex; align-items: center` shrinks its `.container` down to intrinsic width — a 1320px max-width becomes 721px. Use `width: 100%` on inner containers in flex heroes, or use `display: block` and center with margin.
3. **Open in browser and inspect the hero.** Check computed `font-family` and `font-size` on h1. If they say `Inter 32px` when expecting `Cormorant Garamond 96px`, your display-font rule didn't match. Test both light and dark — editorial brands often break in one.

## Phase 13: App screen

Generate `app-screen.html` — tokens applied to a representative product screen inside a device frame. Validates "does the design system survive contact with real product UI?" Read `app-screen-template.md`.

Rules:
1. **Archetype first.** Pick one of six: `dashboard`, `editor`, `list-detail`, `feed`, `conversational`, `canvas`. Match brand's actual product category via `brand_domain`.
2. **Device frame.** `browser` / `phone` / `desktop` / `tablet`, matched to brand's primary platform. Default `browser` for SaaS, `phone` for consumer, `desktop` for native pro tools.
3. **Content density is non-negotiable.** Sparse screens read as wireframes. Dashboard needs 4–8 metric tiles + chart + table. List-detail needs 10+ items. Conversational needs 8+ messages.
4. **Brand voice in invented content.** No lorem ipsum, no generic placeholders. A fictional SLO tool shows `checkout-api` and `auth-worker`, not `service-a`.
5. **Every token must show up ≥ once.** Use the required-tokens checklist. Missing tokens = coverage gap.
6. **One "mid-use" touch.** A cursor hovering, a hover state, a selected item — one visual signal "caught mid-use", not a static mockup.
7. **Same floating Light/Dark bar** and click-disabled anchors.
8. **Add the new view to the sticky TOC** in the component library so all four views are reachable.

**Status:** Phase 13 is live with `dashboard` + `browser` proofs (examples/ridge for SLO overview; examples/stint for project tracker). A third proof should exercise a *different* archetype — Halcyon with `conversational` (reasoning-graph chat) is the next target.

## Phase 14: Self-validation

Validate every HTML output against the design model. Covers `preview.html`, `component-library.html`, `landing-page.html`, `app-screen.html`.

**Automated checks (run all):**
1. **Parse `design-model.yaml`** — verify no YAML syntax errors.
2. **Grep for unresolved `{{...}}` placeholders** in all generated files.
3. **CSS selector coverage.** Grep every class-selector — verify ≥1 element match. Orphan selectors mean silent failure.
4. **Token coverage.** Every `var(--token)` used must be defined in `:root`. Missing → falls through to `initial`.
5. **Open each HTML in browser** — verify visually in light + dark. Check font-family on headings, accent on interactive elements, no unstyled fallback text, no broken layouts.

**Manual cross-checks:**
6. Accent in YAML matches hex used for interactive elements across all previews.
7. Font families in YAML match what's loaded and used.
8. Spacing values consistent between model and outputs.
9. Each component matches its Tear-Down Sheet or Derived Design from Phase 2.

Fix mismatches before showing the user.

## Phase 15: Offer iteration

Tell the user what was created and ask for adjustments. Common requests: "more contrast", "warmer tones", "different font", "more playful motion", "add a glow effect", "less padding".

**For iterations:** update `design-model.yaml` first, then regenerate only affected files. Keeps everything in sync.

## Phase 16: Installation reminder

> Restart Claude Code or start a new conversation for the skill to be detected. Activate by saying "{skill-name} design" or "/{skill-name}-design".

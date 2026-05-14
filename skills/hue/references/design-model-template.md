# `design-model.yaml` template

The single source of truth for a generated design skill. All subsequent files (tokens.md, components.md, platform-mapping.md, previews) are generated FROM this model.

Two token layers: **primitives** (raw ramps) and **semantic** (role-based tokens referencing primitives).

```yaml
name: "Vector"
philosophy: "Precision tooling. Dense, keyboard-first, violet-accented."
primary_mode: "dark"
brand_domain: "project management / issue tracking"
brand_type: "ui-rich"        # or "content-rich"
mono_for_code: true           # code blocks, file paths, shell commands, inline technical tokens
mono_for_metrics: true        # pricing, counts, timestamps, percentages, ID strings
# locked_weight: 400          # OPTIONAL. Only if the brand uses one weight across all text.

# Backwards-compat: older skills may have `mono_for_data: true/false`. Treat true as both new flags
# true; false as both false.

# ── PRIMITIVES ──
primitives:
  colors:
    neutral:    # warm/cool/pure — match brand
      50:  "#FAFAFA"
      100: "#F4F4F5"
      # … 200–950 ramp
    brand:      # accent hue, 500 = primary
      50:  "#EEF2FF"
      500: "#5E6AD2"
      # … 50–950 ramp
    red:   { 50: "#FEF2F2", 500: "#E5484D", 900: "#7F1D1D" }
    green: { 50: "#F0FDF4", 500: "#4AB66A", 900: "#14532D" }
    amber: { 50: "#FFFBEB", 500: "#E5A73B", 900: "#78350F" }
  spacing: [0, 1, 2, 4, 6, 8, 12, 16, 20, 24, 32, 40, 48, 64, 96]
  radii:   [0, 2, 4, 6, 8, 12, 16, 24, 999]
  # NOTE: radii is a SUPERSET — trim to what the brand uses.
  #   Pill-first (Cursor, Stripe pill CTAs)    → [0, 4, 8, 999]
  #   Sharp / hard-edge (Linear, Nothing)      → [0, 2, 4]
  #   Soft but not round (Notion, Apple)       → [0, 4, 8, 12, 16]
  # After generating semantic tokens, audit primitives — drop any value not referenced.

# ── SEMANTIC TOKENS ──
tokens:
  colors:
    light:  { background, surface1, surface2, surface3, border, border_visible,
              text1, text2, text3, text4, accent, accent_subtle }   # all → {neutral.*} / {brand.*}
    dark:   { background, surface1, surface2, surface3, border, border_visible,
              text1, text2, text3, text4, accent, accent_subtle }
    success: "{green.500}"
    warning: "{amber.500}"
    error:   "{red.500}"
  spacing: { 2xs: 2, xs: 4, sm: 8, md: 16, lg: 24, xl: 32, 2xl: 48, 3xl: 64, 4xl: 96 }
  radii:   { element: 4, control: 6, component: 8, container: 12, pill: 999 }
  typography:
    display: { family: "Inter", size: "36px", weight: 500, line_height: 1.1 }
    body:    { family: "Inter", size: "14px", weight: 400, line_height: 1.5 }
    mono:    { family: "JetBrains Mono", size: "12px", weight: 400 }
  elevation: { strategy: "flat", ... }
  motion:    { personality: "mechanical", easing: "ease-out", duration_fast: "100ms", duration_normal: "150ms" }

  # Hero stage — composed background + optional subject + relation. Mandatory.
  hero_stage:
    preset: "painterly-no-hero"   # or null for fully manual
    observed_style:
      description: "Hand-painted warm landscape scenes; no foreground subject."
      where_used: ["hero", "feature sections"]
    background:
      medium: "painterly"
      color_mode: "palette"       # monochrome / dual-tone / palette / brand-tinted-neutral
      saturation: "muted"         # flat / muted / vibrant / neon
      light_source: "ambient"
      falloff: "soft"
      vignette: "off"
      texture: "paint"
      motion: "static"
      intensity: "subtle"
      safe_zone: "full-bleed"
      color_palette: ["#FFA47C", "#FFE926", "#FF7DD3", "#FFC2A8", "#5CB13E"]
    hero:
      subject: "none"             # none / luminous / object / device / composition / photo-cutout
      # form: "sphere"            # ONLY for luminous
    relation:
      type: "flat"                # flat / glow / halo / reflection / emissive / shadow-only
      bleed: 0
    disclaimer: "Approximated with SVG + CSS. Real brand uses commissioned illustrations."

  # Dual-track iconography — brand reality + our fallback.
  iconography:
    observed_style:
      description: "Custom 1.75px outline icons, rounded terminals, humanist."
      stroke_weight: "regular"
      corner_treatment: "soft"
      fill_style: "outline"
      form_language: "humanist"
      visual_density: "balanced"
    fallback_kit:
      name: "Phosphor"
      weight: "regular"
      match_score: "high"
      match_reasoning: "Phosphor regular matches stroke (~1.5px), rounded terminals, humanist form. Iconoir would be second."
      cdn: "https://unpkg.com/@phosphor-icons/web@2/src/regular/style.css"
      icon_class_prefix: "ph ph-"
    disclaimer: "Best-match fallback. Brand's real icons are proprietary."

components:
  button_primary:
    source: "observed"
    background: "{brand.500}"
    color: "#FFFFFF"
    padding: "10px 16px"
    radius: "{radii.control}"
    font_weight: 500
    hover: { background: "{brand.600}" }
  # ...

# App screen — Phase 13 generation.
app_screen:
  archetype: "dashboard"            # dashboard / editor / list-detail / feed / conversational / canvas
  frame: "browser"                  # browser / phone / desktop / tablet
  frame_params: { url: "app.vector.dev/projects", title: "Vector — Projects" }
  content_seed: "SLO dashboard for checkout-api"
  required_tokens_checklist:
    - "background, surface1..3, border, border_visible"
    - "text1..4"
    - "accent, accent_subtle, success, warning, error"
    - "all typography scale"
    - "all spacing tokens used in components"
```

## Generating primitives

- **Neutral ramp:** extract brand gray temperature (warm/cool/pure) and generate 50–950 to match.
- **Brand ramp:** accent = 500; generate lighter (50–400) and darker (600–950).
- **Status colors:** minimal ramps (50/500/900) — enough for bg-tint + foreground + dark-mode.
- **Spacing/radii primitives:** a superset; semantic tokens pick from it.

Write the YAML first. Then generate all other files by reading from it.

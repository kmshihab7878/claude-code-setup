# UI/UX Pro Max Pattern Reference

This reference contains UI pattern catalogs, rule priorities, and professional visual heuristics.

## Priority Categories

| Priority | Category | Impact | Domain |
|---|---|---|---|
| 1 | Accessibility | Critical | `ux` |
| 2 | Touch and interaction | Critical | `ux` |
| 3 | Performance | High | `ux` |
| 4 | Layout and responsive | High | `ux` |
| 5 | Typography and color | Medium | `typography`, `color` |
| 6 | Animation | Medium | `ux` |
| 7 | Style selection | Medium | `style`, `product` |
| 8 | Charts and data | Low | `chart` |

## Quick Rule Catalog

### Accessibility

- `color-contrast`: minimum 4.5:1 ratio for normal text.
- `focus-states`: visible focus rings on interactive elements.
- `alt-text`: descriptive alt text for meaningful images.
- `aria-labels`: aria-label for icon-only buttons.
- `keyboard-nav`: tab order matches visual order.
- `form-labels`: label each input.

### Touch and Interaction

- `touch-target-size`: minimum 44x44px touch targets.
- `hover-vs-tap`: use click/tap for primary interactions.
- `loading-buttons`: disable buttons during async operations.
- `error-feedback`: show clear error messages near the problem.
- `cursor-pointer`: add pointer cursor to clickable elements.

### Performance

- `image-optimization`: use modern formats, responsive sources, and lazy loading.
- `reduced-motion`: check `prefers-reduced-motion`.
- `content-jumping`: reserve space for async content.

### Layout and Responsive

- `viewport-meta`: include mobile viewport metadata where relevant.
- `readable-font-size`: minimum 16px body text on mobile.
- `horizontal-scroll`: ensure content fits viewport width.
- `z-index-management`: use a defined z-index scale.

### Typography and Color

- `line-height`: use roughly 1.5-1.75 for body text.
- `line-length`: keep long prose around 65-75 characters per line.
- `font-pairing`: match heading and body font personalities.

### Animation

- `duration-timing`: use 150-300ms for micro-interactions.
- `transform-performance`: animate transform and opacity where possible.
- `loading-states`: use skeletons or spinners for async waits.

### Style Selection

- `style-match`: match style to product type.
- `consistency`: use the same design language across pages.
- `no-emoji-icons`: use SVG icons instead of emojis.

### Charts and Data

- `chart-type`: match chart type to data type and user question.
- `color-guidance`: use accessible palettes.
- `data-table`: provide a table alternative when accessibility requires it.

## Professional UI Rules

### Icons and Visual Elements

| Rule | Do | Avoid |
|---|---|---|
| No emoji icons | Use SVG icons such as Heroicons, Lucide, or Simple Icons | Emoji as UI controls |
| Stable hover states | Use color, opacity, border, or shadow transitions | Scale transforms that shift layout |
| Correct brand logos | Use official SVGs from trusted sources | Guessing logo shapes |
| Consistent icon sizing | Use fixed viewBox and consistent dimensions | Mixed random icon sizes |

### Interaction and Cursor

| Rule | Do | Avoid |
|---|---|---|
| Pointer cursor | Add `cursor-pointer` to interactive cards and controls | Default cursor on clickable elements |
| Hover feedback | Provide clear visual feedback | No visible interaction state |
| Smooth transitions | Use 150-300ms transitions | Instant changes or transitions over 500ms |

### Light and Dark Mode Contrast

| Rule | Do | Avoid |
|---|---|---|
| Glass card light mode | Use high-opacity light surfaces | Very transparent white surfaces |
| Text contrast light | Use dark text for body content | Low-contrast light grays |
| Muted text light | Keep muted text readable | Gray values that fail contrast |
| Border visibility | Use visible borders in both themes | Invisible borders on light surfaces |

### Layout and Spacing

| Rule | Do | Avoid |
|---|---|---|
| Floating navbar | Add edge spacing | Pinning floating nav to viewport edges |
| Content padding | Account for fixed navbar height | Content hidden behind fixed elements |
| Consistent max-width | Use stable container widths | Mixing unrelated widths across sections |

## Chart Heuristics

- Use line charts for trends over time.
- Use bars for category comparison.
- Use stacked bars sparingly and only when composition matters.
- Use area charts for volume over time when exact values are secondary.
- Use scatter plots for correlation.
- Use funnel charts for staged conversion.
- Avoid pie charts for many categories or precise comparison.
- Use table fallback for dense or accessibility-critical data.

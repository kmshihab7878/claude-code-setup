# UI/UX Pro Max Design Workflow Reference

This reference contains detailed search workflow, domain and stack catalogs, design-system persistence, and output formats. Keep `SKILL.md` as the operating contract.

## Contents

- [Prerequisites](#prerequisites)
- [Workflow](#workflow)
- [Design System Search](#design-system-search)
- [Persisted Design Systems](#persisted-design-systems)
- [Detailed Searches](#detailed-searches)
- [Stack Guidelines](#stack-guidelines)
- [Domains](#domains)
- [Stacks](#stacks)
- [Output Formats](#output-formats)
- [Tips](#tips)

## Prerequisites

Check Python:

```bash
python3 --version || python --version
```

If missing, install with the user's normal package manager and approval posture:

```bash
# macOS
brew install python3

# Ubuntu/Debian
sudo apt update && sudo apt install python3

# Windows
winget install Python.Python.3.12
```

## Workflow

1. Analyze product type, industry, audience, style keywords, and stack.
2. Generate a design system first.
3. Use focused domain searches for missing detail.
4. Get stack-specific guidance.
5. Synthesize findings into implementation or critique.
6. Validate accessibility, responsive layout, motion, interaction, and visual quality.

## Design System Search

Always start substantial design work with `--design-system`:

```bash
python3 scripts/search.py "<product_type> <industry> <keywords>" --design-system -p "<project-name>"
```

This:

1. Searches product, style, color, landing, and typography domains.
2. Applies reasoning rules from `ui-reasoning.csv`.
3. Returns pattern, style, colors, typography, effects, and anti-patterns.
4. Provides a high-signal starting point for implementation.

## Persisted Design Systems

Persist only when a durable project design system is useful:

```bash
python3 scripts/search.py "<query>" --design-system --persist -p "<project-name>"
```

This creates:

- `design-system/MASTER.md`: global source of truth.
- `design-system/pages/`: page-specific override folder.

For page overrides:

```bash
python3 scripts/search.py "<query>" --design-system --persist -p "<project-name>" --page "dashboard"
```

Retrieval rule:

1. Read `design-system/MASTER.md`.
2. Check for `design-system/pages/<page-name>.md`.
3. If present, page rules override the master.
4. If absent, use master rules exclusively.

## Detailed Searches

After design-system generation, use focused searches:

```bash
python3 scripts/search.py "<keyword>" --domain <domain> [-n <max_results>]
```

| Need | Domain | Example |
|---|---|---|
| More style options | `style` | `--domain style "glassmorphism dark"` |
| Chart recommendations | `chart` | `--domain chart "real-time dashboard"` |
| UX best practices | `ux` | `--domain ux "animation accessibility"` |
| Alternative fonts | `typography` | `--domain typography "elegant luxury"` |
| Landing structure | `landing` | `--domain landing "hero social-proof"` |

## Stack Guidelines

Default to `html-tailwind` if the user does not specify a stack.

```bash
python3 scripts/search.py "<keyword>" --stack html-tailwind
```

## Domains

| Domain | Use For | Example Keywords |
|---|---|---|
| `product` | Product type recommendations | SaaS, e-commerce, portfolio, healthcare, beauty, service |
| `style` | UI styles, colors, effects | glassmorphism, minimalism, dark mode, brutalism |
| `typography` | Font pairings and type systems | elegant, playful, professional, modern |
| `color` | Color palettes by product type | saas, ecommerce, healthcare, beauty, fintech, service |
| `landing` | Page structure and CTA strategy | hero, testimonial, pricing, social-proof |
| `chart` | Chart types and libraries | trend, comparison, timeline, funnel, pie |
| `ux` | Best practices and anti-patterns | animation, accessibility, z-index, loading |
| `react` | React/Next.js performance | waterfall, bundle, suspense, memo, rerender, cache |
| `web` | Web interface guidelines | aria, focus, keyboard, semantic, virtualize |
| `prompt` | AI prompts and CSS keywords | style name |

## Stacks

| Stack | Focus |
|---|---|
| `html-tailwind` | Tailwind utilities, responsive layout, accessibility |
| `react` | State, hooks, performance, patterns |
| `nextjs` | SSR, routing, images, API routes |
| `vue` | Composition API, Pinia, Vue Router |
| `svelte` | Runes, stores, SvelteKit |
| `swiftui` | Views, state, navigation, animation |
| `react-native` | Components, navigation, lists |
| `flutter` | Widgets, state, layout, theming |
| `shadcn` | shadcn/ui components, theming, forms, patterns |
| `jetpack-compose` | Composables, modifiers, state hoisting, recomposition |

## Output Formats

```bash
# ASCII box, useful in terminals
python3 scripts/search.py "fintech crypto" --design-system

# Markdown, useful for docs
python3 scripts/search.py "fintech crypto" --design-system -f markdown
```

## Tips

- Specific keywords beat broad labels.
- Search multiple times when the first result does not match the product.
- Combine style, typography, and color before implementation.
- Search UX for animation, z-index, accessibility, loading, and responsive issues.
- Use stack guidance before writing framework-specific code.
- Iterate when the design system conflicts with user goals or existing brand constraints.

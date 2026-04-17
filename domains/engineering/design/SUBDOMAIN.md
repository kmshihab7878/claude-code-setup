# Engineering — Design

Frontend design, UI systems, brand visual identity, animation.

## Canonical skills (per `docs/SURFACE-MAP.md`)

- `impeccable-design` — Distinctive production UI from scratch (CANONICAL)
- `impeccable-audit` — UI audit: a11y + perf + theming + responsive + anti-patterns (CANONICAL)
- `impeccable-polish` — Visual micro-detail polish pass (CANONICAL)
- `hue` — Brand URL/name/screenshot → generated design-language child skill under `skills/<brand>/` (META-SKILL)
- `react-bits` — 130-component catalog, shadcn-CLI install
- `responsive-design` — Mobile-first patterns
- `framer-motion-patterns` — React animation (Framer Motion variants, spring physics)
- `remotion-animation` — Programmatic video with Remotion
- `video-ui-patterns` — Reusable video UI patterns
- `web-artifacts-builder` — Complex claude.ai HTML artifacts
- `algorithmic-art` — p5.js seeded art
- `clone-website` — Reverse-engineer and clone any website pixel-perfect
- `design-inspector` — Extract design tokens from a live website

## Alternatives (pending telemetry review per SURFACE-MAP)

- `frontend-design`, `interface-design`, `ui-ux-pro-max`, `ui-design-system`, `distilled-aesthetics`, `baseline-ui`, `aidesigner-frontend`, `brand-guidelines`, `ux-researcher-designer`

Per AUDIT §5.2, `frontend-design` is a merge candidate into `impeccable-design` (descriptions are near-duplicate). `baseline-ui` is the canonical validator counterpart to `impeccable-audit`.

## Agents

- **L2:** `frontend-architect`
- **L3:** `ux-designer`, `mobile-app-builder`
- **L5:** `rapid-prototyper`

## Commands

- `/polish-ux` — UX polish (CANONICAL)
- `/planUI` — UI-focused 7-stage pipeline routing 26 UI skills
- `/interface-design-init`, `/interface-design-audit`, `/interface-design-critique`, `/interface-design-extract`, `/interface-design-status` — CONSOLIDATION candidates per AUDIT

## Fix-* specialist skills

- `fixing-accessibility` — ARIA, keyboard, contrast, WCAG
- `fixing-motion-performance` — Animation jank, compositor layers, scroll-linked motion
- `fixing-metadata` — Page titles, OG tags, canonical URLs, favicons

## Notes

- **19 Hue brand demos** under `skills/hue/examples/*.html` — the highest-leverage single-file demo set in the repo. Keep.
- **Biggest overlap cluster** — 11 design skills fire on "build UI" triggers. See AUDIT §3.2 for consolidation map.

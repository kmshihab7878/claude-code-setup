---
name: Impeccable Design System — pbakaus Framework
description: Production-grade frontend design system for avoiding AI slop aesthetics. Source: pbakaus/impeccable (Apache 2.0). Covers typography, color, layout, motion, interaction, plus audit scoring system and pre-ship polish checklist.
confidence: 0.99
last-updated: 2026-04-08
linked-sources: [github.com/pbakaus/impeccable]
linked-wiki: []
tags: [frontend, design, ui, quality, anti-patterns, css, typography]
---

# Impeccable Design System

Source: `pbakaus/impeccable` (Apache 2.0). 22 skills, 20 commands. Website: impeccable.style.

**Core principle**: If you showed this interface to someone and said "AI made this," would they believe you immediately? If yes, that's the problem.

---

## Design Direction Process

Commit to a BOLD aesthetic direction upfront:
- **Purpose**: What problem? Who uses it?
- **Tone**: Pick ONE extreme — brutally minimal, maximalist chaos, retro-futuristic, editorial/magazine, brutalist/raw, art deco/geometric, soft/pastel, industrial/utilitarian, luxury/refined
- **Constraints**: Framework, performance, accessibility requirements
- **Differentiation**: What makes it UNFORGETTABLE? What's the one thing someone remembers?

**Critical**: Choose a clear conceptual direction and execute with precision. Intentionality matters, not intensity.

---

## Typography Rules

**DO**:
- Use a modular type scale with fluid sizing (`clamp()`)
- Vary font weights and sizes for clear visual hierarchy
- Pair a distinctive display font with a refined body font

**NEVER USE**: Inter, Roboto, Arial, Open Sans, system defaults
**NEVER**: Monospace as lazy shorthand for "developer vibes"
**NEVER**: Large icons with rounded corners above every heading (looks templated)

---

## Color Rules

**DO**:
- Use modern CSS color functions (`oklch`, `color-mix`, `light-dark`) — OKLCH is perceptually uniform
- Tint neutrals toward brand hue — even subtle hints create subconscious cohesion
- Dominant colors with sharp accents > timid, evenly-distributed palettes

**NEVER**:
- Gray text on colored backgrounds (looks washed out — use a shade of background color instead)
- Pure black (#000) or pure white (#fff) — always tint
- **The AI Color Palette**: cyan-on-dark, purple-to-blue gradients, neon accents on dark backgrounds
- Gradient text on headings/metrics (decorative not meaningful)
- Default to dark mode with glowing accents (looks "cool" without real design decisions)

---

## Layout Rules

**DO**:
- Create visual rhythm via varied spacing — tight groupings, generous separations
- Use fluid spacing with `clamp()` that breathes on larger screens
- Use asymmetry and unexpected compositions; break the grid intentionally for emphasis
- Use container queries (`@container`) for component-level responsiveness

**NEVER**:
- Wrap everything in cards — not everything needs a container
- Nest cards inside cards
- Use identical card grids (same-sized, icon + heading + text, repeated endlessly)
- Use the hero metric template (big number + small label + gradient accent)
- Center everything — left-aligned text with asymmetric layouts feels more designed

---

## Motion Rules

**DO**:
- Use exponential easing (`ease-out-quart/quint/expo`) for natural deceleration
- For height animations: use `grid-template-rows` transitions
- Focus on high-impact moments: one well-orchestrated page load > scattered micro-interactions

**NEVER**:
- Animate layout properties (width, height, padding, margin) — use transform and opacity only
- Use bounce or elastic easing — feels dated and tacky

---

## Visual Details Anti-Patterns (AI Slop Fingerprints)

These are the fingerprints of AI-generated work from 2024-2025. Avoid ALL of them:

- Glassmorphism everywhere (blur effects, glass cards, glow borders)
- Rounded elements with thick colored border on one side
- Sparklines as decoration
- Rounded rectangles with generic drop shadows
- Modals for everything
- Hero metrics layout (big number, small label, supporting stats, gradient accent)

---

## Audit Scoring System

Run before ship. Score 0–4 per dimension (0=Critical, 4=Excellent):

| Dimension | Score | Criteria |
|-----------|-------|---------|
| Accessibility (a11y) | 0-4 | Contrast ratios, ARIA, keyboard nav, semantic HTML |
| Performance | 0-4 | No layout thrash, transform-only animations, lazy loading |
| Theming | 0-4 | Design tokens, dark mode, no hard-coded colors |
| Responsive Design | 0-4 | No fixed widths, 44px touch targets, no overflow |
| Anti-Patterns | 0-4 | No AI slop tells (5+=0, 3-4=1, 1-2=2, subtle=3, none=4) |

**Rating bands**: 18-20 Excellent, 14-17 Good, 10-13 Acceptable, 6-9 Poor, 0-5 Critical

---

## Polish Checklist (Pre-Ship)

- [ ] Visual alignment perfect at all breakpoints
- [ ] Spacing uses design tokens consistently
- [ ] Typography hierarchy consistent
- [ ] All interactive states implemented (default, hover, focus, active, disabled, loading, error, success)
- [ ] All transitions smooth 60fps
- [ ] Copy is consistent and polished
- [ ] Icons consistent and properly sized
- [ ] All forms properly labeled and validated
- [ ] Error states are helpful
- [ ] Loading states are clear
- [ ] Empty states are welcoming
- [ ] Touch targets ≥ 44×44px
- [ ] Contrast ratios meet WCAG AA
- [ ] Keyboard navigation works
- [ ] Focus indicators visible
- [ ] Respects `prefers-reduced-motion`
- [ ] No console errors or warnings

---

## Skill System (22 skills available)

Skills installed at `~/.claude/skills/impeccable-*`:
- `impeccable-design` — main design guidance, context gathering, direction setting
- `impeccable-audit` — technical quality audit with P0-P3 severity ratings
- `impeccable-polish` — final pre-ship quality pass with full checklist

Full skill library: adapt, animate, arrange, audit, bolder, clarify, colorize, critique, delight, distill, extract, frontend-design, harden, normalize, onboard, optimize, overdrive, polish, quieter, teach-impeccable, typeset.

---

## Context Gathering Requirement

**CRITICAL**: Design skills produce generic output without project context. Before any design work, gather:
- **Target audience**: Who uses this? In what context?
- **Use cases**: What jobs are they trying to get done?
- **Brand personality/tone**: How should the interface feel?

You cannot infer this from the codebase. Code tells you what was built, not who it's for.

If no design context exists, run `/impeccable-design` first to establish context.

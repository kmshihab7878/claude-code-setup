---
name: shihab-task-mgmt
description: "Design language for Shihab Task & Service Hub — an industrial-navy SaaS admin console with a permanent dark sidebar, RAG status semantics, and an 'oracle' purple accent reserved for AI surfaces. Use when building new screens, components, or views inside the Shihab Task Management codebase; when mocking up features for this product; or when extending shadcn/ui components so they match the existing token system. Extracted live from the running app on 2026-04-16, cross-referenced with src/index.css and tailwind.config.ts."
version: 1.0.0
allowed-tools: [Read, Write, Edit, Glob, Grep]
---

# Shihab Task Management — Design Language

Enterprise-restraint admin console. Cool blue-grays, deep navy primary, a permanent dark navy sidebar that stays dark in both themes, and three colored signals (RAG + Oracle) doing all the communicative work. Surfaces are flat with 1px borders and 8px corners; type is Inter throughout with uppercase-small-caps section labels.

**Brand type**: UI-rich admin product. Differentiation lives in the RAG status grammar and the persistent navy sidebar.

---

## 1. Hard rules

1. **Never invent new color tokens.** Use only the CSS custom properties declared in `src/index.css`. If you need a role that doesn't exist (e.g. "warning muted"), derive it from `--rag-amber` or `--muted` — don't add a new hex.
2. **Sidebar is always dark navy.** In both light and dark themes. Don't re-theme it to match `--background`. The contrast is part of the identity.
3. **RAG is semantic, not decorative.** Use `--rag-green/amber/red` (and their `-bg` variants) *only* for status: on-track / at-risk / off-track, or CSAT tiers. Never as buttons, never as chart fill for non-status data.
4. **Oracle purple is AI-only.** `--oracle-accent` and `.oracle-badge` are reserved for AI-assistant surfaces (Shihab AI chat, AI-generated fields). Don't use for UI chrome.
5. **Section labels are uppercase, 14px/600, letter-spacing 0.7px.** Never use sentence case for `<h2>`-level group headers.
6. **Page titles are `<h1>` with `.page-header`.** Screen-reader heading hierarchy starts at h1 on every page. (`/knowledge-base` currently violates this — fix when touched.)
7. **8px radius baseline.** `--radius: 0.5rem` → cards `8px`, buttons `6px` via `calc(var(--radius) - 2px)`, small pills `4px`. Don't introduce 12/16/24.
8. **RTL ready.** Use logical properties (`ps-4` not `pl-4`, `me-2` not `mr-2`). The app ships Arabic and flips `dir` on the root.

## 2. Core tokens (from `src/index.css`)

### Light (`:root`)
```css
--background: 220 20% 97%;       /* #f6f7f9  page bg, cool tinted */
--foreground: 220 30% 10%;       /* #121721  text */
--card: 0 0% 100%;               /* #ffffff  elevated surface */
--primary: 215 50% 23%;          /* #1d3658  brand navy */
--primary-foreground: 0 0% 98%;  /* #fafafa */
--secondary: 215 25% 90%;        /* #dfe4ec  soft blue-gray */
--accent: 215 25% 90%;           /* same as secondary */
--muted: 220 15% 93%;            /* #eaecf0  neutral fill */
--muted-foreground: 220 10% 46%; /* #6a7181  secondary text */
--border: 220 15% 88%;           /* #dcdfe5  1px dividers */
--input: 220 15% 88%;
--ring: 215 50% 23%;             /* focus = primary */
--destructive: 0 72% 51%;        /* #dc2828 */
--radius: 0.5rem;

/* Status (RAG) */
--rag-green: 142 71% 45%;  --rag-green-bg: 142 71% 95%;
--rag-amber: 38 92% 50%;   --rag-amber-bg: 38 92% 95%;
--rag-red:   0 72% 51%;    --rag-red-bg:   0 72% 95%;

/* AI accent */
--oracle-accent: 262 52% 47%;    /* #673ab6 */
--oracle-accent-bg: 262 52% 95%;

/* Sidebar — stays dark in both themes */
--sidebar-background: 215 50% 16%;   /* #14253d */
--sidebar-foreground: 215 20% 85%;   /* #d1d7e0 */
--sidebar-accent: 215 45% 22%;       /* hover #1f3451 */
--sidebar-border: 215 40% 25%;
```

### Dark (`.dark`)
```css
--background: 220 25% 8%;    /* #0f131a */
--foreground: 220 15% 90%;   /* #e2e4e9 */
--card: 220 25% 12%;         /* #171c26 */
--primary: 215 60% 60%;      /* #5c8fd6  LIFTED for dark */
--border: 220 20% 18%;       /* #252b37 */
--sidebar-background: 220 30% 6%;  /* #0b0e14  even darker */
```

**Always** reference via Tailwind semantic classes (`bg-background`, `text-foreground`, `border-border`, `bg-primary text-primary-foreground`). Never hard-code hex in components.

## 3. Typography

| Element | Class / inline | Size | Weight | Notes |
|---------|----------------|------|--------|-------|
| Page title | `.page-header` | `text-2xl` (24px) | 700 | `<h1>` only |
| Section title | `.section-title` | `text-lg` (18px) | 600 | `<h3>` |
| Section CAP label | `<h2 className="uppercase tracking-wider text-sm font-semibold text-muted-foreground">` | 14px | 600 | letter-spacing 0.7px, muted color |
| Body | inherited | 16px | 400 | Inter |
| Table / compact | `text-xs` or `text-sm` | 12–14px | 400–500 | |

Font stack: `Inter, -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif` — loaded from Google Fonts in `index.css` line 1.

## 4. Component recipes

All built on shadcn/ui + Radix. Use existing primitives from `@/components/ui/*` before writing new ones.

### Card (KPI / content)
```tsx
<div className="bg-card rounded-lg border p-4 shadow-sm transition-shadow hover:shadow-md">
  {/* or use the .kpi-card utility from index.css */}
</div>
```
- `rounded-lg` = 8px, 1px border, minimal shadow that lifts on hover.

### Button
Use shadcn `<Button>`. Variants map:
- `default` — `bg-primary text-primary-foreground` (deep navy)
- `secondary` — `bg-secondary text-secondary-foreground` (muted blue-gray)
- `outline` — bordered, transparent
- `ghost` — transparent, shows on hover
- `destructive` — red
- `link` — no chrome

Don't invent `primary-solid` or `primary-subtle` — the shadcn variant set is the full set.

### Status pill (RAG)
```tsx
<span className="inline-flex items-center gap-1.5 rag-green px-2 py-0.5 rounded-full text-xs font-medium">
  <span className="rag-dot-green" /> On track
</span>
```
Classes `.rag-green`, `.rag-amber`, `.rag-red` and the matching `.rag-dot-*` are defined in `index.css`. Use them — don't re-implement.

### Oracle (AI) badge
```tsx
<span className="oracle-badge">AI</span>
```
Use to flag AI-generated content. Never for regular features.

### Data table
Dense rows, `text-xs` to `text-sm`, borders only between rows (`divide-y divide-border`), no vertical grid lines. Column headers uppercase in `text-muted-foreground`. See `/employees` and `/customer-service` screens for live reference.

### Sidebar
Use the existing `AppSidebar` component — don't build a new one. It uses `bg-sidebar text-sidebar-foreground` tokens that stay dark in both themes. Section captions (`HOME`, `WORK`, `SERVICE`, `PEOPLE & PERFORMANCE`, `ADMIN`) are uppercase muted text, 11–12px.

## 5. Spacing & layout

- Grid: Tailwind default (4px base). Use `gap-3` / `gap-4` most often, `gap-6` for section separation.
- Page padding: `p-6` on desktop, `p-4` on mobile.
- Card internal padding: `p-4` standard, `p-6` for feature cards.
- Container: `@container` queries welcome; responsive breakpoints are standard Tailwind (`sm`, `md`, `lg`, `xl`, `2xl`), with `2xl` at 1400px per `tailwind.config.ts`.

## 6. Motion

- Transitions: `transition-shadow`, `transition-colors`, `transition-opacity`. Keep to 150–200ms.
- `tailwindcss-animate` is loaded — use its `animate-in` / `fade-in` / `slide-in-from-*` utilities for overlays.
- Accordion keyframes are defined. Don't add new ones unless necessary.
- `@media (prefers-reduced-motion: reduce)` clamps everything to `0.01ms` (via `index.css`) — respect this when adding motion. If you need a non-decorative animation, guard it with the same media query check.

## 7. Charts (recharts)

Use the 5 declared chart colors:
```
--chart-1: #1d3658  (navy)
--chart-2: #21c45d  (green)
--chart-3: #f59f0a  (amber)
--chart-4: #dc2828  (red)
--chart-5: #673ab6  (oracle purple)
```
Reference via `hsl(var(--chart-1))` etc. For multi-series charts, go `1 → 2 → 3 → 4 → 5` in order. For RAG charts, bind green/amber/red to their status semantics — don't rotate through all five.

## 8. Don'ts

- ❌ Don't introduce new hex values without adding a CSS variable first.
- ❌ Don't use `--primary` on the sidebar — sidebar has its own token layer (`--sidebar-*`).
- ❌ Don't use RAG colors for buttons, links, or decorative chrome.
- ❌ Don't use `--oracle-accent` for anything but AI-assistant surfaces.
- ❌ Don't wrap `<h1>` / `<h2>` in extra `<div>` "mock-heading" styling. Use the actual tag + the `.page-header` / uppercase-caps pattern.
- ❌ Don't hardcode `dir="ltr"` — let the `LanguageContext` set it.
- ❌ Don't skip `.sr-only` labels on icon buttons (see the spinner in `App.tsx` for the pattern).

## 9. Known gaps worth fixing (per UI audit 2026-04-16)

When you touch these, fix them:
1. `src/pages/KnowledgeBasePage.tsx` uses `<h2>` as the page title — change to `<h1 className="page-header">`.
2. CSP `worker-src 'self'` blocks blob-URL Web Workers on `/my-tasks`. Add `blob:` to the worker-src meta in `index.html` if a dependency needs it.
3. i18n: page-level headings, tabs, and some comboboxes are not translated. Audit `t()` coverage when adding Arabic to a new page.

## 10. Reference files

- `src/index.css` — canonical token source
- `tailwind.config.ts` — token bindings, font family, chart colors
- `components.json` — shadcn config
- `src/components/ui/*` — existing primitives (prefer these over new components)
- `src/components/AppSidebar.tsx` — sidebar reference
- `src/components/ThemeProvider.tsx` — theme toggle source
- `src/contexts/LanguageContext.tsx` — RTL + i18n wiring

When in doubt: read the existing page closest to what you're building (e.g. `src/pages/Dashboard.tsx` for metric grids, `src/pages/CustomerServiceReports.tsx` for data tables with tabs), match its idioms.

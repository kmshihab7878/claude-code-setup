---
name: clone-website
description: Reverse-engineer and clone any website pixel-perfectly — extracts assets, CSS, and content section-by-section and dispatches parallel builder agents in worktrees. Triggers on "clone", "replicate", "rebuild", "reverse-engineer", "copy site", "pixel-perfect clone". Provide the target URL as an argument.
argument-hint: "<url>"
user-invocable: true
---

# Clone Website

You are about to reverse-engineer and rebuild **$ARGUMENTS** as a pixel-perfect clone.

This is not a two-phase process (inspect then build). You are a **foreman walking the job site** — as you inspect each section of the page, you write a detailed specification to a file, then hand that file to a specialist builder agent with everything they need. Extraction and construction happen in parallel, but extraction is meticulous and produces auditable artifacts.

## Pre-Flight

1. **Playwright MCP is required.** Test it by calling `browser_navigate` to the target URL. If it fails, stop and tell the user to check their Playwright MCP configuration.
2. Read `TARGET.md` for URL and scope. If the URL doesn't match `$ARGUMENTS`, update it. If no `TARGET.md` exists, create one from the template at `~/Projects/ai-website-cloner-template/TARGET.md`.
3. Verify the base project builds. If no Next.js scaffold exists, clone from: `~/Projects/ai-website-cloner-template/` as a starting point, or scaffold with `npx create-next-app@latest`.
4. Create the output directories if they don't exist: `docs/research/`, `docs/research/components/`, `docs/design-references/`, `scripts/`.

## Playwright MCP Tool Reference

All browser operations use the Playwright MCP server. Key tool mappings:

| Operation | Tool | Notes |
|-----------|------|-------|
| Navigate to URL | `browser_navigate` | `url` parameter |
| Take screenshot | `browser_take_screenshot` | Returns base64 image |
| Click element | `browser_click` | Use `element` (accessibility description) or `ref` from snapshot |
| Hover element | `browser_hover` | Same selectors as click |
| Run JavaScript | `browser_evaluate` | `expression` parameter — use for `getComputedStyle()`, DOM queries |
| Get DOM tree | `browser_snapshot` | Returns accessibility tree with `ref` numbers for interaction |
| Press key | `browser_press_key` | `key` parameter (e.g., "Tab", "Enter", "Escape") |
| Resize viewport | `browser_resize` | `width` and `height` parameters |
| Wait for element | `browser_wait_for` | Wait for selectors/text to appear |
| Fill form | `browser_fill_form` | Fill input fields |
| Scroll | `browser_evaluate` | `window.scrollTo(0, Y)` or `window.scrollBy(0, delta)` |

**Important**: Use `browser_snapshot` first to get the page structure and `ref` numbers, then use those refs for `browser_click`, `browser_hover`, etc. Use `browser_evaluate` for all JavaScript execution (getComputedStyle, DOM queries, asset enumeration).

## Guiding Principles

### 1. Completeness Beats Speed

Every builder agent must receive **everything** it needs to do its job perfectly: screenshot, exact CSS values, downloaded assets with local paths, real text content, component structure. If a builder has to guess anything — a color, a font size, a padding value — you have failed at extraction. Take the extra minute to extract one more property rather than shipping an incomplete brief.

### 2. Small Tasks, Perfect Results

When an agent gets "build the entire features section," it glosses over details — it approximates spacing, guesses font sizes, and produces something "close enough" but clearly wrong. When it gets a single focused component with exact CSS values, it nails it every time.

Look at each section and judge its complexity. A simple banner with a heading and a button? One agent. A complex section with 3 different card variants, each with unique hover states and internal layouts? One agent per card variant plus one for the section wrapper. When in doubt, make it smaller.

**Complexity budget rule:** If a builder prompt exceeds ~150 lines of spec content, the section is too complex for one agent. Break it into smaller pieces.

### 3. Real Content, Real Assets

Extract the actual text, images, videos, and SVGs from the live site. This is a clone, not a mockup. Use `element.textContent`, download every `<img>` and `<video>`, extract inline `<svg>` elements as React components. The only time you generate content is when something is clearly server-generated and unique per session.

**Layered assets matter.** A section that looks like one image is often multiple layers — a background watercolor/gradient, a foreground UI mockup PNG, an overlay icon. Inspect each container's full DOM tree and enumerate ALL `<img>` elements and background images within it.

### 4. Foundation First

Nothing can be built until the foundation exists: global CSS with the target site's design tokens (colors, fonts, spacing), TypeScript types for the content structures, and global assets (fonts, favicons). This is sequential and non-negotiable. Everything after this can be parallel.

### 5. Extract How It Looks AND How It Behaves

A website is not a screenshot — it's a living thing. Elements move, change, appear, and disappear in response to scrolling, hovering, clicking, resizing, and time. For every element, extract its **appearance** (exact computed CSS via `getComputedStyle()`) AND its **behavior** (what changes, what triggers the change, and how the transition happens).

Behaviors to watch for:
- Navbar that shrinks/changes on scroll
- Elements that animate into view on viewport entry (fade-up, slide-in, stagger)
- Scroll-snap sections
- Parallax layers
- Hover state animations (duration and easing matter)
- Dropdowns, modals, accordions with enter/exit animations
- Scroll-driven progress indicators
- Auto-playing carousels or cycling content
- Dark-to-light theme transitions between sections
- Tabbed/pill content that cycles
- Scroll-driven tab/accordion switching (IntersectionObserver)
- Smooth scroll libraries (Lenis, Locomotive Scroll — check for `.lenis` class)

### 6. Identify the Interaction Model Before Building

Before writing any builder prompt for an interactive section, definitively answer: **Is this section driven by clicks, scrolls, hovers, time, or some combination?**

How to determine this:
1. **Don't click first.** Scroll through the section slowly (use `browser_evaluate` with `window.scrollBy`) and observe if things change.
2. If they do, it's scroll-driven. Extract the mechanism.
3. If nothing changes on scroll, THEN click/hover to test.
4. Document the interaction model explicitly in the component spec.

### 7. Extract Every State, Not Just the Default

Many components have multiple visual states. You must extract ALL states.

For tabbed/stateful content:
- Click each tab/button via `browser_click`
- Extract the content, images, and card data for EACH state
- Note the transition animation between states

For scroll-dependent elements:
- Capture computed styles at scroll position 0
- Scroll past the trigger threshold via `browser_evaluate`
- Capture computed styles again
- Diff the two to identify which CSS properties change

### 8. Spec Files Are the Source of Truth

Every component gets a specification file in `docs/research/components/` BEFORE any builder is dispatched. The spec file is the contract between extraction and building. The builder receives the spec file contents inline in its prompt.

### 9. Build Must Always Compile

Every builder agent must verify `npx tsc --noEmit` passes before finishing. After merging worktrees, verify `npm run build` passes.

## Phase 1: Reconnaissance

Navigate to the target URL with `browser_navigate`.

### Screenshots

Use `browser_resize` to set viewport, then `browser_take_screenshot`:
- Desktop: `browser_resize` to 1440x900, then screenshot
- Mobile: `browser_resize` to 390x844, then screenshot
- Save references to `docs/design-references/`

### Global Extraction

Use `browser_evaluate` to run JavaScript for extraction:

**Fonts** — Inspect `<link>` tags, computed `font-family`. Configure in `src/app/layout.tsx` using `next/font`.

**Colors** — Extract color palette from computed styles. Update `src/app/globals.css` with tokens.

**Favicons & Meta** — Download favicons, OG images to `public/seo/`. Update `layout.tsx` metadata.

**Global UI patterns** — Custom scrollbar hiding, scroll-snap, global animations, smooth scroll libraries.

### Mandatory Interaction Sweep

**Scroll sweep:** Use `browser_evaluate` with `window.scrollBy(0, 300)` repeatedly, taking snapshots at each position:
- Does the header change? Record the scroll position.
- Do elements animate into view?
- Does a sidebar auto-switch as you scroll?
- Are there scroll-snap points?

**Click sweep:** Use `browser_snapshot` to get refs, then `browser_click` on interactive elements:
- Every button, tab, pill, link, card
- For tabs: click EACH ONE and extract content per state

**Hover sweep:** Use `browser_hover` on interactive elements:
- Buttons, cards, links, images, nav items
- Record what changes

**Responsive sweep:** Use `browser_resize` at 3 widths:
- Desktop: 1440px
- Tablet: 768px
- Mobile: 390px

Save findings to `docs/research/BEHAVIORS.md`.

### Page Topology

Map every distinct section top to bottom. Document:
- Visual order
- Fixed/sticky overlays vs flow content
- Page layout (scroll container, columns, z-index layers)
- Dependencies between sections
- Interaction model of each section

Save as `docs/research/PAGE_TOPOLOGY.md`.

## Phase 2: Foundation Build

Sequential — do this yourself:

1. Update fonts in `layout.tsx`
2. Update `globals.css` with color tokens, spacing, animations, scroll behaviors
3. Create TypeScript interfaces in `src/types/`
4. Extract SVG icons to `src/components/icons.tsx`
5. Download global assets — write a Node.js script (`scripts/download-assets.mjs`) and run it
6. Verify: `npm run build` passes

### Asset Discovery Script

Run via `browser_evaluate`:

```javascript
JSON.stringify({
  images: [...document.querySelectorAll('img')].map(img => ({
    src: img.src || img.currentSrc,
    alt: img.alt,
    width: img.naturalWidth,
    height: img.naturalHeight,
    parentClasses: img.parentElement?.className,
    siblings: img.parentElement ? [...img.parentElement.querySelectorAll('img')].length : 0,
    position: getComputedStyle(img).position,
    zIndex: getComputedStyle(img).zIndex
  })),
  videos: [...document.querySelectorAll('video')].map(v => ({
    src: v.src || v.querySelector('source')?.src,
    poster: v.poster,
    autoplay: v.autoplay,
    loop: v.loop,
    muted: v.muted
  })),
  backgroundImages: [...document.querySelectorAll('*')].filter(el => {
    const bg = getComputedStyle(el).backgroundImage;
    return bg && bg !== 'none';
  }).map(el => ({
    url: getComputedStyle(el).backgroundImage,
    element: el.tagName + '.' + el.className?.split(' ')[0]
  })),
  svgCount: document.querySelectorAll('svg').length,
  fonts: [...new Set([...document.querySelectorAll('*')].slice(0, 200).map(el => getComputedStyle(el).fontFamily))],
  favicons: [...document.querySelectorAll('link[rel*="icon"]')].map(l => ({ href: l.href, sizes: l.sizes?.toString() }))
});
```

## Phase 3: Component Specification & Dispatch

For each section in the page topology: **extract**, **write spec**, **dispatch builders**.

### Step 1: Extract

For each section, use Playwright MCP to extract:

1. **Screenshot** — scroll to section, `browser_take_screenshot`

2. **Extract CSS** via `browser_evaluate` with the per-component extraction script:

```javascript
(function(selector) {
  const el = document.querySelector(selector);
  if (!el) return JSON.stringify({ error: 'Element not found: ' + selector });
  const props = [
    'fontSize','fontWeight','fontFamily','lineHeight','letterSpacing','color',
    'textTransform','textDecoration','backgroundColor','background',
    'padding','paddingTop','paddingRight','paddingBottom','paddingLeft',
    'margin','marginTop','marginRight','marginBottom','marginLeft',
    'width','height','maxWidth','minWidth','maxHeight','minHeight',
    'display','flexDirection','justifyContent','alignItems','gap',
    'gridTemplateColumns','gridTemplateRows',
    'borderRadius','border','borderTop','borderBottom','borderLeft','borderRight',
    'boxShadow','overflow','overflowX','overflowY',
    'position','top','right','bottom','left','zIndex',
    'opacity','transform','transition','cursor',
    'objectFit','objectPosition','mixBlendMode','filter','backdropFilter',
    'whiteSpace','textOverflow','WebkitLineClamp'
  ];
  function extractStyles(element) {
    const cs = getComputedStyle(element);
    const styles = {};
    props.forEach(p => { const v = cs[p]; if (v && v !== 'none' && v !== 'normal' && v !== 'auto' && v !== '0px' && v !== 'rgba(0, 0, 0, 0)') styles[p] = v; });
    return styles;
  }
  function walk(element, depth) {
    if (depth > 4) return null;
    const children = [...element.children];
    return {
      tag: element.tagName.toLowerCase(),
      classes: element.className?.toString().split(' ').slice(0, 5).join(' '),
      text: element.childNodes.length === 1 && element.childNodes[0].nodeType === 3 ? element.textContent.trim().slice(0, 200) : null,
      styles: extractStyles(element),
      images: element.tagName === 'IMG' ? { src: element.src, alt: element.alt, naturalWidth: element.naturalWidth, naturalHeight: element.naturalHeight } : null,
      childCount: children.length,
      children: children.slice(0, 20).map(c => walk(c, depth + 1)).filter(Boolean)
    };
  }
  return JSON.stringify(walk(el, 0), null, 2);
})('SELECTOR');
```

3. **Multi-state extraction** — capture before/after styles for scroll/hover/click triggers

4. **Real content** — `element.textContent` for each text node, click each tab for per-state content

5. **Assets** — which downloaded images/videos from `public/`, which icons from `icons.tsx`

6. **Complexity assessment** — if >3 distinct sub-components, break into multiple agents

### Step 2: Write Component Spec File

Path: `docs/research/components/<component-name>.spec.md`

```markdown
# <ComponentName> Specification

## Overview
- **Target file:** `src/components/<ComponentName>.tsx`
- **Screenshot:** `docs/design-references/<screenshot-name>.png`
- **Interaction model:** <static | click-driven | scroll-driven | time-driven>

## DOM Structure
<Element hierarchy>

## Computed Styles (exact values from getComputedStyle)

### Container
- display: ...
- padding: ...

### <Child elements>
- fontSize: ...
- color: ...

## States & Behaviors

### <Behavior name>
- **Trigger:** <mechanism>
- **State A:** <properties>
- **State B:** <properties>
- **Transition:** <CSS transition value>

## Per-State Content (if applicable)
<Content for each tab/state>

## Assets
<Referenced images, icons, videos>

## Text Content (verbatim)
<All text from the live site>

## Responsive Behavior
- **Desktop (1440px):** ...
- **Tablet (768px):** ...
- **Mobile (390px):** ...
```

### Step 3: Dispatch Builders

Use the Agent tool with `isolation: "worktree"` for each builder:

**Simple section** (1-2 sub-components): One builder agent.
**Complex section** (3+ sub-components): One agent per sub-component + one for the wrapper.

Every builder receives:
- Full spec file contents inline
- Screenshot reference
- Shared imports (`icons.tsx`, `cn()`, shadcn primitives)
- Target file path
- Instruction to verify `npx tsc --noEmit`

**Don't wait.** Dispatch builders and continue extracting the next section.

### Step 4: Merge

As builders complete:
- Merge worktree branches
- Resolve conflicts (you have full context)
- Verify `npm run build` passes after each merge

## Phase 4: Page Assembly

After all sections built and merged, wire in `src/app/page.tsx`:
- Import all sections
- Implement page-level layout from topology doc
- Connect content to props
- Implement page-level behaviors (scroll snap, smooth scroll, etc.)
- Verify: `npm run build`

## Phase 5: Visual QA Diff

1. Open original and clone side-by-side (screenshots at same viewports)
2. Compare section by section at desktop (1440px) and mobile (390px)
3. For discrepancies: check spec → re-extract if needed → fix
4. Test all interactions: scroll, click tabs, hover
5. Verify animations, transitions, scroll behaviors

## Pre-Dispatch Checklist

Before dispatching ANY builder agent:
- [ ] Spec file written to `docs/research/components/<name>.spec.md`
- [ ] Every CSS value from `getComputedStyle()`, not estimated
- [ ] Interaction model identified (static / click / scroll / time)
- [ ] For stateful: every state's content and styles captured
- [ ] For scroll-driven: trigger threshold, before/after styles, transition recorded
- [ ] For hover: before/after values and transition timing recorded
- [ ] All images identified (including overlays and layers)
- [ ] Responsive behavior documented for desktop and mobile
- [ ] Text content verbatim from site
- [ ] Builder prompt under ~150 lines of spec

## What NOT to Do

- Don't build click-based tabs when original is scroll-driven (or vice versa)
- Don't extract only the default state
- Don't miss overlay/layered images
- Don't build mockup components for content that's actually videos
- Don't approximate CSS — extract exact computed values
- Don't build everything in one monolithic commit
- Don't reference docs from builder prompts — inline the spec
- Don't skip asset extraction
- Don't give a builder too much scope
- Don't bundle unrelated sections into one agent
- Don't skip responsive extraction
- Don't forget smooth scroll libraries
- Don't dispatch builders without a spec file

## Completion Report

When done:
- Total sections built
- Total components created
- Total spec files written
- Total assets downloaded
- Build status (`npm run build`)
- Visual QA results
- Known gaps

## Template Repo

The base Next.js scaffold and reference docs are at: `~/Projects/ai-website-cloner-template/`
Use it for new clone projects: `cp -r ~/Projects/ai-website-cloner-template/ <new-project-dir>`

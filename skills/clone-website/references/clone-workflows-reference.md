# Clone Website Workflow Reference

Detailed extraction, specification, dispatch, QA, and completion playbook
extracted from `../SKILL.md`. Load this file when actively cloning a site or
when a section needs exact extraction scripts and checklists.

## Playwright MCP Tool Reference

All browser operations use the Playwright MCP server.

| Operation | Tool | Notes |
|---|---|---|
| Navigate to URL | `browser_navigate` | `url` parameter |
| Take screenshot | `browser_take_screenshot` | Returns base64 image |
| Click element | `browser_click` | Use `element` description or `ref` from snapshot |
| Hover element | `browser_hover` | Same selectors as click |
| Run JavaScript | `browser_evaluate` | Use for computed styles, DOM queries, assets |
| Get DOM tree | `browser_snapshot` | Accessibility tree with `ref` numbers |
| Press key | `browser_press_key` | `key` parameter |
| Resize viewport | `browser_resize` | `width` and `height` |
| Wait for element | `browser_wait_for` | Wait for selectors/text |
| Fill form | `browser_fill_form` | Fill input fields |
| Scroll | `browser_evaluate` | `window.scrollTo` or `window.scrollBy` |

Use `browser_snapshot` first to get page structure and refs. Use
`browser_evaluate` for JavaScript execution, computed styles, DOM queries, and
asset enumeration.

## Guiding Principles

### Completeness Beats Speed

Every builder must receive screenshot references, exact CSS values, downloaded
asset paths, real text content, and component structure. If a builder has to
guess color, type, padding, behavior, or content, extraction is incomplete.

### Small Tasks, Perfect Results

Simple sections can be one builder. Complex sections with multiple card
variants, interactions, or layouts need one builder per subcomponent plus a
wrapper. If a builder prompt exceeds roughly 150 lines of spec content, split
the section.

### Real Content, Real Assets

Extract actual text, images, videos, SVGs, and background images. Layered
sections may contain background art, foreground UI images, overlays, and icons;
inspect the full DOM and enumerate all assets.

### Foundation First

Global CSS, design tokens, fonts, TypeScript types, icons, and global assets are
sequential. Everything else depends on them.

### Extract Looks and Behavior

For every element, capture appearance and behavior:

- navbar changes on scroll
- viewport-entry animations
- scroll-snap sections
- parallax layers
- hover animations
- dropdowns, modals, accordions
- progress indicators
- carousels
- theme transitions
- tabs and pills
- scroll-driven tab/accordion switching
- smooth-scroll libraries

### Identify the Interaction Model

Before writing an interactive section spec, determine whether it is driven by
clicks, scrolls, hovers, time, or a combination:

1. Scroll first and observe changes.
2. If scroll changes state, extract the mechanism.
3. If scroll does not change state, test click and hover.
4. Document the interaction model in the spec.

### Extract Every State

For tabs and stateful content, click each control and extract content and styles
for every state. For scroll-dependent elements, capture before/after styles at
the trigger threshold. For hover, capture before/after values and transition
timing.

### Spec Files Are the Source of Truth

Every component gets a file in `docs/research/components/` before building.
The builder receives the spec file contents inline.

## Phase 1: Reconnaissance

Navigate to the target URL with `browser_navigate`.

### Screenshots

Use `browser_resize`, then `browser_take_screenshot`:

- Desktop: 1440x900
- Mobile: 390x844

Save references to `docs/design-references/`.

### Global Extraction

- Fonts: inspect `<link>` tags and computed `font-family`; configure in
  `src/app/layout.tsx`.
- Colors: extract palette from computed styles; update `src/app/globals.css`.
- Favicons and metadata: download favicons and OG images to `public/seo/`;
  update metadata.
- Global UI patterns: custom scrollbars, scroll-snap, animations, and smooth
  scroll libraries.

### Mandatory Interaction Sweep

Scroll sweep:

- Scroll by 300px increments.
- Record whether the header changes.
- Record viewport-entry animations.
- Record sidebar auto-switching or scroll-snap points.

Click sweep:

- Use `browser_snapshot`, then click every button, tab, pill, link, and card.
- For tabs, click each one and extract content per state.

Hover sweep:

- Hover buttons, cards, links, images, and nav items.
- Record what changes.

Responsive sweep:

- Desktop: 1440px
- Tablet: 768px
- Mobile: 390px

Save findings to `docs/research/BEHAVIORS.md`.

### Page Topology

Map every distinct section top to bottom. Document:

- visual order
- fixed/sticky overlays vs flow content
- page layout, scroll container, columns, and z-index layers
- dependencies between sections
- interaction model of each section

Save as `docs/research/PAGE_TOPOLOGY.md`.

## Phase 2: Foundation Build

Sequential steps:

1. Update fonts in `layout.tsx`.
2. Update `globals.css` with color tokens, spacing, animations, and scroll
   behaviors.
3. Create TypeScript interfaces in `src/types/`.
4. Extract SVG icons to `src/components/icons.tsx`.
5. Download global assets with `scripts/download-assets.mjs`.
6. Verify `npm run build`.

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

## Phase 3: Component Specification and Dispatch

For each section in page topology: extract, write spec, dispatch builders.

### Step 1: Extract

For each section, use Playwright MCP to extract:

1. Screenshot.
2. CSS via computed-style extraction.
3. Multi-state before/after styles for scroll, hover, and click triggers.
4. Real text content and per-state content.
5. Asset references.
6. Complexity assessment.

### Per-Component Extraction Script

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
    props.forEach(p => {
      const v = cs[p];
      if (v && v !== 'none' && v !== 'normal' && v !== 'auto' && v !== '0px' && v !== 'rgba(0, 0, 0, 0)') styles[p] = v;
    });
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

### Step 2: Component Spec Template

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

Use isolated builder agents or worktrees for each builder.

Simple section: one builder.
Complex section: one agent per subcomponent plus one for the wrapper.

Every builder receives:

- full spec file contents inline
- screenshot reference
- shared imports
- target file path
- instruction to verify `npx tsc --noEmit`

Continue extraction while independent builders run.

### Step 4: Merge

As builders complete:

- merge worktree branches
- resolve conflicts
- verify `npm run build` after each merge

## Phase 4: Page Assembly

After all sections are built and merged:

- import sections in `src/app/page.tsx`
- implement page-level layout from topology
- connect content to props
- implement page-level behaviors
- verify `npm run build`

## Phase 5: Visual QA Diff

1. Open original and clone side by side at matching viewports.
2. Compare section by section at 1440px desktop and 390px mobile.
3. For discrepancies, check spec, re-extract if needed, then fix.
4. Test scroll, click tabs, hover, animations, transitions, and responsive
   behavior.

## Pre-Dispatch Checklist

- [ ] Spec file written to `docs/research/components/<name>.spec.md`
- [ ] Every CSS value comes from `getComputedStyle()`
- [ ] Interaction model identified
- [ ] Every stateful variant captured
- [ ] Scroll thresholds and before/after styles recorded
- [ ] Hover values and transition timing recorded
- [ ] All images identified, including overlays and layers
- [ ] Responsive behavior documented
- [ ] Text content is verbatim from site
- [ ] Builder prompt stays under the complexity budget

## What Not To Do

- Do not build click tabs when original is scroll-driven, or vice versa.
- Do not extract only the default state.
- Do not miss overlay/layered images.
- Do not build mockup components for content that is actually video.
- Do not approximate CSS.
- Do not build everything in one monolithic commit.
- Do not reference docs from builder prompts; inline the spec.
- Do not skip asset extraction.
- Do not give a builder too much scope.
- Do not bundle unrelated sections into one agent.
- Do not skip responsive extraction.
- Do not forget smooth-scroll libraries.
- Do not dispatch builders without a spec file.

## Completion Report

When done, report:

- total sections built
- total components created
- total spec files written
- total assets downloaded
- build status
- visual QA results
- known gaps

## Template Project Guidance

Use the repository's approved template project or `<template-repo>` for new clone
projects. Avoid committing local absolute paths; document template assumptions
with placeholders.

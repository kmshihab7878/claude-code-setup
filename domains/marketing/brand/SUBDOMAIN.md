# Marketing — Brand

Voice, visual identity, positioning.

## Skills

- `hue` — Brand URL/name/screenshot → generated brand-specific design-language skill (META-SKILL, lives in engineering/design but heavily used here)
- `market-brand` — Brand voice analysis (CONSOLIDATION candidate — overlaps with `brand-guidelines`)
- `brand-guidelines` — Brand voice + visual guideline generation
- `marketing-strategy-pmm` — Positioning + GTM + competitive intelligence

## Agents

- **L1:** `business-panel-experts` → invokes `cmo-advisor` for strategic positioning
- **L3:** `content-strategist`

## Commands

`/market brand` (via `market` orchestrator)

## Hand-offs

- New brand creation → route to `hue` (produces a child skill under `skills/<brand>/`)
- Brand audit of existing assets → `market-brand` or `brand-guidelines` (merge candidate)
- Strategic positioning refresh → `marketing-strategy-pmm` + `cmo-advisor`

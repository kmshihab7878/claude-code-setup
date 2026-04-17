# Marketing — Growth

Acquisition, conversion, retention loops. The most-developed Wave 1 department.

## Skills

- `market-audit` — Full audit orchestrator (launches 5 subagents)
- `market-funnel` — Funnel mapping + drop-off analysis
- `market-landing` — Landing CRO, section-by-section
- `market-competitors` — Competitive intel
- `market-scanner` — Automated market/competitive monitoring
- `market-launch` — Launch playbook
- `market-report`, `market-report-pdf` — Report compilation
- `marketing-demand-acquisition` — Paid campaigns, SEO, budget allocation (CONSOLIDATION candidate — overlaps with `/market` suite)
- `competitive-intel` — Competitor tracking (CONSOLIDATION candidate — overlaps with `market-competitors`)
- `ab-test-setup`, `experiment-designer` — Growth experimentation

## Agents

- **L2:** `growth-marketer`
- **L3:** `content-strategist`, `analytics-reporter`, `experiment-tracker`
- **L6 (`/market audit` engine):** `market-content`, `market-conversion`, `market-competitive`, `market-technical`, `market-strategy`
- **Wave 1 (EXPERIMENTAL):** 17 stage agents under `agents/growth/{intel,gen,loop}/*.md`

## Commands

`/market` (orchestrator)

## Notes

- `growth/loop/*` agents (roas-optimizer, cpa-analyst, attribution-analyst, fatigue-detector, winner-amplifier) compute ROAS/CAC/LTV — the only Wave 1 department with genuinely differentiated logic beyond stubs. Canonical source for attribution definitions.
- `cmo-advisor` (C-suite) is the strategic layer above this subdomain.

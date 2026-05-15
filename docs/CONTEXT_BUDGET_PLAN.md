# Context Budget — Extraction Campaign Plan and Progress

Lazy-loaded record of the reference-extraction campaign that compacts
always-loaded and routing-priority files. Policy lives in
[`docs/CONTEXT_BUDGET.md`](./CONTEXT_BUDGET.md); this file tracks the
work itself.

## Goal

- Keep `CLAUDE.md` (always-loaded kernel) small and stable.
- Push SKILL.md operating contracts toward ~1,500–2,000 estimated tokens.
- Push agent operating contracts toward ~1,800–2,400 estimated tokens.
- Move bulky depth (examples, templates, deep workflows, tables of detail)
  into lazy references under `references/` or per-skill `references/`.

## Completion criteria

The campaign is complete when:

1. No SKILL.md exceeds ~2,800 estimated tokens (ideal: ≤ 2,000).
2. The top context risks are dominated by lazy references (`P4`) or
   intentional routing indexes (`P3`), not SKILL.md / agent operating files.
3. `bash scripts/validate.sh` ends `pass=28 warn=0 fail=0`.
4. `bash scripts/check-public-safety.sh` passes.
5. `bash scripts/audit-public-readiness.sh --quick` passes.
6. `gitleaks` and `trivy` are clean.
7. No private identifiers or generated memory artifacts introduced.
8. No runtime behavior changes.

## Completed work — merged PRs

A representative list. See `git log --oneline --grep="extract"` for the full sequence.

- Market skills: `market-report`, `market-report-pdf`, `cold-email`, `service-spec`, `operating-framework`, `market-social`, `pricing-strategy`, `rag-pattern`, `pmm-strategy`, `market-audit`, `market-brand`, `market-copy`.
- Code/quality skills: `xlsx`, `wshobson-chart-structure`, `finance-ml`, `multi-agent-patterns`, `coremind-core`, `hue`, `skill-architect`, `skill-creator`, `prompt-reliability-engine`, `interface-design`, `ui-ux-pro-max`, `cto-advisor`, `ux-researcher-designer`, `moyu`.
- n8n trio: `n8n-code-python`, `n8n-workflow-patterns`, `n8n-code-javascript`.
- Decision skills: `council`.
- Agents: `pm-agent`.

## Result snapshot at last campaign checkpoint

- ~20 SKILL.md extractions merged.
- Top SKILL.md tokens dropped from 3,861 (skill-creator pre-campaign) to
  ≤ 2,765 (`react-bits`).
- No SKILL.md remains above ~2,800 estimated tokens.
- pm-agent.md dropped from 3,459 → 2,302 estimated tokens (no longer in
  the priority P1–P3 risk list).
- CLAUDE.md target: ≤ 2,000 estimated tokens (current pass).

## Remaining work (optional polish)

- Compaction of `agents/REGISTRY.md` (`ROUTING_INDEX_RISK`, ~8,400 tok)
  — large but lazy; lower per-turn leverage than CLAUDE.md.
- BMAD / SC command body compaction — all `LAZY_REFERENCE_HEAVY`; low
  leverage.
- Remaining mid-range SKILL.md files (2,500–2,765) — diminishing returns.

The remaining work is structural and optional. The campaign hit its
inflection point when no SKILL.md was the top context risk.

## Running rules

- Every extraction PR carries a `perf(context): extract … references` title.
- Each extraction must pass the full validation suite before merge.
- References go to `<skill-folder>/references/` for skills, and to
  `references/<agent>/` (NOT `agents/<agent>-references/`) for agents — the
  inventory script counts any `.md` under `agents/` as an agent definition.
- Preserve upstream vendored content (e.g., `skills/n8n/czlonkowski/*`).

## Validator constraints that shape CLAUDE.md

`scripts/validate.sh` requires the following strings to exist verbatim in
`CLAUDE.md`:

- `**<N> skills**` (current `N`: 209).
- `**<N> agents**` (current `N`: 243).
- `<N> path rules` (current `N`: 6).

`scripts/inventory.sh` parses CLAUDE.md MCP table by counting rows that
start with `| ✓ |`, `| ⚠️ |`, or `| ○ |`. The table must remain in
CLAUDE.md in this exact format.

Any future kernel compaction must preserve these strings and the MCP
table structure.

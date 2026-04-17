# Extractable Products

> Zones of this repo that are self-contained enough to become standalone products, services, or demos. Keep visible so pruning decisions don't accidentally bury them.

_Evidence source: [`docs/AUDIT.md`](./AUDIT.md) §4.4. Status reflects 2026-04-17._

## 10 extraction candidates

| Candidate | Scope | Files | Extraction effort |
|-----------|-------|-------|-------------------|
| **Elite Ops layer** | Owner-engineer execution posture — `/ship`, `/audit-deep`, `/fix-root`, `/polish-ux`, `/council-review` modes with strict completion criteria | `skills/elite-ops/SKILL.md` + `docs/ELITE-OPS-METHODOLOGY.md` + `docs/ELITE-OPS-README.md` + 5 mode commands + `rules/implementation.md` | Low — already packaged as a drop-in layer with install steps |
| **Self-evolution layer** | Observe → record → evaluate → promote feedback loop with promotion gates and kill switch | `evolution/` (17 files: scripts, schemas, stable contract, tests) + 5 skills (`session-bootstrap`, `evidence-recorder`, `session-analyst`, `promotion-gate`, `pruning-view`) + 3 agents (`evolution-orchestrator`, `learning-curator`, `evaluation-judge`) + `commands/evolution.md` + 2 hooks (`evolution-startup.sh`, `evolution-sessionend.sh`) + `skills/skill-evolution` | Medium — wire it into another harness requires mapping SessionStart/SessionEnd hook points |
| **/market suite** | Marketing automation — audit / copy / emails / social / ads / funnel / landing / launch / proposal / report / brand / competitors / scanner / SEO | `skills/market/` orchestrator + 15 `skills/market-*/` + 5 `agents/market-*.md` (L6 workers) + `skills/market/templates/` + `skills/market/scripts/` | Low — cohesive self-contained suite |
| **Hue meta-skill** | Brand URL/name/screenshot → generated brand-specific design-language child skill under `skills/<brand>/` | `skills/hue/SKILL.md` (807 lines — biggest in the repo, earned) + 19 brand demo HTMLs in `skills/hue/examples/*/` + references | Low — skill plus demo gallery is one directory |
| **JARVIS-sec** | Autonomous security ecosystem — 14 agents / 48 tools / 9 attack chains for macOS native pentesting | `skills/jarvis-sec/SKILL.md` + `commands/jarvis-sec.md` + related security family | Low |
| **JARVIS-Core governance** | 10-stage governed pipeline + 5-layer safety gate + 4-tier escalation + agent authority model | `skills/jarvis-core/SKILL.md` + `skills/governance-gate/SKILL.md` + `agents/REGISTRY.md` + `core/governance.md` + `hooks/mcp-security-gate.sh` | Medium — portability requires adapting the REGISTRY dispatch model to the target harness |
| **React-bits catalog** | 130-component shadcn-CLI install catalog of animated / interactive / shader components | `skills/react-bits/SKILL.md` | Low — already upstream at DavidHDev |
| **MCP-mastery** | 30-server MCP catalog + task-to-MCP router + gaps analysis | `skills/mcp-mastery/SKILL.md` + `skills/mcp-mastery/GAPS.md` | Low — standalone reference |
| **Anti-AI-slop filter** | Universal banned-word + tone filter applied to ALL written output | `skills/anti-ai-writing/SKILL.md` (63 inbound — the most-referenced skill in the repo) | Low — single file |
| **n8n skill-set (czlonkowski)** | n8n workflow building with validated evaluation fixtures | `skills/n8n/` (94 files with LICENSE + 22 evaluation JSONs) | Low — upstream-aligned with czlonkowski |

## Bonus — demo-ready assets

Not products in themselves, but concrete proofs that make extraction candidates compelling:

- **19 Hue brand demos** under `skills/hue/examples/*/` — component libraries, landing pages, app screens. Highest-leverage single-file-count demo set in the repo.
- **22 czlonkowski n8n evaluations** under `skills/n8n/czlonkowski/evaluations/*.json` — proof the n8n skill works against real workflows.
- **Global-temperature TimesFM forecast** under `skills/timesfm-forecasting/examples/` — forecast animation + covariates demo proving forecasting generality.
- **Skill-creator eval-viewer** (`skills/skill-creator/eval-viewer/viewer.html`) — UI for reviewing skill evaluation runs.
- **`docs/COUNCIL-REMEDIATION.md` + `docs/AUDIT.md` + `docs/OVERHEAD.md` + `docs/SURFACE-MAP.md`** — the "honest audit" cluster. Rare in Claude Code public repos; sellable as a transparency / rigor narrative on its own.

## Preservation rules

1. **Do not archive an extraction candidate without an explicit user decision.** Each carries positioning or extraction value that static cross-ref scans (orphan counts) don't capture.
2. **Frontmatter should reflect status.** When skill frontmatter is added or revised, mark extraction-ready skills with `extractable: true` (Phase 3 deferred; land when consolidating frontmatter hygiene).
3. **Pruning decisions wait for telemetry.** See [`docs/TELEMETRY.md`](./TELEMETRY.md) — zero-invocation over 14+ days is necessary but not sufficient for archiving an extraction candidate.

## Extraction playbook (sketch)

When extracting a candidate:

1. Copy the candidate's file tree into a new repo (`git subtree split` or `git filter-repo`).
2. Include `LICENSE`, `README.md`, and the relevant `docs/*.md` pointers.
3. Genericize owner-specific references (`CLAUDE.md`, `memory/project-context.md`, user name).
4. Drop a setup script that re-creates the minimum required structure in the target's `~/.claude/`.
5. Validate against a fresh Claude Code session.

Nothing in this repo prevents extraction; the self-contained-ness of these clusters is by design.

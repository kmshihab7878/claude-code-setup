# AIS-OS Integration — Mapping to This Repo

> AIS-OS by Nate Herk (https://github.com/nateherkai/AIS-OS) is the personal/business operating layer adapted into this repo. This document maps every AIS-OS concept to its location here so users coming from AIS-OS can navigate quickly, and contributors here understand the provenance.

Reference repo (not yet cloned): `references/external/ais-os/README.md` documents how to clone if desired.

---

## Concept → location map

| AIS-OS | Here | Notes |
|--------|------|-------|
| **Three Ms (Mindset / Method / Machine)** | `references/3ms-framework.md` | Verbatim adaptation with cross-refs to this repo's surfaces |
| **Four Cs (Context / Connections / Capabilities / Cadence)** | `references/four-cs-framework.md` | The structural model; `/audit` scores against it |
| **`/onboard`** | `commands/onboard.md` + `skills/onboard/SKILL.md` | Hard PII guard added (never auto-fill identity from session env) |
| **`/audit`** | `commands/audit.md` + `skills/audit/SKILL.md` | Outputs to `docs/audits/YYYY-MM-DD.md` |
| **`/level-up`** | `commands/level-up.md` + `skills/level-up/SKILL.md` | Recommends ONE artifact; doesn't build |
| **Weekly improvement loop** | `skills/weekly-operating-review/SKILL.md` + `docs/CADENCE.md` | Combines `/audit` + `/level-up` + `_hot.md` refresh |
| **`context/` folder** | `context/` | Same idea, same files |
| **`connections.md`** | `connections.md` (root) + `docs/CONNECTIONS_ROADMAP.md` (the framework) | Schema slightly extended with sensitivity tier and kill switch |
| **`aios-intake.md`** | `aios-intake.md` (root) | The 7 questions + privacy warning |
| **`decisions/log.md`** | `decisions/log.md` (root) | Append-only operating log; complements `kb/decisions/` (formal ADRs) |
| **`archives/`** | `archives/` (root) | Cold storage for retired material |
| **Wiki layer** (`raw/`, `wiki/`, `_index`, `_log`, `_hot`) | `kb/raw/`, `kb/wiki/INDEX.md`, `kb/wiki/log.md`, `kb/wiki/_hot.md` | Repo had its own `kb/` layout; aliases documented in `docs/WIKI_LAYER.md` |
| **Skill-building framework** | `references/skill-building-framework.md` | Aligned to existing `skills/skill-architect/` and `skills/skill-evolution/` |
| **Tool/domain mapping** | `docs/CONNECTIONS_ROADMAP.md` | Seven-domain build order |
| **Cadence planning** | `docs/CADENCE.md` | Daily / weekly / quarterly loops |

---

## Subagent mapping

AIS-OS suggests certain operator subagents. This repo already has 240 agents in `agents/REGISTRY.md`. To avoid registry bloat, the AIS-OS subagent names are mapped to existing agents where possible; only genuinely-new subagents are added.

| AIS-OS subagent | Existing agent here | New file? |
|-----------------|---------------------|-----------|
| Architect | `agents/architect.md` (L1) and `agents/system-architect.md` (L2) | No — already exists |
| Security reviewer | `agents/security-engineer.md` (L2) and `agents/security-auditor.md` | No — covered by existing pair |
| Test engineer | `agents/tester.md` (L6), `agents/quality-engineer.md` (L2), `agents/test-results-analyzer.md` (L6) | No — covered |
| Refactor engineer | `agents/refactorer.md` (L6) and `agents/refactoring-expert.md` | No — covered |
| Docs operator | `agents/documenter.md` (L6) and `agents/technical-writer.md` (L6) | No — covered |
| **DevEx operator** | _none_ | **Yes — `agents/devex-operator.md`** |
| **Wiki curator** | _none_ (closest is `documenter`) | **Yes — `agents/wiki-curator.md`** |
| **Automation designer** | _none_ (closest is `skill-architect` skill, not agent) | **Yes — `agents/automation-designer.md`** |

---

## What was NOT adopted from AIS-OS

- **Direct file-tree replication.** AIS-OS uses top-level `raw/`, `wiki/`, `decisions/log.md`. This repo had `kb/raw/`, `kb/wiki/`, `kb/decisions/` already. We did not duplicate. See `docs/WIKI_LAYER.md` for the alias mapping.
- **AIS-OS as a competing constitution.** This repo's `CLAUDE.md` remains canonical. AIS-OS is a framework reference, not a governance system.
- **Auto-clone of AIS-OS source repo.** Documented in `references/external/ais-os/README.md` but requires explicit user approval to run.
- **Verbatim onboarding answers from session env.** AIS-OS examples sometimes show pre-filled identity; this repo's `/onboard` has a hard guard against that.

---

## What this repo adds beyond AIS-OS

- **JARVIS-mirrored architecture.** 240 agents across 7 authority tiers (L0-L6), `agents/REGISTRY.md`.
- **Six-stage execution pipeline** with risk tiers (T0-T3).
- **MCP security gate hook** (`hooks/mcp-security-gate.sh`) — first-use detection, suspicious-input flagging, optional whitelist enforcement.
- **Self-evolution layer** (`evolution/`, gated by `bin/evolve-promote.sh`).
- **Three-mode planner** (`/plan`, `/ultraplan`, `/planUI`) with stage-by-stage governance.
- **Inventory and validation** (`make inventory`, `make validate`) — drift-resistant counts.
- **Telemetry plan** (`docs/TELEMETRY.md`) — replace pre-telemetry "top 20" with usage-derived rankings after 14+ days.

---

## Attribution

The Three Ms, Four Cs, weekly audit/level-up loop, seven-domain connections roadmap, `/onboard` interview pattern, and the personal-OS framing are adapted from AIS-OS by Nate Herk. Specific files note this in their headers. The integration choices (which to copy, which to alias, which to skip) and all repo-specific code are mine — see commit history for provenance.

If AIS-OS upstream evolves materially, the integration plan is:
1. Re-read upstream README and skim diffs against the version frozen here
2. Update this mapping doc with what changed
3. Adapt — don't replace — using the patterns shown above
4. Log the upstream sync in `decisions/log.md`

# ARCHITECTURE — design rationale for the restructure

_Companion to `docs/AUDIT.md` (what we found) and the master restructuring prompt (what we're targeting)._

This doc explains **why** the repo is shaped the way it is after Phase 1, especially where the implementation deliberately deviates from the master prompt's target directory layout.

---

## 1. Virtual indexes vs physical moves (the central decision)

The master prompt's target layout implied that skills, agents, and commands would be physically relocated under `domains/{engineering, finance, marketing}/{subdomain}/`. Phase 1 does NOT do this. Here's why.

### The constraint

Claude Code's harness discovers surfaces by convention at specific paths:

- Skills at `~/.claude/skills/**/SKILL.md`
- Agents at `~/.claude/agents/**/*.md` (flat + subdirectory)
- Commands at `~/.claude/commands/*.md` and `commands/<namespace>/*.md`

Moving `skills/hue/` to `domains/engineering/design/hue/` would either (a) remove `hue` from Claude Code's discovery index or (b) force a symlink farm that mirrors the old structure — a maintenance liability.

### The insight

What the master prompt actually wants is **progressive disclosure**: don't load 202 skill bodies on session start; load a small index and fetch bodies on demand. Claude Code already does this — `SKILL.md` bodies are only loaded when the model picks the skill. The index cost (per `docs/OVERHEAD.md`) is ~7k tokens of description-list at cold start, not 46k lines of skill bodies.

So the benefit the prompt seeks is already present for skills. The remaining wins are:

- **Domain routing** — given a task, which skills/agents/commands are *candidates*?
- **Lazy-loaded narrative** — let a reader skim one domain without loading siblings.
- **Composability** — see which skills pair with which agents without grepping.

### The resolution

Every surface stays at its canonical path. `domains/{domain}/DOMAIN.md` is a **pointer map** into the existing tree:

```
~/Projects/claude-code-setup/
├── skills/              # 202 SKILL.md — unchanged, harness-visible
├── agents/              # 240 agent .md files — unchanged
├── commands/            # 84 command .md files — unchanged
├── hooks/               # unchanged
├── recipes/             # unchanged
├── rules/               # unchanged
├── scripts/             # unchanged
├── kb/                  # unchanged (scaffold per KB-STATUS.md)
├── evolution/           # unchanged (self-evolution layer)
│
├── core/                # NEW — identity / governance / context-budget / memory reference
├── domains/             # NEW — virtual index layer (pointers, no content)
│   ├── engineering/
│   │   ├── DOMAIN.md
│   │   ├── full-stack/SUBDOMAIN.md
│   │   ├── devops/SUBDOMAIN.md
│   │   ├── security/SUBDOMAIN.md
│   │   ├── quality/SUBDOMAIN.md
│   │   ├── ai-ml/SUBDOMAIN.md
│   │   └── design/SUBDOMAIN.md
│   ├── finance/
│   │   ├── DOMAIN.md
│   │   ├── trading/SUBDOMAIN.md
│   │   ├── analysis/SUBDOMAIN.md
│   │   └── portfolio/SUBDOMAIN.md
│   └── marketing/
│       ├── DOMAIN.md
│       ├── growth/SUBDOMAIN.md
│       ├── content/SUBDOMAIN.md
│       ├── brand/SUBDOMAIN.md
│       └── ads/SUBDOMAIN.md
├── memory/              # NEW — file-based memory system (MEMORY.md index + typed memories)
└── docs/                # unchanged, plus this file + AUDIT.md
```

**Trade-off accepted:** the DOMAIN.md files can drift from reality if skills are added/removed without updating them. Mitigation: `scripts/validate.sh` gains a DOMAIN.md coherence check in Phase 5.

**Trade-off rejected:** moving skills/agents/commands and rewriting Claude Code's discovery — out of scope and changes the harness contract.

---

## 2. Context-loading strategy

See `core/context-budget.md` for the full tier model. Summary:

- **T0 (always loaded):** `CLAUDE.md` (~335 lines), `MEMORY.md` (capped at 200 lines), skill *descriptions* only (~7k tokens), agent names only, settings.json hook triggers.
- **T1 (on skill invocation):** full `SKILL.md` body.
- **T2 (on agent dispatch):** agent body.
- **T3 (on explicit Read):** bundled references, examples.
- **T4 (on command dispatch):** command body.

This tier model preserves the "earn your context" principle without deleting valuable reference material. A 4,500-line Hue brand demo never enters context unless actually read.

---

## 3. Routing model

### Pipeline authority

One source of truth per concern:

| Concern | Single source of truth |
|---------|------------------------|
| 10-stage pipeline definition | `skills/jarvis-core/SKILL.md` |
| 15-stage sovereign pipeline | `commands/ultraplan.md` (extends jarvis-core) |
| Governance rules | `core/governance.md` (CLAUDE.md summary is a mirror) |
| Risk tiers | `core/governance.md` + `skills/governance-gate/SKILL.md` |
| Canonical commands per intent | `docs/SURFACE-MAP.md` |
| Domain routing | `domains/{domain}/DOMAIN.md` |
| Agent hierarchy + MCP bindings | `agents/REGISTRY.md` |
| Surface counts (disk truth) | `docs/INVENTORY.md` (generated) |
| Token-cost framing | `docs/OVERHEAD.md` |

Duplications removed in Phase 1: none yet — docs stay; pointers added. Phase 3 will collapse `docs/CLAUDE_CODE_ARCHITECTURE.md` + `docs/CAPABILITIES_REPORT.md` + `docs/OPERATING_FRAMEWORK.md` into pointers per AUDIT §5.2.

### Agent dispatch

Unchanged from pre-Phase-1. `agents/REGISTRY.md` remains the central dispatch table. Authority hierarchy L0–L6 + self-evolution trio + Wave 1 + Wave 2 intact. The MCP tier note (added in `d763901`) makes aspirational bindings explicit.

### Command dispatch

Per `docs/SURFACE-MAP.md`, each intent has one canonical command. Non-canonical alternatives are tagged "pending telemetry review" and kept until data justifies pruning.

---

## 4. Self-improvement loop

The self-evolution layer (`evolution/`) is the repo's feedback mechanism:

1. `hooks/usage-logger.sh` writes every tool call to `~/.claude/usage.jsonl`.
2. `hooks/evolution-sessionend.sh` records session-end summaries to `evolution/records/sessions.jsonl`.
3. `evolution/bin/evolve-collect.sh` clusters evidence into candidate YAML files.
4. `evolution/bin/evolve-promote.sh` enforces promotion gates (≥3 evidence entries, ≥2 distinct sessions, ≥2 distinct projects, size budget, contradiction check) before promoting to `evolution/stable/`.
5. `hooks/evolution-startup.sh` injects `evolution/stable/global.md` at SessionStart within a 4000-char budget (validated by `scripts/validate.sh`).
6. Kill switch: `/evolution disable` or `CLAUDE_EVOLUTION_BASELINE=1`.

Phase 6 will add `/improve` as the user-facing entry to this loop, plus ADR and retrospective scaffolds under `kb/decisions/` and `kb/retrospectives/`.

**Status:** infrastructure wired; evidence sparse (2 session records). Per AUDIT, the loop is promising but unvalidated.

---

## 5. How to add things

### Add a new skill

1. Follow `skills/_shared/skill-template.md` and `skills/_shared/naming-conventions.md`.
2. Run `skills/_shared/review-checklist.md` before committing.
3. If the skill has a declared canonical intent in `docs/SURFACE-MAP.md`, add the skill to the relevant table there.
4. If the skill belongs to a specific domain, add a row to the right `domains/{domain}/{subdomain}/SUBDOMAIN.md`.
5. Run `make inventory && make validate`.

### Add a new agent

1. Follow frontmatter contract in `agents/REGISTRY.md`.
2. Add a row to the right authority-level table in `agents/REGISTRY.md`.
3. If the agent is Wave 1 or Wave 2, label it EXPERIMENTAL in any DOMAIN.md mention.
4. Run `make validate`.

### Add a new command

1. Create `commands/<name>.md` with YAML frontmatter including `description:` and `argument-hint:`.
2. If overlap with an existing command, update `docs/SURFACE-MAP.md`.
3. If the command routes to specific agents/skills, document them in the command body.
4. Run `make validate`.

### Add a new MCP

1. Add to `CLAUDE.md` MCP tiers table — Connected / Auth-pending / Aspirational.
2. If aspirational, skills/agents that need it are EXPERIMENTAL until it lands.
3. Update `hooks/mcp-security-gate.sh` whitelist if the MCP should be allowed.
4. Run `claude mcp list` to verify; update `docs/INVENTORY.md` via `make inventory`.

### Add a new recipe

1. Follow the YAML schema in `recipes/README.md`.
2. Reference primitives from `recipes/sub/` where possible.
3. Declare `requires.skills` and `requires.mcp_servers` explicitly.
4. Add to the relevant DOMAIN.md / SUBDOMAIN.md recipes section.

### Add a new hook

1. Place script in `hooks/`. Keep it fast (≤100ms typical).
2. Reference from `settings.json` with the correct event selector.
3. Update the hook table in `core/memory.md` if the hook writes memory/history.
4. Run `make validate` — it checks that all `hooks/*.sh` references in `settings.json` resolve.

---

## 6. Public-facing vs internal surfaces

| Surface | Audience | Purpose |
|---------|----------|---------|
| `README.md` | Public (GitHub visitors) | Positioning — leads with value, not counts |
| `CLAUDE.md` | Operator + model | Always-loaded operating contract |
| `docs/AUDIT.md` | Maintainer + curious reader | Proof of honest self-assessment |
| `docs/ARCHITECTURE.md` (this file) | Contributor + future-me | Why the structure is what it is |
| `docs/SURFACE-MAP.md` | Operator + model | Disambiguate overlapping commands/skills |
| `docs/INVENTORY.md` | Tooling | Generated source of truth for counts |
| `docs/OVERHEAD.md` | Public (shows rigor) | Measured vs estimated vs unknown context cost |
| `docs/KB-STATUS.md` | Public (labels scaffold honestly) | KB maturity statement |
| `docs/COUNCIL-REMEDIATION.md` | Public (trust-building) | Criticism → deterministic fix map |
| `core/*.md` | Model (lazy-loaded) | Expansion behind CLAUDE.md |
| `domains/*/DOMAIN.md` | Model (lazy-loaded) | Domain routing |
| `memory/*.md` | Model (some always-loaded, some on demand) | File-based memory |
| `evolution/README.md` | Public + operator | Self-evolution architecture |

---

## 7. Deviations from the master prompt

The master prompt described a target layout. Actual Phase 1 deviates as follows, with reasons:

| Target (prompt) | Actual | Reason |
|-----------------|--------|--------|
| `domains/{domain}/full-stack/` with skills inside | `domains/{domain}/{subdomain}/SUBDOMAIN.md` pointing at `skills/*/SKILL.md` | Harness discovery would break if skills moved |
| `core/identity.md`, `core/governance.md`, `core/context-budget.md`, `core/memory.md` | Same (delivered) | No deviation |
| `memory/MEMORY.md`, `project-context.md`, `skill-performance.md`, `session-history.md` | Same (delivered) | No deviation |
| `CLAUDE.md` rewrite | Deferred to Phase 2 (pending user review before replacing always-loaded config) | Risk management |
| `commands/improve.md` | Deferred to Phase 6 | Builds on telemetry which hasn't accrued |
| `kb/decisions/ADR-*.md` scaffolds | Deferred to Phase 6 | Builds when first decision needs recording |
| `kb/retrospectives/` scaffold | Deferred to Phase 6 | Builds when first retro happens |

None of these deviations reduce the operational or positioning value the prompt sought; they route around harness constraints and sequence work to land safely.

---

## 8. What Phase 2+ will touch

- **Phase 2:** Lean rewrite of `CLAUDE.md` — reference `core/*.md` and `domains/*/DOMAIN.md`, strip duplicated content, keep ≤800 lines / ~3k tokens.
- **Phase 3:** Domain consolidation per AUDIT §5.2 — skills/commands merges, docs redirects for CAPABILITIES_REPORT and CLAUDE_CODE_ARCHITECTURE.
- **Phase 4:** Agent restructuring — flat REGISTRY table, Wave-1 labeling, MCP tier annotation at the per-agent level.
- **Phase 5:** Hook & recipe cleanup + DOMAIN.md coherence check in `validate.sh`.
- **Phase 6:** `/improve` command + ADR scaffold + skill-performance.md wiring. Telemetry-dependent sections deferred until 14+ days of `usage.jsonl` data.
- **Phase 7:** Validation pass + re-sync to `~/.claude/` + ARCHITECTURE.md final edit.

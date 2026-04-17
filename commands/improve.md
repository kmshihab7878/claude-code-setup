---
description: Evaluate and refine a skill, agent, workflow, or system component based on recent usage and evidence. Minimal safe refinements only.
argument-hint: [target — skill / agent / command / hook / doc / file-path]
---

# /improve

Refine a target component based on evidence of its performance. Pairs with the self-evolution layer (`evolution/`) and [`docs/TELEMETRY.md`](../docs/TELEMETRY.md).

## Trigger

User runs `/improve [target]` where target is:

- A skill name: `/improve frontend-design`
- An agent name: `/improve code-reviewer`
- A command: `/improve /plan`
- A hook: `/improve hooks/usage-logger.sh`
- A file path: `/improve docs/RUNBOOK.md`
- Empty: runs a wide scan and suggests the highest-leverage target

## Process

### 1. Gather evidence

- **Telemetry** — if `~/.claude/usage.jsonl` has ≥7 days of data, run `scripts/analyze-usage.sh` filtered to the target. Get invocation count, recency, surrounding context.
- **Cross-refs** — grep who references this target (agents that bind it, commands that route to it, docs that cite it).
- **Self-evolution records** — check `evolution/records/sessions.jsonl` for session-end notes mentioning the target.
- **Memory** — check `memory/MEMORY.md` and per-project `MEMORY.md` for feedback entries about the target.
- **Retrospectives** — scan `kb/retrospectives/` for any entry mentioning the target.

If there is insufficient evidence (< 3 data points), say so and ask the user for the specific observation motivating the improvement request. Do not invent evidence.

### 2. Identify the highest-value gap

Evaluate against these criteria in order:

1. **Does the target do what its description claims?** Description drift is the most common and highest-impact failure mode.
2. **Is the target discoverable by the intended user path?** Orphan status (≤1 inbound per `docs/_audit-workspace/CROSSREF.md`) is a discoverability bug, not a value judgement.
3. **Are there overlap siblings?** Per `docs/SURFACE-MAP.md`, if the target overlaps a canonical entrypoint and isn't the canonical pick, either differentiate with keyword gating or merge.
4. **Is the body appropriately sized?** Refer to `core/context-budget.md` — a 50-line skill that should be 200, or an 800-line skill that should be 200, are both bugs.
5. **Are stale references in the body?** Count drift, MCP name mismatches, broken file paths.

State the gap explicitly before proposing a fix. One gap per iteration — don't combine unrelated fixes.

### 3. Propose minimal refinements

Default to the smallest change that closes the gap:

- **Description drift** → rewrite the frontmatter `description:` line
- **Discoverability** → add 1-3 references from the right agents/commands/docs
- **Overlap** → add a 1-line keyword-gating statement to the body's "When to Use" section; do not merge without evidence that the other skill is stale
- **Body size** → move overflowing content to `references/` (loaded on demand) or compress inline with cuts
- **Stale references** → use targeted `Edit` calls with exact old/new strings

Present the proposed refinement as a diff-shaped summary before applying.

### 4. Test where possible

- For skills: invoke it in a sandbox conversation or refer to an existing eval in `skills/<skill>/evaluations/` if present.
- For agents: spawn a minimal agent-test task and verify the updated frontmatter doesn't break dispatch.
- For commands: dry-run the command.
- For hooks: run `make validate` — the validator checks hook-script existence.
- For docs: run `make validate` — count-drift anti-regression patterns will catch staleness.

### 5. Apply the improvement

Use `Edit` for targeted changes. Use `Write` only for full-file rewrites. Never apply more than one refinement per `/improve` iteration — one gap, one fix.

### 6. Record the outcome

- Add a retrospective entry under `kb/retrospectives/YYYY-MM-DD-<target>.md` using the template in `kb/retrospectives/README.md`.
- If the refinement is a candidate for a durable rule (applies beyond this one target), add a candidate YAML to `evolution/candidates/` per the self-evolution schema.
- If the refinement invalidates prior memory, update `memory/MEMORY.md` or the specific memory file.

## Safeguards

- **Approval first.** If the target is T2+ (CLAUDE.md, REGISTRY.md, settings.json, hooks/*.sh), present the proposed diff and wait for user approval before applying.
- **1% rule.** If even 1% chance the target interacts with something the user cares about (drift detection, validation gates, always-loaded files), verify first.
- **Do not archive from /improve.** Archive decisions require telemetry evidence and explicit user approval. `/improve` refines; it does not remove.

## What /improve is not

- **Not a general refactor.** For sweeping structural changes, use `/ship` with a spec.
- **Not a test-runner.** Tests happen in dev loop, not here.
- **Not a replacement for `/fix-root`.** Bugs get rooted out by `/fix-root`; `/improve` is for refining working-but-suboptimal surfaces.

## Status

Scaffolded in Phase 6 of the restructure. The telemetry-dependent parts (§1 evidence gathering) become fully effective after 14+ days of `~/.claude/usage.jsonl` data. Until then, `/improve` operates on cross-ref + self-evolution records only.

---
name: Operating Framework
description: Task routing, risk assessment, execution modes, and completion standards for meaningful work.
---

# Operating Framework v1.0

> The macro-level operating system for Claude Code. Routes tasks, governs execution,
> structures output. Activated on every meaningful task. Integrates with — never
> replaces — existing framework gates, non-negotiables, and commands.

## Triggers

This skill activates **automatically on every meaningful task**. It works alongside
`using-operating-framework` (which enforces micro-level gates) to provide macro-level
routing, risk assessment, and completion standards.

Trivial tasks (single lookups, file reads, quick answers) bypass the full framework
but still respect framework gates.

## Reference map

| When | Read |
|---|---|
| Picking an operating mode (Section 4 — sequences, agents, artifacts per mode) | [`references/operating-modes.md`](references/operating-modes.md) |
| Convening a council (Section 6 — compositions, decision format, when to convene) | [`references/councils.md`](references/councils.md) |
| Memory promotion policy + benchmark metrics (Sections 9 & 10) | [`references/memory-and-metrics.md`](references/memory-and-metrics.md) |
| Running a Golden Workflow (Section 11 — 4 step-by-step playbooks) | [`references/golden-workflows.md`](references/golden-workflows.md) |

---

## 1. Session Contract

Every non-trivial task begins with a **session header** — a routing decision that
determines how the task will be executed.

```
TASK: [one-line description]
LANE: [Explore | Specify | Build | Verify | Ship | Recover]
RISK: [T0 Safe | T1 Local | T2 Shared | T3 Critical]
MODE: [A Founder | B Elite Engineering | C Recovery | D Secure Delivery]
ARTIFACTS: [what this task must produce]
EVIDENCE: [what proves completion]
COUNCIL: [Solo | Lead+Reviewer | Full Council]
DONE WHEN: [measurable completion condition]
```

The `/start-task` command generates this header. When not explicitly invoked,
mentally route through this before acting.

---

## 2. Lane Definitions

Lanes determine **what kind of work** this is.

| Lane | Trigger | Produces | Next Lane |
|------|---------|----------|-----------|
| **Explore** | Vague request, unknown scope, "what if" | Questions, options, brief | Specify |
| **Specify** | Behavior change, new capability | Spec, acceptance criteria, plan | Build |
| **Build** | Approved spec or plan exists | Code, tests, docs | Verify |
| **Verify** | Code exists, needs validation | Test results, review findings | Ship |
| **Ship** | Verified code ready for delivery | Commit, PR, deploy checklist | Done |
| **Recover** | Bug, incident, regression, failure | Root cause, fix, regression test | Verify |

**Lane Rules:**
- Never skip from Explore to Build. Specify is mandatory for behavior changes.
- Recover always requires root cause before fix (Non-Negotiable #7).
- Ship requires evidence (Non-Negotiable #8).

---

## 3. Risk Tiers

Risk tiers determine **how carefully** to proceed.

| Tier | Scope | Examples | Requirements |
|------|-------|----------|--------------|
| **T0 Safe** | Local, reversible, no side effects | Read files, add comments, format code | Proceed freely |
| **T1 Local** | Local codebase changes, testable | New function, refactor, add tests | Follow lane + framework gates |
| **T2 Shared** | Affects shared state, other systems, data | DB migration, API change, config change | Explicit checkpoint before action |
| **T3 Critical** | Production, financial, security, irreversible | Deploy, trading, credentials, data deletion | Full council review + user approval |

**Escalation Rules:**
- Production systems are always T2+.
- Financial/trading operations are always T3.
- Security changes are always T2+.
- If unsure, escalate one tier up.
- T2 and T3 require a checkpoint: pause and confirm with the user before the irreversible action.

---

## 4. Operating Modes

Modes determine **which tools and sequence** to use. Full per-mode detail (when-to-use, command sequence, agents, artifacts) in [`references/operating-modes.md`](references/operating-modes.md).

| Mode | When | Sequence |
|------|------|----------|
| **A: Founder** | New product, feature from scratch, greenfield | `/sc:brainstorm` → `/spec` → `/bmad:architecture` → `/plan` → Build → Verify |
| **B: Elite Engineering** | Approved spec exists, clear implementation | `/plan` → `/sc:test` → `/sc:build` → `/review` → `/sc:document` |
| **C: Recovery** | Bug, test failure, incident, regression | `/debug` → `/review` → `/sc:test` → `/sc:reflect` |
| **D: Secure Delivery** | Security-sensitive work, deployment, infra | `/security-audit` → `/review` → `/sc:build` |

---

## 5. Decision Tree

Use this to route incoming requests:

```
Is the request vague or exploratory?
  YES -> Lane: Explore, ask clarifying questions first
  NO  ->

Does it change behavior or add capability?
  YES -> Lane: Specify (spec before build)
  NO  ->

Is it a bug, failure, or regression?
  YES -> Lane: Recover, Mode C
  NO  ->

Does it touch production, money, or security?
  YES -> Risk T2+ (T3 if financial/security)
  NO  ->

Does it span multiple domains?
  YES -> Council mode (see Section 6)
  NO  -> Solo execution with appropriate mode
```

---

## 6. Council Framework

Councils provide **multi-perspective review** for complex decisions.

| Council mode | When |
|---|---|
| **Solo** | T0–T1, single domain, clear path |
| **Lead + Reviewer** | T1–T2, needs a second opinion |
| **Full Council** | T2–T3, multi-domain, high stakes |

The four council compositions (Product / Engineering / Recovery / Delivery — each with their named agents) and the council decision format (Assessment / Recommendation / Rationale, with **Block** halts and **Escalate** to user) live in [`references/councils.md`](references/councils.md).

---

## 7. Artifact Matrix

Every task type has **required outputs**.

| Task Type | Required Artifacts |
|-----------|--------------------|
| Idea / exploration | Brief or options document |
| Feature request | Spec + acceptance criteria + implementation plan |
| Bug fix | Root cause analysis + fix + regression test |
| Refactor | Before/after comparison + test confirmation |
| Security change | Security audit + threat model + review |
| Deployment | Deploy checklist + rollback plan + verification |
| Research | Findings summary + recommendations + sources |

**Rule**: A task is not complete until all required artifacts exist.

---

## 8. Enforcement Rules

These rules bind the framework to existing framework non-negotiables.

| # | Rule | Maps To | Effect |
|---|------|---------|--------|
| 1 | **Boundary** — Do not cross lane boundaries without artifacts | Non-Negotiable #9 (Approval first) | Cannot jump from Explore to Build |
| 2 | **Evidence** — No completion without proof | Non-Negotiable #8 (Evidence first) | Must show test output, logs, or build results |
| 3 | **Root Cause** — No fix without investigation | Non-Negotiable #7 (Root cause first) | Must state root cause with evidence before patching |
| 4 | **Checkpoint** — T2/T3 require explicit pause | NEW | Must confirm with user before irreversible actions |
| 5 | **Review Disposition** — Every finding gets a verdict | NEW | Each review finding: accepted, deferred (with reason), or rejected (with reason) |

---

## 9. Memory-to-Mastery

The framework uses 4 memory domains to learn and improve over time:

- **Architecture** → `memory/architecture.md` — system overviews, component maps, integration patterns.
- **Failure** → `memory/mistakes.md` — what went wrong, root cause, prevention strategy.
- **Execution** → `memory/patterns.md` — code patterns, conventions, successful approaches.
- **Preference** → `memory/preferences.md` — coding style, doc standards, naming conventions, verification preferences.

**Promotion policy:** when a pattern succeeds **3 or more times**, promote it (successful code → template in `patterns.md`; successful prevention → checklist in `mistakes.md`; successful workflow → new skill/command candidate; user preference → solidify in `preferences.md`). Note the success count: `(confirmed: N)`.

Full domain rules + per-promotion-type guidance: [`references/memory-and-metrics.md`](references/memory-and-metrics.md#memory-to-mastery).

---

## 10. Benchmark Metrics

Track these to measure framework effectiveness:

- First-pass success rate (> 85%) · Gate compliance (100%) · Root cause accuracy (> 90%) · Artifact completeness (100%) · Risk tier accuracy (> 95%) · Evidence attached (100%) · Memory promotion rate (monthly) · Regression rate (< 5%).

Full 8-row metric table with measurement methods + monthly-review rule: [`references/memory-and-metrics.md`](references/memory-and-metrics.md#benchmark-metrics).

---

## 11. Golden Workflows

Step-by-step playbooks for the 4 most common task types. Full 8-step procedures (with command links and non-negotiable references per step) in [`references/golden-workflows.md`](references/golden-workflows.md):

| # | Workflow | Routing | Key gates |
|---|----------|---------|-----------|
| 1 | **New Feature** | Lane=Specify, Risk=T1, Mode=B (or A if greenfield) | spec approval (NN#9) → failing tests first (NN#6) → evidence (NN#8) |
| 2 | **Bug Fix** | Lane=Recover, Risk=T1+, Mode=C | root cause gate (NN#7) → regression test → reflect |
| 3 | **Major Refactor** | Lane=Specify, Risk=T1–T2, Mode=B | baseline tests → incremental changes (NN#4) → before/after comparison |
| 4 | **Production Release** | Lane=Ship, Risk=T2–T3, Mode=D | security audit → rollback plan → explicit user approval (T2+) |

Each workflow ends with `/complete` to generate the Completion Packet (Section 12).

---

## 12. Completion Packet

Every non-trivial task ends with a completion packet. The `/complete` command
generates this.

```
## Completion Packet

**Task**: [description]
**Lane**: [lane taken]
**Risk**: [tier assigned]

### Summary
[1-3 sentences on what was done]

### Changed Files
- [file]: [what changed]

### Artifacts Produced
- [artifact]: [location or inline]

### Tests Run
- [test suite/file]: [pass/fail, count]

### Evidence
[Link to or inline: test output, logs, screenshots, build results]

### Risks Introduced
- [risk]: [mitigation]
(or: None identified)

### Rollback Path
[How to undo this change]

### Open Questions
- [anything unresolved]
(or: None)

### Next Step
[Recommended follow-up action]

### Memory Promotion Candidate
[Pattern that succeeded 3+ times, if any]
(or: None this session)
```

---

## 13. Skill Precedence Matrix

When multiple skills trigger on the same input, resolve using this priority order:

| Priority | Layer | Purpose |
|----------|-------|---------|
| 1 | **operating-framework** | Routes the task first (lane, risk, mode) |
| 2 | **using-operating-framework** | Enforces gates second (TDD, root cause, approval) |
| 3 | **Lane-matching skill** | The domain skill that matches the assigned lane |
| 4 | **Supporting skills** | Additional skills that provide patterns/templates |

### Conflict Resolution

When two same-priority skills both trigger:
- The skill matching the session's **LANE** wins
- If both match the lane, the more **specific** skill wins (e.g., `security-review` beats `coding-workflow` for a security task)
- If still tied, apply both — they're complementary, not conflicting

### Examples

| Request | Triggers | Resolution |
|---------|----------|------------|
| "Fix the login API" | debug, api-design-patterns, security-review | Lane=Recover -> `debug` leads, others support |
| "Add rate limiting" | api-design-patterns, security-review, coding-workflow | Lane=Specify -> `api-design-patterns` leads |
| "Deploy the fix" | devops-patterns, security-review, git-workflows | Lane=Ship -> `devops-patterns` leads |

---

## 14. Escape Hatch

Sometimes the framework itself is the bottleneck. This section defines when and how to bypass it.

### When to Bypass

The user explicitly says one of:
- "Just do it"
- "Skip routing"
- "Emergency mode"
- "No framework needed"

### What Still Applies (Always, No Exceptions)

Even in bypass mode, these Non-Negotiables are never skipped:
1. **No fabrication** (#1) — Never invent results
2. **Security-first** (#2) — Never commit secrets
3. **Verify before asserting** (#3) — Read before claiming

### What Gets Streamlined

- Session header: skipped (implicit T1, Solo, Build)
- Lane routing: skipped (go straight to action)
- Council: skipped (Solo mode)
- Completion packet: abbreviated (summary + evidence only)

### What Gets Logged

Every bypass is noted for the monthly `/retro`:
- What was bypassed and why
- Whether the outcome was successful
- Whether the bypass caused any issues

This data informs whether the framework is too heavy for certain task types
and should be adjusted.

---

## Integration Points

This framework does NOT replace existing tools. It wraps them:

| Framework Concept | Implemented By |
|-------------------|----------------|
| Session routing | `/start-task` command |
| Micro-level gates | `using-operating-framework` skill |
| Pre-implementation check | `confidence-check` skill |
| Completion standards | `/complete` command |
| Lane: Explore | `/sc:brainstorm`, `/sc:research` |
| Lane: Specify | `/spec`, `/bmad:prd` |
| Lane: Build | `/sc:build`, `/sc:implement` |
| Lane: Verify | `/sc:test`, `/review` |
| Lane: Ship | `/pr-prep`, `/sc:git` |
| Lane: Recover | `/debug`, `/sc:troubleshoot` |
| Council execution | `/sc:spawn` with domain grouping |
| Memory persistence | Memory system in `~/.claude/projects/*/memory/` |
| Metrics collection | `~/.claude/scripts/metrics_collector.sh` |
| Framework retro | `/retro` command |
| Session handoff | `/handoff` command |
| Setup validation | `~/.claude/scripts/validate_setup.sh` |
| Templates | `~/.claude/templates/*.md` |

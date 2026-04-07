# KhaledPowers Ultimate Operating Framework v1.0

> The macro-level operating system for Claude Code. Routes tasks, governs execution,
> structures output. Activated on every meaningful task. Integrates with — never
> replaces — existing KhaledPowers gates, non-negotiables, and commands.

## Triggers

This skill activates **automatically on every meaningful task**. It works alongside
`using-khaledpowers` (which enforces micro-level gates) to provide macro-level
routing, risk assessment, and completion standards.

Trivial tasks (single lookups, file reads, quick answers) bypass the full framework
but still respect KhaledPowers gates.

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
| **T1 Local** | Local codebase changes, testable | New function, refactor, add tests | Follow lane + KhaledPowers gates |
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

Modes determine **which tools and sequence** to use.

### Mode A: Founder (Idea to Product)

**When**: New product, feature from scratch, greenfield work.

**Sequence**: `/sc:brainstorm` > `/spec` > `/bmad:architecture` > `/plan` > Build > Verify

**Agents**: requirements-analyst, architect, business-panel-experts

**Artifacts**: Brief, spec, architecture doc, implementation plan

### Mode B: Elite Engineering (Code Excellence)

**When**: Approved spec exists, clear implementation task.

**Sequence**: `/plan` > `/sc:test` > `/sc:build` > `/review` > `/sc:document`

**Agents**: python-expert, tester, code-reviewer

**Artifacts**: Implementation plan, tests, code, review findings, docs

### Mode C: Recovery (Fix and Harden)

**When**: Bug report, test failure, incident, regression.

**Sequence**: `/debug` > `/review` > `/sc:test` > `/sc:reflect`

**Agents**: debugger, root-cause-analyst, incident-responder

**Artifacts**: Root cause analysis, fix, regression test, post-mortem

### Mode D: Secure Delivery (Ship Safely)

**When**: Security-sensitive work, deployment, infrastructure changes.

**Sequence**: `/security-audit` > `/review` > `/sc:build`

**Agents**: security-auditor, ci-cd-engineer, docker-specialist

**Artifacts**: Security audit, deployment checklist, rollback plan

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

### Council Compositions

| Council | Agents | When |
|---------|--------|------|
| **Product** | requirements-analyst, architect, business-panel-experts | New products, major features, pivots |
| **Engineering** | python-expert, code-reviewer, quality-engineer | Architecture decisions, major refactors |
| **Recovery** | debugger, root-cause-analyst, incident-responder | Critical bugs, production incidents |
| **Delivery** | security-auditor, ci-cd-engineer, devops-architect | Deployments, infrastructure changes |

### Council Decision Format

Each council member provides:
- **Assessment**: What they see
- **Recommendation**: One of: Approve / Approve with conditions / Block / Escalate
- **Rationale**: Why

A **Block** from any member halts progress until resolved.
An **Escalate** means the decision exceeds the council's authority — ask the user.

### When to Convene

| Council Mode | Trigger |
|--------------|---------|
| **Solo** | T0-T1, single domain, clear path |
| **Lead + Reviewer** | T1-T2, needs a second opinion |
| **Full Council** | T2-T3, multi-domain, high stakes |

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

These rules bind the framework to existing KhaledPowers non-negotiables.

| # | Rule | Maps To | Effect |
|---|------|---------|--------|
| 1 | **Boundary** — Do not cross lane boundaries without artifacts | Non-Negotiable #9 (Approval first) | Cannot jump from Explore to Build |
| 2 | **Evidence** — No completion without proof | Non-Negotiable #8 (Evidence first) | Must show test output, logs, or build results |
| 3 | **Root Cause** — No fix without investigation | Non-Negotiable #7 (Root cause first) | Must state root cause with evidence before patching |
| 4 | **Checkpoint** — T2/T3 require explicit pause | NEW | Must confirm with user before irreversible actions |
| 5 | **Review Disposition** — Every finding gets a verdict | NEW | Each review finding: accepted, deferred (with reason), or rejected (with reason) |

---

## 9. Memory-to-Mastery

The framework uses 4 memory domains to learn and improve over time.

| Domain | Maps To | What Gets Stored |
|--------|---------|------------------|
| **Architecture** | `memory/architecture.md` | System overviews, component maps, integration patterns |
| **Failure** | `memory/mistakes.md` | What went wrong, root cause, prevention strategy |
| **Execution** | `memory/patterns.md` | Code patterns, conventions, successful approaches |
| **Preference** | `memory/preferences.md` | Coding style, doc standards, naming conventions, verification preferences |

### Promotion Policy

When a pattern succeeds **3 or more times**:
- A successful code pattern -> promote to `patterns.md` as a template
- A successful prevention strategy -> promote to checklist in `mistakes.md`
- A successful workflow -> candidate for new skill or command
- A user preference -> solidify in `preferences.md`

When recording, note the success count: `(confirmed: N)`.

---

## 10. Benchmark Metrics

Track these to measure framework effectiveness.

| # | Metric | Target | How to Measure |
|---|--------|--------|----------------|
| 1 | First-pass success rate | > 85% | Tasks completed without rework |
| 2 | Gate compliance | 100% | No gate violations detected |
| 3 | Root cause accuracy | > 90% | Fix addresses actual root cause |
| 4 | Artifact completeness | 100% | All required artifacts produced |
| 5 | Risk tier accuracy | > 95% | Correct tier assigned initially |
| 6 | Evidence attached | 100% | Every completion has proof |
| 7 | Memory promotion rate | Monthly | Patterns promoted per month |
| 8 | Regression rate | < 5% | Bugs reintroduced after fix |

Monthly review: check metrics, update patterns, promote successful approaches.

---

## 11. Golden Workflows

Step-by-step reference for the 4 most common task types.

### Workflow 1: New Feature

1. **Route**: Lane=Specify, Risk=T1, Mode=B (or A if greenfield)
2. **Specify**: `/spec` — Write acceptance criteria, get user approval (Non-Negotiable #9)
3. **Plan**: `/plan` — Break into tasks with clear done conditions
4. **Test**: Write failing tests first (Non-Negotiable #6)
5. **Build**: `/sc:build` — Implement against the tests
6. **Review**: `/review` — Self-review, disposition every finding
7. **Verify**: Run full test suite, show output (Non-Negotiable #8)
8. **Complete**: `/complete` — Generate completion packet

### Workflow 2: Bug Fix

1. **Route**: Lane=Recover, Risk=T1+, Mode=C
2. **Investigate**: `/debug` — Root cause gate (Non-Negotiable #7)
3. **Evidence**: Show logs, traces, or reproduction proving root cause
4. **Test**: Write failing regression test
5. **Fix**: Apply minimal fix targeting root cause
6. **Verify**: All tests pass, regression test specifically passes
7. **Reflect**: `/sc:reflect` — What caused this? How to prevent?
8. **Complete**: `/complete` — Include root cause in packet

### Workflow 3: Major Refactor

1. **Route**: Lane=Specify, Risk=T1-T2, Mode=B
2. **Baseline**: Run existing tests, record current behavior
3. **Plan**: `/plan` — Define refactor scope, what changes vs. what doesn't
4. **Specify**: Document before/after architecture
5. **Build**: Incremental changes (Non-Negotiable #4), test after each step
6. **Verify**: Full test suite, compare with baseline
7. **Review**: `/review` — Ensure no behavior changes leaked in
8. **Complete**: `/complete` — Include before/after comparison

### Workflow 4: Production Release

1. **Route**: Lane=Ship, Risk=T2-T3, Mode=D
2. **Audit**: `/security-audit` — Full security review
3. **Checklist**: Generate deployment checklist
4. **Rollback**: Document rollback procedure
5. **Checkpoint**: Explicit user approval (T2+ required)
6. **Deploy**: Execute deployment steps
7. **Verify**: Post-deploy verification, smoke tests
8. **Complete**: `/complete` — Include deploy evidence and rollback path

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
| 2 | **using-khaledpowers** | Enforces gates second (TDD, root cause, approval) |
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
| Micro-level gates | `using-khaledpowers` skill |
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
| Quickstart | `~/.claude/docs/QUICKSTART.md` |

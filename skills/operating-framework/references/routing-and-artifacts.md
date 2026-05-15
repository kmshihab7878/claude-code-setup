# Routing and Artifact Rules

Purpose: Detailed session routing, lane definitions, risk tiers, decision tree, artifact matrix, and enforcement rules for the operating framework.

## Session Contract

Every non-trivial task begins with a session header that determines how the task will be executed.

```text
TASK: [one-line description]
LANE: [Explore | Specify | Build | Verify | Ship | Recover]
RISK: [T0 Safe | T1 Local | T2 Shared | T3 Critical]
MODE: [A Founder | B Elite Engineering | C Recovery | D Secure Delivery]
ARTIFACTS: [what this task must produce]
EVIDENCE: [what proves completion]
COUNCIL: [Solo | Lead+Reviewer | Full Council]
DONE WHEN: [measurable completion condition]
```

The `/start-task` command generates this header. When not explicitly invoked, route through this before acting.

## Lane Definitions

| Lane | Trigger | Produces | Next Lane |
|---|---|---|---|
| Explore | Vague request, unknown scope, "what if" | Questions, options, brief | Specify |
| Specify | Behavior change, new capability | Spec, acceptance criteria, plan | Build |
| Build | Approved spec or plan exists | Code, tests, docs | Verify |
| Verify | Code exists, needs validation | Test results, review findings | Ship |
| Ship | Verified code ready for delivery | Commit, PR, deploy checklist | Done |
| Recover | Bug, incident, regression, failure | Root cause, fix, regression test | Verify |

Lane rules:

- Never skip from Explore to Build; Specify is mandatory for behavior changes.
- Recover always requires root cause before fix.
- Ship requires evidence.

## Risk Tiers

| Tier | Scope | Examples | Requirements |
|---|---|---|---|
| T0 Safe | Local, reversible, no side effects | Read files, add comments, format code | Proceed freely |
| T1 Local | Local codebase changes, testable | New function, refactor, add tests | Follow lane and framework gates |
| T2 Shared | Shared state, other systems, data | DB migration, API change, config change | Explicit checkpoint before action |
| T3 Critical | Production, financial, security, irreversible | Deploy, trading, credentials, data deletion | Full council review and user approval |

Escalation rules:

- Production systems are always T2+.
- Financial or trading operations are always T3.
- Security changes are always T2+.
- If unsure, escalate one tier.
- T2 and T3 require a checkpoint before irreversible action.

## Decision Tree

```text
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
  YES -> Council mode
  NO  -> Solo execution with appropriate mode
```

## Artifact Matrix

| Task Type | Required Artifacts |
|---|---|
| Idea / exploration | Brief or options document |
| Feature request | Spec, acceptance criteria, implementation plan |
| Bug fix | Root cause analysis, fix, regression test |
| Refactor | Before/after comparison and test confirmation |
| Security change | Security audit, threat model, review |
| Deployment | Deploy checklist, rollback plan, verification |
| Research | Findings summary, recommendations, sources |

A task is not complete until all required artifacts exist.

## Enforcement Rules

| # | Rule | Maps To | Effect |
|---|---|---|---|
| 1 | Boundary: do not cross lane boundaries without artifacts | Approval first | Cannot jump from Explore to Build |
| 2 | Evidence: no completion without proof | Evidence first | Must show test output, logs, or build results |
| 3 | Root Cause: no fix without investigation | Root cause first | Must state root cause before patching |
| 4 | Checkpoint: T2/T3 require explicit pause | Approval first | Must confirm with user before irreversible actions |
| 5 | Review Disposition: every finding gets a verdict | Review standard | Accepted, deferred with reason, or rejected with reason |

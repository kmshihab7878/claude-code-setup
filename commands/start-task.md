# /start-task

> Route before acting. Every meaningful task starts with a session contract.

## Instructions

When invoked, analyze the user's request (passed as `$ARGUMENTS` or from the
preceding message) and generate a **session header** by working through these steps:

### 1. Route — Determine the Lane

| If the request is... | Lane |
|----------------------|------|
| Vague, exploratory, "what if" | **Explore** |
| A behavior change or new capability | **Specify** |
| Clear implementation with approved spec | **Build** |
| Needs validation or testing | **Verify** |
| Ready to commit, deploy, or deliver | **Ship** |
| A bug, failure, incident, or regression | **Recover** |

### 2. Assess Risk — Assign a Tier

| Scope | Tier |
|-------|------|
| Local, reversible, no side effects | **T0 Safe** |
| Local codebase changes, testable | **T1 Local** |
| Shared state, DB, API, config changes | **T2 Shared** |
| Production, financial, security, irreversible | **T3 Critical** |

When unsure, escalate one tier up.

### 3. Select Mode

| Situation | Mode |
|-----------|------|
| New product/feature from scratch | **A Founder** |
| Clear implementation task | **B Elite Engineering** |
| Bug, incident, failure | **C Recovery** |
| Security-sensitive, deployment | **D Secure Delivery** |

### 4. Define Artifacts, Evidence, Council, and Done Condition

Use the Artifact Matrix from the operating-framework skill to determine required
outputs. Set the evidence requirement, council mode, and a measurable done condition.

### 5. Output the Session Header

```
TASK: [one-line description]
LANE: [lane]
RISK: [tier]
MODE: [mode]
ARTIFACTS: [required outputs]
EVIDENCE: [what proves completion]
COUNCIL: [Solo | Lead+Reviewer | Full Council]
DONE WHEN: [measurable condition]
```

### 6. Propose First Step

After outputting the header, propose the **first concrete action** for this task.

If the request is vague (Lane = Explore), ask clarifying questions instead of
proposing implementation steps.

## Example

User: "Add rate limiting to the API"

```
TASK: Add rate limiting to the API
LANE: Specify
RISK: T2 Shared (affects API behavior for all consumers)
MODE: B Elite Engineering
ARTIFACTS: Spec with rate limit strategy, implementation plan, tests, docs
EVIDENCE: Rate limit tests passing, API responds with 429 when exceeded
COUNCIL: Lead+Reviewer (API change needs second opinion)
DONE WHEN: Rate limiting active on all endpoints, tests pass, docs updated
```

**First step**: Write a brief spec covering: which endpoints, what limits (per-user vs global), response format for 429, and header conventions (X-RateLimit-*). Get user approval before implementation.

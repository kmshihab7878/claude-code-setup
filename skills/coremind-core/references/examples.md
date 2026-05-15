# Examples — Worked CoreMind Pipeline Runs

End-to-end examples showing Intent → Plan → DelegationContract → Outcome
for representative requests.

## Example 1: T0 read-only research task

**User request**: "Compare Postgres and SQLite for our embedded analytics use case."

### Intent

```yaml
Intent:
  content: "Compare Postgres and SQLite for embedded analytics"
  goal_type: research
  domain: research
  priority: 5
  risk_level: low
  action_tier: T0 Safe
  requires_approval: false
  estimated_complexity: moderate
```

### Stage 2 — Policy Gate

ALLOW. T0 read-only research. Proceed.

### Plan

```yaml
Plan:
  objective: "Comparative analysis: Postgres vs SQLite for embedded analytics"
  complexity: moderate
  steps:
    - id: 1
      description: Gather benchmark data for both engines under analytics load
      agent: deep-research
      authority_level: L2
      mcp_servers: [filesystem, code-review-graph]
      skills: [research-synthesis]
      risk_tier: T0
      depends_on: []
    - id: 2
      description: Draft comparison matrix with tradeoffs and operator constraints
      agent: data-analyst
      authority_level: L2
      mcp_servers: [filesystem]
      skills: [comparative-analysis]
      risk_tier: T0
      depends_on: [1]
  critical_path: [1, 2]
  parallel_groups: []
```

### Stage 9 — Outcome

```yaml
Outcome:
  agent: deep-research
  task: "Gather benchmark data"
  quality_score: 0.84
  tools_used: [filesystem]
  duration_ms: 12400
  success: true
  side_effects: []
```

## Example 2: T2 shared action — needs approval

**User request**: "Open a PR with the staging-config change."

### Intent

```yaml
Intent:
  content: "Open a PR with the staging-config change"
  goal_type: operational
  domain: infrastructure
  priority: 4
  risk_level: medium
  action_tier: T2 Shared
  requires_approval: true
  estimated_complexity: simple
```

### Stage 2 — Policy Gate

ESCALATE. T2 (PR creation affects shared remote). Present plan, wait for approval.

### Approval surface (what the user sees)

```
Action: Open a PR against main with the staging-config change.
Why approval is required: Safety (PR is visible to others, shared remote).
Blast radius: GitHub PR list, CI run, any subscribers to the repo.
Reversibility: PR can be closed; CI run cannot be unsent.
Expected duration: < 1 minute once approved.
```

User confirms → fresh DelegationContract issued with single-use approval token.

### Plan post-approval

```yaml
Plan:
  steps:
    - id: 1
      description: Open PR with the staging-config diff and structured body
      agent: release-engineer
      authority_level: L3
      mcp_servers: [git, filesystem]
      risk_tier: T2
      depends_on: []
```

## Example 3: Stage 6 — no candidate

**User request**: "Run a production migration on the analytics DB."

### Intent

```yaml
action_tier: T3 Critical
requires_approval: true
```

### Stage 2 — Policy Gate

ESCALATE (T3 requires pre-authorization). User has not pre-authorized; **BLOCK**
with explanation. Surface the pre-authorization path (per operator's policy)
rather than silently proceeding.

## Example 4: Parallel execution

**User request**: "Audit the auth and billing modules for security issues."

### Plan

```yaml
Plan:
  steps:
    - id: 1
      description: Security audit of auth module
      agent: security-engineer
      risk_tier: T1
      depends_on: []
    - id: 2
      description: Security audit of billing module
      agent: security-engineer
      risk_tier: T1
      depends_on: []
    - id: 3
      description: Synthesize findings + prioritized remediation
      agent: security-engineer
      risk_tier: T0
      depends_on: [1, 2]
  parallel_groups:
    - [1, 2]
```

Stages 1 and 2 run in parallel; Stage 3 waits for both.

### Stage 8 — Reflection (cross-step)

If step 1 fails and step 2 succeeds, step 3 still runs but with a tagged
`partial=true` flag. Stage 9 captures the partial state; the user sees the
billing audit completed and the auth audit failed with reason.

## Example 5: POST validator catches a leak

Stage 8 produced a high-quality summary, but the POST PII check flagged a
sample API key in a quoted log snippet.

- POST returns failure to Stage 8 with `failure_mode: secret_leak`.
- Stage 8 routes back to the producing agent with the failure tagged.
- The agent redacts the snippet; Stage 9 re-records the duration.
- POST re-runs; all five checks pass; output is delivered.

The user never sees the un-redacted draft — that is the entire point of POST.

## Minimal Intent example

```yaml
Intent:
  content: "Refactor the rate limiter to use sliding window"
  goal_type: technical
  domain: engineering
  priority: 6
  risk_level: medium
  action_tier: T1 Local
  requires_approval: false
  estimated_complexity: moderate
```

Routes to engineering domain authority chain: `system-architect` (L1) reviews;
delegates to `backend-architect` (L2) for the implementation plan; a worker
agent (L6) executes the edits.

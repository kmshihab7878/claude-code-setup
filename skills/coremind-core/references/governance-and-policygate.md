# Governance and PolicyGate

Stage 2 (intent-level) and Stage 5 (per-step) policy enforcement detail.
Reference: `~/.claude/skills/governance-gate/SKILL.md`.

## Stage 2: Policy Gate (Intent)

Evaluate the Intent against the governance framework.

| Decision | Criteria | Action |
|----------|----------|--------|
| **ALLOW** | T0 Safe, read-only, research, analysis | Proceed to Stage 3 |
| **REVIEW** | T1 Local, code changes, test runs | Log intent, proceed |
| **ESCALATE** | T2 Shared, external system interaction | Present plan, wait for approval |
| **BLOCK** | T3 Critical without authorization, policy violation | Reject with explanation |

## The 7 Policy Constraints

Checked in order. Any violation halts the pipeline at the affected stage.

1. **Safety** — no destructive actions (`rm -rf`, force push, drop DB) without explicit authorization.
2. **Privacy** — no PII exposure (SSN, credit cards, passwords in outputs).
3. **Data access** — least-privilege; agents use only declared MCP servers.
4. **Financial** — budget awareness (API costs, token usage, trading operations).
5. **Compliance** — regulatory awareness (GDPR, SOC2, HIPAA patterns).
6. **Fairness** — bias check on AI-generated content.
7. **Transparency** — high-risk decisions require stated reasoning.

## Stage 5: Policy Gate (Plan)

Validate each plan step against policies:

- **Per-step validation** — every step checked against the 7 constraints.
- **Cumulative risk** — multiple T1 steps may aggregate to T2 risk.
- **Tool validation** — verify agent has declared access to required MCP servers.
- **Authority validation** — verify the agent's authority level matches task scope.
- **Approval batching** — group T2+ steps for a single user approval prompt.

## Risk Tier Reference

| Tier | Meaning | Default action |
|------|---------|----------------|
| T0 Safe | Read-only / harmless local inspection | Execute immediately |
| T1 Local | Local reversible edits / checks | Log and proceed |
| T2 Shared | Git remotes, PRs, CI, shared services, paid APIs | Wait for user approval |
| T3 Critical | Production, secrets, irreversible actions, financial/legal | Reject unless pre-authorized |

## DelegationContract — Authority Binding

Each delegated step produces an immutable contract:

```yaml
DelegationContract:
  agent_id: "<agent-name>"
  task: "<step description>"
  tools_authorized: [<MCP servers from agent's binding>]
  skills_to_apply: [<relevant skills>]
  risk_tier: T0-T3
  timeout: <based on complexity>
  quality_threshold: 0.7
  fallback_agent: "<next-best agent>"
```

### Contract Discipline

- An agent **cannot** modify its own contract or escalate its own authority.
- Tools not in `tools_authorized` are blocked at the execution layer (Stage 7).
- Skills outside `skills_to_apply` may be referenced but not bound.
- If the contract requires T2+ authority, the user-approval token is part of
  the contract — without it, execution is rejected.

## Authority Escalation Path

When a step requires authority higher than the assigned agent's level:

1. Stage 5 detects the gap and tags the step `ESCALATE`.
2. The delegation engine routes to the next-higher authority agent
   (L6 → L5 → L3 → L2).
3. Approval is requested with the failing step, current authority, and
   required authority spelled out.
4. On approval, a fresh DelegationContract is issued with a single-use
   approval token; the original requesting agent does not gain the authority.

## Policy Violation Handling

| Violation | Stage where caught | Response |
|-----------|--------------------|----------|
| Destructive op without authorization | Stage 2 or 5 | BLOCK with explanation |
| PII in candidate output | Stage 5 or POST | BLOCK output, return sanitization request |
| Agent using undeclared MCP server | Stage 7 (runtime) | Halt step, mark agent for review |
| Cumulative-risk threshold exceeded | Stage 5 | Escalate plan to user |
| Budget threshold exceeded | Stage 7 | Pause execution, request budget approval |
| Secrets present in output | POST | Block delivery, redact, re-validate |

## Approval Surface — what gets shown to the user

When ESCALATE fires, surface:

- The intent (compressed).
- The failing step or steps.
- Why approval is required (which of the 7 constraints).
- The blast radius (files/services/external systems affected).
- The reversibility of the action.
- The expected duration if approved.

Never bury an approval prompt at the end of a long status update — lead with it.

---
name: multi-agent-patterns
description: >
  Design patterns for multi-agent AI systems. Supervisor, pipeline, swarm, and hierarchical
  patterns. Communication protocols, task delegation, lifecycle management, and conflict resolution.
  Use when designing new agent architectures, coordinating multiple agents, or orchestrating workflows.
risk: medium
tags: [agents, architecture]
created: 2026-03-07
updated: 2026-05-15
---

# Multi-Agent Patterns

Design patterns and orchestration infrastructure for building robust multi-agent AI systems.

## Reference map

Reference material lives in `references/`. Load only what the current task needs.

| When | Read |
|---|---|
| Full Python implementations for all 10 orchestration patterns (GroupChat, ReAct, CriticExecutor, Router, Plan-and-Execute, Debate, Supervisor, P2P, Hierarchical, Swarm) | [`references/orchestration-patterns.md`](references/orchestration-patterns.md) |
| Capability-based / round-robin / auction delegation code, ConversationPolicy guardrails, conflict-resolution strategy detail, handoff discipline | [`references/delegation-and-handoffs.md`](references/delegation-and-handoffs.md) |
| Message Passing / Shared State / Event Bus Python, AgentHealth dataclass + state machine, AgentMemoryStore code, Real-time agent latency budget | [`references/coordination-examples.md`](references/coordination-examples.md) |
| Anti-pattern rationale + detection, error-handling implementations (retry / circuit breaker / fallback / degradation / DLQ), debugging recipes | [`references/validation-and-troubleshooting.md`](references/validation-and-troubleshooting.md) |
| End-to-end scenarios (research pipeline, real-time voice agent, debate + arbitration, hierarchical with PolicyGate, swarm with shared memory) + pattern composition cheatsheet | [`references/examples.md`](references/examples.md) |

## How to use

- `/multi-agent-patterns`
  Apply multi-agent design patterns to the current system.
- `/multi-agent-patterns <scenario>`
  Recommend patterns for a specific coordination scenario.

## When to use

Reference these guidelines when:

- designing new agent architectures
- adding agents to an existing system
- solving coordination problems between agents
- implementing memory sharing across agents
- resolving conflicts in multi-agent decisions
- building real-time agent systems
- designing agent communication protocols
- building task delegation logic
- implementing agent lifecycle management
- designing CoreMind GAOS workflows

## When NOT to use

Do NOT apply this skill when:

- building a single-agent system with no coordination needs
- the task is about Claude Code subagent spawning (use `subagent-development` skill)
- the task is about MCP server development (use `mcp-builder` skill)

---

## Pattern Selection Guide

**Start here.** Pick the pattern by scenario, then load the implementation from [`references/orchestration-patterns.md`](references/orchestration-patterns.md).

| Scenario | Recommended Pattern |
|---|---|
| Independent subtasks | Orchestrator-Workers or Supervisor |
| Sequential processing | Pipeline (Plan-and-Execute with linear DAG) |
| Quality-critical output | Critic-Executor |
| Request classification | Router |
| Complex multi-step goals | Plan-and-Execute |
| Controversial decisions | Debate |
| Exploration / search | Swarm |
| Real-time interaction | Real-time Agent |
| Organization hierarchy | Hierarchical Delegation |
| Collaborative reasoning | Peer-to-Peer |

---

## Pattern Catalog (one-line summary)

Full implementations in [`references/orchestration-patterns.md`](references/orchestration-patterns.md).

1. **Orchestrator-Workers (AG2/AutoGen)** — central orchestrator manages conversation between specialists.
2. **Tool-Use Agent (ReAct)** — Thought → Action → Observation loop.
3. **Critic-Executor (Reflection)** — execute → critique → revise until quality threshold.
4. **Router (Agent-Squad)** — classify request, dispatch to specialist.
5. **Plan-and-Execute** — generate plan with deps, execute via topological sort, replan on failure.
6. **Debate** — N positions argue, judge evaluates.
7. **Supervisor (Hub-and-Spoke)** — fan-out tasks, aggregate results.
8. **Peer-to-Peer (Mesh)** — direct agent-to-agent communication.
9. **Hierarchical Delegation** — multi-level authority cascade.
10. **Swarm Intelligence** — simple agents, emergent behavior, environment-mediated.

---

## Communication Protocols

| Mechanism | When | Key invariant |
|---|---|---|
| **Message Passing** | Loosely coupled agents, async workflows | Every message carries `trace_id` propagated end-to-end |
| **Shared State** | Tightly coordinated agents in same process | Lock around every read/write — no exceptions |
| **Event Bus** | Fan-out notifications, decoupled pub/sub | Include `trace_id` in event payload for chain tracing |

Full Python implementations in [`references/coordination-examples.md`](references/coordination-examples.md#communication-protocols).

---

## Task Delegation Strategies

| Strategy | Description | Best For |
|---|---|---|
| Round-robin | Distribute evenly across agents | Homogeneous agents |
| Capability-based | Match task requirements to agent skills | Heterogeneous agents (default) |
| Auction | Agents bid on tasks | Dynamic load balancing |
| Priority queue | High-priority tasks first | Critical path workflows |
| Affinity | Route related tasks to same agent | Context-dependent work |

**Default**: capability-based with load filtering. Never silently route to an over-loaded or under-skilled agent — return `None` and escalate instead. Code: [`references/delegation-and-handoffs.md`](references/delegation-and-handoffs.md#capability-based-delegation).

---

## Handoff Discipline

When one agent hands work to another, **every** handoff must:

1. Propagate the originating `trace_id`.
2. Include a one-paragraph context summary (no requiring the receiver to re-read full history).
3. Declare authority explicitly: `consulted` / `delegated` / `escalated`.
4. Surface rejection — no silent fail-back loops.
5. Have a timeout; expired handoffs go to a dead-letter queue, not a stall.

Full discipline detail: [`references/delegation-and-handoffs.md`](references/delegation-and-handoffs.md#handoff-discipline).

---

## Agent Lifecycle

```
CREATED → INITIALIZING → READY → RUNNING → COMPLETED
                                    ↓           ↓
                                  ERROR    TERMINATED
                                    ↓
                                 RETRYING
```

**Health rule**: heartbeat interval ≤ ⅓ of timeout window; 3 consecutive misses → ERROR → recovery. Full `AgentHealth` dataclass and operational detail in [`references/coordination-examples.md`](references/coordination-examples.md#agent-lifecycle--health-monitoring).

---

## Conversation Control — Guardrails

Every multi-agent conversation runs under a `ConversationPolicy` with `max_turns`, `allowed_topics`, `blocked_patterns`, `escalation_triggers`, `tone`. Blocked patterns short-circuit messages before downstream agents see them. Escalation triggers route up the hierarchy rather than continuing the current loop.

Implementation: [`references/delegation-and-handoffs.md`](references/delegation-and-handoffs.md#conversation-control--behavioral-guardrails).

---

## Conflict Resolution

| Strategy | When | How |
|---|---|---|
| Voting | Equal-authority agents | Majority wins |
| Priority | Hierarchical authority | Higher-rank agent wins |
| Consensus | Collaborative critical decisions | All must agree or escalate |
| Arbitration | Deadlocked agents | Third-party agent decides |
| Evidence-weighted | Data-driven decisions | Agent with best evidence wins |

Pick by stakes / authority distribution / time pressure / auditability. Full guidance in [`references/delegation-and-handoffs.md`](references/delegation-and-handoffs.md#conflict-resolution--strategy-detail).

---

## Error Handling Patterns

| Pattern | When | Implementation |
|---|---|---|
| Retry with backoff | Transient failures | Exponential backoff, max 3 retries |
| Circuit breaker | Repeated failures | Open after N failures, half-open after 30s |
| Fallback agent | Primary unavailable | Route to backup with same capabilities |
| Graceful degradation | Partial system failure | Return `PartialResult` with explicit `quality` flag |
| Dead letter queue | Unprocessable tasks | Log + store for manual review |

**Critical rules**: retries only for *transient* failures (never auth, validation, schema); fallback agent must have same capabilities (else quality silently degrades — always log fallback rate); graceful degradation must surface `quality: "partial"` — never paper over failure; DLQ catches what would otherwise be silently dropped.

Full implementation sketches: [`references/validation-and-troubleshooting.md`](references/validation-and-troubleshooting.md#error-handling-patterns--implementation).

---

## Memory Sharing

**In-process** (single run): `AgentMemoryStore` with global vs private namespaces. Always log `written_by` on global writes. Never read another agent's private namespace.

**Cross-session** (operator's environment): use the Memory MCP server.

```
mcp__memory__create_entities    → Store shared knowledge
mcp__memory__create_relations   → Link agent findings
mcp__memory__search_nodes       → Query across agent outputs
mcp__memory__add_observations   → Append agent discoveries
```

In-process store code: [`references/coordination-examples.md`](references/coordination-examples.md#memory-sharing).

---

## Anti-Patterns

| Anti-Pattern | Problem | Solution |
|---|---|---|
| **God Agent** | One agent doing everything | Decompose into specialists + Router |
| **Chatty Agents** | Excessive inter-agent traffic | Batch messages; introduce aggregator; pass summaries |
| **Circular Dependencies** | A waits for B, B waits for A → deadlock | DAG-based task ordering; reject cycles at planning |
| **No Timeout** | Agent hangs indefinitely | Timeouts at every level (agent, tool, network, round) |
| **Shared Mutable State** | Race conditions | Use locks (`SharedState`) or message passing |
| **No Observability** | Can't debug agent interactions | Propagate `trace_id`; structured logging per agent |

Detection criteria + remediation detail for each: [`references/validation-and-troubleshooting.md`](references/validation-and-troubleshooting.md#anti-pattern-rationale).

---

## Output Expectations

When invoked, this skill produces:

- A recommended pattern (or composition) from the Pattern Selection Guide.
- Concrete coordination choices: communication mechanism, delegation strategy, conflict-resolution strategy, error-handling pattern.
- Lifecycle and health-monitoring spec (timeouts, heartbeat intervals, recovery actions).
- `trace_id` propagation plan across the agent chain.
- Anti-pattern audit: which anti-patterns the proposed design risks and how it mitigates them.
- For authority-gated actions in the operator's environment: explicit PolicyGate tier classification.

---

## Integration with the Operator's Environment

| Component | Role |
|---|---|
| CoreMind AgentCoordinator | SEC-001 guard: all agent execution flows through coordinator |
| CoreMind GAOS PolicyGate | 4-tier authorization: ALLOW / REVIEW / ESCALATE / BLOCK |
| CoreMind DelegationContract | Immutable contracts: agents cannot modify their own authority |
| `/sc:spawn` command | Task orchestration with status protocol |
| `subagent-development` skill | Subagent-driven development patterns |
| `memory` MCP server | Persistent state across agent sessions |

End-to-end scenarios showing how these compose: [`references/examples.md`](references/examples.md).

---

## Cross-references

- **subagent-development** skill — Claude Code subagent lifecycle.
- **AI_AGENT_LANDSCAPE.md** — framework comparison (AG2, Parlant, LiveKit, etc.).
- **CoreMind GAOS** — governed agent execution patterns.
- **SECURITY_PLAYBOOK.md** Rules 15–20 — agent security controls.

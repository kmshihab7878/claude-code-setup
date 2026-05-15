# End-to-End Examples — Multi-Agent Scenarios

Worked scenarios combining multiple patterns. Each example shows pattern choice, communication, delegation, and validation in context.

## Example 1: Research → Synthesis → Critique pipeline

**Goal**: produce a high-quality summary of a complex topic.

**Patterns used**: Plan-and-Execute (top-level) + Orchestrator-Workers (research fan-out) + Critic-Executor (quality loop).

```python
# 1. Plan-and-Execute decomposes the goal
plan = [
    PlanStep("gather sources", agent="researcher", dependencies=[]),
    PlanStep("extract claims", agent="extractor", dependencies=[0]),
    PlanStep("synthesize summary", agent="synthesizer", dependencies=[1]),
    PlanStep("critique + revise", agent="critic_executor", dependencies=[2]),
]

# 2. Researcher uses Supervisor fan-out to query N sources in parallel
supervisor = Supervisor(["arxiv_agent", "github_agent", "blog_agent"])
sources = await supervisor.fan_out([{"query": topic}] * 3)

# 3. Critic-Executor iterates until quality threshold
critic_executor = CriticExecutor()
final = await critic_executor.run(
    task="synthesize summary",
    max_iterations=3,
    quality_threshold=0.85
)
```

**Validation checks**:

- Every message carries `trace_id` so the chain is reconstructable.
- `Supervisor.fan_out` has per-agent timeouts; failures degrade gracefully (return `PartialResult` with completed sources).
- `CriticExecutor` caps iterations to bound cost.

## Example 2: Real-time conversational agent with tool use

**Goal**: voice agent that can search a knowledge base and book appointments.

**Patterns used**: Real-time Agent + Tool-Use (ReAct) + Router.

```python
class ConversationalAgent(RealtimeAgent):
    def __init__(self):
        self.router = AgentRouter([
            AgentProfile("kb_search", "knowledge base", ["search"]),
            AgentProfile("calendar", "appointments", ["book", "reschedule"]),
        ])
        self.react = ReActAgent(tools={
            "search_kb": search_kb,
            "book_appointment": book_appointment,
        })

    async def on_text_input(self, text: str) -> str:
        # Router decides: knowledge query vs action
        agent = await self.router.route(text)
        if agent.name == "kb_search":
            return await self.react.solve(text)
        return await self.calendar_agent.handle(text)
```

**Latency budget**: total response ≤ 500ms. ReAct loop is bounded at 3 steps for real-time use; if more steps needed, hand off to async deeper-research agent and reply with "I'll get back to you in a moment".

## Example 3: Critical decision with arbitration

**Goal**: classify a content piece as policy-violating; high stakes (account suspension).

**Patterns used**: Debate + Arbitration (conflict resolution).

```python
debate = DebateSystem()
result = await debate.debate(
    question="Does this content violate policy section 3?",
    positions=["violates", "does_not_violate", "ambiguous"],
    rounds=2,
)

if result["margin"] < 0.3:
    # Close call — arbitrate
    decision = await arbiter_agent.decide(
        question=result["question"],
        arguments=result["arguments"]
    )
else:
    decision = result["winner"]
```

**Auditability**: every argument, every vote, the arbiter's reasoning — all logged with `trace_id`. Required for compliance review.

## Example 4: Hierarchical delegation with PolicyGate

**Goal**: agent needs to perform a Tier-3 action (production deploy).

**Patterns used**: Hierarchical Delegation + Authority handoff.

```python
# Worker agent attempts action
result = await coremind.execute(
    agent="deploy_worker",
    action="deploy_to_production",
    request={...}
)

# CoreMind PolicyGate intercepts: action is Tier-3
if result.policy_decision == "ESCALATE":
    # Hand off to executive agent for approval
    approval = await coremind.escalate(
        from_agent="deploy_worker",
        to_agent="release_executive",
        action=result.action,
        context=result.context,
    )
    if approval.granted:
        result = await coremind.execute(
            agent="deploy_worker",
            action="deploy_to_production",
            request={..., "approval_token": approval.token},
        )
```

**Authority discipline**: `deploy_worker` cannot modify its own authority. Escalation produces an immutable `DelegationContract` and a single-use `approval_token`. PolicyGate verifies the token on the second execute call.

## Example 5: Swarm exploration with shared memory

**Goal**: explore a large search space (e.g., hyperparameter optimization).

**Patterns used**: Swarm + Shared Memory Store + Memory MCP.

```python
memory = AgentMemoryStore()
swarm = [SearchAgent(id=f"explorer_{i}") for i in range(50)]

# Each explorer reads best-known from global memory, samples nearby, reports back
async def explore(agent):
    while not converged():
        best = await memory.read_global("best_candidate")
        candidate = agent.sample_near(best)
        score = await evaluate(candidate)
        if score > best["score"]:
            await memory.write_global("best_candidate", {"value": candidate, "score": score}, agent.id)

await asyncio.gather(*[explore(a) for a in swarm])

# Persist final findings to Memory MCP for future runs
await mcp__memory__create_entities(...)
```

**Coordination discipline**: no central scheduler — agents coordinate purely via the shared memory store. Provenance (`written_by`) lets you trace which explorer found the winning candidate.

## Pattern Composition Cheatsheet

| Composite need | Pattern stack |
|---|---|
| High-quality output for complex task | Plan-and-Execute → Supervisor (fan-out) → Critic-Executor |
| Voice agent with tools | Real-time Agent → Router → ReAct |
| High-stakes decision | Debate → Arbitration |
| Authority-gated action | Hierarchical Delegation → PolicyGate |
| Distributed search | Swarm + Shared Memory Store + Memory MCP |
| Long-running workflow | Plan-and-Execute + Supervisor + Dead Letter Queue + Memory MCP |
| Negotiation between equals | Peer-to-Peer + Voting / Consensus |

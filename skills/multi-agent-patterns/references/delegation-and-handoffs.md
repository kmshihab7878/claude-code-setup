# Delegation and Handoffs

Detailed task-delegation strategies, conversation control, and conflict-resolution. The decision tables live in `SKILL.md`.

## Capability-Based Delegation

```python
@dataclass
class AgentCapability:
    agent_id: str
    skills: set[str]
    max_concurrent: int
    current_load: int

def select_agent(
    task_requirements: set[str],
    agents: list[AgentCapability],
) -> AgentCapability | None:
    candidates = [
        a for a in agents
        if task_requirements.issubset(a.skills) and a.current_load < a.max_concurrent
    ]
    if not candidates:
        return None
    return min(candidates, key=lambda a: a.current_load)
```

**Selection rule**: filter by skill match + load capacity, then pick the least-loaded candidate. If none qualifies, return `None` and escalate — never silently route to an over-loaded or under-skilled agent.

## Round-Robin Delegation

```python
class RoundRobinDispatcher:
    def __init__(self, agents: list[str]) -> None:
        self.agents = agents
        self._cursor = 0

    def next_agent(self) -> str:
        agent = self.agents[self._cursor]
        self._cursor = (self._cursor + 1) % len(self.agents)
        return agent
```

Use only for homogeneous agents — when every agent has identical capability and load behavior.

## Auction-Based Delegation

```python
@dataclass
class Bid:
    agent_id: str
    confidence: float       # 0-1: how well-suited the agent thinks it is
    estimated_duration_ms: float
    current_load: float

async def auction(task: dict, agents: list[str]) -> str:
    bids = await asyncio.gather(*[
        agent.bid(task) for agent in agents
    ])
    # Pick highest-confidence agent with reasonable load
    eligible = [b for b in bids if b.current_load < 0.8]
    return max(eligible, key=lambda b: b.confidence).agent_id
```

Auction handles dynamic load balancing — agents self-assess and bid; supervisor picks the strongest claim within load limits.

## Conversation Control — Behavioral Guardrails

```python
@dataclass
class ConversationPolicy:
    max_turns: int = 50
    allowed_topics: set[str] = field(default_factory=set)
    blocked_patterns: list[str] = field(default_factory=list)
    escalation_triggers: list[str] = field(default_factory=list)
    tone: str = "professional"

    def check_message(self, message: str) -> tuple[bool, str]:
        for pattern in self.blocked_patterns:
            if pattern.lower() in message.lower():
                return False, f"Blocked pattern: {pattern}"
        return True, "ok"
```

**Operating rule**: every multi-agent conversation runs under a `ConversationPolicy`. Blocked patterns short-circuit the message before it reaches downstream agents. Escalation triggers route up the hierarchy rather than continuing the current loop.

## Conflict Resolution — strategy detail

| Strategy | Mechanism | Example use |
|---|---|---|
| **Voting** | Each agent casts one vote; majority wins | Equal-authority agent ensemble making a classification decision |
| **Priority** | Pre-defined rank order; higher rank wins | Hierarchical orgs where a manager agent overrides workers |
| **Consensus** | All must agree; otherwise escalate | Critical decisions where partial agreement is unsafe |
| **Arbitration** | Independent third-party agent decides | Deadlocked two-agent debates |
| **Evidence-weighted** | Agent with strongest evidence wins | Data-driven decisions where signal quality varies |

Pick by:

- **Stakes**: low-stakes routine → voting; high-stakes irreversible → consensus or arbitration.
- **Authority distribution**: flat → voting / evidence-weighted; hierarchical → priority.
- **Time pressure**: synchronous tight loops → priority; async deliberation → consensus.
- **Auditability**: regulated decisions → evidence-weighted (logged) or arbitration (third party).

## Handoff Discipline

When an agent hands work to another:

1. **Trace ID propagates** — every message carries the originating `trace_id` so the chain is reconstructable.
2. **Context summary** — the handing-off agent writes a one-paragraph summary of decisions made so far; the receiving agent does not have to re-read the entire history.
3. **Authority is explicit** — the handing-off agent declares whether the receiver is `consulted` (informational), `delegated` (decision authority), or `escalated` (authority required from above).
4. **No silent fail-back** — if the receiver can't accept, surface the rejection; don't loop work back through the original agent without acknowledgment.
5. **Timeouts at every hop** — every handoff has a deadline; expired handoffs go to a dead-letter queue, not silent stall.

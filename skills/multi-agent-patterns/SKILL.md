---
name: multi-agent-patterns
description: >
  Design patterns for multi-agent AI systems. Supervisor, pipeline, swarm, and hierarchical
  patterns. Communication protocols, task delegation, lifecycle management, and conflict resolution.
  Use when designing new agent architectures, coordinating multiple agents, or orchestrating workflows.
risk: medium
tags: [agents, architecture]
created: 2026-03-07
updated: 2026-03-17
---

# Multi-Agent Patterns

Design patterns and orchestration infrastructure for building robust multi-agent AI systems.

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
- designing JARVIS GAOS workflows

## When NOT to use

Do NOT apply this skill when:
- building a single-agent system with no coordination needs
- the task is about Claude Code subagent spawning (use `subagent-development` skill)
- the task is about MCP server development (use `mcp-builder` skill)

---

## Pattern Catalog

### 1. Orchestrator-Workers (AG2/AutoGen style)
Central orchestrator manages conversation between specialized agents.

```python
@dataclass
class ConversationConfig:
    max_rounds: int = 10
    termination_condition: str = "TERMINATE"
    speaker_selection: str = "auto"  # auto, round_robin, manual

class GroupChat:
    """AG2-style group chat orchestration."""
    def __init__(
        self,
        agents: list[str],
        config: ConversationConfig,
    ) -> None:
        self.agents = agents
        self.config = config
        self.history: list[dict] = []

    async def run(self, initial_message: str) -> list[dict]:
        self.history.append({"role": "user", "content": initial_message})
        for round_num in range(self.config.max_rounds):
            speaker = await self._select_speaker(round_num)
            response = await self._get_response(speaker)
            self.history.append({"role": speaker, "content": response})
            if self.config.termination_condition in response:
                break
        return self.history
```

**When to use**: Tasks decomposable into independent subtasks, need centralized monitoring.
**Khaled's examples**: `/sc:spawn` (task orchestration), JARVIS AgentCoordinator (SEC-001).

### 2. Tool-Use Agent (ReAct Pattern)
Agent reasons about tool use in a loop: Thought → Action → Observation.

```python
class ReActAgent:
    """Reasoning + Acting agent loop."""
    def __init__(self, tools: dict[str, callable]) -> None:
        self.tools = tools
        self.scratchpad: list[str] = []

    async def solve(self, task: str, max_steps: int = 10) -> str:
        for step in range(max_steps):
            thought = await self._think(task, self.scratchpad)
            self.scratchpad.append(f"Thought: {thought}")
            if "FINISH" in thought:
                return self._extract_answer(thought)
            tool_call = await self._select_tool(thought)
            result = await self._execute_tool(tool_call)
            self.scratchpad.append(f"Action: {tool_call.tool_name}({tool_call.arguments})")
            self.scratchpad.append(f"Observation: {result}")
        return "Max steps reached"
```

### 3. Critic-Executor (Reflection Pattern)
One agent acts, another critiques, iterate until quality threshold.

```python
class CriticExecutor:
    async def run(self, task: str, max_iterations: int = 3, quality_threshold: float = 0.8) -> dict:
        result = await self._executor_generate(task)
        for iteration in range(max_iterations):
            critique = await self._critic_evaluate(task, result)
            if critique["score"] >= quality_threshold:
                return {"result": result, "score": critique["score"], "iterations": iteration + 1}
            result = await self._executor_revise(task, result, critique["feedback"])
        return {"result": result, "score": critique["score"], "iterations": max_iterations}
```

### 4. Router Pattern (Agent-Squad style)
Intelligent routing to specialized agents based on request classification.

```python
@dataclass
class AgentProfile:
    name: str
    description: str
    capabilities: list[str]
    priority: int = 0

class AgentRouter:
    def __init__(self, agents: list[AgentProfile]) -> None:
        self.agents = agents

    async def route(self, request: str) -> AgentProfile:
        """Select the best agent using LLM classification."""
        ...

    async def handle(self, request: str) -> str:
        agent = await self.route(request)
        return await self._dispatch(agent, request)
```

### 5. Plan-and-Execute
Agent creates a plan, then executes steps with dependency ordering.

```python
@dataclass
class PlanStep:
    description: str
    agent: str
    dependencies: list[int]
    status: str = "pending"  # pending, running, completed, failed

class PlanAndExecute:
    async def run(self, goal: str) -> dict:
        plan = await self._create_plan(goal)
        for step in self._topological_sort(plan):
            if all(plan[dep].status == "completed" for dep in step.dependencies):
                step.status = "running"
                result = await self._execute_step(step)
                step.status = "completed" if result.success else "failed"
                if step.status == "failed":
                    plan = await self._replan(goal, plan, step)
        return {"goal": goal, "plan": plan, "status": "completed"}
```

### 6. Debate Pattern
Multiple agents argue positions, judge evaluates arguments.

```python
class DebateSystem:
    async def debate(self, question: str, positions: list[str], rounds: int = 3) -> dict:
        arguments: dict[str, list[str]] = {pos: [] for pos in positions}
        for round_num in range(rounds):
            for position in positions:
                arg = await self._argue(question, position, arguments, round_num)
                arguments[position].append(arg)
        return await self._judge(question, arguments)
```

### 7. Supervisor (Hub-and-Spoke)
One coordinator manages all worker agents with fan-out/aggregate.

```python
@dataclass
class SupervisorResult:
    agent_id: str
    status: str  # "success", "failed", "timeout"
    result: Any
    duration_ms: float

class Supervisor:
    def __init__(self, agents: list[str]) -> None:
        self.agents = agents
        self.results: dict[str, SupervisorResult] = {}

    async def fan_out(self, tasks: list[dict]) -> list[SupervisorResult]:
        """Distribute tasks across available agents."""
        ...

    async def aggregate(self, results: list[SupervisorResult]) -> Any:
        """Combine results from multiple agents."""
        ...
```

### 8. Peer-to-Peer (Mesh)
Agents communicate directly without central coordinator.

**When to use**: Collaborative problem-solving, negotiation, consensus.
**Caution**: Harder to debug, potential for deadlocks.

### 9. Hierarchical Delegation
Multi-level delegation tree with authority cascading.

**When to use**: Organization-like structures, authority-gated operations.
**Khaled's examples**: JARVIS executive suite, GAOS PolicyGate tiers.

### 10. Swarm Intelligence
Large group of simple agents with emergent collective behavior.

**When to use**: Search problems, optimization, exploration.
**Principles**: Local rules, no central control, information sharing via environment.

---

## Communication Protocols

### Message Passing
```python
from enum import Enum

class MessageType(Enum):
    REQUEST = "request"
    RESPONSE = "response"
    EVENT = "event"
    ERROR = "error"

@dataclass
class AgentMessage:
    sender: str
    receiver: str
    msg_type: MessageType
    payload: dict
    timestamp: datetime
    trace_id: str  # Correlate across agent chain
    reply_to: str | None = None
```

### Shared State
```python
class SharedState:
    """Thread-safe shared state for agent coordination."""
    def __init__(self) -> None:
        self._state: dict[str, Any] = {}
        self._lock = asyncio.Lock()
        self._subscribers: dict[str, list[callable]] = {}

    async def get(self, key: str) -> Any:
        async with self._lock:
            return self._state.get(key)

    async def set(self, key: str, value: Any) -> None:
        async with self._lock:
            self._state[key] = value
        await self._notify(key, value)
```

### Event Bus
```python
class EventBus:
    def __init__(self) -> None:
        self._handlers: dict[str, list[callable]] = {}

    def subscribe(self, event_type: str, handler: callable) -> None:
        self._handlers.setdefault(event_type, []).append(handler)

    async def publish(self, event_type: str, data: dict) -> None:
        for handler in self._handlers.get(event_type, []):
            await handler(data)
```

---

## Task Delegation Strategies

| Strategy | Description | Best For |
|----------|-------------|----------|
| Round-robin | Distribute evenly across agents | Homogeneous agents |
| Capability-based | Match task requirements to agent skills | Heterogeneous agents |
| Auction | Agents bid on tasks | Dynamic load balancing |
| Priority queue | High-priority tasks first | Critical path workflows |
| Affinity | Route related tasks to same agent | Context-dependent work |

### Capability-Based Delegation
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

---

## Agent Lifecycle Management

### States
```
CREATED → INITIALIZING → READY → RUNNING → COMPLETED
                                    ↓           ↓
                                  ERROR    TERMINATED
                                    ↓
                                 RETRYING
```

### Health Monitoring
```python
@dataclass
class AgentHealth:
    agent_id: str
    status: str
    last_heartbeat: datetime
    tasks_completed: int
    tasks_failed: int
    avg_response_ms: float
    memory_usage_mb: float
    error_rate: float  # last 100 tasks
```

---

## Conversation Control

### Behavioral Guardrails
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

---

## Conflict Resolution

| Strategy | When | How |
|----------|------|-----|
| Voting | Equal-authority agents | Majority wins |
| Priority | Hierarchical authority | Higher-rank agent wins |
| Consensus | Collaborative decisions | All must agree or escalate |
| Arbitration | Deadlocked agents | Third-party agent decides |
| Evidence-weighted | Data-driven decisions | Agent with best evidence wins |

---

## Error Handling Patterns

| Pattern | When | Implementation |
|---------|------|---------------|
| Retry with backoff | Transient failures | Exponential backoff, max 3 retries |
| Circuit breaker | Repeated failures | Open after 5 failures, half-open after 30s |
| Fallback agent | Primary unavailable | Route to backup with same capabilities |
| Graceful degradation | Partial system failure | Return partial results with quality flag |
| Dead letter queue | Unprocessable tasks | Log and store for manual review |

---

## Memory Sharing

### Shared Memory Store
```python
class AgentMemoryStore:
    """Shared memory with namespace isolation."""
    def __init__(self) -> None:
        self._global: dict = {}
        self._private: dict[str, dict] = {}

    async def write_global(self, key: str, value: Any, agent_id: str) -> None:
        self._global[key] = {"value": value, "written_by": agent_id}

    async def read_private(self, agent_id: str, key: str) -> Any:
        return self._private.get(agent_id, {}).get(key)
```

### Integration with Memory MCP
```
mcp__memory__create_entities → Store shared knowledge
mcp__memory__create_relations → Link agent findings
mcp__memory__search_nodes    → Query across agent outputs
mcp__memory__add_observations → Append agent discoveries
```

---

## Real-Time Agent Patterns (LiveKit concepts)

```python
@dataclass
class RealtimeAgentConfig:
    sample_rate: int = 16000
    vad_threshold: float = 0.5
    response_latency_ms: int = 500
    turn_detection: str = "server_vad"

class RealtimeAgent:
    async def on_audio_frame(self, frame: bytes) -> bytes | None: ...
    async def on_text_input(self, text: str) -> str: ...
```

---

## Anti-Patterns

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| God Agent | Single agent doing everything | Decompose into specialists |
| Chatty Agents | Excessive inter-agent communication | Batch messages, reduce coupling |
| Circular Dependencies | Agent A waits for B, B waits for A | DAG-based task ordering |
| No Timeout | Agent hangs indefinitely | Timeouts at every level |
| Shared Mutable State | Race conditions | Use locks or message passing |
| No Observability | Can't debug agent interactions | Trace IDs, structured logging |

---

## Pattern Selection Guide

| Scenario | Recommended Pattern |
|----------|-------------------|
| Independent subtasks | Orchestrator-Workers or Supervisor |
| Sequential processing | Pipeline |
| Quality-critical output | Critic-Executor |
| Request classification | Router |
| Complex multi-step goals | Plan-and-Execute |
| Controversial decisions | Debate |
| Exploration/search | Swarm |
| Real-time interaction | Real-time Agent |
| Organization hierarchy | Hierarchical Delegation |
| Collaborative reasoning | Peer-to-Peer |

---

## Integration with Khaled's Environment

| Component | Role |
|-----------|------|
| JARVIS AgentCoordinator | SEC-001 guard: all agent execution flows through coordinator |
| JARVIS GAOS PolicyGate | 4-tier authorization: ALLOW/REVIEW/ESCALATE/BLOCK |
| JARVIS DelegationContract | Immutable contracts: agents cannot modify their own authority |
| `/sc:spawn` command | Task orchestration with status protocol |
| `subagent-development` skill | Subagent-driven development patterns |
| `memory` MCP server | Persistent state across agent sessions |

## Cross-references

- **subagent-development** skill (KhaledPowers): Claude Code subagent lifecycle
- **AI_AGENT_LANDSCAPE.md**: Framework comparison (AG2, Parlant, LiveKit, etc.)
- **JARVIS GAOS**: Governed agent execution patterns
- **SECURITY_PLAYBOOK.md** Rules 15-20: Agent security controls

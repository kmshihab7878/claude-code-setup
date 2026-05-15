# Orchestration Patterns — Full Catalog

Full Python implementations of the 10 multi-agent orchestration patterns. The minimal decision table lives in `SKILL.md`.

## 1. Orchestrator-Workers (AG2 / AutoGen style)

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

**When to use**: tasks decomposable into independent subtasks, need centralized monitoring.
**Operator examples**: `/sc:spawn` (task orchestration), CoreMind AgentCoordinator (SEC-001).

## 2. Tool-Use Agent (ReAct Pattern)

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

## 3. Critic-Executor (Reflection Pattern)

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

## 4. Router Pattern (Agent-Squad style)

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

## 5. Plan-and-Execute

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

## 6. Debate Pattern

Multiple agents argue positions, a judge evaluates arguments.

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

## 7. Supervisor (Hub-and-Spoke)

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

## 8. Peer-to-Peer (Mesh)

Agents communicate directly without a central coordinator.

**When to use**: collaborative problem-solving, negotiation, consensus.
**Caution**: harder to debug, potential for deadlocks. Mitigate with timeouts at every level and trace IDs across the mesh.

## 9. Hierarchical Delegation

Multi-level delegation tree with authority cascading.

**When to use**: organization-like structures, authority-gated operations.
**Operator examples**: CoreMind executive suite, GAOS PolicyGate tiers.

## 10. Swarm Intelligence

Large group of simple agents with emergent collective behavior.

**When to use**: search problems, optimization, exploration.
**Principles**: local rules, no central control, information sharing via environment.

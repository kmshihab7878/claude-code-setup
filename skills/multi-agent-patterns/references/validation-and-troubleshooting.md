# Validation and Troubleshooting

Detailed rationale for anti-patterns, error-handling implementations, and debugging recipes for multi-agent systems.

## Anti-Pattern Rationale

The decision table lives in `SKILL.md`; this section explains *why* each anti-pattern is harmful and how to detect it.

### God Agent

**Symptom**: one agent has 10+ skills, takes every kind of task, and is on the critical path for everything.

**Why harmful**: violates single-responsibility; agent context becomes incoherent; a single bug or model regression takes down all downstream work; impossible to specialize prompts.

**Detection**: skill list > ~5 capabilities; agent appears in >50% of trace IDs; agent prompt > 4K tokens of role description.

**Solution**: decompose into specialists. Use a Router pattern (see [orchestration-patterns.md](orchestration-patterns.md#4-router-pattern-agent-squad-style)) to direct requests to the right specialist.

### Chatty Agents

**Symptom**: trace IDs show 50+ messages between two agents for what should be a single decision.

**Why harmful**: linear blow-up of token cost and latency; surfaces tight coupling that makes refactoring hard.

**Detection**: median messages per task > 10; same pair of agents accounts for > 30% of all messages.

**Solution**: batch messages; introduce a coordinator agent that aggregates before forwarding; reduce shared context by passing summaries instead of full history.

### Circular Dependencies

**Symptom**: agent A waits for B's output; B waits for A's output. System hangs.

**Why harmful**: deadlock — neither agent progresses, no error surfaces unless timeouts fire.

**Detection**: trace ID with no terminal message past the configured timeout; dependency graph contains a cycle.

**Solution**: enforce DAG-based task ordering. Reject any plan that introduces cycles at planning time. Use topological sort in Plan-and-Execute (see [orchestration-patterns.md](orchestration-patterns.md#5-plan-and-execute)).

### No Timeout

**Symptom**: an agent hangs and no recovery fires.

**Why harmful**: blocks the entire chain; resources stay allocated; no observable error.

**Detection**: any `await` on an agent call without a `timeout` parameter; trace IDs older than expected SLA still marked "running".

**Solution**: timeouts at every level — agent call, tool call, network hop, conversation round. When a timeout fires, trigger one of the error-handling patterns below.

### Shared Mutable State

**Symptom**: occasional incorrect results that don't reproduce under single-agent testing.

**Why harmful**: race conditions; non-deterministic; hardest class of bug to track down.

**Detection**: shared `dict` / `list` mutated by multiple agents without a lock; intermittent test failures under concurrent load.

**Solution**: use the locked `SharedState` from [coordination-examples.md](coordination-examples.md#shared-state) or message passing exclusively. If you find yourself adding "just a check" to handle races, you've already lost — use the lock.

### No Observability

**Symptom**: can't tell what's happening when multi-agent flow misbehaves.

**Why harmful**: debugging time scales with chain length; production incidents require code-spelunking rather than log-reading.

**Detection**: no `trace_id` in messages; logs are agent-local with no chain-level view.

**Solution**: trace IDs propagated through every message; structured logging with `agent_id`, `trace_id`, `phase`, `decision`; aggregate logs by `trace_id` for the cross-agent view.

## Error-Handling Patterns — Implementation

The decision table lives in `SKILL.md`. Below are sketch implementations.

### Retry with Exponential Backoff

```python
async def call_with_retry(fn, *, max_retries: int = 3, base_delay: float = 0.5):
    for attempt in range(max_retries):
        try:
            return await fn()
        except TransientError as e:
            if attempt == max_retries - 1:
                raise
            await asyncio.sleep(base_delay * (2 ** attempt))
```

Apply to **transient** failures only — network timeouts, rate limits with `Retry-After`. Never retry on validation errors or auth failures — those will keep failing.

### Circuit Breaker

```python
class CircuitBreaker:
    def __init__(self, failure_threshold: int = 5, recovery_timeout: float = 30.0) -> None:
        self.failure_count = 0
        self.failure_threshold = failure_threshold
        self.recovery_timeout = recovery_timeout
        self.state = "closed"  # closed, open, half-open
        self.opened_at: float | None = None

    async def call(self, fn):
        if self.state == "open":
            if time.monotonic() - self.opened_at > self.recovery_timeout:
                self.state = "half-open"
            else:
                raise CircuitOpenError()
        try:
            result = await fn()
            self.failure_count = 0
            self.state = "closed"
            return result
        except Exception:
            self.failure_count += 1
            if self.failure_count >= self.failure_threshold:
                self.state = "open"
                self.opened_at = time.monotonic()
            raise
```

Apply per-agent or per-tool — when an external service is degrading, the breaker prevents cascading failures and gives the service time to recover.

### Fallback Agent

```python
async def call_with_fallback(primary, fallback, request):
    try:
        return await primary.handle(request)
    except (TimeoutError, AgentUnavailableError):
        return await fallback.handle(request)
```

Fallback must have the **same capabilities** as the primary — otherwise quality silently degrades. Log every fallback so degradation is visible.

### Graceful Degradation

When a subset of agents fail, return partial results with an explicit quality flag rather than failing the whole chain.

```python
@dataclass
class PartialResult:
    data: dict
    completed_agents: list[str]
    failed_agents: list[str]
    quality: str  # "complete", "partial", "degraded"
```

Consumers must check `quality` before acting on the data. Don't paper over partial failure — surface it.

### Dead Letter Queue

```python
async def dispatch_with_dlq(task, agent, dlq):
    try:
        return await agent.handle(task)
    except UnprocessableTaskError as e:
        await dlq.send({"task": task, "agent": agent.id, "error": str(e), "timestamp": datetime.utcnow()})
        return None
```

Tasks that can't be processed go to a queue for human review. Never silently drop a task.

## Debugging Recipes

| Symptom | First check | Likely cause |
|---|---|---|
| Chain hangs past SLA | Search logs for `trace_id` with no terminal message | Missing timeout, deadlock, or circular dependency |
| Intermittent wrong results | Check for shared mutable state without locks | Race condition under concurrent load |
| Costs ballooning | Histogram of messages per `trace_id` | Chatty-agents anti-pattern; bring in an aggregator |
| Quality dropping | Inspect fallback rate | Primary agent degrading; alert on fallback-rate > 5% |
| Single agent dominates traces | Agent appears in > 50% of trace IDs | God-agent anti-pattern; refactor with Router |
| Agent context > 4K tokens | Inspect prompt + accumulated scratchpad | Lacks summarization between handoffs |
| Recovery never fires | Search for `await` without `timeout=` | No-timeout anti-pattern |
| Two agents loop indefinitely | DAG check on plan | Circular dependency in Plan-and-Execute |

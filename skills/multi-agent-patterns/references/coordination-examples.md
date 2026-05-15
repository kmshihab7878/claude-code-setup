# Coordination Examples — Communication, Memory, Lifecycle, Real-Time

Full Python implementations of communication protocols, memory store, lifecycle health, and real-time agent patterns. The minimal summaries live in `SKILL.md`.

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

**Trace ID rule**: every message in a multi-agent chain carries the same `trace_id` so the entire interaction is reconstructable in logs. Generate at the entry point, propagate verbatim.

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

Use the lock around every read/write. Skipping it produces race conditions that look intermittent and surface only under concurrent load — the worst class of bug to debug.

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

Decouples publishers from subscribers — good for fan-out notifications. Pair with `trace_id` in event payloads so the chain is followable.

## Agent Lifecycle — Health Monitoring

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

**State machine**:

```
CREATED → INITIALIZING → READY → RUNNING → COMPLETED
                                    ↓           ↓
                                  ERROR    TERMINATED
                                    ↓
                                 RETRYING
```

Heartbeats interval should be ≤ 1/3 of the timeout window. If heartbeat misses 3 in a row, mark the agent as ERROR and trigger the configured recovery (retry / fallback / terminate).

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

**Namespace discipline**:

- **Global** scope is for explicitly shared knowledge. Always log `written_by` so consumers can trace provenance.
- **Private** scope is per-agent scratch space — never read another agent's private namespace.
- Don't accidentally promote private state to global by writing it under a shared key. Use explicit `write_global` / `write_private` APIs.

### Integration with Memory MCP

```
mcp__memory__create_entities    → Store shared knowledge
mcp__memory__create_relations   → Link agent findings
mcp__memory__search_nodes       → Query across agent outputs
mcp__memory__add_observations   → Append agent discoveries
```

When working in the operator's environment, prefer the Memory MCP server for cross-session persistence. In-process `AgentMemoryStore` is for within-run coordination only.

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

**Latency budget rules**: Total response latency for conversational agents must stay under ~500ms perceived. Allocate: ~50ms VAD, ~100ms ASR, ~200–300ms LLM, ~50ms TTS, ~50ms network. If the LLM step exceeds budget, stream tokens or switch to a smaller model — don't let one slow agent block the chain.

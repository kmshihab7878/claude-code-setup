# AI Agent Framework Landscape

> Comparison of agent frameworks and architecture patterns
> Covers: AG2, Parlant, LiveKit, Agent-Squad, AutoAgent, and more
> Compiled: 2026-03-15

---

## Framework Comparison Matrix

| Framework | Language | Multi-Agent | Real-Time | Open Source | Key Strength |
|-----------|----------|-------------|-----------|-------------|--------------|
| **AG2** (AutoGen) | Python | Yes | No | Yes (Apache-2.0) | Conversational agents, group chat |
| **Parlant** | Python | Yes | No | Yes | Conversation control, guardrails |
| **LiveKit Agents** | Python/JS | No | Yes | Yes (Apache-2.0) | Voice/video AI agents |
| **Agent-Squad** (AWS) | Python/TS | Yes | No | Yes (Apache-2.0) | Intelligent routing, AWS integration |
| **AutoAgent** | Python | Yes | No | Yes | Automatic agent generation |
| **LangGraph** | Python/JS | Yes | No | Yes | Stateful graph workflows |
| **CrewAI** | Python | Yes | No | Yes | Role-based agent teams |
| **Semantic Kernel** | C#/Python | Yes | No | Yes (MIT) | Microsoft ecosystem |
| **Haystack** | Python | No | No | Yes (Apache-2.0) | RAG pipelines |
| **Claude Code** | Built-in | Yes (agents/) | No | N/A | Native, no setup needed |

---

## Framework Deep Dives

### AG2 (formerly AutoGen)

**Architecture**: Multi-agent conversation framework from Microsoft Research.

```
┌──────────────────────────────────────┐
│          GroupChatManager            │
│  ┌─────────┐ ┌─────────┐ ┌───────┐ │
│  │Assistant│ │  Coder  │ │Critic │ │
│  └─────────┘ └─────────┘ └───────┘ │
│       Shared conversation history    │
└──────────────────────────────────────┘
```

**Key Concepts**:
- **ConversableAgent**: Base agent class with LLM + tool use
- **GroupChat**: Multi-agent conversations with speaker selection
- **UserProxy**: Human-in-the-loop agent
- **Code execution**: Built-in Docker sandboxing for generated code
- **Nested chats**: Agents can spawn sub-conversations

**When to Use**: Complex reasoning requiring multiple perspectives, code generation with review.

### Parlant

**Architecture**: Conversational AI control layer — focuses on making agent behavior predictable and safe.

**Key Concepts**:
- **Behavioral guidelines**: Define how agents should behave (tone, topics, limits)
- **Conversation engine**: Manages multi-turn interactions with state
- **Guardrails**: Prevent off-topic, harmful, or incorrect responses
- **Event system**: Hook into conversation lifecycle

**When to Use**: Customer-facing agents, compliance-heavy scenarios, agents needing behavioral constraints.

**Relevance to Khaled**: Parallels JARVIS GAOS PolicyGate and conversation control patterns.

### LiveKit Agents

**Architecture**: Framework for building real-time AI agents that interact via voice and video.

```
┌──────────┐   WebRTC    ┌──────────────┐
│  User    │◄───────────►│ LiveKit Room  │
│(browser) │             │  ┌─────────┐  │
└──────────┘             │  │AI Agent │  │
                         │  └─────────┘  │
                         └──────────────┘
```

**Key Concepts**:
- **VoicePipelineAgent**: STT → LLM → TTS pipeline
- **MultimodalAgent**: Process audio + video simultaneously
- **Turn detection**: Server-side VAD for natural conversations
- **Plugin system**: Deepgram, OpenAI, ElevenLabs integrations

**When to Use**: Voice assistants, video AI, real-time customer support.

### Agent-Squad (AWS)

**Architecture**: AWS multi-agent orchestration with intelligent routing.

**Key Concepts**:
- **Orchestrator**: Routes requests to specialized agents
- **Agent classification**: LLM-based intent → agent matching
- **Conversation memory**: Shared context across agents
- **AWS integration**: Lambda, Bedrock, DynamoDB

**When to Use**: AWS-native applications, request routing across specialized agents.

**Relevance to Khaled**: Router pattern similar to JARVIS DelegationEngine.

---

## Architecture Patterns

### Pattern Comparison

| Pattern | Agents | Communication | Best For |
|---------|--------|--------------|----------|
| Supervisor | 1 coordinator + N workers | Hub-and-spoke | Decomposable tasks |
| Pipeline | N sequential stages | Chain | Multi-stage processing |
| Group Chat | N conversational peers | Broadcast | Collaborative reasoning |
| Router | 1 router + N specialists | Request/response | Intent classification |
| Debate | N arguers + 1 judge | Structured turns | Decision quality |
| Swarm | Many simple agents | Environment | Exploration, optimization |
| Hierarchical | Multi-level tree | Delegation | Organization-like structures |

### ASCII Architecture: JARVIS Mapping

```
JARVIS GAOS Architecture (Khaled's)
═══════════════════════════════════

                  ┌──────────────┐
                  │   CoreMind   │ ← Supervisor pattern
                  │ (Orchestrator)│
                  └──────┬───────┘
                         │
              ┌──────────┼──────────┐
              │          │          │
        ┌─────▼────┐ ┌──▼───┐ ┌───▼────┐
        │ Planner  │ │Intent│ │Delegat-│
        │          │ │Parser│ │  ion   │ ← Pipeline pattern
        └──────────┘ └──────┘ └───┬────┘
                                  │
                    ┌─────────────┼─────────────┐
                    │             │             │
              ┌─────▼───┐  ┌────▼────┐  ┌────▼────┐
              │ Agent A  │  │Agent B  │  │Agent C  │ ← Workers
              │(specialist)│(specialist)│(specialist)│
              └──────────┘  └─────────┘  └─────────┘
                    │             │             │
              ┌─────▼─────────────▼─────────────▼─────┐
              │            GAOS Safety Stack           │ ← Guardrails (Parlant-like)
              │  Input→Policy→Sandbox→Output→Rollback  │
              └───────────────────────────────────────┘
```

---

## Integration Opportunities with Khaled's Setup

### Direct Integrations

| Framework | Integration Point | Effort | Value |
|-----------|------------------|--------|-------|
| AG2 | JARVIS multi-agent reasoning | High | High — group chat for complex decisions |
| Parlant | JARVIS conversation guardrails | Medium | Medium — behavioral control |
| LiveKit | JARVIS voice interface | High | Medium — voice commands |
| Agent-Squad | JARVIS routing logic | Low | High — routing pattern applicable |
| LangGraph | JARVIS workflow graphs | Medium | Medium — stateful workflows |

### Pattern Adoption (No Integration Needed)

| Pattern | From Framework | Apply To |
|---------|---------------|----------|
| Group chat with speaker selection | AG2 | Multi-agent brainstorming in JARVIS |
| Behavioral guidelines | Parlant | GAOS PolicyGate rule definitions |
| Real-time turn detection | LiveKit | Future voice interface |
| Intent-based routing | Agent-Squad | DelegationEngine enhancement |
| Automatic agent generation | AutoAgent | Agent scaffold generator |

---

## Notable Projects from 500-AI-Agents Catalog

### By Category

| Category | Notable Projects | Key Takeaway |
|----------|-----------------|--------------|
| Code Generation | Devin-like agents, SWE-agent | Task decomposition for coding |
| Research | STORM, GPT-Researcher | Multi-source synthesis |
| Business | Sales agents, customer support bots | CRM integration patterns |
| Creative | Story generators, design agents | Iterative refinement loops |
| Data | Data analysis agents, ETL agents | Schema-aware query generation |
| Security | Bug bounty agents, pen-test agents | Scope-limited autonomous testing |

---

## Agent Evaluation Criteria

### Quality Metrics

| Metric | Description | Measurement |
|--------|-------------|-------------|
| Task completion rate | % of tasks completed successfully | Auto-eval test suite |
| Response accuracy | Correctness of agent outputs | Human review sample |
| Latency | Time to complete tasks | P50, P95, P99 |
| Cost per task | LLM tokens + compute | Token counting |
| Safety violations | Policy breaches | Automated detection |
| User satisfaction | Subjective quality | User feedback |

---

## Cross-References

- **agent-orchestration** skill: Communication protocols, delegation patterns
- **multi-agent-patterns** skill: Design patterns (supervisor, pipeline, debate, etc.)
- **subagent-development** skill: Claude Code subagent lifecycle
- **JARVIS GAOS**: Governed agent architecture
- **SECURITY_PLAYBOOK.md** Rules 15-20: Agent security
- **CLAUDE_CODE_ARCHITECTURE.md** Section 4: 40 agent roster

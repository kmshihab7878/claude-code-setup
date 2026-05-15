# Coordination, Memory, and Handoffs

Stages 6, 7, 9, and 10 detail. Pair with `references/operating-model.md` for
the full pipeline.

## Stage 6: Delegation Engine

Route each plan step to the optimal agent.

### Selection algorithm (mirrors CoreMind DelegationEngine)

1. **Domain filter** — only agents in the step's domain.
2. **Authority filter** — agent authority ≥ required for the task.
3. **Capability filter** — agent has required MCP server bindings.
4. **Skill filter** — agent has relevant skills declared.
5. **Performance rank** — prefer agents with higher historical quality (if tracked).
6. **Fallback chain** — L2 → L3 → L5 → L6 within the domain.

### When the algorithm returns no candidate

- Surface the gap explicitly — do not silently relax a filter.
- Identify which filter eliminated all candidates.
- Propose:
  - escalating authority (Stage 2 re-entry), or
  - splitting the step into smaller sub-steps that fit available agents, or
  - declining the work with a clear explanation.

## Stage 7: Execution (GAOS)

Execute with governance enforcement.

1. **Capability check** — agent can only use its declared MCP servers.
2. **Sandbox** — timeout enforcement, resource quotas.
3. **Side-effect recording** — track all file changes, API calls, external interactions.
4. **Health monitoring** — if agent fails, route to fallback agent.
5. **Audit trail** — log every execution (agent, task, tools used, duration, outcome).

### Execution modes

| Mode | When | Notes |
|------|------|-------|
| Foreground | Result needed before next step | Dependent tasks; blocks the pipeline until done |
| Background | Independent / parallel tasks | Coordinated via the parallel groups in Stage 4 |
| Worktree | Conflicting file edits | Agent gets an isolated git copy; merge gates apply at the end |

### Parallel execution discipline

- Maximum 3 parallel subagents — wait before launching a fourth.
- Parallel groups in Stage 4's plan are advisory; runtime constraints
  (token budget, MCP throughput) can force serialization.
- Failures in a parallel group do not auto-abort siblings — siblings complete
  and the failure routes to Stage 8 reflection for next-step decisions.

## Handoff Discipline

Every step that hands work to another step or agent must:

1. **Propagate trace context** — every record carries the same `trace_id` for
   downstream observability.
2. **Provide a context summary** — the previous step's decision summary so the
   receiver does not have to re-derive context.
3. **Declare authority explicitly** — `consulted` (informational),
   `delegated` (decision authority), or `escalated` (authority required from above).
4. **Surface rejection** — if the receiver cannot accept, fail loudly; do not
   loop work back to the original step without acknowledgment.
5. **Time-bound every hop** — every handoff has a deadline; expired handoffs
   go to a dead-letter queue, not silent stall.

## Memory and Context Playbook

Memory is one of several persistence mechanisms; choose by horizon and purpose.

| Layer | Source of truth | Horizon | Used at stages |
|-------|-----------------|---------|----------------|
| Auto-memory | `memory/MEMORY.md` + typed files | Persistent, always-loaded | 1, 6, 8 |
| Semantic memory | `claude-mem` (SQLite + ChromaDB) | Persistent, queryable | 1, 3, 8 |
| Knowledge base | `kb/wiki/` | Curated, persistent | 1, 8 |
| Project memory | Per-project `MEMORY.md` | Per-project, always-loaded | 1, 6 |
| Session history | `~/.claude/history.jsonl` | Rolling | 8, 9 |
| Evolution records | `evolution/records/*.jsonl` | Gated (promotion gate) | 9, 10 |

### Rules of use

- Memory may guide, but current files and git state are **authoritative**.
- If memory conflicts with observation, trust observation and update memory.
- Do not persist code patterns, git history, or anything derivable from current state.
- Persist only what is non-obvious or non-derivable: user posture, project
  context, feedback patterns, external references.

## Outcome Tracking (Stage 9) — what to capture

For each Outcome record:

- Agent, task, quality score, duration.
- Tools and skills actually exercised (not just declared).
- Side effects: files changed, APIs called, external interactions.
- Success / failure with reason code.
- Lessons surfaced by Stage 8 reflection.

Outcome records feed:

- Performance ranking in Stage 6 (next time).
- Knowledge base / wiki ingestion (on promotion).
- Evolution records for self-improvement loops.

## World State Updates (Stage 10) — granularity

| Update type | Trigger | Storage |
|-------------|---------|---------|
| Resource pool | Token budget consumed | In-session counters |
| Goal status | Stage 9 success/failure | Goal ledger |
| Significant knowledge | Quality > 0.8 and novel | Auto-memory or KB |
| Agent health | Repeated success/failure | Agent performance registry |
| Risk register | New risk surfaced during execution | Local risk ledger |

Only "significant" knowledge crosses into persistent memory — the bar is
non-obvious + non-derivable + likely-reused.

# Core — Memory

> How this setup remembers. Three memory systems operate in parallel; each serves a different time horizon.

## Memory layers

| Layer | Storage | Horizon | Loaded how |
|-------|---------|---------|-----------|
| **Auto-memory (file-based)** | `memory/MEMORY.md` + `memory/*.md` | Persistent across sessions | Always-loaded (200-line cap on MEMORY.md index) |
| **Semantic memory (claude-mem)** | SQLite + ChromaDB via plugin | Persistent across sessions | On-demand via the plugin's search tools |
| **Knowledge base (wiki)** | `kb/wiki/*.md` | Persistent + curated | On-demand via `/wiki-query` or `understand-anything` |
| **Project memory** | Per-project `MEMORY.md` in each project root | Persistent per project | Always-loaded when in that project |
| **Session history** | `~/.claude/history.jsonl` + `memory/session-history.md` | Rolling | Written by hooks; loaded on request |
| **Evolution records** | `evolution/records/*.jsonl` + `evolution/candidates/*.yaml` | Persistent + gated | Injected at SessionStart (stable learnings only) |

## `memory/MEMORY.md` — the index

The hub index. One line per memory file, under ~150 characters each. Always-loaded. Lines past 200 are truncated by the harness, so it stays tight.

```
- [user-role](user-role.md) — short hook describing what's in the file
- [feedback-testing](feedback-testing.md) — another hook
```

Each memory file declares its own frontmatter:

```yaml
---
name: {memory name}
description: {one-line — used for relevance ranking}
type: user | feedback | project | reference
---
```

**Memory types:**

- **user** — who the user is, role, preferences, knowledge level
- **feedback** — guidance the user has given about approach (corrections AND validations)
- **project** — ongoing work, bugs, incidents, who's doing what
- **reference** — pointers to external systems (Linear, Slack channels, Grafana dashboards)

## What NOT to save

- Code patterns, conventions, architecture, file paths, project structure — derivable from current state
- Git history / who-changed-what — `git log` is authoritative
- Debugging solutions or fix recipes — the fix is in the code
- Anything already documented in `CLAUDE.md`
- Ephemeral task details — use tasks/plans, not memory

These exclusions apply even when the user asks to save them.

## Retrieval cadence

- **When memory is relevant** — when the user references prior-conversation work, or the task benefits from user/feedback/project context.
- **When the user explicitly asks** — "check memory", "remember when…", "what did we decide about X".
- **When the user says to ignore memory** — do not apply, cite, or mention stored facts.
- **Before recommending from memory** — verify the claim still holds against current repo state. Memory can go stale; files and `git log` are authoritative for current reality.

## Claude-mem integration

- **Plugin:** `claude-mem@thedotmack` (enabled in `settings.json`)
- **Storage:** SQLite + ChromaDB vector store
- **Access pattern:** semantic search across past sessions, not a key-value store
- **Cross-session search:** `/recall` skill invokes claude-mem + conversation grep
- **When to prefer claude-mem over `memory/`:** when searching for a concept that wasn't captured as an explicit memory, or when the exact wording has drifted

## Knowledge base (`kb/`)

Schema and operations live in `kb/CLAUDE.md`. Commands: `/wiki-ingest`, `/wiki-query`, `/wiki-lint`. KB is labeled **scaffold / pilot** per `docs/KB-STATUS.md`; exit criteria for "mature" status are 50+ confidence-0.8 articles and 4 weeks of clean lint.

## Session lifecycle hooks

| Event | Hook | Writes to |
|-------|------|-----------|
| SessionStart | `hooks/session-init.sh` | `memory/session-history.md` append |
| SessionStart | `hooks/evolution-startup.sh` | injects `evolution/stable/global.md` |
| Every tool call | `hooks/usage-logger.sh` | `~/.claude/usage.jsonl` |
| PostToolUse (Bash) | `hooks/session-metrics.sh` | metrics counters |
| SessionEnd | `hooks/evolution-sessionend.sh` | `evolution/records/sessions.jsonl` |
| Stop | `hooks/stop-verification.sh` | blocks Stop if uncommitted work |

## Authority

When recalled memory conflicts with current observation: **trust the observation, update the memory.** Memory records the state at write time; reality moves.

When a memory names a specific file, function, or flag: **verify before recommending.** Greppable facts should be grepped.

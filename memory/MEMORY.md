# MEMORY

_Always-loaded index of file-based memories. One line per memory, ≤150 chars. Lines past 200 are truncated by the harness. Keep tight._

_Schema: `- [title](file.md) — one-line hook`_

## User

_No user memories yet — add via auto-memory system when the user reveals role, preferences, or working style._

## Feedback

_No feedback memories yet — add when the user corrects approach OR validates a non-obvious call._

## Project

- [project-context](project-context.md) — Active work on claude-code-setup repo: Phase 1 restructure landed, Phase 2 rewrites CLAUDE.md.

## Reference

_No reference memories yet — add when pointing at external systems (Linear projects, Slack channels, Grafana dashboards)._

---

## Schema

Each memory file declares:

```yaml
---
name: {memory name}
description: {one-line — used for relevance ranking}
type: user | feedback | project | reference
---
```

Body format — for `feedback` and `project`, structure as rule/fact + `**Why:**` + `**How to apply:**` lines so future-you can judge edge cases.

See `core/memory.md` for retrieval cadence, what NOT to save, and how this interacts with claude-mem, KB, and session history.

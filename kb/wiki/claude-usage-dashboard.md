---
name: Claude Code Usage Dashboard — phuryn/claude-usage
description: Local dashboard that reads ~/.claude/projects/ JSONL files to show real token usage, costs, and model breakdown. Zero dependencies. MIT license. Built by @PawelHuryn.
confidence: 0.99
last-updated: 2026-04-08
linked-sources: [github.com/phuryn/claude-usage]
linked-wiki: []
tags: [claude-code, tooling, observability, cost-tracking, tokens]
---

# Claude Code Usage Dashboard

Source: @PawelHuryn (19.6K views, Apr 7 2026). Repo: `github.com/phuryn/claude-usage` (MIT).

**Problem**: Claude Code for subscriptions only shows "63% used" with no breakdown by model, project, or session.

**Solution**: Local dashboard that reads the JSONL files Claude Code already writes to your machine.

---

## How It Works

Every Claude Code session logs to `~/.claude/projects/` in JSONL format:
- Input tokens, output tokens, cache reads, cache creation
- Model name (Opus, Sonnet, Haiku)
- Timestamp
- Session ID, turn number

The dashboard:
1. Scans `~/.claude/projects/` JSONL files
2. Builds a SQLite database
3. Serves charts at `localhost:8080`

**Works retroactively** — first run processes your entire Claude Code history.

---

## Usage Statistics (Pawel's 30-day snapshot as reference)
- 440 sessions
- 18,000 turns
- $1,588 in API-equivalent costs
- Cache spike: 700M tokens on one day (visible cache bug, two days in a row)

---

## Installation

```bash
git clone github.com/phuryn/claude-usage
cd claude-usage
python3 cli.py dashboard
# Windows: use python instead of python3
```

**Zero dependencies** — Python standard library only.

---

## Features
- Filter by model: Opus, Sonnet, Haiku
- Filter by time range: 7d, 30d, 90d, all time
- Cost estimates based on current Anthropic API pricing
- Session-level breakdown
- Cache usage visualization

---

## Integration Notes

This tool reads `~/.claude/projects/` — the same directory used by:
- claude-mem plugin (semantic memory)
- Our KB system's context tracking
- MEMORY.md facts (session-derived)

The JSONL format is `history.jsonl` per project directory. The usage dashboard processes these to surface cost insights that Anthropic's UI doesn't show for subscription users.

**Recommended**: Run weekly to track if costs are spiking and which model is consuming most tokens. Cache bugs (sudden large spikes) are visible here before they become billing surprises.

---

## Status

- License: MIT
- Language: Python (stdlib only, zero deps)
- Architecture: SQLite backend + localhost web server
- Maintenance: Open source, active (304 bookmarks at time of discovery)

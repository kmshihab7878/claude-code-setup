---
name: Knowledge Base Index
description: Master map of all synthesized knowledge in ~/.claude/kb/wiki/. Source of truth for what has been learned, decided, and documented. Updated by Stage 8.5 of /ultraplan on every kb_trigger=yes execution.
last-updated: 2026-04-08
maintainer: CoreMind (AI-maintained — never edit manually)
---

# Knowledge Base — Master Index

> **Maturity: scaffold / pilot.** See [`docs/KB-STATUS.md`](../../docs/KB-STATUS.md) for exit criteria. The infrastructure exists; the content is sparse. Do not cite as authoritative until graduated.

> Drop raw material into `~/.claude/kb/raw/`. Ask questions against `wiki/`. Find outputs in `outputs/`.
> CoreMind maintains this index. Every AI edit is logged in `changelog.md`.

## How to Use This KB

| Action | Command |
|--------|---------|
| Add raw material | Drop any file into `~/.claude/kb/raw/` |
| Ask a question | "Based only on wiki/, answer: [question]" |
| Ingest new raw files | "Ingest new raw files, update wiki/ articles" |
| Monthly health check | "Run KB health check: flag contradictions, gaps, orphans" |
| Generate briefing | "Generate executive briefing on [topic] from wiki/" |

## Architecture

```
~/.claude/kb/
├── raw/          ← DROP ZONE: never AI-edited, single source of truth
├── wiki/         ← AI-MAINTAINED: synthesized knowledge, one .md per topic
│   ├── INDEX.md  ← This file — master map
│   ├── changelog.md
│   └── sources/  ← Source excerpts (anti-hallucination layer)
└── outputs/      ← SAVED RESULTS: query outputs, briefings, decisions
```

## Integration with Ecosystem Memory Layers

This KB is the **fourth memory layer** in a 4-layer stack:

| Layer | Location | Type | Scope |
|-------|----------|------|-------|
| 1. Vector semantic | claude-mem (SQLite+ChromaDB) | Conversation excerpts | Cross-session search |
| 2. Confidence facts | MEMORY.md | Verified facts with scores | Persistent ground truth |
| 3. Personal notes | Obsidian (~/Downloads/[redacted-AI-surface]) | PARA-organized notes | Personal knowledge |
| 4. Synthesized KB | ~/.claude/kb/wiki/ | Topic articles | Persistent synthesis |

**Query order for /ultraplan PRE-STAGE 0:**
1. claude-mem (fastest, semantic)
2. MEMORY.md (confidence ≥ 0.80)
3. Obsidian vault + this INDEX
4. Web search (only if gaps remain)

## Wiki Articles

### Product & Business
- [b2c-app-playbook.md](b2c-app-playbook.md) — Ernesto Lopez B2C iOS subscription app framework ($73k MRR, 12 apps)
- [external-brain-kb-methodology.md](external-brain-kb-methodology.md) — External brain methodology (Karpathy + hooeem): raw/wiki/outputs compounding system

### Design & UI
- [impeccable-design-system.md](impeccable-design-system.md) — pbakaus/impeccable: anti-AI-slop frontend design system (22 skills, audit scoring, polish checklist)

### Tools & Ecosystem
- [claude-usage-dashboard.md](claude-usage-dashboard.md) — phuryn/claude-usage: local dashboard for Claude Code token/cost tracking from JSONL files

### Ecosystem & Infrastructure
- [ecosystem-overview.md](ecosystem-overview.md) — Full Claude Code ecosystem state *(pending)*
- [port-map.md](port-map.md) — Service port assignments *(pending)*

### Projects
- [jarvis-aion.md](jarvis-aion.md) — JARVIS-FRESH / AION architecture *(pending)*
- [fincalc-ai.md](fincalc-ai.md) — FinCalc AI project *(pending)*

### Patterns
*(Articles added here as patterns are discovered via Stage 8.5)*

### Decisions
*(ADRs added here when council or ultrathink produces a decision memo)*

## KB Schema (for AI-generated articles)

Every wiki/ article must use this YAML frontmatter:

```yaml
---
name: <topic name>
description: <one-line — used for relevance scoring>
confidence: 0.0–1.0
last-updated: YYYY-MM-DD
linked-sources: [raw/ file paths — anti-hallucination requirement]
linked-wiki: [related wiki/ articles]
tags: [domain, stack-layer, project]
---
```

## KB Rules (CoreMind enforces these)

1. **Never edit raw/** — raw files are the single source of truth
2. **Never delete without asking the user**
3. **Every wiki/ claim must trace to a source** in raw/ or linked-sources
4. **Detect contradictions** — flag when a new article conflicts with an existing one
5. **Flag knowledge decay** — mark anything > 90 days old for re-verification
6. **Keep it flat** — no nested folders deeper than 1 level inside wiki/
7. **Human-readable first** — wiki/ must be immediately useful without AI
8. **No lorem ipsum, no placeholder URLs, no generic copy**

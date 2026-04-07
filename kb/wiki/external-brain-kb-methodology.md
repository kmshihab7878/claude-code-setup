---
name: External Brain — KB Methodology (Karpathy + hooeem)
description: System for building a self-improving LLM knowledge base using Obsidian + Claude Code. Raw drop zone feeds AI-maintained wiki that compounds over time. This is what ~/.claude/kb/ implements.
confidence: 0.98
last-updated: 2026-04-08
linked-sources: []
linked-wiki: [INDEX.md]
tags: [knowledge-management, obsidian, kb, claude-code, methodology, compounding]
---

# External Brain — KB Methodology

Source: @hooeem (X) + Andrej Karpathy's external brain concept. This is what `~/.claude/kb/` implements.

**Core insight**: Most people use AI like a forgetful search engine. This system makes knowledge **accumulate and compound**. Every answer gets saved back. The wiki self-heals. After 1 month it becomes irreplaceable.

---

## Our Implementation

```
~/.claude/kb/
├── raw/          ← DROP ZONE: single source of truth, never AI-edited
├── wiki/         ← AI-MAINTAINED: synthesized knowledge, one .md per topic
│   ├── INDEX.md  ← master map
│   ├── changelog.md ← every AI edit logged here
│   ├── log.md    ← activity log (append-only)
│   └── sources/  ← source excerpts (anti-hallucination layer)
└── outputs/      ← SAVED RESULTS: query outputs, briefings, decisions
```

This is **the fourth memory layer** in a 4-layer stack:

| Layer | Location | Type |
|-------|----------|------|
| 1. Vector semantic | claude-mem (SQLite+ChromaDB) | Conversation excerpts |
| 2. Confidence facts | MEMORY.md | Verified facts with scores |
| 3. Personal notes | Obsidian (~/Downloads/Shihab AI) | PARA-organized notes |
| 4. Synthesized KB | ~/.claude/kb/wiki/ | Topic articles |

---

## 4 Core Operations

### Ingest
Process new raw files → create/update wiki articles → update index.

```
New source in raw/: [reference or paste]. Ingest it: create summaries and concept pages, 
weave into existing structure, update INDEX.md and log.md. Do not rebuild everything.
```

### Query
Research across wiki → synthesize with citations → save answer to outputs/.

```
Research this question across wiki: [QUESTION]
Read INDEX.md first, load only needed pages, synthesize with citations, 
save full answer as a new note in wiki/outputs/.
```

### Lint (Health Check)
Scan for contradictions, gaps, broken links, outdated info (>90 days).

```
Run full lint: scan for contradictions, gaps, broken links, outdated info.
Fix what you can, flag what you can't, update INDEX and log.
```

### Compile
Incremental update of wiki from existing raw materials.

```
Run incremental compile: review all raw/ files not yet ingested, create/update wiki articles.
```

---

## KB CLAUDE.md (Brain Operating System)

The file `~/.claude/kb/CLAUDE.md` is the AI's rulebook for the KB vault. It defines:
- Vault structure and rules
- YAML frontmatter template for every wiki page
- What each operation does
- Anti-hallucination requirements

---

## KB Rules (CoreMind enforces)

1. **Never edit raw/** — raw files are the single source of truth
2. **Never delete without asking the user**
3. **Every wiki/ claim must trace to a source** in raw/ or linked-sources
4. **Detect contradictions** — flag when a new article conflicts with an existing one
5. **Flag knowledge decay** — mark anything >90 days old for re-verification
6. **Keep it flat** — no nested folders deeper than 1 level inside wiki/
7. **Human-readable first** — wiki/ must be immediately useful without AI
8. **No lorem ipsum, no placeholder URLs, no generic copy**

---

## Compounding Loop

The power of this system: **every answer gets filed back**.

```
New source → raw/
               ↓ /wiki-ingest
          wiki/ article
               ↓ /wiki-query
          outputs/ answer
               ↓ (always file back)
          wiki/ article updated
               ↓ /wiki-lint (weekly)
          contradictions flagged
```

This is what Andrej Karpathy calls an "external brain" — knowledge that accumulates with usage rather than decaying.

---

## Commands Available

| Command | What It Does |
|---------|-------------|
| `/wiki-ingest` | Process new files from raw/ → update wiki/ |
| `/wiki-query "question"` | Research across wiki/ → save to outputs/ |
| `/wiki-lint` | Health check: contradictions, gaps, stale info |

---

## Obsidian Integration

The Obsidian vault at `~/Downloads/Shihab AI` is Layer 3 of our memory stack. For the KB specifically, useful Obsidian plugins:
- **Dataview** — query wiki like a database
- **Obsidian Git** — version control
- **Linter** — enforce frontmatter standards
- **Templater** — article templates

Example Dataview query for KB dashboard:
```
TABLE updated, confidence FROM "wiki" WHERE confidence >= 0.8 SORT updated DESC
```

---

## Advanced: Fine-Tuning Pathway

Once wiki has 50–100+ articles:
1. Feed each wiki page to Claude: "Generate 3–5 high-quality QA pairs capturing core knowledge, reasoning patterns, and vocabulary"
2. Export 300–500 QA pairs
3. Fine-tune a smaller model (OpenAI API or local QLoRA)

The wiki handles exact facts (RAG-style). Fine-tuning teaches the model your domain's style and reasoning.

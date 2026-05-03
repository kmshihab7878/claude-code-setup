# Wiki Layer — How the OS Remembers

> **Naming reconciliation.** This repo's KB layer was built before AIS-OS naming conventions landed. Both naming schemes refer to the same files. Use whichever the upstream framework expects.

---

## File-name aliases

| AIS-OS name | This repo's path | Purpose |
|-------------|------------------|---------|
| `raw/` | `kb/raw/` | Drop zone for unprocessed source material — never AI-edited |
| `wiki/` | `kb/wiki/` | AI-maintained synthesised knowledge articles |
| `_index.md` | `kb/wiki/INDEX.md` | Master article map, one source-of-truth navigation page |
| `_log.md` | `kb/wiki/log.md` | Append-only operation log (ingests, queries, lints) |
| `_hot.md` | `kb/wiki/_hot.md` | Current-week cache — small, refreshed weekly, token-cheap |
| `archives/` | `archives/` | Cold storage for retired material (project-level, not just wiki) |

The repo standardised on uppercase `INDEX.md` and lowercase `log.md` before this integration. We did not rename to AIS-OS underscored names because:
- Existing tooling (`/wiki-ingest`, `/wiki-query`, `/wiki-lint`) reads `INDEX.md` and `log.md` directly
- Renaming breaks the existing 7 articles' cross-links
- The `_hot.md` file is genuinely new — added without conflict

When the AIS-OS reference updates with new file conventions, treat aliases additively: add the new name, keep the old, document both here.

---

## What lives where

```
kb/
├── raw/          ← DROP ZONE: unedited source material
├── wiki/         ← AI-maintained knowledge
│   ├── INDEX.md  ← navigation (alias: _index.md)
│   ├── log.md    ← activity log (alias: _log.md)
│   ├── _hot.md   ← current-week cache (AIS-OS pattern)
│   ├── changelog.md  ← AI-edit audit trail
│   └── *.md      ← topic articles
├── outputs/      ← saved /wiki-query results
├── decisions/    ← formal numbered ADRs (separate from decisions/log.md)
└── retrospectives/ ← post-incident / post-project writeups
```

Plus, at repo root:
- `decisions/log.md` — lightweight day-to-day operating decisions (different from `kb/decisions/`)
- `archives/` — cold storage for everything retired (skills, docs, refs)

---

## When to write what, where

| Pattern | Goes in |
|---------|---------|
| Raw source: PDF, paste, transcript, blog post | `kb/raw/<source>.md` |
| One-source synthesis: distilled article | `kb/wiki/<topic>.md` |
| Cross-source synthesis: pattern across multiple inputs | `kb/wiki/<pattern>.md` (with `linked-sources` frontmatter) |
| Quick navigation cache for current week | `kb/wiki/_hot.md` |
| Saved query result | `kb/outputs/<query>.md` |
| Operating decision (not architectural) | `decisions/log.md` |
| Architectural decision record | `kb/decisions/NNNN-<title>.md` |
| Post-incident writeup | `kb/retrospectives/YYYY-MM-DD-<incident>.md` |
| Permanent reference / framework | `references/<topic>.md` |
| Personal/business context | `context/<area>.md` |

---

## Read order at session start

1. **`memory/MEMORY.md`** — always-loaded index (≤200 lines)
2. **`kb/wiki/_hot.md`** — current-week cache (token-cheap)
3. **`decisions/log.md`** last-30-days — recent operating context
4. **`kb/wiki/INDEX.md`** — navigation if a wider topic surfaces
5. **`kb/wiki/<specific-article>.md`** — only when the topic is hit
6. **`kb/raw/<source>.md`** — only when validation against source is needed

The order is by token cost ascending. Don't load step 4-6 unless the task requires it.

---

## Operations summary

| Command | What it does | Updates |
|---------|--------------|---------|
| `/wiki-ingest` | Process new files from `kb/raw/` into `kb/wiki/` articles | `INDEX.md`, `log.md`, `_hot.md` (if new article goes hot) |
| `/wiki-query` | Search `kb/wiki/` for an answer; save to `kb/outputs/` | `kb/outputs/`, `log.md` |
| `/wiki-lint` | Health check — contradictions, gaps, broken links, decay | `log.md` |
| `/weekly-operating-review` | Refresh `_hot.md` from current state | `_hot.md`, `log.md` |

---

## Privacy

- `kb/raw/` — may contain source material; treat as if public unless the file is gitignored individually
- `kb/wiki/` — synthesised, public-safe (do not paste customer/PII into raw and synthesise it onward)
- `_hot.md` — public-safe (it's a cache of public surfaces)
- `decisions/log.md` — public-safe (operating decisions, not strategic)
- `kb/decisions/` — formal ADRs, public-safe
- `kb/outputs/` — query results; check before committing if query touched sensitive context
- `archives/` — keep PII-free; the archive is the wrong place to "store" sensitive material

---

## Pruning policy

- **Hot cache** — refresh weekly, no pruning needed (it's a derived view)
- **Wiki articles** — `/wiki-lint` flags articles >90 days old for review; archive only if explicitly retired
- **Decisions log** — never prune; truncate annually if file exceeds 5000 lines (keep tail)
- **Archives** — quarterly review; never delete without `decisions/log.md` entry explaining the un-archive option

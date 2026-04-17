# Knowledge Base — Status

**Maturity: scaffold / pilot.** The schema and workflow are built. The content is not.

## What's real today

Regenerate counts: `scripts/inventory.sh`

| Surface | State |
|---------|-------|
| `kb/wiki/` | 7 Markdown files — includes `INDEX.md`, `changelog.md`, `log.md`, the methodology doc, and a small number of topical articles. |
| `kb/raw/` | Near-empty (≤ 1 file). Intended as the unstructured drop zone. |
| `kb/outputs/` | Near-empty. Intended for `/wiki-query` results. |
| Commands | `/wiki-ingest`, `/wiki-query`, `/wiki-lint` — all implemented. |
| Frontmatter schema | Defined (confidence, last-updated, linked-sources, tags). See `kb/CLAUDE.md`. |
| Decay detection | `/wiki-lint` flags articles > 90 days old; not yet run as a cron. |

## What this means

- Do not treat the KB as an authoritative knowledge store yet. It is a pilot workflow with a few seed articles.
- The infrastructure exceeds the content by roughly 100×. That is the definition of scaffolding.
- Do not cite the KB in README as if it were a live knowledge system. It is labeled "scaffold" wherever it is mentioned.

## Workflow (for when you do use it)

### Ingest a raw note

1. Drop any unstructured file into `kb/raw/` (transcripts, notes, research PDFs).
2. Run `/wiki-ingest`.
3. The command reads `raw/` files, produces structured articles under `kb/wiki/` with frontmatter, citations back to the raw source, and updates `INDEX.md`.
4. `log.md` gets an append-only entry.

### Query

`/wiki-query "<question>"` — searches across `kb/wiki/` and writes an answer to `kb/outputs/<slug>.md` with links to the source articles used.

### Lint

`/wiki-lint` — checks for: stale articles (>90 days), broken inter-article links, missing frontmatter fields, duplicate topics. Run weekly if the KB is active.

## Exit criteria for "mature"

The KB graduates from "scaffold" to "working system" when **all** of:

- ≥ 50 articles in `kb/wiki/` with confidence ≥ 0.8 on at least 30 of them.
- `/wiki-lint` passes weekly for 4+ consecutive weeks.
- At least one decision in the real world has been made materially faster by `/wiki-query` (recorded in `kb/outputs/`).
- `kb/raw/` shows a steady flow of new material (not a one-shot dump).

Until then: the KB is scaffold, not product.

## What NOT to do

- Do not generate filler articles to inflate the count. An empty KB is better than a padded one.
- Do not rely on the KB to answer questions in this repo — the main sources remain `CLAUDE.md`, `docs/`, `agents/REGISTRY.md`, and `scripts/inventory.sh`.
- Do not promise "KB-backed" features in the README without linking to the specific article that backs them.

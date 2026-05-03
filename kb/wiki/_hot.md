---
name: Hot Cache — Current Week
description: Token-saving cache of the most important wiki/ context for the current week. Updated by /wiki-ingest and weekly review. Read first when planning, deciding, or routing.
type: cache
last-updated: 2026-05-03
ttl-days: 7
maintainer: AI-maintained — refreshed weekly via /weekly-operating-review
---

# Hot Cache — Current Week

> Adapted from AIS-OS `_hot.md` pattern. The point is to keep ONE small file that summarises what the OS most needs to know **right now**, so other surfaces don't have to re-load the full wiki.

> **Maintenance rule:** if this file is older than 7 days, it's stale. Re-generate via `/weekly-operating-review` or by running `/wiki-ingest --refresh-hot`.

---

## This week's focus
_(Filled by `/weekly-operating-review` from `context/Priorities.md` + most-recent `/audit` top gap. One sentence.)_

## Active decisions in play
_(Pulled from `decisions/log.md` last 7 days. Bullet list, one line each.)_

## Open candidates from /level-up
_(Pulled from `decisions/log.md`. What's been recommended but not yet built. One line each.)_

## Hot wiki articles
_(The 3-5 wiki articles that are most relevant to the current week's focus. One bullet per article: title + why-it-matters in 10 words.)_

## Active connections at risk
_(Any row in `connections.md` marked `auth pending`, `paused`, or with rotating credentials due. One line each.)_

## Leverage gap of the week
_(Top gap from latest `/audit`. One sentence. This is the thing `/level-up` should target.)_

---

## How this file is consumed

- **Loaded eagerly** by `/daily-plan`, `/level-up`, `/weekly-operating-review`.
- **Searched** by `/wiki-query` before searching the rest of `wiki/`.
- **Refreshed weekly** — older than 7 days = ignored.

## How this file is updated

- `/weekly-operating-review` re-derives sections from current state every Friday.
- `/wiki-ingest` may add/remove entries as articles change.
- Manual edits are allowed but discouraged — prefer to update the source files (decisions, audit reports) and re-derive.

## What does NOT belong here

- Detailed technical knowledge → that's the full wiki article.
- Permanent reference material → that's `references/`.
- Operating decisions → those go in `decisions/log.md`.
- Personal context → that's `context/`.

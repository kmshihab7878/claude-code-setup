# Archives

_Cold storage for retired skills, deprecated docs, superseded references, and stale onboarding answers._

## Rules
- **Never delete archived content silently.** Move it here, then update any pointers.
- Each archived item lives in a dated subdirectory: `YYYY-MM-DD-short-name/`.
- Add a `WHY.md` inside each archive folder explaining what was retired and what (if anything) replaced it.
- Pruning archives is a quarterly operation — never automatic.

## Layout

```
archives/
  2026-Q2/                         # quarterly bucket
    2026-05-12-old-onboard-flow/
      WHY.md
      <archived files>
```

## What belongs here
- Retired skills the user explicitly removed
- Old reference docs replaced by newer canonical versions
- Superseded onboarding/intake snapshots when context is fully refreshed
- Past audit reports that pre-date a major architecture change

## What does NOT belong here
- Secrets (those go nowhere — they get rotated)
- Active knowledge (lives in `kb/wiki/`)
- Decision history (lives in `decisions/log.md` and `kb/decisions/`)
- Session telemetry (lives in `~/.claude/usage.jsonl`)

## Restoration
To revive archived content, copy it back to its original path and add an entry in `decisions/log.md` explaining the un-archive.

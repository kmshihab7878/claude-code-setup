---
description: "Onboard or refresh the AI OS by running the 7-question intake. Populates context/, seeds connections.md, logs the run. Never auto-fills identity from session env."
---

# /onboard — AI OS Onboarding Command

Invoke the `onboard` skill (`skills/onboard/SKILL.md`).

## What this does
Walks the user through `aios-intake.md` — 7 questions covering identity, projects, tool stack, repeated work, operating preferences, the 10x constraint, and hard limits. Distills answers into `context/*.md`, seeds `connections.md` Tier-4 rows, and logs the run in `decisions/log.md`.

## Privacy guarantee
- Will NOT auto-fill name, email, GitHub handle, or any identity field from session environment, system reminders, or OS state.
- Will refuse to write content matching credential patterns.
- Will warn before saving any answer that contains an email address.

## Output validation
Onboarding ends with the question: **"What should I focus on this week?"**
If the OS routes the answer correctly using the populated context, onboarding worked. If not, the user should call out the missing link and the skill should suggest which file to update.

## Re-running
Idempotent. Existing rich content is preserved (moved to `archives/YYYY-MM-DD-pre-onboard/`) before being overwritten. Pass `--quick` for a 3-question version (identity, projects, hard limits only).

## See also
- `aios-intake.md` — the 7 questions in canonical form
- `references/four-cs-framework.md` — Context is the C this command builds
- `skills/audit/SKILL.md` — uses `context/` to score the Context pillar

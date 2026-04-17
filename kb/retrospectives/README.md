# Retrospectives

_Per-task postmortems. Write after significant work to capture what worked and what didn't, so the next similar task benefits. Complements `evolution/records/sessions.jsonl` (machine-readable) with human-readable narrative._

## Template

```markdown
# {YYYY-MM-DD} — {Task summary}

**Context:** {what triggered this task — user request, bug report, telemetry signal}
**Commit(s):** {sha range}
**Duration:** {approx time, e.g. "2 sessions, ~3 hours"}

## What worked

- Specific thing that worked and why. Not vague ("the plan was good").
- Another specific thing.

## What didn't

- Specific failure mode. Include the wrong assumption or missed signal.
- Another specific failure.

## Lesson

One sentence. The durable takeaway. If it generalizes beyond this task, consider adding a candidate to `evolution/candidates/` per the self-evolution schema.

## Improvement candidate

{If applicable: a concrete change to skill / agent / command / hook / doc that would prevent this failure mode in the future. Path + one-sentence change proposal.}

## Applied

yes — {commit sha} | no — {reason}
```

## Filename convention

`{YYYY-MM-DD}-{kebab-case-topic}.md` — e.g. `2026-04-17-phase-0-audit.md`.

## When to write one

- After completing a significant task (multi-hour, multi-file, cross-domain).
- After any task where the outcome differed from the plan.
- After any incident where something broke and was fixed.
- Per the KhaledPowers 'Record learnings before closing' non-negotiable.

## When NOT to write one

- Trivial edits, typo fixes, single-file refactors.
- Tasks where the lesson is "follow the existing pattern" — that's a CLAUDE.md or domain-rule concern, not a retro.

## Integration

- `/improve` scans this directory for prior evidence about a target.
- `evolution/bin/evolve-collect.sh` mines retros for patterns that might become promoted candidates.
- The self-evolution promotion gate requires ≥3 retrospective or session evidence entries before promoting a candidate to `evolution/stable/`.

## Current retrospectives

_Phase 0–2 of the restructure produced the initial retrospective; it is captured in [`memory/session-history.md`](../../memory/session-history.md) rather than here. Individual-task retros will accumulate in this directory as work progresses._

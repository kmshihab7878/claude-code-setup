# Cadence — Daily, Weekly, Quarterly Loops

> The loops that keep the OS healthy. Cadence is the **last** of the Four Cs to build (Context → Connections + Capabilities → Cadence). Don't automate broken workflows.

---

## Daily

### Morning — `/daily-plan`
- Read `context/Priorities.md` (this week's focus)
- Read `kb/wiki/_hot.md` (current-week cache)
- Read `decisions/log.md` last 7 days
- Propose top focus for the day
- Identify one AI-assisted task

### Evening — `/end-of-day-review`
- Record what changed (commits, ships, conversations)
- Note what skills worked / didn't work
- Note missing context (which file would have helped if filled?)
- Propose updates to skills, references, or wiki — log to `decisions/log.md`

**Tooling:** both are interactive Claude Code skills. Run them as the first/last thing in the working day.

---

## Weekly (Friday)

### `/weekly-operating-review`
Combines three actions into one skill so the operator has one Friday command:
1. Run `/audit` — Four-Cs scorecard, top 3 gaps, recommended action
2. Run `/level-up` — 5 reflection questions, one recommended artifact
3. Refresh `kb/wiki/_hot.md` from current state
4. Log the run in `decisions/log.md`

### Or run them separately
- `/audit` — read-only score, saved to `docs/audits/YYYY-MM-DD.md`
- `/level-up` — recommendation only, doesn't build
- Manual `_hot.md` refresh if needed

**When this fires:** Friday end-of-day, ideally before the weekend so Monday starts with the recommended action queued.

---

## Quarterly (every 3 months)

| Action | Why |
|--------|-----|
| Refresh `context/Priorities.md` | Quarter goals shift |
| Re-run `/onboard` (or partial) | Tool stack drifts; preferences evolve |
| Review `connections.md` | Rotate sensitive credentials; deprecate unused tools |
| Prune `archives/` | Genuinely-dead material can be moved out |
| Audit skill registry | Skills not used in 90 days → archive or improve |
| Update `docs/CAPABILITIES.md` | Re-derive capability registry from actual usage |

**Tooling:** no dedicated skill yet — this is calendar-driven. A future `quarterly-review` skill is a candidate for `/level-up` when it surfaces.

---

## Anti-patterns

| Anti-pattern | Why it's bad | Fix |
|--------------|--------------|-----|
| Daily audit | Trend disappears in noise | Audit is weekly. Daily is for `/daily-plan` and `/end-of-day-review`. |
| Skipping `/end-of-day-review` "because nothing happened" | Quiet days are signal too — log them | Run anyway; the entry can be one line |
| Automating `/level-up` artifacts before manual proof | `/level-up` recommendation is built and scheduled the same day, before manual run | Run manually for ≥1 week; promote to cadence only after success |
| `/audit` score gaming | Operator marks pillars done that aren't actually done | Audit rubric is evidence-based, but don't fight it — accept low scores as the baseline |
| `_hot.md` becoming a duplicate of priorities | Hot cache should be a derived view, not a duplicate | If `_hot.md` is mostly copy-paste from `context/Priorities.md`, it's not adding value — let it auto-refresh from sources |

---

## How cadence is enforced (currently)

**Manual.** The operator runs the slash commands. There is no automatic scheduler tied to cadence in this OS today, by design — premature scheduling automates broken workflows.

### When to introduce automation
After a daily/weekly/quarterly loop has run **manually** for a sustained period (suggested: 30+ days for daily, 60+ days for weekly, 1 cycle for quarterly), and the operator has confirmed it's worth keeping, you may:

1. **Local schedule** (`launchd` / `cron`) — machine must be on. Document the kill switch.
2. **Cloud routine** via `/schedule` (claude-code remote trigger) — only after secrets are managed via env vars and the workflow tolerates non-interactive execution.

Scheduling adds:
- Cost (cloud compute or local power)
- Surface area (one more thing that can fail silently)
- Drift (the schedule keeps running after the workflow's purpose dies)

Don't reach for it lightly.

---

## Cadence health check (part of `/audit`)

The `Cadence` pillar (out of 25) scores:

| Score | Meaning |
|-------|---------|
| 0-5 | No loops running |
| 6-12 | Some manual loops, irregular |
| 13-19 | Daily/weekly cadence stable for 14+ days |
| 20-25 | Cadence stable 30+ days; all scheduled jobs reviewed monthly |

A cadence pillar that drops over 3 audits is a signal the OS is being abandoned. Don't ignore it.

---

## Skills involved

| Skill | Cadence | What it does |
|-------|---------|--------------|
| `skills/daily-plan/SKILL.md` | daily morning | Propose top focus from priorities + hot cache |
| `skills/end-of-day-review/SKILL.md` | daily evening | Record learnings, propose system updates |
| `skills/audit/SKILL.md` | weekly | Score Four-Cs, surface gaps |
| `skills/level-up/SKILL.md` | weekly | Recommend ONE next artifact |
| `skills/weekly-operating-review/SKILL.md` | weekly | Combines audit + level-up + hot-cache refresh |

All five are interactive — they ask questions, the operator answers. No background execution.

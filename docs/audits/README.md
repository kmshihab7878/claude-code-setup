# Audits

_Output of `/audit` — weekly Four-Cs scorecard for the AI OS._

## Files in this directory
- `YYYY-MM-DD.md` — one report per audit run
- `README.md` (this file)

## What goes in each audit

```markdown
# Audit — YYYY-MM-DD

**Total: X/100**

| Pillar | Score | Trend |
|--------|-------|-------|
| Context | X/25 | ↑/→/↓ |
| Connections | X/25 | |
| Capabilities | X/25 | |
| Cadence | X/25 | |

## Top 3 leverage gaps
1. ...
2. ...
3. ...

## Next action
<one sentence — feeds /level-up>

## Evidence
- <file>: <what it told us>
```

## What does NOT go here
- Code review — that's `/audit-deep` output
- Security review — that's `/security-audit` output
- Per-project memory — that's `memory/`
- Operating decisions — those go in `decisions/log.md` (audits link there)

## Retention
Keep all audit reports. They are the trend signal. Pruning happens only at quarterly review and only if a report is genuinely empty.

## How to read these as a series
1. Open the last 4-6 reports
2. Watch the **Cadence** score — if it's dropping, the OS is being abandoned
3. Watch the **Capabilities** score — should rise as `/level-up` artifacts ship
4. Watch the **Context** score — should rise after `/onboard` and after major life/work shifts
5. Watch the **Connections** score — usually the slowest to move; that's normal

## When to run a baseline audit
- First-time setup → expect 15-30/100 baseline
- After a major OS restructure → re-baseline
- After 90 days of dormancy → re-baseline before resuming cadence

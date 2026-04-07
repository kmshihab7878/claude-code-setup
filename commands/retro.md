# /retro

> Monthly framework retrospective — evaluate and evolve the operating system itself.

## Instructions

When invoked, conduct a structured retrospective of the KhaledPowers Operating
Framework. This evaluates whether the framework is helping or hindering.

### Step 1: Gather Data

Read metrics from `~/.claude/metrics/` for the current or specified month.
Read memory files to check for promotion candidates.
Scan skills directory for trigger activity.

### Step 2: Framework Health Assessment

Evaluate each framework component:

#### Skills Audit
- **Active skills**: Skills that triggered this month
- **Dormant skills**: Skills that exist but never triggered (dead weight candidates)
- **Overloaded skills**: Skills that triggered on tasks outside their intended scope
- **Recommendation**: Keep / Adjust trigger / Merge / Remove for each dormant skill

#### Gate Effectiveness
- **Blocks that caught real issues**: Gate blocked, and the block was correct
- **Blocks that caused friction**: Gate blocked, but the user overrode it (friction signal)
- **Missed catches**: Issues that gates should have caught but didn't
- **Recommendation**: Tighten / Loosen / Keep for each gate

#### Lane Routing Accuracy
- **Correct routes**: Task routed to the right lane on first try
- **Re-routes**: Tasks that changed lanes mid-execution
- **Recommendation**: Adjust decision tree if re-routes > 10%

#### Council Utilization
- **Councils convened**: How many, which type
- **Solo when should have been council**: Missed escalations
- **Council when could have been solo**: Over-escalations
- **Recommendation**: Adjust council triggers

### Step 3: Memory Promotion Review

Check each memory domain for promotion candidates:

| Domain | File | Candidates | Action |
|--------|------|-----------|--------|
| Execution | patterns.md | Patterns with 3+ successes | Promote to template |
| Failure | mistakes.md | Prevention strategies with 3+ successes | Promote to checklist |
| Preference | preferences.md | Preferences confirmed 3+ times | Solidify |
| Architecture | architecture.md | Stable patterns | Document as convention |

### Step 4: Generate Recommendations

Output a prioritized list of changes:

```
## Retro: [YYYY-MM]

### Keep (working well)
- [component]: [why it's working]

### Adjust (needs tuning)
- [component]: [what to change and why]

### Add (missing capability)
- [what's needed]: [why]

### Remove (dead weight)
- [component]: [why it's not earning its keep]

### Promote (earned its place)
- [pattern/prevention/preference]: [promote to what]
```

### Step 5: Action Items

Generate specific, actionable items for each recommendation.
Each item should reference the exact file to modify.

### Optional Arguments

- `$ARGUMENTS` = specific month (e.g., `2026-03`)
- `$ARGUMENTS` = `quarterly` — cover the last 3 months
- `$ARGUMENTS` = `skills-only` — just audit skills
- `$ARGUMENTS` = `gates-only` — just evaluate gates

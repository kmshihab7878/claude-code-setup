# PM Agent Workflow — full session lifecycle and PDCA

Detailed session-start, during-work PDCA loop, and session-end procedures.
The compact lifecycle summary lives in `agents/pm-agent.md`.

## Session start (auto-runs every time)

Activation: every Claude Code session start. No user command required.

### Context restoration sequence

1. `list_memories()` — check for prior PM Agent state.
2. `read_memory("pm_context")` — overall project context.
3. `read_memory("current_plan")` — what we're working on.
4. `read_memory("last_session")` — what was done previously.
5. `read_memory("next_actions")` — what to do next.

### Required report-back

After context restoration, present:

- Previous-session summary.
- Current progress.
- Planned next actions.
- Blockers.

The user can then immediately continue from the last checkpoint — no
re-explaining context, goals, architecture, or patterns.

## During work — continuous PDCA cycle

### Plan (仮説)

- `write_memory("plan", goal)`.
- Create `docs/temp/hypothesis-YYYY-MM-DD.md`.
- Define what to implement and the success criteria.

### Do (実験)

- `TodoWrite` for tracking (≥ 3 steps).
- `write_memory("checkpoint", progress)` every 30 min.
- Log trial-and-error in `docs/temp/experiment-YYYY-MM-DD.md` with errors
  and solutions.

### Check (評価)

- `think_about_task_adherence()`.
- Capture what worked, what failed, lessons learned in
  `docs/temp/lessons-YYYY-MM-DD.md`.

### Act (改善)

- Success → move `docs/temp/experiment-*` to `docs/patterns/<pattern>.md` (清書).
- Failure → create `docs/mistakes/mistake-YYYY-MM-DD.md` (prevention).
- Update `CLAUDE.md` if a global pattern emerged.
- `write_memory("summary", outcomes)`.

## PDCA self-evaluation prompts

### Plan

- What am I trying to accomplish?
- What approach?
- Success criteria?
- What could go wrong?

### Do

- Execute the plan.
- Monitor deviations.
- Record unexpected issues.
- Adapt as you learn.

### Check

- Did I follow architecture patterns? (`think_about_task_adherence`)
- Did I read relevant docs?
- Did I check for existing implementations?
- Am I truly done? (`think_about_whether_you_are_done`)
- What did I miss?

### Act

- **Success**: extract pattern to `docs/patterns/`, update `CLAUDE.md` if
  global, create reusable template.
- **Failure**: root cause analysis, `docs/mistakes/` entry, prevention
  checklist, anti-patterns update.

## Session end

1. `think_about_whether_you_are_done()` — verify all tasks completed or
   documented as blocked; no partial implementations left.
2. `write_memory("last_session", summary)` — accomplishments, issues, learnings.
3. `write_memory("next_actions", todos)` — specific next steps, blockers
   to resolve, docs to update.
4. **Documentation cleanup** — promote `docs/temp/` to `docs/patterns/` or
   `docs/mistakes/`; update `CLAUDE.md` for global patterns; remove
   outdated temp files (> 7 days).
5. `write_memory("pm_context", state)` — complete project state for
   seamless resumption.

## Memory operations — full reference

### Session start (MANDATORY)

- `list_memories`.
- `read_memory("pm_context" | "last_session" | "next_actions")`.

### During work — checkpoints

- `write_memory("plan", goal)`.
- `write_memory("checkpoint", progress)` every 30 min.
- `write_memory("decision", rationale)`.

### Self-evaluation — critical

- `think_about_task_adherence`.
- `think_about_collected_information`.
- `think_about_whether_you_are_done`.

### Session end (MANDATORY)

- `write_memory("last_session", summary)`.
- `write_memory("next_actions", todos)`.
- `write_memory("pm_context", state)`.

### Monthly maintenance

- Review and prune memories.
- Merge duplicates.
- Verify freshness.

## Self-improvement workflow integration

### BEFORE — context gathering

- Verify specialist agents have read `CLAUDE.md`.
- Ensure relevant `docs/*.md` consulted.
- Confirm existing implementations were searched.
- Validate public documentation was checked.

### DURING — monitoring

- Monitor decision points needing documentation.
- Track why approaches were chosen.
- Note edge cases as discovered.
- Observe emerging patterns.

### AFTER — documentation

- Record new patterns.
- Document architectural decisions.
- Update `docs/*.md` and add examples.
- Attach evidence: test results / coverage, screenshots / logs, metrics,
  integration validation.
- Update `CLAUDE.md` if global.
- Refine existing docs.

### MISTAKE RECOVERY

1. Stop immediately.
2. Root-cause analysis — why mistake? docs missed? checks skipped? pattern violation?
3. Document in `docs/self-improvement-workflow.md` + add mistake case
   study + prevention checklist.
4. Update `CLAUDE.md` if needed.

### MAINTENANCE — monthly

- Identify unused docs (> 6 months, no references), duplicates, outdated info.
- Delete or archive unused.
- Merge duplicates.
- Refresh versions / dates.
- Verify links + examples + copy-paste readiness.

## Behavioral mindset

Continuous learning system that transforms experiences into knowledge.

- **Experience → knowledge** — every implementation generates learnings.
- **Immediate documentation** — record insights while context is fresh.
- **Root cause focus** — analyze deeply, not just symptoms.
- **Living documentation** — continuously evolve and prune.
- **Pattern recognition** — extract recurring patterns into reusable knowledge.

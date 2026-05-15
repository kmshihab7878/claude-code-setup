# Discovery, Requirements, and Stakeholder Documentation

Documentation strategy (the trial-and-error → knowledge pipeline), handoff
protocol for agent and session transitions, and integration patterns with
specialist agents.

## Documentation Strategy — trial-and-error to knowledge

The PM Agent maintains a three-tier documentation hierarchy.

### `docs/temp/`

- Hypothesis, experiment, lessons.
- Trial-and-error welcome.
- Raw notes.
- **Expire after 7 days.**

### `docs/patterns/`

- Successful patterns ready for reuse.
- Cleaned up from `docs/temp/experiment-*`.
- Include "Last Verified" date and concrete examples.

### `docs/mistakes/`

Error records with prevention. Each entry contains:

- **What Happened (現象)** — the observed failure.
- **Root Cause (根本原因)** — the underlying reason.
- **Why Missed (なぜ見逃したか)** — what check should have caught it.
- **Fix Applied (修正内容)** — what was changed.
- **Prevention Checklist (防止策)** — bullets a future agent can run.
- **Lesson Learned (教訓)** — short narrative for cross-project reuse.

### Evolution path

```
docs/temp/  ──success──>  docs/patterns/
            ──failure──>  docs/mistakes/

Best practices roll up into:
  ~/.claude/CLAUDE.md  (global)
  <project>/CLAUDE.md  (project-scoped)
```

## Handoff Protocol

Use this template when transitioning between agents or sessions.

```yaml
Handoff:
  context:
    task: "<what was being worked on>"
    status: in-progress | blocked | ready-for-review | complete
    branch: "<git branch>"
    key_files: ["<modified files>"]
  completed: ["<step>"]
  remaining: ["<step>"]
  blockers: ["<blocker + suggested resolution>"]
  decisions_made:
    - decision: "<what>"
      rationale: "<why>"
      alternatives_rejected: ["<option>"]
  notes: ["<anything the next agent/session needs>"]
```

### Handoff discipline

- The agent handing off is responsible for completing every field.
- `status` must use one of the four allowed values — never free-text.
- `decisions_made` carries forward the rationale; the next agent should
  not have to re-derive it.
- `notes` is the right place for ergonomic context (env quirks, partial
  test state) that doesn't fit the structured fields.
- A handoff with no decisions and no blockers means the work is finished
  cleanly — say so in `notes`.

## Integration with Specialist Agents

PM Agent is a **meta-layer**. Specialist agents execute; PM Agent
auto-triggers after to document learnings.

### Example flow — auth implementation

1. User request → auto-activation selects specialist (e.g., `backend-architect`, `security-engineer`).
2. Specialist agents execute the implementation.
3. PM Agent auto-activates:
   - Document the pattern.
   - Record security decisions.
   - Update `docs/authentication.md`.
   - Add a prevention checklist if issues were found.

PM Agent **complements** specialist agents by ensuring knowledge from
implementations is captured and maintained. It does not duplicate their
work.

### Specialist → PM Agent handoff signals

The PM Agent's auto-trigger fires after a specialist agent's run when:

- The specialist produced new code in a non-trivial area.
- A decision was recorded (test passed, design chosen, library picked).
- A mistake was caught (build broke, test failed, security audit flagged).
- A pattern that the specialist used could be reused elsewhere.

### What the PM Agent does NOT do

- Re-execute the specialist's task.
- Re-argue decisions the specialist already made (only documents them).
- Block delivery to "document first" — documentation runs in parallel where possible.

## Discovery and Requirements Notes

The PM Agent captures requirements as they are discovered during
implementation, not before. The model is:

- Specialist agents discover requirements while implementing.
- PM Agent captures them into the documentation hierarchy in real time.
- Future specialist agents read those docs before re-discovering the same requirements.

This is **not** a substitute for upfront product discovery in a product
sense — the PM Agent in this repo is a documentation/learning loop, not a
product manager.

## Stakeholder Communication via Documentation

The PM Agent treats documentation as the primary stakeholder communication
channel.

- **Patterns** → engineering stakeholders (other agents, future implementers).
- **Mistakes** → cross-functional stakeholders (security, ops) when relevant.
- **Maintenance reports** → operator / owner.
- **`CLAUDE.md` updates** → every future session.

Stakeholder messages outside the documentation graph (Slack, Telegram, etc.)
are out of scope for the PM Agent itself — those belong to comms tools (e.g.,
`hermes` MCP) and are invoked separately.

## Documentation Status Tags

Every long-lived document should carry one of these tags so future agents
know how to treat it:

| Tag | Meaning | Lifetime |
|-----|---------|----------|
| Hypothesis | Speculative; under test | ≤ 7 days |
| Experiment | Implementation in progress | ≤ 7 days |
| Lesson | Captured outcome, not yet promoted | ≤ 14 days |
| Pattern | Reusable, verified | Indefinite, refresh ≤ 6 months |
| Mistake | Error case + prevention | Indefinite, refresh on recurrence |
| Global | Promoted to `CLAUDE.md` | Indefinite, refresh on every related change |

# KhaledPowers Quickstart Guide

> The 5 most common workflows, end-to-end. Reference this when starting a new
> session or when unsure which path to take.

---

## Workflow 1: Add a Feature

**Lane**: Specify -> Build -> Verify -> Ship
**Mode**: B Elite Engineering
**Risk**: T1 Local (typical)

```
Step 1:  /start-task "Add [feature name]"
         -> Generates session header, confirms lane/risk/mode

Step 2:  /spec
         -> Write acceptance criteria
         -> Get user approval (Non-Negotiable #9)

Step 3:  /plan
         -> Break into tasks with done conditions
         -> User approves plan

Step 4:  Write failing tests (TDD gate)
         -> Tests define the expected behavior

Step 5:  /sc:build
         -> Implement against the failing tests
         -> Tests go green

Step 6:  /review
         -> Self-review, disposition every finding
         -> Accept / Defer (with reason) / Reject (with reason)

Step 7:  Run full test suite
         -> All tests pass, show output

Step 8:  /complete
         -> Generates completion packet with evidence
```

**Time**: Varies. Steps 1-3 take ~5 min, steps 4-7 are the bulk.

---

## Workflow 2: Fix a Bug

**Lane**: Recover
**Mode**: C Recovery
**Risk**: T1+ (assess based on blast radius)

```
Step 1:  /start-task "Fix [bug description]"
         -> Routes to Recover lane automatically

Step 2:  /debug
         -> Root cause gate activates
         -> Investigate: read logs, reproduce, trace
         -> State root cause with evidence (Non-Negotiable #7)

Step 3:  Write failing regression test
         -> Test reproduces the bug
         -> Test fails (proves the bug exists)

Step 4:  Apply minimal fix
         -> Target the root cause, not symptoms
         -> Regression test goes green

Step 5:  Run full test suite
         -> No regressions introduced
         -> Show output (Non-Negotiable #8)

Step 6:  /complete
         -> Include root cause in completion packet
         -> Flag prevention strategy for mistakes.md
```

**Key rule**: Never skip Step 2. "I know the fix" is not evidence.

---

## Workflow 3: Deploy to Production

**Lane**: Ship
**Mode**: D Secure Delivery
**Risk**: T2-T3 (always)

```
Step 1:  /start-task "Deploy [what] to production"
         -> Routes to T2+ automatically
         -> Council: Lead+Reviewer minimum

Step 2:  /security-audit
         -> Full security review of changes
         -> Disposition every finding

Step 3:  Use template: ~/.claude/templates/deploy-checklist.md
         -> Fill in all pre-deploy checks
         -> Document rollback procedure

Step 4:  CHECKPOINT — User confirms
         -> T2+ requires explicit approval
         -> Show the filled checklist
         -> "Proceed with deployment?" -> User says yes

Step 5:  Execute deployment steps
         -> Follow the checklist exactly

Step 6:  Post-deploy verification
         -> Smoke tests pass
         -> Error rates normal
         -> Response times within SLA

Step 7:  /complete
         -> Include deploy evidence and rollback path
```

**Key rule**: Step 4 is non-negotiable. Never deploy without explicit user approval.

---

## Workflow 4: Research a Topic

**Lane**: Explore
**Mode**: A Founder (if leading to a product) or Solo
**Risk**: T0 Safe

```
Step 1:  /start-task "Research [topic]"
         -> Routes to Explore lane
         -> No gates needed for research

Step 2:  /sc:research or /bmad:research
         -> Gather information from multiple sources
         -> Use context7 MCP for library docs
         -> Use web search for current state

Step 3:  Synthesize findings
         -> Options document or brief
         -> Recommendations with trade-offs
         -> Sources cited

Step 4:  Present to user
         -> "Here are the options. Which direction?"
         -> User decides next lane (Specify? Build? Done?)
```

**Key rule**: Explore never jumps to Build. Always pass through Specify first.

---

## Workflow 5: Emergency Hotfix

**Lane**: Recover -> Ship
**Mode**: C Recovery -> D Secure Delivery
**Risk**: T2-T3

```
Step 1:  /start-task "EMERGENCY: [issue]"
         -> Routes to Recover, T2+
         -> Escape hatch: streamlined process, but still requires evidence

Step 2:  Reproduce and identify root cause
         -> Abbreviated investigation (minutes, not hours)
         -> Root cause stated with evidence

Step 3:  Write regression test + apply fix
         -> Can be done in rapid succession for emergencies

Step 4:  Run critical test suite
         -> Full suite if time allows
         -> Minimum: affected area + regression test

Step 5:  CHECKPOINT — User confirms deploy
         -> Even in emergencies, T2+ needs confirmation

Step 6:  Deploy fix
         -> Follow abbreviated deploy checklist

Step 7:  /complete
         -> Note this was an emergency
         -> Schedule full post-mortem for later
         -> Use template: ~/.claude/templates/post-mortem.md
```

**What's skipped**: Full spec, detailed plan, exhaustive review.
**What's NOT skipped**: Root cause evidence, regression test, user checkpoint, completion packet.

---

## Quick Reference Card

| I need to... | Start with | Lane | Mode |
|-------------|-----------|------|------|
| Add a feature | `/start-task` -> `/spec` | Specify | B |
| Fix a bug | `/start-task` -> `/debug` | Recover | C |
| Deploy | `/start-task` -> `/security-audit` | Ship | D |
| Research | `/start-task` -> `/sc:research` | Explore | A |
| Hotfix | `/start-task` -> reproduce | Recover->Ship | C->D |
| Refactor | `/start-task` -> `/plan` | Specify->Build | B |
| Review code | `/review` | Verify | B |
| End a session | `/complete` or `/handoff` | — | — |
| Check metrics | `/metrics` | — | — |
| Monthly review | `/retro` | — | — |

## Non-Negotiables That Always Apply

No matter the workflow, these never get skipped:

1. No fabrication
2. Security-first (no secrets committed)
3. Verify before asserting
4. Test first (for code changes)
5. Root cause first (for bugs)
6. Evidence first (for completion)
7. Approval first (for specs/plans)

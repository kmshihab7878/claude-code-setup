# Golden workflows (Section 11 detail)

Step-by-step playbooks for the four most common task types: New Feature, Bug Fix, Major Refactor, Production Release. Each workflow has 8 steps tying routing decision → commands → required artifacts → non-negotiable references → completion packet. SKILL.md keeps a workflow index; this file holds the full step lists.

## 11. Golden Workflows

Step-by-step reference for the 4 most common task types.

### Workflow 1: New Feature

1. **Route**: Lane=Specify, Risk=T1, Mode=B (or A if greenfield)
2. **Specify**: `/spec` — Write acceptance criteria, get user approval (Non-Negotiable #9)
3. **Plan**: `/plan` — Break into tasks with clear done conditions
4. **Test**: Write failing tests first (Non-Negotiable #6)
5. **Build**: `/sc:build` — Implement against the tests
6. **Review**: `/review` — Self-review, disposition every finding
7. **Verify**: Run full test suite, show output (Non-Negotiable #8)
8. **Complete**: `/complete` — Generate completion packet

### Workflow 2: Bug Fix

1. **Route**: Lane=Recover, Risk=T1+, Mode=C
2. **Investigate**: `/debug` — Root cause gate (Non-Negotiable #7)
3. **Evidence**: Show logs, traces, or reproduction proving root cause
4. **Test**: Write failing regression test
5. **Fix**: Apply minimal fix targeting root cause
6. **Verify**: All tests pass, regression test specifically passes
7. **Reflect**: `/sc:reflect` — What caused this? How to prevent?
8. **Complete**: `/complete` — Include root cause in packet

### Workflow 3: Major Refactor

1. **Route**: Lane=Specify, Risk=T1-T2, Mode=B
2. **Baseline**: Run existing tests, record current behavior
3. **Plan**: `/plan` — Define refactor scope, what changes vs. what doesn't
4. **Specify**: Document before/after architecture
5. **Build**: Incremental changes (Non-Negotiable #4), test after each step
6. **Verify**: Full test suite, compare with baseline
7. **Review**: `/review` — Ensure no behavior changes leaked in
8. **Complete**: `/complete` — Include before/after comparison

### Workflow 4: Production Release

1. **Route**: Lane=Ship, Risk=T2-T3, Mode=D
2. **Audit**: `/security-audit` — Full security review
3. **Checklist**: Generate deployment checklist
4. **Rollback**: Document rollback procedure
5. **Checkpoint**: Explicit user approval (T2+ required)
6. **Deploy**: Execute deployment steps
7. **Verify**: Post-deploy verification, smoke tests
8. **Complete**: `/complete` — Include deploy evidence and rollback path

# Completion Packet and Skill Precedence

Purpose: Full completion packet template and skill precedence rules for tasks where the concise operating contract is not enough.

## Completion Packet

Every non-trivial task ends with a completion packet. The `/complete` command can generate this.

```markdown
## Completion Packet

**Task**: [description]
**Lane**: [lane taken]
**Risk**: [tier assigned]

### Summary
[1-3 sentences on what was done]

### Changed Files
- [file]: [what changed]

### Artifacts Produced
- [artifact]: [location or inline]

### Tests Run
- [test suite/file]: [pass/fail, count]

### Evidence
[Link to or inline: test output, logs, screenshots, build results]

### Risks Introduced
- [risk]: [mitigation]
(or: None identified)

### Rollback Path
[How to undo this change]

### Open Questions
- [anything unresolved]
(or: None)

### Next Step
[Recommended follow-up action]

### Memory Promotion Candidate
[Pattern that succeeded 3+ times, if any]
(or: None this session)
```

## Skill Precedence Matrix

When multiple skills trigger on the same input, resolve using this priority order:

| Priority | Layer | Purpose |
|---|---|---|
| 1 | operating-framework | Routes the task first: lane, risk, mode |
| 2 | using-operating-framework | Enforces gates second: TDD, root cause, approval |
| 3 | Lane-matching skill | Domain skill that matches the assigned lane |
| 4 | Supporting skills | Additional skills that provide patterns/templates |

## Conflict Resolution

When two same-priority skills both trigger:

- The skill matching the session lane wins.
- If both match the lane, the more specific skill wins.
- If still tied, apply both when complementary.

## Examples

| Request | Triggers | Resolution |
|---|---|---|
| "Fix the login API" | debug, api-design-patterns, security-review | Lane=Recover; debug leads, others support |
| "Add rate limiting" | api-design-patterns, security-review, coding-workflow | Lane=Specify; api-design-patterns leads |
| "Deploy the fix" | devops-patterns, security-review, git-workflows | Lane=Ship; devops-patterns leads |

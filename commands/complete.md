# /complete

> No "done" without proof. Generate the completion packet for the current task.

## Instructions

When invoked, generate a **completion packet** summarizing the work done in this
session. If invoked with `$ARGUMENTS`, use that as the task description; otherwise
infer from conversation context.

### Pre-Check

Before generating the packet, verify:

1. **Evidence exists** — Test output, logs, build results, or screenshots were shown.
   If not, list what evidence is still needed and **do not generate the packet**.
2. **All required artifacts were produced** — Check against the Artifact Matrix
   for the task type.
3. **All review findings were dispositioned** — Every finding must be accepted,
   deferred (with reason), or rejected (with reason).

If any pre-check fails, output what is missing and stop.

### Completion Packet Format

```markdown
## Completion Packet

**Task**: [description]
**Lane**: [lane taken]
**Risk**: [tier assigned]

### Summary
[1-3 sentences on what was done and why]

### Changed Files
- `[file path]`: [what changed]

### Artifacts Produced
- [artifact name]: [location or inline]

### Tests Run
- [test suite/file]: [PASS/FAIL, count]

### Evidence
[Inline or reference to: test output, logs, screenshots, build results]

### Risks Introduced
- [risk]: [mitigation]
(or: None identified)

### Rollback Path
[How to undo this change — git revert, config restore, etc.]

### Open Questions
- [anything unresolved]
(or: None)

### Next Step
[Recommended follow-up action]

### Memory Promotion Candidate
[Pattern that succeeded 3+ times, ready for promotion to template/checklist/skill]
(or: None this session)
```

### Post-Packet Actions

After generating the packet:

1. If a pattern succeeded 3+ times, suggest promoting it to the appropriate
   memory file (patterns.md, mistakes.md, or preferences.md).
2. If a new prevention strategy emerged, suggest adding it to mistakes.md.
3. If user preferences were clarified, suggest recording in preferences.md.

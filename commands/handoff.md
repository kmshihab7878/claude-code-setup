# /handoff

> Generate a session handoff packet for cross-conversation continuity.

## Instructions

When invoked, generate a handoff packet that allows the next conversation to
seamlessly resume the current work. Store it in `~/.claude/sessions/`.

### Handoff Packet Format

```markdown
# Session Handoff

**Generated**: [timestamp]
**Session ID**: [conversation identifier or date-based ID]

## Session Contract
TASK: [current task description]
LANE: [current lane]
RISK: [current tier]
MODE: [current mode]

## Progress
### Completed Steps
1. [step]: [outcome]
2. [step]: [outcome]

### Current Step
- [what's in progress right now]
- [what's blocking, if anything]

### Remaining Steps
1. [step]: [expected outcome]
2. [step]: [expected outcome]

## Files Touched
- `[file path]`: [what was changed and why]

## Key Decisions Made
- [decision]: [rationale]

## Blocking Issues
- [issue]: [what's needed to unblock]
(or: None)

## Context That Won't Be Obvious
- [insight that took investigation to discover]
- [assumption that was validated or invalidated]
- [dependency or constraint that's not in the code]

## To Resume
1. Read this handoff packet
2. [specific first action to take]
3. [verification to confirm context is loaded correctly]
```

### Storage

Save the packet to:
`~/.claude/sessions/handoff-[YYYY-MM-DD]-[short-task-name].md`

### When to Use

- End of a long session that isn't complete
- Before context compression on large tasks
- When switching between tasks mid-stream
- When the user says "let's pick this up later"

### Loading a Handoff

The next conversation should use `/context-load` or directly read the handoff
file to restore context. The "To Resume" section provides the exact steps.

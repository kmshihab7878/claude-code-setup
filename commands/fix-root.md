---
description: "Root cause diagnosis. Find the real problem, not just the symptom. Patch narrowly but safely. Add regression protection."
---

# /fix-root — Root Cause Fix Mode

Find the root cause. Do not patch symptoms.

## Protocol

1. **Reproduce** — Understand and confirm the failure. Trace the execution path.

2. **Diagnose** — Identify the root cause, not just the trigger. Distinguish between:
   - The symptom (what the user sees)
   - The trigger (what changed or what input causes it)
   - The root cause (the underlying defect)

3. **Scope** — Determine the blast radius. What else does this affect? Are there related bugs hiding behind the same root cause?

4. **Karpathy review (pre-patch)** — invoke `skills/karpathy-review/SKILL.md` on the diagnosis. Check Think Before Coding: were the assumptions about the root cause stated explicitly? Is the trigger being mistaken for the cause? Is there a simpler diagnosis we missed? If the verdict is ASK, ask the operator before patching.

5. **Fix** — Patch narrowly but safely:
   - Change only what needs to change
   - Preserve backward compatibility
   - Handle the edge cases the original code missed
   - Do not refactor unrelated code (Karpathy: Surgical Changes — debugging agents are the worst offenders here)

6. **Protect** — Add regression protection:
   - Add a test that would have caught this bug
   - If a test already exists but missed it, fix the test too
   - If the pattern is error-prone, add a comment explaining why

7. **Verify** — Confirm the fix works:
   - The original failure no longer occurs
   - Related flows still work
   - No new regressions introduced
   - Edge cases are covered

8. **Karpathy review (post-patch)** — invoke `skills/karpathy-review/SKILL.md` on the diff. Check Goal-Driven Execution: did we run the reproduction and confirm it now passes, or are we claiming "should be fixed" without evidence? Check Surgical Changes: did the patch touch only what the root cause demanded?

## Output

- Root cause explanation (one paragraph, precise)
- Files changed and why
- Test added or modified
- Verification performed
- Risk assessment of the fix

## Target

$ARGUMENTS

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

4. **Fix** — Patch narrowly but safely:
   - Change only what needs to change
   - Preserve backward compatibility
   - Handle the edge cases the original code missed
   - Do not refactor unrelated code

5. **Protect** — Add regression protection:
   - Add a test that would have caught this bug
   - If a test already exists but missed it, fix the test too
   - If the pattern is error-prone, add a comment explaining why

6. **Verify** — Confirm the fix works:
   - The original failure no longer occurs
   - Related flows still work
   - No new regressions introduced
   - Edge cases are covered

## Output

- Root cause explanation (one paragraph, precise)
- Files changed and why
- Test added or modified
- Verification performed
- Risk assessment of the fix

## Target

$ARGUMENTS

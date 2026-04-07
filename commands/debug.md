# Debug

Systematically debug the described issue using the RIFV cycle.

## Instructions

Use `$ARGUMENTS` as the bug description or error message.

### Step 1: Reproduce
- Understand the reported symptoms
- Identify the minimum steps to reproduce
- Read relevant error logs and stack traces

### Step 2: Isolate
- Trace the error from the stack trace to source code
- Read the relevant files and understand the code path
- Check recent git changes that might have introduced the bug
- Narrow down to the specific component, function, and line

### HARD GATE: Root Cause Required

Before fixing, you MUST state the root cause in **one sentence** backed by evidence.

- Evidence = specific file:line, log output, stack trace, or reproduction result
- If root cause is unknown, DO NOT proceed to Step 3. Investigate further.
- "I think it might be..." is NOT a root cause. "X fails because Y at file:line" IS.

### Step 3: Fix
- State the root cause clearly (gate requirement above)
- Write a test that reproduces the bug (fails before fix)
- Apply the minimal fix needed
- Ensure the test passes after the fix

### Step 4: Verify
- Run the full test suite to check for regressions
- Verify the original reproduction steps no longer trigger the bug
- Check edge cases related to the fix

Output:
- Root cause analysis with file:line references
- The fix applied (as a diff)
- Verification results
- Prevention suggestions

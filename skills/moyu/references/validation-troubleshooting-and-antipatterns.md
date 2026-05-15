# Validation, Troubleshooting, and Anti-Patterns

Self-validation procedures, common failure modes when applying Moyu, and the
anti-patterns that look like Moyu but aren't.

## Self-Validation Procedure

Before declaring a delivery complete, walk this in order:

1. **Read the user's original message verbatim.**
2. **List every change you made**, file by file.
3. **For each change, answer:** "Is this in the user's noun-verb?"
4. **Revert every "no".**
5. **Run the Moyu Checklist** (in `SKILL.md`) on the remaining diff.
6. **Estimate review time.** If a reviewer would take more than 30 seconds,
   the diff is probably too large.

If any of steps 3-5 fail, you have not finished the Moyu loop — go back to
the workflow's Step 4 in `references/workflow.md`.

## Checklist Failure Modes

Each Moyu Checklist item can fail in a specific, predictable way.

### "Did I only modify code the user explicitly asked me to change?"

| Failure mode | Recovery |
|--------------|----------|
| Touched an adjacent function while editing the requested one | Revert the adjacent change; keep only the requested edit |
| Touched a config file the user didn't mention | Revert; surface the config change as a separate question |
| Renamed a symbol "to be consistent" | Revert; ask the user if rename is desired |

### "Is there a way to achieve the same result with fewer lines?"

| Failure mode | Recovery |
|--------------|----------|
| Added a helper function called once | Inline it |
| Added a class when a function works | Replace with a function |
| Added a constant module for one value | Move the value next to its use site |

### "If I delete any line I added, would functionality break?"

| Failure mode | Recovery |
|--------------|----------|
| Try-catch around code that cannot throw | Remove the try-catch |
| Null check on a guaranteed-non-null value | Remove the check |
| Logging statement nobody asked for | Remove the log |
| Default parameter value never reached | Remove the default |

### "Did I touch files the user didn't mention?"

| Failure mode | Recovery |
|--------------|----------|
| Formatter ran on save and reformatted unrelated files | Revert those file changes; commit only the target file |
| "While I was here" edit to a neighboring file | Revert; the neighboring fix is a separate PR |
| Auto-import added an entry to an index file | Re-evaluate; if the index entry isn't required for the change, revert |

### "Did I search the codebase for existing reusable implementations?"

| Failure mode | Recovery |
|--------------|----------|
| Wrote a date formatter that already exists in `utils/date.ts` | Delete the new code; use the existing function |
| Wrote a validation helper that an upstream library already provides | Delete; use the library function |
| Reimplemented a pattern visible 3 directories away | Delete; copy the pattern (or reuse if shared) |

### "Did I add comments, docs, tests, or config the user didn't ask for?"

| Failure mode | Recovery |
|--------------|----------|
| Added JSDoc to an internal function | Remove |
| Added a unit test for a one-line fix | Remove unless the user invoked TDD |
| Added a comment explaining what the code already says | Remove |
| Added a config entry "for future flexibility" | Remove; the configurability is YAGNI |

### "Is my diff small enough for a 30-second code review?"

| Failure mode | Recovery |
|--------------|----------|
| Diff > 50 lines for what was a small request | Run L2 recovery (course correction) |
| Diff > 200 lines for what was a small request | Run L4 recovery (emergency brake) |
| Diff touches > 3 files | Revert everything outside the primary file unless the user named multiple files |

## Anti-Patterns — things that look like Moyu but aren't

Moyu is restraint applied to unrequested work. It is NOT:

### Refusing to do what the user asked

If the user explicitly asks for "complete error handling," deliver it.
Moyu does not justify under-delivery on a clear request. See "When Moyu
does NOT apply" in `SKILL.md` and `references/workflow.md`.

### Hiding bugs you found

If you find a bug while doing the requested work, **report it** to the user.
Do not silently fix it. Do not silently ignore it. Tell the user what you
found and let them decide.

### Skipping safety checks

If the requested work touches authentication, secrets, data integrity, or
production state, the safety considerations are part of the work — they
are not optional add-ons. Moyu does not justify shipping unsafe code.

### Refusing to refactor existing brokenness

If the requested change requires modifying a broken function to make the
change work at all, modifying that function is part of the requested work.
You are not adding unrequested refactor; you are completing the request.

### Holding back when the user iterates

If the user reviews your diff and says "expand this" or "also handle X,"
that is a new explicit request. Deliver fully on it. Moyu reset.

### Producing nothing because the request is vague

Moyu says ask, not freeze. If the request is ambiguous, ask one specific
question and then proceed.

## Common Pitfalls

| Pitfall | Symptom | Fix |
|---------|---------|-----|
| Pre-emptive abstraction | Created an interface "in case there's a second implementation" | Delete the interface; add it when the second implementation appears |
| Drive-by formatting | Whitespace / import order changes mixed with logic | Split into two commits or revert formatting changes |
| "Just one more" | Started with a 3-line fix that grew | Discard the diff; restart from the original ask |
| Apologetic comments | Comments like "// TODO: refactor later" | Delete; the comment is residue from over-thinking |
| Speculative parameters | Added a function parameter "for future use" | Remove; add when needed |
| Cascading rename | Renamed a symbol, propagated through the codebase | Revert; ask the user if the rename is desired |
| Conditional that can't happen | `if (x === null)` where x can't be null | Remove the check; trust the type system |

## Recognizing Moyu Mastery — the inverted checklist

If all of the following are true on delivery, the moyu loop is intact:

- [ ] The diff fits on one screen.
- [ ] A reviewer can understand it in 30 seconds.
- [ ] No file the user didn't name was touched.
- [ ] No new dependency was added without asking.
- [ ] No new abstraction was introduced.
- [ ] No drive-by formatting changes.
- [ ] No unrequested tests, docs, or comments.
- [ ] Each line you added is load-bearing — deleting it would break the requested behavior.

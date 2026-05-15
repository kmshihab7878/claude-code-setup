# Moyu Workflow — five-step delivery loop

The Moyu Checklist and L1-L4 detection levels live in `SKILL.md`. This
reference is the procedural walkthrough — how to apply moyu turn by turn
while working on a task.

## The Five-Step Loop

Run this loop on every code-affecting turn.

### Step 1: Parse the actual ask

Read the user's request literally. Underline (mentally) the noun and the
verb. Anything outside that noun-verb pair is **not** part of the task.

- Verb: "fix", "add", "change", "remove", "update".
- Noun: the specific function, file, behavior, or value.
- Scope modifier: a quantifier the user provided ("only", "just", "minimal").

If you cannot underline a noun and a verb, ask before coding.

### Step 2: Search the codebase before writing

Before writing any new code:

1. Does an existing function do this?
2. Does an existing pattern in the codebase model how to do this?
3. Does a built-in language or platform feature do this?
4. Does a dependency you already have do this?

The order matters. Reuse > pattern-match > built-in > new dependency > new code.

### Step 3: Plan the smallest diff

Sketch (in your head or on paper) the smallest possible diff that satisfies
the noun-verb pair from Step 1.

- One line if possible.
- One function if not.
- One file if not.
- One module if not.

If the diff exceeds one module, surface the question to the user before
proceeding.

### Step 4: Implement only the planned diff

Type only the lines you sketched. Resist drift:

- Do not rename adjacent symbols.
- Do not reformat adjacent code.
- Do not reorder imports.
- Do not "improve" surrounding logic.

If you accidentally touched something outside the planned diff, revert that
specific change before delivery.

### Step 5: Run the Moyu Checklist

Walk every item in the Moyu Checklist (in `SKILL.md`). If any answer is
"no," revise the diff before delivering.

## L1-L4 Intervention Detail

`SKILL.md` lists the trigger and headline action for each level. Full
recovery procedures below.

### L1 — Minor Over-Reach (Self-Reminder)

**Recovery procedure:**

1. Identify the 1-2 unnecessary changes (formatting, comments, micro-edits).
2. Revert each, one at a time, by diff inspection.
3. Continue with the user's actual task.

L1 should never reach the user as a delivery. Catch it on Step 4 or Step 5
of the loop.

### L2 — Clear Over-Engineering (Course Correction)

**Recovery procedure:**

1. Stop typing immediately.
2. Re-read the user's original request out loud (or paraphrase it).
3. Discard the current diff entirely.
4. Re-implement using the simplest approach Step 3 would have produced.
5. Run the Moyu Checklist before delivery.

If "re-implement from scratch" feels expensive, that is the cost of the
abstraction layer you added — pay it once.

### L3 — Severe Scope Violation (Scope Reset)

**Recovery procedure:**

1. Halt every modification.
2. Produce a literal change-by-change list:
   - File touched | Change | Was it asked for? (yes/no)
3. Revert every "no" row.
4. Confirm the remaining diff matches the original request.
5. If you cannot revert cleanly (cascading dependencies), surface the
   situation to the user with the full list before continuing.

L3 is the level that produces broken PR review experiences. Recovery is
non-negotiable.

### L4 — Total Loss of Control (Emergency Brake)

**Recovery procedure:**

1. Stop. Type nothing.
2. Apologize in one sentence; do not over-explain.
3. Restate the user's original request in one sentence.
4. Propose a minimal solution with no more than 10 lines of diff.
5. Wait for user confirmation before any further code change.

L4 is rare but signals the conversation has lost shared context. The fix is
explicit re-alignment, not more code.

## Cross-Skill Workflow

Moyu pairs with several skills; here is how they interact during a turn.

| Companion | How it interacts |
|-----------|------------------|
| PUA | Sets the floor (don't slack). Moyu sets the ceiling (don't over-do). Run both. |
| karpathy-review | The four Karpathy constraints (Think Before Coding, Simplicity First, Surgical Changes, Goal-Driven Execution) overlap heavily; karpathy-review is the reviewer hat, moyu is the producer hat. |
| coding-workflow | Moyu activates during code-writing turns; coding-workflow handles overall planning + delivery cadence. |
| test-driven-development | If the user explicitly invokes TDD, moyu does NOT apply to the tests being written — they are explicitly requested. |
| operating-framework | When operating-framework promotes a pattern repeatedly, moyu can be relaxed for that pattern (it is now requested by precedent). |

## When the User Asks for More Than Minimum

Moyu suppresses unsolicited expansion. It does **not** suppress solicited
expansion. Moyu does not apply when the user explicitly asks for:

- "Complete error handling".
- "Refactor this module".
- "Add comprehensive tests".
- "Add documentation".
- "Make it production-ready".
- "Polish this for review".

When the user invokes any of these, deliver fully on the request. Moyu's
principle is **don't do what wasn't asked for**, not **refuse to do what was asked for**.

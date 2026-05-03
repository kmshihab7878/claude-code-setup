---
description: "Full implementation mode. Inspect repo → plan → build → validate → deliver. No placeholders, no scaffolds, launch-day standard."
---

# /ship — Elite Implementation Mode

Activate Elite Ship Mode for this task.

## Directive

You are shipping a production-ready implementation. Not a sketch, not a scaffold, not a starting point.

## Execution Order

1. **Repo Assimilation** — Inspect the codebase. Identify framework, patterns, conventions, and the native implementation path for this type of work. Use the `repo-index` agent if available.

2. **Build Intent** — One paragraph: what you are building and why this approach fits the repo.

3. **3 Key Decisions** — The highest-leverage technical choices.

4. **Locked Assumptions** — What you are relying on. Mark weak assumptions `[provisional]`.

5. **Implementation Plan** — File-aware, concrete. Include migrations, API updates, UI implications, test implications, risk areas.

6. **Karpathy review (pre-edit)** — invoke `skills/karpathy-review/SKILL.md` on the plan. Check Think Before Coding (assumptions stated? ambiguity surfaced?) and Simplicity First (is this the smallest version that satisfies the goal? any speculative abstractions?). If the verdict is SIMPLIFY or ASK, address before implementing. Skip for trivial work.

7. **Implementation** — Execute the changes. Complete, integrated, backward-compatible. No TODOs, no mock values, no dead branches.

8. **Karpathy review (post-edit)** — invoke `skills/karpathy-review/SKILL.md` on the diff. Check Surgical Changes (every line trace to the request? drive-by edits?) and Goal-Driven Execution (success criterion met? verification ran?). If SIMPLIFY, trim the diff before validation.

9. **Validation** — Run type checks, lint, tests. Describe manual verification flow. Cover edge cases.

10. **Ship Summary** — What changed, why it is safe, remaining optional follow-ups.

## Rules

- Do not stop at planning unless blocked by missing data or destructive ambiguity
- Do not ask for permission to proceed — inspect and decide
- Ask one sharp question only if the ambiguity would materially change architecture or user-visible behavior
- Build like the result will be reviewed by senior engineers, used by real users, and deployed today
- Karpathy constraints (`CLAUDE.md § Karpathy Operating Constraints`) apply with full weight to non-trivial work — Simplicity First, Surgical Changes, no drive-by refactors

## Task

$ARGUMENTS

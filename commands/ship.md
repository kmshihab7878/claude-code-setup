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

6. **Implementation** — Execute the changes. Complete, integrated, backward-compatible. No TODOs, no mock values, no dead branches.

7. **Validation** — Run type checks, lint, tests. Describe manual verification flow. Cover edge cases.

8. **Ship Summary** — What changed, why it is safe, remaining optional follow-ups.

## Rules

- Do not stop at planning unless blocked by missing data or destructive ambiguity
- Do not ask for permission to proceed — inspect and decide
- Ask one sharp question only if the ambiguity would materially change architecture or user-visible behavior
- Build like the result will be reviewed by senior engineers, used by real users, and deployed today

## Task

$ARGUMENTS

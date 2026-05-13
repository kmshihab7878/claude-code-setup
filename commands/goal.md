---
description: Run one bounded autonomous objective from goal to verified deliverable using success criteria, constraints, progress tracking, and proof.
---

# /goal

Run one bounded objective from clear goal to verified deliverable.

`/goal` is for end-to-end execution when the objective, success criteria, and
constraints are clear enough to continue without constant user prompts.

It is not permission to bypass safety gates. It operates inside the existing
repository rules, risk tiers, approval requirements, MCP governance, validation,
and public-safety checks.

## Quick form

```text
/goal [final outcome] until [measurable success criteria] without [constraints]
```

## Full form

```text
/goal [the final outcome: what done looks like in one line]
Context:
- Project: [what is being built]
- Stack: [languages, frameworks, infrastructure]
- Current state: [what exists today]
- Working area: [repo path or scope]
- Constraints: [budget, time, off-limits items]
- Audience: [who this is for]
Success criteria:
1. [specific measurable outcome]
2. [specific measurable outcome]
3. [specific measurable outcome]
4. Final deliverable runs without errors.
5. Proof is available through test output, command output, screenshot reference, or URL.
Checklist: [optional .md file for progress tracking]
```

## Operating rules

1. Plan first. Create or reference a numbered task list before editing.
2. Work autonomously only within existing safety boundaries.
3. Ask for clarification only when genuinely blocked by missing information or
   required approval.
4. Self-verify after every meaningful change.
5. Debug failures. If a check fails, diagnose and fix it before reporting
   completion.
6. Use available safe tools: repo inspection, terminal commands, tests, docs,
   and approved MCP tools.
7. Do not leave placeholders, TODOs, stubs, or fake outputs unless explicitly
   requested.
8. Track progress for multi-step goals: completed, in-flight, decisions, and
   blockers.
9. Stay on goal. Log out-of-scope discoveries as follow-ups.
10. Check all success criteria before stopping.

## Quality bar

- Code follows project conventions.
- Changes are minimal and scoped.
- Tests or validation run where applicable.
- Public-facing docs are clear and adoption-friendly.
- No secrets, credentials, private context, session records, local absolute
  paths, or personal identifiers enter tracked files.
- Final answer includes proof, not just claims.

## Execution loop

1. Restate the objective.
2. Convert the goal into measurable success criteria.
3. Identify constraints, off-limits areas, and approval gates.
4. Inspect relevant files before editing.
5. Create or maintain a short checklist for multi-step work.
6. Execute the smallest safe increment.
7. Validate the increment.
8. Fix failures.
9. Repeat until success criteria are met.
10. Produce the final deliverable and report.

## Pairing with existing commands

- Use `/plan` before `/goal` for ambiguous, high-risk, or multi-system work.
- Use `/review` before completion when code, docs, security, or architecture
  quality matters.
- Use `/complete` to produce a final completion packet.
- Use `/handoff` if the goal cannot be completed in the current session.

## Examples

```text
/goal improve README so a new contributor can install, validate, and run the repo until scripts/validate.sh passes without warnings, without changing runtime behavior
/goal research current options for [topic] until there is a concise comparison table and recommendation, without using unverified sources
/goal add a dark/light theme toggle until it persists in localStorage and is verified in browser, without changing unrelated UI behavior
/goal create a clear visual explanation for [topic] until it is ready to share, without using private or copyrighted source material
```

## Final response format

When complete, report:

1. Objective.
2. Success criteria and whether each was met.
3. Files created or modified.
4. Validation performed.
5. Proof or evidence.
6. Decisions made.
7. Remaining risks or limitations.
8. Recommended next action.

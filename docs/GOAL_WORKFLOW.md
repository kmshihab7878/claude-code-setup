# Goal Workflow

`/goal` is a bounded autonomous-work pattern for one clear objective. It keeps
the agent moving from goal to proof when the outcome, success criteria, and
constraints are already clear enough to act.

## What It Is

- One objective with a measurable done-state.
- A plan-first execution loop.
- Progress tracking for longer work.
- Self-verification after meaningful changes.
- A final report with evidence.

## What It Is Not

- Not an agent bypass mode.
- Not permission to skip approval gates.
- Not a way to run destructive, credential, production, security-sensitive, or
  irreversible actions without explicit approval.
- Not a vague request to "do everything."

## When To Use It

- The objective is clear.
- The working scope is bounded.
- Success can be checked through tests, commands, screenshots, URLs, or file
  inspection.
- The agent can proceed without asking the user to approve every small step.

## When Not To Use It

- The goal is ambiguous or strategic.
- The work is high-risk, shared-state, production, financial, or irreversible.
- The success criteria are not measurable.
- The request needs product decisions the repo cannot answer.

Use `/plan` first for ambiguous, high-risk, or multi-system work.

## Formula

```text
/goal [final outcome] until [measurable done-state] without [constraints]
```

The three parts are:

- Final outcome: what done looks like in one line.
- Measurable done-state: the checks that prove completion.
- Constraints: off-limits files, risk limits, time, budget, or behavior that must
  not change.

## Full Structure

```text
/goal [the final outcome]
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
Checklist: [optional .md file for progress tracking]
```

## Operating Rules

- Plan first.
- Work autonomously within existing safety gates.
- Self-verify after each meaningful change.
- Diagnose and fix failed checks before reporting completion.
- Do not leave placeholders, TODOs, stubs, or fake outputs unless explicitly
  requested.
- Keep a progress log for longer goals.
- Stay on goal; record out-of-scope discoveries as follow-ups.
- Re-check success criteria before stopping.

## Quality Bar

- Code follows project conventions and is typed where applicable.
- Changes are small and scoped.
- Design and docs are clear for a new adopter.
- Output can pass a serious review.
- Security posture is unchanged: no secrets, credentials, private context,
  session records, local absolute paths, or personal identifiers enter tracked
  files.

## How It Differs From /plan

`/plan` decides what should be done and surfaces tradeoffs before implementation.
`/goal` executes a bounded objective after the outcome and constraints are clear.
If the goal needs unresolved decisions, run `/plan` first.

## Pairing With Other Commands

- `/plan`: use before `/goal` when scope, risk, or approach is unclear.
- `/review`: use before completion when quality or safety needs a second pass.
- `/complete`: use to generate a completion packet with evidence.
- `/handoff`: use when the goal cannot be completed in the current session.

## Safety Rules

- Do not bypass approval gates.
- Do not take destructive actions without explicit approval.
- Do not put secrets in tracked files.
- Do not commit private context.
- Run relevant validation before completion.

## Examples

```text
/goal research options for [topic] until there is a concise comparison table and recommendation, without unverified sources
/goal update docs in [scope] until a new adopter can follow the setup path, without changing runtime behavior
/goal add [feature] until tests cover the new behavior and pass, without touching unrelated modules
/goal create a visual explanation for [topic] until it is ready to share, without private or copyrighted source material
```

## Checklist Template

```markdown
# Goal Checklist

## Objective

[One-line outcome]

## Success criteria

- [ ] [measurable criterion]
- [ ] [measurable criterion]
- [ ] [measurable criterion]

## Constraints

- [constraint]
- [off-limits item]

## Progress

- [ ] Inspect relevant files
- [ ] Plan steps
- [ ] Implement
- [ ] Validate
- [ ] Fix failures
- [ ] Final report

## Evidence

- Command output:
- Test output:
- Files changed:
- Known limitations:
```

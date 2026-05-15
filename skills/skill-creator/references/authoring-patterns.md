# Skill Authoring Patterns

Long-form authoring patterns and examples extracted from `../SKILL.md`.

## Instruction Style

Use imperative instructions:

- "Inspect the file before editing."
- "Run validation after each meaningful change."
- "Ask one clarifying question when the output contract is ambiguous."

Prefer practical reasoning over rigid phrasing:

- Explain why a rule matters.
- Avoid excessive "ALWAYS" and "NEVER" unless the rule is safety-critical.
- Keep guidance general enough to handle future prompts.
- Avoid overfitting to a single example or user.

## Theory Of Mind

Good skills help Claude infer the user's likely intent without turning every
step into a brittle script. Include:

- what the user is trying to accomplish
- why the workflow is ordered this way
- what failure modes to watch for
- what evidence proves completion

## Minimal Output Format Pattern

Use exact templates only when structure matters.

```markdown
## Report structure

Use this template:

# [Title]
## Executive summary
## Key findings
## Recommendations
```

For flexible tasks, state required fields and allow natural presentation.

## Example Pattern

```markdown
## Commit message format

Example:
Input: Added user authentication with JWT tokens
Output: feat(auth): implement JWT-based authentication
```

Keep only one or two examples in `SKILL.md`. Move larger sets here.

## Description Authoring Pattern

Descriptions should answer:

1. What does the skill do?
2. When should it trigger?
3. What nearby cases should also trigger?
4. What cases should not trigger?

Example:

```yaml
description: Create KPI dashboards from business metrics. Use when the user asks for dashboards, reporting views, charts, scorecards, or visualizing company metrics. Do not use for general spreadsheet cleanup unless visualization or reporting is requested.
```

## Strong Skill Body Pattern

```markdown
# Skill Name

## Purpose
One paragraph describing the durable capability.

## When To Use
- Trigger condition 1
- Trigger condition 2
- Near-miss condition that should still trigger

## Inputs
- Required input
- Optional input

## Workflow
1. Inspect context.
2. Choose variant.
3. Execute.
4. Validate.
5. Report evidence.

## Safety
- Constraint 1
- Constraint 2

## Output
- Artifact or response shape
- Validation evidence

## References
- `references/detail.md` when deeper detail is needed.
```

## Script Bundling Pattern

If multiple eval runs or transcripts show Claude recreating the same helper,
turn that helper into a script:

1. Identify repeated code.
2. Write a small script under `scripts/`.
3. Document inputs and outputs in `SKILL.md`.
4. Add test prompts that require the script.
5. Prefer running the script over retyping logic.

## Reference Pattern

Use references when details are important but not always needed:

```markdown
Read `references/aws.md` only when deploying to AWS.
Read `references/errors.md` only when validation fails.
```

Do not hide essential routing or safety rules exclusively in references.

## Anti-Patterns

- A skill that only says "be helpful".
- A skill that is a huge pasted article with no operating workflow.
- A description that names the topic but not the trigger conditions.
- Long examples in `SKILL.md` that are irrelevant for most invocations.
- Hidden safety rules buried in references.
- Overly rigid instructions that prevent useful adaptation.
- Capability claims without validation instructions.

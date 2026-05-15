# Testing Protocol and Prompt Standards

Purpose: Test cases, test report format, and prompt engineering standards for reliability work.

## Minimum Test Set

1. Normal input.
2. Minimal input.
3. Ambiguous input.
4. Adversarial input.
5. Off-scope input.

## Extended Test Set

Add these for important systems:

6. Conflicting requirements.
7. Noisy user language.
8. Missing context.
9. Edge-domain terminology.
10. Format-breaking attempts.

## Test Report Format

| Input | Expected | Actual | Pass/Fail | Root Cause | Fix Priority |
|---|---|---|---|---|---|

## Prompt Engineering Standards

1. Preserve intent: rewrites must keep original business goal, scope, audience, and tone.
2. Observable constraints: convert instructions into checkable criteria.
3. Diagnosis before repair: identify what fails, explain why, fix, then test.
4. Structured outputs: default to named sections, tables, checklists, or schemas.
5. Minimum viable complexity: add complexity only when it improves reliability.

## Production Audit Rubric

| Score | Level |
|---|---|
| 9-10 | Production-grade |
| 7-8 | Usable, minor launch risks |
| 5-6 | Fragile under variation |
| 3-4 | Vague or inconsistent |
| 1-2 | Broken; start over or repair |

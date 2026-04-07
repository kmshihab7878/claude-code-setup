# Prompt Reliability Playbook

Companion to `~/.claude/skills/prompt-reliability-engine/SKILL.md`.
Operational rules for applying the 9-mode reliability framework in daily work.

## Mission

Make every prompt, skill, and workflow more durable, repeatable, and production-grade.

## Daily Working Rules

When asked for a prompt, workflow, assistant behavior, or reusable instruction set:

1. Infer likely failure modes FIRST
2. Build or repair with explicit constraints
3. Lock output format when consistency matters
4. Stress-test when reliability matters
5. Score readiness before calling something production-ready
6. Prune weak language (apply anti-slop rules)
7. Convert repeated work into staged systems
8. Add reflection and improvement loops where reuse is expected

## What "production-ready" means

- Hard to misinterpret
- Resilient to noisy inputs
- Structured enough to test
- Lean enough to maintain
- Passes Mode 7 audit with all dimensions >= 7/10

## Response to common requests

### "Here's my prompt" (paste)
Do NOT just improve wording. Instead:
1. Diagnose failures (Mode 1)
2. Identify root causes
3. Tighten constraints (Mode 4)
4. Lock format (Mode 5)
5. Show revised version with change log
6. Score reliability (Mode 7)

### "Build me a prompt for X"
Do NOT draft immediately. Instead:
1. Infer goal, audience, output contract
2. Identify likely failure modes (Mode 2)
3. Build safeguards into first version
4. Provide 5 test cases (Mode 3)
5. Deliver production-ready version

### "Is this good enough?"
Run full audit (Mode 7):
- Clarity, output structure, constraints, edge cases, tone stability
- Anything below 7/10 = launch risk

## Default deliverable formats

- Prompt + rationale
- Before/after comparison
- Scorecard (5-dimension)
- Test matrix (10 cases)
- Workflow map (for multi-stage)
- Handoff schema (for pipelines)
- Versioned improvement log (for reusable systems)

## Improvement memory

When a prompt repeatedly fails for the same reason:
1. Name the pattern
2. Add to Failure Pattern Library
3. Codify the fix as a constraint
4. Apply the constraint in future prompts
5. Update `~/.claude/projects/*/memory/mistakes.md` if cross-session

## Internal workflow (silent)

For every prompt-related task, silently run:
1. Identify task type
2. Select mode(s)
3. Infer failure modes
4. Check for vague language
5. Check output format lock
6. Decide if stress-testing needed
7. Deliver result
8. Add improvement note if high-leverage
9. Log lessons for session consistency

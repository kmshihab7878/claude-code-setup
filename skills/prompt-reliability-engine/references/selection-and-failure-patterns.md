# Mode Selection and Failure Patterns

Purpose: Mode selection algorithm and failure-pattern library.

## Mode Selection Algorithm

```text
IF user gives a broken prompt:
  -> Failure Repair -> Constraint Engineer -> Output Lock -> Audit

IF user asks to build from scratch:
  -> Skill Builder -> Stress-Test -> Output Lock -> Audit

IF user asks "is this good enough?":
  -> Stress-Test -> Audit

IF outputs are inconsistent:
  -> Output Lock -> Constraint Engineer -> Language Pruning

IF user wants a reusable system:
  -> Workflow Architect -> Self-Improving Skill

IF user wants stricter wording:
  -> Language Pruning

DEFAULT:
  -> Infer best mode and state it briefly
```

## Failure Pattern Library

Always scan for these root causes:

| Category | Patterns |
|---|---|
| Instruction | Ambiguous verbs, conflicting directives, missing success criteria, unclear audience or scope |
| Constraint | No hard limits, no measurable rules, soft hedging, missing exclusions |
| Format | Undefined structure, no section order, inconsistent tone, variable length |
| Robustness | No edge-case handling, no adversarial resistance, brittle input assumptions |
| Workflow | Too many jobs in one prompt, no handoffs, no checkpoints, no test cases |
| Learning | No reflection loop, no logging, repeated mistakes without codification |

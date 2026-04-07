---
name: prompt-reliability-engine
description: >
  9-mode prompt reliability framework: diagnose, repair, stress-test, constrain, lock, architect,
  audit, prune, and self-improve prompts, skills, and workflows. Treats prompting as engineering.
risk: low
tags: [process, quality, testing, meta, skills]
created: 2026-03-25
updated: 2026-03-25
---

# Prompt Reliability Engine

Systematic framework for making prompts, skills, and workflows production-grade through
9 operating modes: failure repair, skill building, stress-testing, constraint engineering,
output locking, workflow architecture, production audit, language pruning, and self-improvement.

## How to use

- `/prompt-reliability-engine`
  Run a reliability audit on the current prompt or skill context.

- `/prompt-reliability-engine <mode> <target>`
  Apply a specific mode (repair, build, stress-test, constrain, lock, architect, audit, prune, improve) to the target.

## When to use

- User provides a weak, failing, or inconsistent prompt
- Building a new skill, command, or reusable instruction set
- Evaluating whether a prompt is production-ready
- Outputs drift in format, length, tone, or structure
- Converting a single prompt into a multi-stage pipeline
- Tightening vague instructions into testable constraints
- Adding feedback loops to skills that will be reused

## When NOT to use

- Simple one-shot questions that need a direct answer
- Code-only tasks with no prompt engineering component
- Tasks already governed by jarvis-core pipeline (unless auditing the pipeline prompts themselves)

---

## The 9 Modes

### Mode 1: Failure Repair

**Trigger**: User provides a broken, weak, or underperforming prompt.

**Process**:
1. Read the prompt. Identify exact failure patterns.
2. Map each failure to a structural fix.
3. Rewrite only what is needed — preserve intent.
4. Re-test conceptually against sample inputs.
5. Report new baseline.

**Output contract**:
| Section | Required |
|---------|----------|
| Failure Diagnosis | Yes |
| Root Causes | Yes |
| Fixed Prompt | Yes |
| Change Log (by failure type) | Yes |
| Re-Test Matrix | Yes |
| Reliability Score (1-10) | Yes |
| Confidence Rating | Yes |

**Rules**:
- Fix root causes only. No cosmetic rewrites.
- Distinguish structural fixes from stylistic edits.
- Preserve user intent, scope, tone unless tone IS the problem.

---

### Mode 2: Skill Builder

**Trigger**: User wants a prompt, skill, or workflow built from scratch.

**Process**:
1. Clarify end goal + audience + output contract.
2. Infer top 3 failure modes.
3. Design with preventive safeguards built in.
4. Add constraints, format requirements, boundary conditions.
5. Stress-test on 5+ edge cases before finalizing.
6. Deliver production-ready artifact.

**Output contract**:
| Section | Required |
|---------|----------|
| Goal Definition | Yes |
| Top 3 Failure Risks | Yes |
| Production Prompt/Skill | Yes |
| Safeguards Embedded | Yes |
| Edge Case Tests | Yes |
| Usage Notes | Yes |

**Rules**:
- Prevention over repair.
- Build for real-world input noise, not clean demos.
- Follow `~/.claude/skills/_shared/skill-template.md` for skills.
- Apply `~/.claude/skills/_shared/review-checklist.md` before delivery.

---

### Mode 3: Stress-Test

**Trigger**: User wants to know how breakable a prompt or skill is.

**Process**:
1. Generate 10 adversarial inputs:
   - Ambiguous, adversarial, incomplete, conflicting, off-topic, edge-domain,
     format-breaking, noisy language, missing context, conflicting requirements
2. Run conceptual tests against current prompt.
3. Log exact breakage points.
4. Rank severity (critical / high / medium / low).
5. Report BEFORE proposing fixes.

**Output contract**:
| Section | Required |
|---------|----------|
| Adversarial Input Set (10) | Yes |
| Failure Log | Yes |
| Severity Rankings | Yes |
| Stress-Test Score (1-10) | Yes |
| Fix Recommendations | On request |

**Rules**:
- Report breakage before repair.
- Never hide weaknesses.
- Differentiate minor inconsistency from total failure.

---

### Mode 4: Constraint Engineer

**Trigger**: Instructions are vague, soft, or interpretive.

**Process**:
1. Scan for fuzzy phrases.
2. Rewrite each as a specific, enforceable rule.
3. Convert abstract goals into observable criteria.
4. Re-test on 5 sample inputs.

**Transform table**:
| Vague | Constrained |
|-------|------------|
| "be clear" | "Use exactly N sections, each 80-120 words" |
| "make it good" | "Include 1 example + 1 counterexample per point" |
| "keep it concise" | "Max 150 words total, no bullet points unless requested" |
| "try to" | Delete or replace with "MUST" |
| "if possible" | Delete or state the specific condition |
| "be thoughtful" | "Address the top 3 objections explicitly" |
| "write naturally" | "Use active voice, 12th-grade reading level, no jargon" |

**Output contract**: Vague list, constraint rewrites, before/after comparison, consistency score.

---

### Mode 5: Output Lock

**Trigger**: Outputs drift in length, structure, tone, naming, or format.

**Process**:
1. Diagnose the drift pattern.
2. Define fixed sections + order.
3. Set rules: length limits, naming, formatting, allowed/forbidden content.
4. Embed template directly in the prompt.
5. Verify consistency across 3+ conceptual runs.

**Rules**:
- Name every section explicitly.
- Fix the order. Use numeric limits.
- Specify what MUST NOT appear.
- MUST match existing anti-slop rules from CLAUDE.md.

---

### Mode 6: Workflow Architect

**Trigger**: Single prompt should become a multi-stage pipeline.

**Process**:
1. Map the full workflow.
2. Break into phases (one job per phase).
3. Assign one skill/prompt per phase.
4. Define exact handoff output format between phases.
5. Add checkpoints to catch defects early.
6. Test end-to-end on 3 realistic cases.

**Standard phase pattern**:
```
Phase 1: Intake (parse intent, classify)
Phase 2: Clarification (ask typed questions: MISSING_INFO, AMBIGUOUS, APPROACH_CHOICE)
Phase 3: Draft Generation
Phase 4: Constraint Check (apply Mode 4)
Phase 5: Stress Test (apply Mode 3)
Phase 6: Final Packaging
Phase 7: Reflection + Improvement Log
```

**Integration**: Workflows SHOULD map to the CoreMind 10-stage pipeline when applicable.

---

### Mode 7: Production Readiness Audit

**Trigger**: Deciding whether a prompt/skill is ready for use.

**Score 5 dimensions (1-10)**:

| Dimension | Question |
|-----------|----------|
| Clarity | Are instructions unambiguous and specific? |
| Output Format | Is the output structure locked and consistent? |
| Constraint Power | Are rules measurable and enforceable? |
| Edge-Case Handling | Does it survive adversarial/noisy inputs? |
| Tone Stability | Does tone remain consistent across inputs? |

**Rules**:
- Quote exact evidence for each score.
- Flag anything below 7 as launch risk.
- Overall score = weighted average (equal weights).
- Priority fixes = highest-leverage first.

**Scoring rubric**:
| Score | Level |
|-------|-------|
| 9-10 | Production-grade. Ship it. |
| 7-8 | Usable, minor launch risks. |
| 5-6 | Fragile under variation. Fix before use. |
| 3-4 | Vague, inconsistent. Major rework needed. |
| 1-2 | Broken. Start over or apply Failure Repair. |

---

### Mode 8: Language Pruning

**Trigger**: Prompt wording weakened by hedging, filler, or soft phrasing.

**Flag and remove**:
- try, maybe, if possible, generally, sort of, usually
- you can, feel free to, as needed, be thoughtful, make it nice
- Any phrase from the anti-slop list in CLAUDE.md

**Process**:
1. Flag weakening phrases.
2. Delete, replace, or tighten each.
3. Produce cleaner version.
4. Compare word count + clarity.

**Rules**:
- Remove softness that causes ambiguity.
- Keep legitimate uncertainty when truthfully required.
- Apply CLAUDE.md anti-slop rules: never use "delve", "leverage", "streamline",
  "robust", "cutting-edge", "game-changer", "innovative", "seamless", "holistic",
  "synergy", "paradigm", "ecosystem" (buzzword), "utilize", "facilitate", "empower".

---

### Mode 9: Self-Improving Skill

**Trigger**: Prompt or system will be reused repeatedly.

**Process**:
1. Identify recurring error categories.
2. Design failure logging structure.
3. Add reflection loop that extracts lessons.
4. Convert lessons into constraints or checks.
5. Compare baseline vs improved performance.
6. Provide repeatable improvement cycle.

**Failure log schema**:
```yaml
- task_type: <string>
  input_pattern: <string>
  output_issue: <string>
  root_cause: <string>
  severity: critical | high | medium | low
  fix_candidate: <string>
  validated: true | false
  date: <YYYY-MM-DD>
  version: <string>
```

**Integration**: Feeds into `~/.claude/projects/*/memory/mistakes.md` for cross-session learning.
Patterns that succeed 3+ times get promoted to skill templates (Operating Framework promotion policy).

---

## Mode Selection Algorithm

```
IF user gives a broken prompt:
  → Failure Repair → Constraint Engineer → Output Lock → Audit

IF user asks to build from scratch:
  → Skill Builder → Stress-Test → Output Lock → Audit

IF user asks "is this good enough?":
  → Stress-Test → Audit

IF outputs are inconsistent:
  → Output Lock → Constraint Engineer → Language Pruning

IF user wants a reusable system:
  → Workflow Architect → Self-Improving Skill

IF user wants stricter wording:
  → Language Pruning

DEFAULT (not specified):
  → Infer best mode, state briefly: "Mode: Failure Repair + Constraint Tightening"
```

---

## Failure Pattern Library

Always scan for these root causes:

| Category | Patterns |
|----------|----------|
| Instruction | Ambiguous verbs, conflicting directives, missing success criteria, unclear audience/scope |
| Constraint | No hard limits, no measurable rules, soft hedging, missing exclusions |
| Format | Undefined structure, no section order, inconsistent tone, variable length |
| Robustness | No edge-case handling, no adversarial resistance, brittle input assumptions |
| Workflow | Too many jobs in one prompt, no handoffs, no checkpoints, no test cases |
| Learning | No reflection loop, no logging, same mistakes repeated without codification |

---

## Testing Protocol

**Minimum test set** (5 cases):
1. Normal input
2. Minimal input
3. Ambiguous input
4. Adversarial input
5. Off-scope input

**Extended test set** (add for important systems):
6. Conflicting requirements
7. Noisy user language
8. Missing context
9. Edge-domain terminology
10. Format-breaking attempts

**Test report format**:
| Input | Expected | Actual | Pass/Fail | Root Cause | Fix Priority |
|-------|----------|--------|-----------|------------|-------------|

---

## Prompt Engineering Standards

1. **Preserve intent** — rewrites MUST keep original business goal, scope, audience, tone
2. **Observable constraints** — convert instructions into checkable criteria (counts, schemas, required/forbidden fields)
3. **Diagnosis before repair** — identify what fails, explain why, THEN fix, THEN test
4. **Structured outputs** — default to named sections, tables, checklists, JSON schemas
5. **Minimum viable complexity** — complexity only when it directly improves reliability

---

## Integration with Existing Setup

| This Skill | Works With |
|------------|-----------|
| Mode 2 (Skill Builder) | `skill-creator`, `skill-architect` skills |
| Mode 3 (Stress-Test) | `test-driven-development`, `property-based-testing` |
| Mode 4 (Constraint Engineer) | `confidence-check`, `verification-before-completion` |
| Mode 6 (Workflow Architect) | `jarvis-core` pipeline, `operating-framework` |
| Mode 7 (Audit) | `python-quality-gate`, `security-review` |
| Mode 8 (Pruning) | Anti-slop rules in CLAUDE.md |
| Mode 9 (Self-Improving) | `autoresearch` loop, memory system |
| Agent dispatch | `prompt-engineer` (L3), `ai-engineer` (L2) |

---

## Cross-references

- **skill-creator** skill: creating new skills (this skill audits them)
- **skill-architect** skill: designing skill systems (this skill stress-tests them)
- **autoresearch** skill: iterative improvement loops (Mode 9 extends this)
- **confidence-check** skill: pre-implementation validation (Mode 7 extends this)
- **operating-framework** skill: promotion policy for patterns that succeed 3+ times
- **prompt-engineer** agent: L3 specialist that uses this skill

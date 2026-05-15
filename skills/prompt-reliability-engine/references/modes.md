# Prompt Reliability Modes

Purpose: Detailed procedures, output contracts, and rules for the 9 prompt reliability modes.

## Mode 1: Failure Repair

Trigger: user provides a broken, weak, or underperforming prompt.

Process:

1. Read the prompt and identify exact failure patterns.
2. Map each failure to a structural fix.
3. Rewrite only what is needed and preserve intent.
4. Re-test conceptually against sample inputs.
5. Report new baseline.

Output: failure diagnosis, root causes, fixed prompt, change log, re-test matrix, reliability score, confidence rating.

Rules:

- Fix root causes only.
- Distinguish structural fixes from stylistic edits.
- Preserve user intent, scope, and tone unless tone is the problem.

## Mode 2: Skill Builder

Trigger: user wants a prompt, skill, or workflow built from scratch.

Process:

1. Clarify end goal, audience, and output contract.
2. Infer top 3 failure modes.
3. Design preventive safeguards.
4. Add constraints, format requirements, and boundary conditions.
5. Stress-test on 5+ edge cases.
6. Deliver production-ready artifact.

Output: goal definition, top 3 failure risks, production artifact, safeguards, edge-case tests, usage notes.

Rules:

- Prevention over repair.
- Build for real-world input noise.
- Apply the repo's skill templates and review checklists when present.

## Mode 3: Stress-Test

Trigger: user wants to know how breakable a prompt or skill is.

Process:

1. Generate 10 adversarial inputs: ambiguous, adversarial, incomplete, conflicting, off-topic, edge-domain, format-breaking, noisy language, missing context, conflicting requirements.
2. Run conceptual tests against current prompt.
3. Log exact breakage points.
4. Rank severity: critical, high, medium, low.
5. Report before proposing fixes.

Output: adversarial input set, failure log, severity rankings, stress-test score, optional fix recommendations.

## Mode 4: Constraint Engineer

Trigger: instructions are vague, soft, or interpretive.

Process:

1. Scan for fuzzy phrases.
2. Rewrite each as a specific, enforceable rule.
3. Convert abstract goals into observable criteria.
4. Re-test on sample inputs.

Examples:

| Vague | Constrained |
|---|---|
| be clear | Use exactly N sections, each 80-120 words |
| make it good | Include 1 example and 1 counterexample per point |
| keep it concise | Max 150 words total |
| try to | Delete or replace with MUST |
| if possible | Delete or state the condition |
| be thoughtful | Address the top 3 objections explicitly |

## Mode 5: Output Lock

Trigger: outputs drift in length, structure, tone, naming, or format.

Process:

1. Diagnose drift pattern.
2. Define fixed sections and order.
3. Set length, naming, formatting, allowed, and forbidden content rules.
4. Embed template directly.
5. Verify consistency across 3+ conceptual runs.

Rules:

- Name every section explicitly.
- Fix the order.
- Use numeric limits.
- Specify what must not appear.

## Mode 6: Workflow Architect

Trigger: a single prompt should become a multi-stage pipeline.

Standard phase pattern:

```text
Phase 1: Intake
Phase 2: Clarification
Phase 3: Draft Generation
Phase 4: Constraint Check
Phase 5: Stress Test
Phase 6: Final Packaging
Phase 7: Reflection + Improvement Log
```

Define exact handoff output formats and checkpoints.

## Mode 7: Production Readiness Audit

Trigger: deciding whether a prompt or skill is ready for use.

Score 5 dimensions:

| Dimension | Question |
|---|---|
| Clarity | Are instructions unambiguous and specific? |
| Output Format | Is the output structure locked and consistent? |
| Constraint Power | Are rules measurable and enforceable? |
| Edge-Case Handling | Does it survive noisy inputs? |
| Tone Stability | Does tone remain consistent? |

Rules:

- Quote exact evidence for each score.
- Flag anything below 7 as launch risk.
- Overall score is equal-weight average unless user says otherwise.

## Mode 8: Language Pruning

Trigger: prompt wording is weakened by hedging, filler, or soft phrasing.

Flag and remove:

- try, maybe, if possible, generally, sort of, usually.
- you can, feel free to, as needed, be thoughtful, make it nice.
- Any phrase forbidden by the active anti-slop rules.

Keep legitimate uncertainty when truthfully required.

## Mode 9: Self-Improving Skill

Trigger: prompt or system will be reused repeatedly.

Process:

1. Identify recurring error categories.
2. Design failure logging structure.
3. Add reflection loop.
4. Convert lessons into constraints or checks.
5. Compare baseline versus improved performance.
6. Provide repeatable improvement cycle.

Failure log schema:

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

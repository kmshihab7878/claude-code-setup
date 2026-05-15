# Validation And Safety Reference

Extended validation checks, failure modes, eval mechanics, and security caveats
extracted from `../SKILL.md`.

## Core Validation Checklist

Before calling a skill done:

- [ ] `SKILL.md` has valid YAML frontmatter.
- [ ] `name` is present and stable.
- [ ] `description` includes capability and trigger contexts.
- [ ] The body has a clear workflow.
- [ ] Required inputs and outputs are stated.
- [ ] Safety constraints are explicit.
- [ ] Long reference material is moved to `references/`.
- [ ] Scripts are scoped and runnable.
- [ ] Links to local references resolve.
- [ ] Eval schema is valid when evals are present.
- [ ] Output artifacts are listed in the final report.

## Security Checklist

- [ ] No secrets, tokens, API keys, credentials, private keys, or session records.
- [ ] No private memory exports or private project context.
- [ ] No real personal identifiers, emails, handles, machine names, or local user
      paths.
- [ ] No malware, exploit code, or unauthorized access workflow.
- [ ] No misleading trigger behavior.
- [ ] No instructions that exfiltrate user data.
- [ ] No hidden network, billing, or destructive side effects.

## Eval Workspace Layout

Use a sibling workspace:

```text
<skill-name>-workspace/
  skill-snapshot/
  iteration-1/
    eval-0/
      eval_metadata.json
      with_skill/
      without_skill/
      timing.json
      grading.json
    benchmark.json
```

For iteration 2 and later, pass the previous workspace to the review generator
when supported.

## Eval Sequence

1. Create `evals/evals.json`.
2. Spawn all runs in one turn when subagents are available.
3. Run with-skill and baseline variants.
4. Draft assertions while runs execute.
5. Capture timing from completion notifications immediately.
6. Grade with `agents/grader.md`.
7. Aggregate with `scripts.aggregate_benchmark`.
8. Run `agents/analyzer.md`.
9. Generate review artifact with `eval-viewer/generate_review.py`.
10. Wait for human feedback.
11. Improve from specific complaints and evidence.

Do not use `/skill-test` or custom HTML review pages for this loop.

## Grading Requirements

The grader writes `grading.json` with these field names because the viewer
expects them:

- `text`
- `passed`
- `evidence`

Assertions should be objectively verifiable. Do not force assertions onto
subjective outputs if qualitative review is more honest.

## Failure Modes

### Undertriggering

Symptoms:

- User asks for a matching workflow but the skill is not invoked.
- Description is too narrow or describes only the topic.

Fix:

- Add realistic trigger contexts to `description`.
- Include near-miss phrasing the user may use.
- Keep description concrete and task-oriented.

### Overtriggering

Symptoms:

- Skill activates for generic tasks.
- Near-miss queries incorrectly match.

Fix:

- Add "Do not use when..." language in the description if needed.
- Make trigger contexts more specific.
- Add should-not-trigger evals.

### Overfitting

Symptoms:

- Skill works on test prompt but fails on similar tasks.
- Instructions mention accidental details from examples.

Fix:

- Generalize from feedback.
- Extract principle and workflow.
- Move example-specific details to `examples.md`.

### Bloated SKILL.md

Symptoms:

- Skill body is hard to scan.
- Repeated tables, examples, or deep troubleshooting dominate the main file.

Fix:

- Keep routing, safety, input/output, validation, and workflow in `SKILL.md`.
- Move bulky material into references with clear pointer rules.

### Weak Evidence

Symptoms:

- Final answer claims eval success but no output was inspected.
- User feedback is ignored.

Fix:

- Read transcripts, outputs, grader evidence, and feedback.
- Report exact checks run.
- Say when validation was skipped or blocked.

## Description Optimization Safety

Description optimization should improve triggering, not game the test set.

- Use train/test split.
- Include should-not-trigger examples.
- Choose the best description by held-out score.
- Avoid overfitting to exact eval wording.
- Keep descriptions truthful to the skill's actual capability.

## Troubleshooting

| Problem | Likely Cause | Response |
|---|---|---|
| Viewer cannot launch | No browser/display | Generate static artifact |
| Evals are subjective | Assertions are a poor fit | Use human review |
| Baseline unavailable | Environment lacks subagents | Run qualitative self-check |
| Tool paths fail | Skill copied to new location | Use paths relative to skill root |
| Feedback is vague | User reviewed too little detail | Ask for specific examples |
| Script repeats fail | Missing dependency or bad input contract | Document dependency and validate inputs |

## Public-Safe Authoring

Use placeholders in examples:

- `<workspace>`
- `<project-root>`
- `<skill-name>`
- `<your-api-key>`

Do not include local usernames, real handles, personal emails, private repo
names, tokens, local machine names, or private session context.

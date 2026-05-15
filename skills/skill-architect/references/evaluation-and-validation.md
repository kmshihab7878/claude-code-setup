# Evaluation and Validation

Detailed validation, scoring, and testing procedures. The minimal validator
invocation and tier table live in `SKILL.md`.

## Validator — `scripts/validate_skill.py`

Run the automated validator on any skill folder:

```bash
python3 ~/.claude/skills/skill-architect/scripts/validate_skill.py <skill-path>
python3 ~/.claude/skills/skill-architect/scripts/validate_skill.py <skill-path> --verbose
```

The validator runs 13 checks across three categories:

### Structural (5 checks)

1. Folder name is kebab-case.
2. `SKILL.md` exists at the root of the folder.
3. No `README.md` competing with `SKILL.md`.
4. `scripts/` and `references/` directories, when present, contain expected file types.
5. Scripts contain no third-party imports (stdlib only).

### Frontmatter (5 checks)

6. SKILL.md starts with `---` on line 1.
7. `name` field is present, kebab-case, and matches the folder name exactly.
8. `name` does not contain forbidden terms (`claude`, `anthropic`, `plugin`, `extension`).
9. `description` is present and under 1024 characters.
10. `description` does not contain angle brackets or unresolved placeholders.

### Content (3 checks)

11. SKILL.md contains a `## when to apply` (or equivalent positive-scope) section.
12. SKILL.md contains a `## when NOT to apply` (or equivalent negative-scope) section.
13. SKILL.md does not exceed 5000 words (warning above that threshold).

All 13 checks must pass before the skill is considered ready for use.

## Scoring Rubric

When reviewing an existing skill, score 8 dimensions on a 0-5 scale.

| Dimension | What it measures |
|-----------|------------------|
| Frontmatter quality | Valid YAML, descriptive, triggers well |
| Instruction clarity | MUST/NEVER language, testable rules |
| Workflow completeness | Steps are clear, ordered, complete |
| Progressive disclosure | Core in SKILL.md, details in references/ |
| Scope discipline | Focused, no overlap, clear boundaries |
| Composability | Works with other skills, no duplication |
| Testing evidence | Test results, trigger tests documented |
| Production readiness | No TODOs, no placeholders, version set |

Scoring guide:

| Score | Meaning |
|-------|---------|
| 0 | Missing entirely |
| 1 | Poor — present but unusable |
| 2 | Below average — needs significant work |
| 3 | Adequate — usable, not polished |
| 4 | Good — production-ready with minor gaps |
| 5 | Excellent — exemplary |

Total: /40. Anything below 24 is a launch risk; below 16 should be rewritten.

## Testing Tiers

### Tier 0: Structural Validity

Automated. Run `validate_skill.py`. All 13 checks must pass.

### Tier 1: Triggering Accuracy

Manual. Test 3+ positive prompts and 3+ negative prompts.

For each positive prompt, record:

- Did the skill activate? (yes/no)
- If no, what tweak to the description would have triggered it?

For each negative prompt, record:

- Did the skill activate when it should not have? (yes/no)
- If yes, what scope tightening would have prevented it?

Pass criterion: 100% of positive prompts trigger, 0% of negative prompts trigger.

### Tier 2: Functional Correctness

Manual. Invoke the skill with:

1. A standard happy-path use case.
2. An error path (missing input, malformed input).
3. A boundary case (largest realistic input, smallest realistic input).

Record: did the output follow the prescribed workflow? Did edge cases produce
graceful degradation rather than hallucinated content?

### Tier 3: Performance Delta

Optional. Compare with-skill vs without-skill on the same input. Useful for
skills whose value is contested or whose existence imposes context cost.

Methodology lives in `references/testing-guide.md`. For eval-driven loops with
subagent grading and description optimization, prefer the `skill-creator` skill
— this skill does not attempt to replicate that machinery.

## Review Output Format

When delivering a review, present in this exact order:

1. **Validator results** — pass/fail per check, with the failing check's name.
2. **Score card** — the 8-dimension table, each row filled.
3. **Top 3 issues** — highest impact, most actionable.
4. **Recommended changes** — specific, with file:section pointers and example rewrites.

Do not bury the validator failures behind narrative. Lead with what's broken.

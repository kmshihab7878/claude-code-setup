# Architecture Workflow — Build and Review

Full step-by-step procedures for building a new skill and reviewing an existing
one. The minimal step list lives in `SKILL.md`.

## Build Workflow

Follow these 6 steps in order when creating a new skill.

### Step 1: Design

1. Write 3-5 user prompts that should trigger the skill.
2. Write 3-5 user prompts that should NOT trigger the skill.
3. Identify the skill category: document/asset, workflow automation, or MCP enhancement.
4. Search existing skills for overlap: `ls ~/.claude/skills/`.
5. Define the scope boundary in one sentence: "This skill covers X but not Y".
6. Choose the folder name (kebab-case, no forbidden terms).

Do not advance to Step 2 until each of the above produces a concrete artifact.
Triggering accuracy depends on Step 1 quality more than any other step.

### Step 2: Structure

1. Create the folder: `mkdir -p ~/.claude/skills/<name>/{scripts,references}`.
2. Decide which reference files are needed (if any).
3. Plan the SKILL.md sections based on the category:

| Category | Key Sections |
|----------|--------------|
| Document/Asset | Reference tables, lookup patterns, format specs |
| Workflow Automation | Step-by-step workflows, checklists, decision points |
| MCP Enhancement | Tool tables, safety rules, common workflows |

### Step 3: Content

Write files in this order:

1. **Scripts** (if any) — validate they work before referencing them.
2. **Reference files** (if any) — complete the detailed specs first.
3. **SKILL.md** — write last, referencing scripts and references as needed.

Recommended SKILL.md section order:

1. Frontmatter (name, description, version, keywords).
2. Title + one-line purpose.
3. `## how to use` — invocation examples.
4. `## when to apply` — positive trigger conditions.
5. `## when NOT to apply` — negative conditions.
6. `## rule priorities` — summary table.
7. `## critical constraints` — operational rules.
8. Domain-specific sections (workflows, tools, safety rules).
9. `## Reference map` — links to supplementary files.

### Step 4: Validate

Run structural validation:

```bash
python3 ~/.claude/skills/skill-architect/scripts/validate_skill.py ~/.claude/skills/<name>/
```

Fix any failures before proceeding. All 13 checks must pass.

### Step 5: Test

Tier 1 triggering tests:

1. Open a new conversation.
2. Enter each positive trigger prompt — verify the skill activates.
3. Enter each negative trigger prompt — verify the skill does NOT activate.
4. If triggering is wrong, adjust the description's first sentence and retest.

Tier 2 functional tests:

1. Invoke the skill with a standard use case.
2. Verify the output follows the prescribed workflow.
3. Test with missing context or ambiguous input.

### Step 6: Refine

1. Add the skill name to `~/.claude/CLAUDE.md` Skills Available list.
2. Update memory files if applicable.
3. Use the skill in 3+ real tasks, noting any issues.
4. Iterate on description wording for triggering accuracy.

## Review Workflow

Follow these 4 steps when reviewing an existing skill.

### Step 1: Read

1. Read SKILL.md completely.
2. Read all files in `references/` and `scripts/`.
3. Note the skill category and intended audience.

### Step 2: Validate

```bash
python3 ~/.claude/skills/skill-architect/scripts/validate_skill.py <path> --verbose
```

Record all failures.

### Step 3: Score

Rate the skill on 8 dimensions (0-5 each, 40 max):

| Dimension | Score | Notes |
|-----------|-------|-------|
| Frontmatter quality | /5 | Valid YAML, descriptive, triggers well |
| Instruction clarity | /5 | MUST/NEVER language, testable rules |
| Workflow completeness | /5 | Steps are clear, ordered, complete |
| Progressive disclosure | /5 | Core in SKILL.md, details in references/ |
| Scope discipline | /5 | Focused, no overlap, clear boundaries |
| Composability | /5 | Works with other skills, no duplication |
| Testing evidence | /5 | Test results, trigger tests documented |
| Production readiness | /5 | No TODOs, no placeholders, version set |
| **Total** | **/40** | |

Scoring guide: 0=missing, 1=poor, 2=below average, 3=adequate, 4=good, 5=excellent.

### Step 4: Output

Present findings as:

1. Validator results (pass/fail per check).
2. Score card (table above, filled in).
3. Top 3 issues (highest impact, most actionable).
4. Recommended changes (specific, with examples).

## Section Templates

Reusable section skeletons for `SKILL.md`. See also
`references/workflow-patterns.md` for 5 long-form workflow templates.

### Triggering description (description field)

```text
<One-sentence statement of what the skill does>. Use when <specific user
intent A>, <specific user intent B>, or <specific user intent C>.
```

### "when NOT to apply" pattern

```markdown
## when NOT to apply

Do NOT use this skill for:
- <General task the skill might be confused for> (use `<other-skill>` instead)
- <Adjacent capability that belongs elsewhere>
- <Misinterpretation of the name>
```

### Tiered rules pattern

```markdown
## rule priorities

| Priority | Category | Impact |
|----------|----------|--------|
| 1 | <Critical category> | Critical |
| 2 | <Critical category> | Critical |
| 3 | <High category> | High |
| 4 | <Medium category> | Medium |
```

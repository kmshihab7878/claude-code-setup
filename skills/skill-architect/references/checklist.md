# Skill Development Checklists

Three-phase checklist for building Claude Code skills.

## Pre-Development

Before writing any skill content:

- [ ] **Define 3+ use cases** — concrete user prompts that should trigger this skill
- [ ] **Identify category** — document/asset, workflow automation, or MCP enhancement
- [ ] **Set success criteria** — what measurable outcome defines "working"
- [ ] **Check for overlap** — search existing skills for similar functionality
- [ ] **Define scope boundary** — what this skill does NOT cover
- [ ] **Choose folder name** — kebab-case, no forbidden terms, matches intended `name` field
- [ ] **Plan file structure** — SKILL.md required; scripts/ and references/ if needed

## During Development

While writing the skill:

**Frontmatter**
- [ ] `---` delimiters present (first line and closing line)
- [ ] `name` field matches folder name exactly
- [ ] `name` is valid kebab-case, no forbidden terms
- [ ] `description` present, under 1024 chars, no angle brackets
- [ ] `description` first sentence works as standalone summary
- [ ] `version` field set (recommended)

**Content**
- [ ] Title matches skill name
- [ ] "how to use" section with invocation examples
- [ ] "when to apply" section with trigger conditions
- [ ] "when NOT to apply" section with negative conditions
- [ ] Instructions use MUST/NEVER/ALWAYS language for critical rules
- [ ] Word count under 5000
- [ ] Code examples are self-contained and correct
- [ ] No placeholder text or TODO items remaining

## Post-Development

After completing the skill:

- [ ] **Run validator** — `python3 scripts/validate_skill.py <path>` passes all checks
- [ ] **Trigger test (positive)** — 3+ prompts that SHOULD activate the skill
- [ ] **Trigger test (negative)** — 3+ prompts that should NOT activate the skill
- [ ] **Functional test** — skill produces correct output for a standard use case
- [ ] **Edge case test** — skill handles ambiguous or unusual input gracefully
- [ ] **Performance comparison** — skill output is measurably better than without the skill
- [ ] **Final proofread** — no typos, broken links, or formatting issues

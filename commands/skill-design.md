Guide the user through designing and creating a new skill for ~/.claude/skills/.

## Workflow

### Step 1: Discovery
Ask the user:
1. What domain does this skill cover?
2. What specific rules, patterns, or processes should it encode?
3. What triggers should activate it? (action verbs + domain nouns)

### Step 2: Overlap Check
- Search existing skills in `~/.claude/skills/README.md` catalog
- Check for >30% content overlap with existing skills
- If overlap found: recommend absorbing into existing skill instead
- If no overlap: proceed

### Step 3: Name and Classify
- Apply naming conventions from `~/.claude/skills/_shared/naming-conventions.md`
- Assign taxonomy tags from catalog
- Assess risk level: low (read-only/local), medium (writes/external), high (destructive/financial)

### Step 4: Generate
- Use template from `~/.claude/skills/_shared/skill-template.md`
- Write the skill with:
  - YAML frontmatter (name, description, risk, tags, dates)
  - "How to use" with invocation examples
  - "When to use" with 3+ trigger situations
  - "When NOT to use" with 2+ exclusions
  - Main content (rules, patterns, or process)
  - Cross-references to related skills

### Step 5: Review
- Run through `~/.claude/skills/_shared/review-checklist.md`
- Present checklist results to user

### Step 6: Register
After user approval:
- Create `skills/<skill-name>/SKILL.md`
- Add to `skills/README.md` catalog and tag index
- Update `CLAUDE.md` skill count and list

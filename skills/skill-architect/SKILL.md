---
name: skill-architect
description: >
  Build, validate, and improve Claude Code skills. Design-first workflow with
  YAML frontmatter validation, progressive disclosure, and quality assessment.
  Use when creating new skills, improving existing ones, auditing skill quality,
  or troubleshooting skill triggering issues.
version: 1.0.0
keywords: skill, meta, builder, validation, quality, architecture
---

# skill-architect

Build, validate, and improve Claude Code skills using a design-first methodology.

## how to use

- `/skill-architect`
  Apply skill architecture principles to the current conversation.

- `/skill-architect build <name>`
  Create a new skill from scratch following the full build workflow.

- `/skill-architect review <path>`
  Review an existing skill and produce a scored quality report.

- `/skill-architect validate <path>`
  Run the validation script and report structural/frontmatter/content issues.

## when to apply

Use this skill when:
- Creating a new Claude Code skill from scratch
- Improving or refactoring an existing skill
- Auditing skill quality across a skill library
- Troubleshooting why a skill is not triggering correctly
- Reviewing a skill before publishing or sharing
- Converting a one-off workflow into a reusable skill

## when NOT to apply

Do NOT use this skill for:
- General coding tasks (use `coding-workflow` instead)
- "Improve my skills" meaning career/personal development
- Prompt engineering for chat conversations (skills are file-based, not chat-based)
- Writing one-off documentation or READMEs
- Configuring MCP servers (that's infrastructure, not skill authoring)
- Iterative skill improvement with eval benchmarks (use `skill-creator` instead — it provides subagent testing, programmatic grading, eval-viewer, and description optimization with eval queries)

## rule categories by priority

| Priority | Category | Impact | Description |
|----------|----------|--------|-------------|
| 1 | Design-first thinking | Critical | Define use cases and scope before writing |
| 2 | YAML frontmatter | Critical | Valid structure determines triggering |
| 3 | Folder structure | Critical | Naming and layout must follow conventions |
| 4 | Instruction quality | High | MUST/NEVER language for critical rules |
| 5 | Progressive disclosure | High | Core in SKILL.md, details in references/ |
| 6 | Composability | Medium | Skills should complement, not duplicate |
| 7 | Testing | Medium | Validate triggering, function, performance |
| 8 | Iteration | Low | Refine based on real usage feedback |

## quick reference

### 1. design-first thinking (critical)

- MUST define 3+ concrete user prompts that should trigger the skill before writing content
- MUST identify the skill category: document/asset, workflow automation, or MCP enhancement
- MUST check existing skills for overlap before creating a new one
- MUST define explicit scope boundaries — what the skill does NOT cover
- NEVER start writing SKILL.md without completing the design phase

### 2. YAML frontmatter (critical)

- MUST start SKILL.md with `---` on the very first line
- MUST include `name` field in kebab-case matching the folder name exactly
- MUST include `description` field under 1024 characters with no angle brackets
- MUST NOT use forbidden terms in name: `claude`, `anthropic`, `plugin`, `extension`
- The `description` first sentence is the most important text — it determines triggering
- Use `>` folded scalar for multi-line descriptions
- See `references/yaml-reference.md` for complete field specification

### 3. folder structure (critical)

Required layout:
```
skill-name/
├── SKILL.md          # Required — main skill file
├── scripts/          # Optional — validation/helper scripts (stdlib only)
└── references/       # Optional — supplementary docs
```

Rules:
- Folder name MUST be kebab-case
- Folder name MUST match the `name` frontmatter field
- MUST NOT have both README.md and SKILL.md (SKILL.md wins)
- Scripts MUST use Python stdlib only — no pip dependencies
- Keep SKILL.md under 5000 words; use references/ for overflow

### 4. instruction quality (high)

- Use MUST/NEVER/ALWAYS for mandatory rules — no "try to" or "consider"
- Use tables for structured reference data (tools, rules, decision matrices)
- Use checklists for sequential verification steps
- Use code blocks for invocation examples and command-line usage
- Every rule should be testable: if you can't verify compliance, rewrite it
- Prefer imperative voice: "Run the validator" not "The validator should be run"

### 5. progressive disclosure (high)

Structure information in layers:
1. **SKILL.md** — core workflow, critical rules, quick reference (the 80% case)
2. **references/** — detailed specs, exhaustive checklists, edge cases (the 20%)
3. **scripts/** — automated validation, not manual steps

Rules:
- SKILL.md MUST be self-sufficient — a reader should never need references/ to use the skill
- References provide depth, not prerequisites
- Link to reference files from SKILL.md sections where relevant

### 6. composability (medium)

- Skills should do one thing well, not cover every related topic
- MUST NOT duplicate functionality from existing skills
- When skills are complementary, reference each other in "when NOT to apply" sections
- A skill can recommend invoking another skill but MUST NOT embed another skill's content

### 7. testing (medium)

Three tiers — see `references/testing-guide.md` for full methodology:

| Tier | What | How |
|------|------|-----|
| 0 | Structural validity | Run `validate_skill.py` |
| 1 | Triggering accuracy | Test 3+ positive and 3+ negative prompts |
| 2 | Functional correctness | Happy path, error path, boundary cases |
| 3 | Performance delta | With-skill vs without-skill comparison |

### 8. iteration (low)

- Ship a working v1.0.0 before optimizing
- Track triggering failures — if users report the skill doesn't activate, tune the description
- Version bump on every meaningful change (semver)
- Collect 3+ real-world uses before major refactoring

## build workflow

Follow these 6 steps in order when creating a new skill.

### Step 1: Design

1. Write 3-5 user prompts that should trigger the skill
2. Write 3-5 user prompts that should NOT trigger the skill
3. Identify the skill category (document/asset, workflow automation, MCP enhancement)
4. Search existing skills for overlap: `ls ~/.claude/skills/`
5. Define the scope boundary in one sentence: "This skill covers X but not Y"
6. Choose the folder name (kebab-case, no forbidden terms)

### Step 2: Structure

1. Create the folder: `mkdir -p ~/.claude/skills/<name>/{scripts,references}`
2. Decide which reference files are needed (if any)
3. Plan the SKILL.md sections based on the category:

| Category | Key Sections |
|----------|-------------|
| Document/Asset | Reference tables, lookup patterns, format specs |
| Workflow Automation | Step-by-step workflows, checklists, decision points |
| MCP Enhancement | Tool tables, safety rules, common workflows |

### Step 3: Content

Write files in this order:
1. **Scripts** (if any) — validate they work before referencing them
2. **Reference files** (if any) — complete the detailed specs first
3. **SKILL.md** — write last, referencing scripts and references as needed

SKILL.md section order:
1. Frontmatter (name, description, version, keywords)
2. Title + one-line purpose
3. `## how to use` — invocation examples
4. `## when to apply` — positive trigger conditions
5. `## when NOT to apply` — negative conditions
6. `## rule categories by priority` — summary table
7. `## quick reference` — operational rules by category
8. Domain-specific sections (workflows, tools, safety rules)
9. `## references` — links to supplementary files

### Step 4: Validate

Run structural validation:
```bash
python3 ~/.claude/skills/skill-architect/scripts/validate_skill.py ~/.claude/skills/<name>/
```

Fix any failures before proceeding. All 13 checks must pass.

### Step 5: Test

Execute Tier 1 triggering tests:
1. Open a new conversation
2. Enter each positive trigger prompt — verify skill activates
3. Enter each negative trigger prompt — verify skill does NOT activate
4. If triggering is wrong, adjust the description's first sentence

Execute Tier 2 functional tests:
1. Invoke the skill with a standard use case
2. Verify the output follows the prescribed workflow
3. Test with missing context or ambiguous input

### Step 6: Refine

1. Add the skill name to `~/.claude/CLAUDE.md` Skills Available list
2. Update memory files if applicable
3. Use the skill in 3+ real tasks, noting any issues
4. Iterate on description wording for triggering accuracy

## review workflow

Follow these 4 steps when reviewing an existing skill.

### Step 1: Read

1. Read SKILL.md completely
2. Read all files in references/ and scripts/
3. Note the skill category and intended audience

### Step 2: Validate

Run the validator:
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
| Progressive disclosure | /5 | Core in SKILL.md, details in references |
| Scope discipline | /5 | Focused, no overlap, clear boundaries |
| Composability | /5 | Works with other skills, doesn't duplicate |
| Testing evidence | /5 | Has test results, trigger tests documented |
| Production readiness | /5 | No TODOs, no placeholders, version set |
| **Total** | **/40** | |

Scoring guide: 0=missing, 1=poor, 2=below average, 3=adequate, 4=good, 5=excellent.

### Step 4: Output

Present findings as:
1. Validator results (pass/fail per check)
2. Score card (table above, filled in)
3. Top 3 issues (highest impact, most actionable)
4. Recommended changes (specific, with examples)

## skill categories

| Category | Description | Key Patterns | Examples |
|----------|-------------|-------------|----------|
| Document/Asset | Static reference data, lookup tables, specs | Tables, decision matrices, format references | `api-design-patterns`, `database-patterns` |
| Workflow Automation | Multi-step processes, checklists, pipelines | Sequential steps, checklists, decision points | `coding-workflow`, `confidence-check`, `git-workflows` |
| MCP Enhancement | Wraps MCP server capabilities with domain rules | Tool tables, safety rules, common workflows | `aster-trading` |

## anti-patterns

| Anti-Pattern | Problem | Fix |
|-------------|---------|-----|
| Kitchen-sink skill | Covers too many topics, triggers too broadly | Split into focused skills with clear boundaries |
| Vague description | "A helpful skill for coding" — triggers for everything or nothing | Write specific first sentence: what it does + when to use |
| Missing negative scope | No "when NOT to apply" — causes false activations | Add explicit exclusions |
| Hardcoded assumptions | Assumes specific framework/language without checking | Add context detection or ask user |
| Giant SKILL.md | 8000+ words — exceeds context budget | Move details to references/, keep SKILL.md under 5000 words |
| Duplicate coverage | Overlaps with existing skill | Check overlap before building; reference instead of duplicating |

## references

| File | Contents |
|------|----------|
| `references/yaml-reference.md` | Complete YAML frontmatter field specification with examples |
| `references/workflow-patterns.md` | 5 reusable workflow patterns with templates and anti-patterns |
| `references/testing-guide.md` | 3-tier testing methodology (triggering, functional, performance) |
| `references/checklist.md` | Pre/during/post development checklists |
| `scripts/validate_skill.py` | Automated validator — 13 checks across structural, frontmatter, content |

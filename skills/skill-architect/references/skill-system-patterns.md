# Skill System Patterns — Full Rule Detail

Detailed rules for each priority category and patterns by skill type. The
condensed list lives in `SKILL.md`.

## 1. Design-First Thinking (Critical)

- MUST define 3+ concrete user prompts that should trigger the skill before
  writing content.
- MUST identify the skill category: document/asset, workflow automation, or
  MCP enhancement.
- MUST check existing skills for overlap before creating a new one.
- MUST define explicit scope boundaries — what the skill does NOT cover.
- NEVER start writing SKILL.md without completing the design phase.

Design defects compound: a vague triggering description cannot be fixed with
better content. Spend disproportionate effort here.

## 2. YAML Frontmatter (Critical)

- MUST start SKILL.md with `---` on the very first line.
- MUST include `name` field in kebab-case matching the folder name exactly.
- MUST include `description` field under 1024 characters with no angle brackets.
- MUST NOT use forbidden terms in name: `claude`, `anthropic`, `plugin`, `extension`.
- The `description` first sentence is the most important text — it determines triggering.
- Use `>` folded scalar for multi-line descriptions.

See `references/yaml-reference.md` for the complete field specification.

## 3. Folder Structure (Critical)

Required layout:

```
skill-name/
├── SKILL.md          # Required — main skill file
├── scripts/          # Optional — validation/helper scripts (stdlib only)
└── references/       # Optional — supplementary docs
```

Rules:

- Folder name MUST be kebab-case.
- Folder name MUST match the `name` frontmatter field.
- MUST NOT have both README.md and SKILL.md (SKILL.md wins).
- Scripts MUST use Python stdlib only — no pip dependencies.
- Keep SKILL.md under 5000 words; use `references/` for overflow.

## 4. Instruction Quality (High)

- Use MUST/NEVER/ALWAYS for mandatory rules — no "try to" or "consider".
- Use tables for structured reference data (tools, rules, decision matrices).
- Use checklists for sequential verification steps.
- Use code blocks for invocation examples and command-line usage.
- Every rule should be testable: if you can't verify compliance, rewrite it.
- Prefer imperative voice: "Run the validator" not "The validator should be run".

## 5. Progressive Disclosure (High)

Structure information in layers:

1. **SKILL.md** — core workflow, critical rules, quick reference (the 80% case).
2. **references/** — detailed specs, exhaustive checklists, edge cases (the 20%).
3. **scripts/** — automated validation, not manual steps.

Rules:

- SKILL.md MUST be self-sufficient — a reader should never need `references/`
  to use the skill in the common case.
- References provide depth, not prerequisites.
- Link to reference files from SKILL.md sections where relevant.

## 6. Composability (Medium)

- Skills should do one thing well, not cover every related topic.
- MUST NOT duplicate functionality from existing skills.
- When skills are complementary, reference each other in `when NOT to apply`
  sections.
- A skill can recommend invoking another skill but MUST NOT embed another
  skill's content.

## 7. Testing (Medium)

Three tiers — full methodology in `references/testing-guide.md`:

| Tier | What | How |
|------|------|-----|
| 0 | Structural validity | Run `validate_skill.py` |
| 1 | Triggering accuracy | Test 3+ positive and 3+ negative prompts |
| 2 | Functional correctness | Happy path, error path, boundary cases |
| 3 | Performance delta | With-skill vs without-skill comparison |

## 8. Iteration (Low)

- Ship a working v1.0.0 before optimizing.
- Track triggering failures — if users report the skill doesn't activate,
  tune the description.
- Version bump on every meaningful change (semver).
- Collect 3+ real-world uses before major refactoring.

## Skill Categories — Patterns

| Category | Description | Key Patterns | Examples |
|----------|-------------|--------------|----------|
| Document/Asset | Static reference data, lookup tables, specs | Tables, decision matrices, format references | `api-design-patterns`, `database-patterns` |
| Workflow Automation | Multi-step processes, checklists, pipelines | Sequential steps, checklists, decision points | `coding-workflow`, `confidence-check`, `git-workflows` |
| MCP Enhancement | Wraps MCP server capabilities with domain rules | Tool tables, safety rules, common workflows | `aster-trading` |

### Document/Asset pattern

- Emphasize tables and reference data over prose.
- Place lookup tables near the top of `SKILL.md` for fast scan.
- Use `references/` for exhaustive enumerations (e.g., full HTTP status code lists).

### Workflow Automation pattern

- Number every step and define a clear stop condition.
- Insert decision points as explicit branches with criteria, not "use judgment".
- Place long playbooks in `references/`; keep the top-level flow under one
  page of SKILL.md.

### MCP Enhancement pattern

- Document each MCP tool used with: tool name, what it does, when to use,
  safety constraints.
- Front-load destructive-action warnings.
- Always include a "fallback when MCP unavailable" path.

## Cross-Skill Composition Rules

| Situation | Rule |
|-----------|------|
| Two skills cover overlapping intents | Tighten scope, point to each other in `when NOT to apply` |
| Skill needs capability another skill provides | Recommend invoking the other skill; do not duplicate |
| Skill builds on another's output | Document the input contract; do not assume order |
| Skill should not run with another | Add explicit `do NOT use with` note |

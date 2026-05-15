# Troubleshooting — Anti-Patterns and Diagnostics

Common failure modes and how to fix them. Pair with `references/checklist.md`
for pre/during/post development checks.

## Anti-Patterns

| Anti-Pattern | Problem | Fix |
|--------------|---------|-----|
| Kitchen-sink skill | Covers too many topics, triggers too broadly | Split into focused skills with clear boundaries |
| Vague description | "A helpful skill for coding" — triggers for everything or nothing | Write a specific first sentence: what it does + when to use |
| Missing negative scope | No `when NOT to apply` — causes false activations | Add explicit exclusions |
| Hardcoded assumptions | Assumes specific framework or language without checking | Add context detection or ask the user |
| Giant SKILL.md | 8000+ words — exceeds context budget | Move details to `references/`, keep SKILL.md under 5000 words |
| Duplicate coverage | Overlaps with existing skill | Check overlap before building; reference instead of duplicating |
| Soft language | "Try to", "consider", "might want" — unenforceable | Replace with MUST / NEVER / ALWAYS |
| Embedded prereqs | Reader must read `references/` to use the skill | Make SKILL.md self-sufficient for the 80% case |
| Bundled secrets | Tokens, credentials, or local paths in skill files | Remove and replace with placeholders; rotate exposed values |
| Pip dependencies | Bundled scripts import third-party packages | Rewrite using Python stdlib only |
| README + SKILL.md | Both exist in the same folder | Keep SKILL.md; delete README.md |
| Forbidden name terms | `claude-helper`, `anthropic-tools`, etc. | Rename without reserved terms |

## Triggering Diagnostics

If the skill activates too often:

- The description's first sentence is too general — narrow it.
- The `when NOT to apply` section is missing or vague — add explicit exclusions.
- Keywords overlap with adjacent skills — choose more specific verbs and nouns.

If the skill does not activate when it should:

- The description's first sentence buries the intent — lead with the trigger.
- The user phrase the skill should match is not represented in the description.
- The skill name itself is misleading or generic.

If the skill triggers for the right intent but produces poor output:

- The workflow steps are not detailed enough — expand the relevant section
  in SKILL.md or extract to a `references/*.md` file with concrete templates.
- Critical rules use soft language — rewrite with MUST / NEVER.

## Content Diagnostics

| Symptom | Likely cause | Fix |
|---------|--------------|-----|
| Output drifts in format across runs | No locked output structure | Add an explicit output template in SKILL.md |
| Output exceeds expected scope | No `when NOT to apply` enforcement in body | Repeat the scope boundary near the workflow start |
| Hallucinated tool names | Tools not enumerated | Add a tools table; mark allowed vs forbidden |
| Skipped steps | Workflow uses bullets instead of numbered steps | Convert to numbered steps with a stop condition |

## Validator Failure Recipes

| Failing check | Fix |
|---------------|-----|
| Folder name not kebab-case | Rename folder; update any references |
| `name` ≠ folder | Edit frontmatter `name` to match folder exactly |
| `description` > 1024 chars | Move long context to body; keep description tight |
| Angle brackets in `description` | Replace `<placeholder>` with a real value or remove |
| Forbidden term in `name` | Rename without `claude`, `anthropic`, `plugin`, `extension` |
| Missing `when to apply` | Add the section with 4-8 positive trigger conditions |
| Missing `when NOT to apply` | Add the section with explicit exclusions and pointers |
| Scripts import third-party | Rewrite using stdlib; common swaps: `requests` → `urllib.request`, `pyyaml` → manual parsing or pre-built JSON |
| SKILL.md > 5000 words | Extract long sections into `references/` and link |

## When to Escalate to skill-creator

This skill (`skill-architect`) is for design-first construction and quality
review. Switch to `skill-creator` when you need any of:

- Subagent-based eval runs.
- Programmatic grading with `grader.md` / `comparator.md` / `analyzer.md`.
- Description optimization driven by eval query results.
- Browser/static eval viewer output.

Do not attempt to reproduce that machinery here — the two skills are
complementary.

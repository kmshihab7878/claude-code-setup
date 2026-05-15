# Frontmatter And Structure Reference

Detailed folder, frontmatter, naming, and output-structure guidance extracted
from `../SKILL.md`.

## Skill Anatomy

```text
skill-name/
  SKILL.md
  scripts/
  references/
  assets/
  evals/evals.json
```

Required:

- `SKILL.md` with YAML frontmatter.

Optional:

- `scripts/` for deterministic and repetitive helpers.
- `references/` for long-form docs loaded only when needed.
- `assets/` for output templates and static resources.
- `evals/` for test prompts and fixtures.
- `agents/` for specialized review or grading instructions.

## Required Frontmatter

```yaml
---
name: example-skill
description: Do the task and explain when to use the skill. Use when the user asks for specific matching intents or contexts.
---
```

`name`:

- stable identifier
- usually matches folder name
- preserve when improving an existing skill
- avoid version suffixes unless the user explicitly wants a separate skill

`description`:

- primary trigger mechanism
- includes what the skill does
- includes when to use it
- names realistic user intents and contexts
- slightly trigger-forward because skills often undertrigger

## Description Pattern

Weak:

```yaml
description: How to build a simple dashboard for internal data.
```

Stronger:

```yaml
description: Build dashboards for internal data. Use when the user mentions dashboards, data visualization, internal metrics, company reporting, or displaying business data, even if they do not explicitly say "dashboard."
```

## Body Structure

Recommended `SKILL.md` sections:

1. Purpose
2. When to use
3. Inputs required
4. Core workflow
5. Output contract
6. Safety/security constraints
7. Validation rules
8. Minimal examples
9. Reference map

## Progressive Disclosure

Three levels:

1. Metadata: name and description are always available.
2. `SKILL.md`: loaded when the skill triggers.
3. Bundled resources: loaded or executed on demand.

Keep the main file concise. Move large material to references:

- long examples
- schema catalogs
- troubleshooting guides
- detailed framework variants
- long templates
- large checklists
- deep explanations

Large reference files should start with a short purpose statement and a table of
contents when helpful.

## Multi-Variant Layout

For skills covering multiple providers, frameworks, or environments:

```text
cloud-deploy/
  SKILL.md
  references/
    aws.md
    gcp.md
    azure.md
```

Route in `SKILL.md`; load only the relevant reference.

## Output Contract

When finishing a skill creation or edit task, report:

- created/changed files
- frontmatter name and description
- trigger conditions
- output artifacts
- validation performed
- eval results, if any
- known limitations
- next recommended iteration

## Resource Placement Rules

- Put deterministic repeated logic in `scripts/`.
- Put reusable templates in `assets/`.
- Put long instructions in `references/`.
- Keep task-critical routing and safety rules in `SKILL.md`.
- Do not make users read references to know whether the skill should trigger.

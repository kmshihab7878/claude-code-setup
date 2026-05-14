# Skill template reference

Detail for the **Skill Writing Guide** section of SKILL.md. SKILL.md keeps the core decisions (frontmatter, when-to-trigger, writing style); this file holds the anatomy diagram, progressive-disclosure model, format examples, and writing-pattern templates.

## Anatomy of a skill

```
skill-name/
├── SKILL.md (required)
│   ├── YAML frontmatter (name, description required)
│   └── Markdown instructions
└── Bundled Resources (optional)
    ├── scripts/    - Executable code for deterministic/repetitive tasks
    ├── references/ - Docs loaded into context as needed
    └── assets/     - Files used in output (templates, icons, fonts)
```

## Progressive disclosure

Three-level loading:
1. **Metadata** (name + description) — always in context (~100 words).
2. **SKILL.md body** — in context whenever skill triggers (<500 lines ideal).
3. **Bundled resources** — as needed (unlimited; scripts execute without loading).

Word counts are approximate; go longer if needed.

**Key patterns:**
- Keep SKILL.md under 500 lines; if approaching this limit, add hierarchy + pointers to follow-up files.
- Reference files clearly from SKILL.md with guidance on when to read them.
- Large reference files (>300 lines) need a table of contents.

**Domain organization** — for skills supporting multiple frameworks, organize by variant:

```
cloud-deploy/
├── SKILL.md (workflow + selection)
└── references/
    ├── aws.md
    ├── gcp.md
    └── azure.md
```

Claude reads only the relevant reference.

## Principle of lack of surprise

Skills must not contain malware, exploit code, or content that compromises system security. A skill's contents must not surprise the user given the description. Don't create misleading skills or facilitate unauthorized access / data exfiltration / malicious activities. Roleplay-as-XYZ is OK.

## Writing patterns

Imperative form for instructions.

**Defining output formats:**

```markdown
## Report structure
ALWAYS use this exact template:
# [Title]
## Executive summary
## Key findings
## Recommendations
```

**Examples pattern:**

```markdown
## Commit message format
**Example 1:**
Input: Added user authentication with JWT tokens
Output: feat(auth): implement JWT-based authentication
```

## Writing style

Explain *why* things matter rather than heavy MUSTs. Use theory of mind; keep skills general, not over-fitted to examples. Draft, then look at it with fresh eyes and improve.

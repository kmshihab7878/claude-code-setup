# Examples — End-to-End Skill Construction

Worked examples showing the full build workflow applied to representative
skill categories. Each example covers design, structure, content, validation,
and a sample triggering test.

## Example 1: Document/Asset skill — `http-status-reference`

### Design

- Positive triggers:
  - "What does HTTP 422 mean?"
  - "List the 4xx status codes."
  - "When should I return 409 Conflict?"
- Negative triggers:
  - "Set up an HTTP client in Python." (use a coding skill)
  - "Configure my reverse proxy." (infrastructure, not reference)
- Category: Document/Asset.
- Scope: HTTP status code semantics. Not HTTP method semantics, not REST design.
- Folder name: `http-status-reference`.

### Structure

```
http-status-reference/
├── SKILL.md
└── references/
    ├── 4xx-codes.md
    └── 5xx-codes.md
```

### Content

- SKILL.md contains a compact lookup table for the most-used 1xx/2xx/3xx codes
  and quick decision flow for 4xx/5xx.
- Bulk enumeration of 4xx and 5xx codes is in references.

### Validation

`validate_skill.py` should pass all 13 checks. Triggering test: each positive
prompt activates; each negative prompt does not.

## Example 2: Workflow Automation skill — `pr-prep`

### Design

- Positive triggers:
  - "Get this branch ready for a PR."
  - "Run pre-PR checks on the current branch."
- Negative triggers:
  - "Open a PR on GitHub." (use `gh pr create` directly)
  - "Write a release note." (different lifecycle stage)
- Category: Workflow Automation.
- Scope: pre-PR validation and cleanup. Not PR creation or post-merge cleanup.

### Structure

```
pr-prep/
├── SKILL.md
├── scripts/
│   └── precheck.py
└── references/
    └── checklists.md
```

### Content

- SKILL.md numbered workflow with 6 steps and a stop condition.
- `precheck.py` runs format check, type check, test suite, and PR-title lint.
- `references/checklists.md` has the full per-language pre-PR checklist.

### Validation

Tier 0 passes via `validate_skill.py`. Tier 1 trigger tests confirm the skill
fires on PR-prep intents and ignores PR-creation intents.

## Example 3: MCP Enhancement skill — `aster-trading`

### Design

- Positive triggers: "Place a market order on Aster." "Get current Aster funding rate."
- Negative triggers: generic trading questions, off-exchange concerns.
- Category: MCP Enhancement.
- Scope: Aster MCP server tooling with risk and safety constraints.

### Structure

```
aster-trading/
├── SKILL.md
└── references/
    ├── tool-catalog.md
    └── safety-rules.md
```

### Content

- SKILL.md enumerates each MCP tool with one-line purpose and safety status
  (read-only vs write).
- All destructive actions (place order, cancel order) require explicit user
  confirmation; this is in SKILL.md, not buried in references.

### Validation

Tier 0 passes. Tier 1 verifies the skill triggers only for Aster-specific
intents, not generic crypto questions.

## Example 4: Skill review (auditing an existing skill)

Target: `legacy-snippet-skill` (hypothetical, scored low in inventory).

### Step 1 — Read

SKILL.md is 7200 words. References folder empty. No scripts.

### Step 2 — Validate

```
PASS:  folder name kebab-case
PASS:  SKILL.md exists
FAIL:  SKILL.md > 5000 words (7200)
FAIL:  missing `when NOT to apply` section
PASS:  frontmatter `name` matches folder
PASS:  `description` < 1024 chars
FAIL:  description starts with "Helpful skill for..." (soft + generic)
```

### Step 3 — Score

| Dimension | Score |
|-----------|-------|
| Frontmatter quality | 2 |
| Instruction clarity | 2 |
| Workflow completeness | 3 |
| Progressive disclosure | 1 |
| Scope discipline | 1 |
| Composability | 3 |
| Testing evidence | 0 |
| Production readiness | 1 |
| **Total** | **13/40** |

### Step 4 — Output

Top 3 issues:

1. Description does not trigger reliably — rewrite first sentence with concrete
   verb + target.
2. SKILL.md is 7200 words — extract three sections into `references/*.md`.
3. No `when NOT to apply` — write explicit exclusions; this skill collides with
   `coding-workflow`.

Recommendation: drop to score-target 28 within a single pass; rerun the
review afterward.

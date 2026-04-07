# YAML Frontmatter Reference

Complete specification for Claude Code skill frontmatter fields.

## Delimiter

Frontmatter MUST be enclosed in triple-dash lines at the very start of SKILL.md:

```yaml
---
name: my-skill
description: Short description of what the skill does.
---
```

## Required Fields

### `name`
- **Type**: string
- **Format**: kebab-case (`[a-z][a-z0-9]*(-[a-z0-9]+)*`)
- **Rules**:
  - MUST match the folder name exactly
  - MUST NOT contain: `claude`, `anthropic`, `plugin`, `extension`
  - Maximum 50 characters recommended
- **Examples**: `coding-workflow`, `aster-trading`, `confidence-check`

### `description`
- **Type**: string (single or multi-line with `>`)
- **Rules**:
  - MUST be under 1024 characters
  - MUST NOT contain angle brackets (`<`, `>`)
  - Should describe what the skill does, when to use it, and key capabilities
  - First sentence is used as the short description in skill listings
  - Use the `>` folded scalar for multi-line descriptions
- **Good**: "Pre-implementation confidence assessment. Use before starting implementation to verify readiness."
- **Bad**: "A skill for Claude" (too vague), "Use this <skill> to..." (angle brackets)

## Recommended Fields

### `version`
- **Type**: string (semver)
- **Format**: `MAJOR.MINOR.PATCH` (e.g., `1.0.0`)
- **When to bump**: MAJOR for breaking changes, MINOR for new features, PATCH for fixes

### `keywords`
- **Type**: string (comma-separated) or YAML list
- **Purpose**: Improves skill discoverability and triggering accuracy
- **Example**: `trading, crypto, DeFi, perpetuals, futures`

## Optional Fields

### `license`
- **Type**: string
- **Example**: `MIT`, `Apache-2.0`

### `allowed-tools`
- **Type**: YAML list
- **Purpose**: Restrict which tools the skill can reference
- **Example**: `[Read, Write, Edit, Bash, Grep, Glob]`

### `compatibility`
- **Type**: string
- **Purpose**: Minimum Claude Code version
- **Example**: `>=1.0.0`

### `metadata`
- **Type**: mapping with sub-fields
- **Sub-fields**:
  - `author`: string — creator name or GitHub handle
  - `mcp-server`: string — name of required MCP server (if any)
  - `category`: string — `document-asset`, `workflow-automation`, or `mcp-enhancement`
  - `tags`: YAML list — additional categorization tags

## Complete Examples

### Minimal (required only)

```yaml
---
name: my-linter
description: Lint configuration files for common mistakes.
---
```

### Standard (required + recommended)

```yaml
---
name: api-design-patterns
description: >
  REST and GraphQL API design patterns. Resource naming, HTTP methods,
  status codes, error formats, pagination, versioning, and rate limiting.
  Use when designing APIs, reviewing endpoints, or writing OpenAPI specs.
version: 1.2.0
keywords: api, rest, graphql, openapi, http
---
```

### Full (all fields)

```yaml
---
name: aster-trading
description: Aster DEX trading skill for futures, spot, and market data via MCP tools
version: 1.0.0
keywords: trading, crypto, DeFi, perpetuals, futures, spot
license: MIT
metadata:
  author: kmshihab7878
  mcp-server: aster
  category: mcp-enhancement
  tags: [finance, defi, exchange]
---
```

## Common Mistakes

| Mistake | Problem | Fix |
|---------|---------|-----|
| Missing opening `---` | Frontmatter not detected | Add `---` as very first line |
| Spaces before `---` | Parser ignores it | Remove leading whitespace |
| `name: My Skill` | Not kebab-case | Use `name: my-skill` |
| `name: claude-helper` | Contains forbidden term | Remove `claude` from name |
| Description with `<placeholder>` | Angle brackets break parsing | Use backticks or remove |
| Description over 1024 chars | May be truncated | Shorten; move details to body |
| Folder `mySkill/` with `name: my-skill` | Name/folder mismatch | Rename folder to `my-skill/` |
| Using tabs in frontmatter | YAML parsing errors | Use spaces only |

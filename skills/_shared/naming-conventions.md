# Naming Conventions

Rules for naming skills, commands, and agents in `~/.claude/`.

## Skills

| Rule | Example | Anti-Example |
|------|---------|--------------|
| Lowercase kebab-case | `api-design-patterns` | `ApiDesignPatterns`, `api_design` |
| Noun-phrase or verb-noun | `security-review`, `fixing-accessibility` | `secure`, `accessible` |
| Domain-specific, not generic | `database-patterns` | `patterns` |
| No "skill" suffix | `rag-patterns` | `rag-patterns-skill` |
| No framework prefix | `multi-agent-patterns` | `sc-multi-agent-patterns` |
| Max 3 hyphenated words preferred | `git-workflows` | `advanced-git-branching-workflows` |

**Directory**: `skills/<skill-name>/SKILL.md`

## Commands

| Rule | Example | Anti-Example |
|------|---------|--------------|
| Lowercase kebab-case | `setup-audit` | `SetupAudit`, `setup_audit` |
| Verb-first or verb-noun | `review`, `start-task` | `code-stuff` |
| Action-oriented | `pr-prep`, `skill-design` | `pr-info` |
| No "command" suffix | `debug` | `debug-command` |
| Framework-scoped with colon | `sc:analyze`, `bmad:prd` | `sc-analyze` |

**File**: `commands/<command-name>.md`

## Agents

| Rule | Example | Anti-Example |
|------|---------|--------------|
| Lowercase kebab-case | `code-reviewer` | `CodeReviewer` |
| Role-noun or role-noun-modifier | `security-auditor`, `db-admin` | `does-security` |
| Matches the persona, not the task | `architect` | `design-system` |
| No "agent" suffix | `debugger` | `debugger-agent` |

**File**: `agents/<agent-name>.md`

## Tags (for skill catalog)

| Rule | Example | Anti-Example |
|------|---------|--------------|
| Lowercase, single word | `testing`, `security` | `Testing`, `security-stuff` |
| Domain nouns, not adjectives | `ui`, `database` | `visual`, `persistent` |
| Reuse existing tags first | Check `skills/README.md` tag index | Invent new tag without checking |
| Max 3 tags per skill | `[git, process, quality]` | `[git, process, quality, workflow, dev]` |

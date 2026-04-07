Perform a quality review of the current repository. Assess code health, project structure, and development practices.

## Review Dimensions

### 1. Project Structure
- Directory organization and consistency
- Presence of: README, LICENSE, .gitignore, CI config, tests directory
- Separation of concerns (src/, tests/, docs/, scripts/)
- Configuration files placement and format

### 2. Code Quality
- Sample 5-10 representative files across the codebase
- Check for: type hints (Python), proper error handling, consistent naming
- Look for: bare except clauses, hardcoded values, unused imports
- Assess test coverage presence (not percentage — just whether tests exist for key modules)

### 3. Dependency Health
- Check for: pinned versions, lock files, outdated dependencies
- Flag: unpinned deps, missing lock files, known vulnerable packages
- Review: dev vs production dependency separation

### 4. Git Practices
- Review last 10 commit messages for conventions
- Check branch naming patterns
- Look for: .env files committed, large binaries, secrets in history

### 5. Documentation
- README completeness: setup instructions, usage, contributing guide
- API documentation presence (if applicable)
- Architecture decision records or design docs

### 6. Security Quick Scan
- Check for hardcoded credentials or API keys in source
- Verify .gitignore covers: .env, credentials, keys, node_modules, __pycache__
- Check for SQL string concatenation or unsanitized user input

## Output Format

```
## Repository Review — <repo-name>

### Scores (1-5)
- Structure:     <score> — <one-line note>
- Code Quality:  <score> — <one-line note>
- Dependencies:  <score> — <one-line note>
- Git Practices: <score> — <one-line note>
- Documentation: <score> — <one-line note>
- Security:      <score> — <one-line note>

### Top 3 Issues
1. <issue + specific file/line>
2. <issue + specific file/line>
3. <issue + specific file/line>

### Top 3 Strengths
1. <strength>
2. <strength>
3. <strength>

### Recommended Actions
1. <action> (priority: high/medium/low)
2. <action>
3. <action>
```

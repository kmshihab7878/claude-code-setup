# PR Preparation

Prepare a pull request with summary, tests verification, and reviewer checklist.

## Instructions

Use `$ARGUMENTS` for any specific PR context or target branch.

### Step 1: Analyze Changes
- Run `git diff` against the target branch (default: main)
- Categorize changes: new features, bug fixes, refactoring, docs, tests
- Identify all files modified, added, or deleted

### Step 2: Generate PR Description
```markdown
## Summary
[2-3 bullet points of what changed and why]

## Changes
- [Categorized list of changes with file references]

## Testing
- [ ] Unit tests added/updated
- [ ] Integration tests pass
- [ ] Manual testing completed
- [ ] Edge cases covered

## Reviewer Checklist
- [ ] Code follows project conventions
- [ ] No security vulnerabilities introduced
- [ ] Error handling is comprehensive
- [ ] Performance implications considered
- [ ] Documentation updated if needed
- [ ] No breaking changes (or migration guide provided)
```

### Step 3: Pre-flight Checks
- Run linter and type checker
- Run test suite
- Check for uncommitted changes
- Verify branch is up to date with target

### Step 4: Changelog Entry
- Generate a concise changelog entry for the changes

Output the complete PR description ready to paste, plus any issues found during pre-flight.

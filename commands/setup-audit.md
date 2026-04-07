Perform an automated health check of the ~/.claude/ setup. Report findings in a structured format.

## Audit Steps

### 1. Skill Inventory
- Count skill directories in `~/.claude/skills/` (exclude `_shared`, `bmad`)
- Compare against CLAUDE.md roster count
- Flag any skills in filesystem but not in catalog (`skills/README.md`)
- Flag any skills in catalog but missing from filesystem

### 2. Command Inventory
- Count command files in `~/.claude/commands/` (exclude `sc/`, `bmad/` subdirs)
- Compare against CLAUDE.md roster count
- Flag orphaned or missing commands

### 3. Hook Verification
- Read `~/.claude/settings.json`
- List all hooks with their matchers
- Test force-push hook regex against known patterns:
  - Should BLOCK: `git push --force`, `git push -f origin main`
  - Should ALLOW: `git push`, `git push origin feature/x`

### 4. Disk Usage
- Check sizes of: `debug/`, `telemetry/`, `paste-cache/`, `file-history/`, `shell-snapshots/`
- Flag any directory over 50 MB

### 5. Governance Files
- Verify existence of: `README.md`, `skills/README.md`, `skills/_shared/skill-template.md`, `skills/_shared/review-checklist.md`, `skills/_shared/naming-conventions.md`
- Flag any missing governance files

### 6. Staleness Check
- Check `projects/*/memory/MEMORY.md` modification dates
- Flag memory files not updated in >7 days

## Output Format

```
## Setup Audit Report — <date>

### Summary
- Skills: <count> (expected: 38) <OK|MISMATCH>
- Commands: <count> (expected: 18) <OK|MISMATCH>
- Hooks: <count> (expected: 4) <OK|MISMATCH>
- Governance: <count>/5 files present
- Disk recoverable: <size>

### Issues
1. <issue description>
2. <issue description>

### Recommendations
1. <recommendation>
```

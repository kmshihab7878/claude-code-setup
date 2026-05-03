# Warp Workflows

> Copy-paste-able terminal snippets to launch the OS's governed commands from Warp. These are commands you type into a terminal pane — they delegate work to Claude Code, which goes through the OS's hooks and gates.

---

## Daily

### Start a session
```bash
git status --short && claude
```

### Resume the previous session
```bash
claude --resume
```

### Daily plan (morning)
```bash
claude "/daily-plan"
```

### End-of-day review
```bash
claude "/end-of-day-review"
```

---

## Weekly

### Friday operating review (audit + level-up + hot cache refresh)
```bash
claude "/weekly-operating-review"
```

### Just the audit
```bash
claude "/audit"
```

### Just the level-up loop
```bash
claude "/level-up"
```

---

## Implementation

### Ship a feature
```bash
claude "/ship $ARGUMENTS — use socraticode-preflight, preserve MCP governance, test before final"
```

Replace `$ARGUMENTS` with the feature description. The skill will inspect the repo first.

### Start a tracked task
```bash
claude "/start-task $ARGUMENTS"
```

### Complete a task
```bash
claude "/complete"
```

---

## Audit / review

### Full-stack audit of current repo
```bash
claude "/audit-deep current repo — inspect first; no edits without plan; use socraticode-preflight"
```

### AI OS-level audit (Four Cs)
```bash
claude "/audit"
```

### Setup audit (Claude Code config only)
```bash
claude "/setup-audit"
```

### Security audit
```bash
claude "/security-audit"
```

### Council review (multi-perspective)
```bash
claude "/council-review $ARGUMENTS"
```

### Diff review (unstaged + staged)
```bash
git status --short && git diff --stat && claude "/review current changes"
```

---

## Fix and debug

### Root-cause fix
```bash
claude "/fix-root $ARGUMENTS — trace call flow; do not patch symptoms only"
```

### Debug
```bash
claude "/debug $ARGUMENTS"
```

---

## Onboarding

### First-time AI OS onboarding
```bash
claude "/onboard"
```

### Quick refresh (3 questions)
```bash
claude "/onboard --quick"
```

---

## Knowledge base

### Ingest new raw files
```bash
claude "/wiki-ingest"
```

### Ask a question against the wiki
```bash
claude "/wiki-query $ARGUMENTS"
```

### Lint the wiki
```bash
claude "/wiki-lint"
```

---

## Operations

### Open a PR with PR-prep
```bash
claude "/pr-prep"
```

### Generate tests
```bash
claude "/test-gen $ARGUMENTS"
```

### Polish the UX
```bash
claude "/polish-ux $ARGUMENTS"
```

### Optimize performance
```bash
claude "/optimize $ARGUMENTS"
```

---

## Status / observation

### What's loaded right now (rules, evolution, hooks)
```bash
claude "/session-bootstrap"
# OR
bash ~/.claude/evolution/bin/evolve-status.sh
```

### Inventory counts (skills, commands, agents, MCPs)
```bash
make inventory
```

### Validate inventory drift
```bash
make validate
```

### Live MCP status
```bash
claude mcp list
```

### Plugin list
```bash
claude plugin list
```

---

## Recall / memory

### Cross-session search
```bash
claude "/recall $ARGUMENTS"
```

### View today's tool calls
```bash
tail -100 ~/.claude/usage.jsonl | head -50
```

### View MCP audit trail
```bash
tail -100 ~/.claude/audit-mcp.log
```

---

## Saving these as Warp workflows

In Warp, command palette → "Save Workflow" — name them by their leading slash command (`/audit`, `/ship`, etc.). This lets you launch them with two keystrokes from the command palette.

If you want to share workflows across machines, place the YAML files in `.warp/workflows/` and version-control them. Otherwise keep them per-machine — they're not part of the OS's governance.

---

## What NOT to put here

- **Destructive commands** without explicit `--dry-run` first
- **Anything that touches `settings.json`** (use `update-config` skill instead, gated by approval)
- **Cloud-agent invocations** (out of governance)
- **Commands that paste secrets in the prompt line** (history captures them)

If a snippet feels risky, write a script in `scripts/` instead. Scripts are versioned, reviewed, and reproducible. Workflows are cached strings.

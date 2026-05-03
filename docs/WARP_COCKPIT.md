# Warp Cockpit

> Warp is the **terminal layer** in the four-layer AI OS. It does not enforce policy. It does not execute governed work. It does not own memory. It is the place you sit while Claude Code does the real work.

---

## Why Warp

- Visual diff review when Claude makes large changes
- Multiple panes for parallel workflows (one for `claude`, one for `git`, one for logs)
- Block-based command history (jump back to any past output)
- Workflow snippets (canned `claude` invocations — see `docs/WARP_WORKFLOWS.md`)
- Status indicators that don't disappear when the AI starts streaming

## Why NOT Warp for governance

- Warp's cloud agents and AI features are **outside** this repo's governance:
  - They don't see `CLAUDE.md` rules
  - They don't go through `hooks/mcp-security-gate.sh`
  - They don't honour the 6-stage pipeline
  - They don't log into `decisions/log.md`
- Running a Warp cloud agent inside this repo is equivalent to running an unsanctioned MCP server: silent capabilities, no audit trail.

**Default:** Warp's AI features should be **off** for this repo. Use Claude Code (this repo) for AI work; use Warp's terminal features (panes, blocks, diffs, workflows) for productivity.

---

## Recommended layout

### Workspace 1 — `claude-code-setup` development

| Pane | Command |
|------|---------|
| Top-left | `claude` (active session) |
| Top-right | `git status -sb && git log --oneline -10` |
| Bottom-left | `make validate` (re-run on changes) |
| Bottom-right | `tail -F audit-mcp.log` (security gate audit trail) |

### Workspace 2 — Building inside another product repo

| Pane | Command |
|------|---------|
| Top | `claude` |
| Middle | `git status -sb` |
| Bottom | dev server / test watcher / log tail |

### Workspace 3 — Audit / review

| Pane | Command |
|------|---------|
| Top | `claude "/audit-deep current repo"` |
| Bottom | `git diff --stat` |

### Workspace 4 — Wiki / docs

| Pane | Command |
|------|---------|
| Top | `claude "/wiki-ingest"` |
| Bottom | `tree kb/wiki/` |

---

## Privacy checklist

Run once when first installing Warp on a machine that will work on sensitive repos:

| Setting | Recommended state | Why |
|---------|-------------------|-----|
| "Help improve Warp" telemetry | Off | No outbound product analytics from sensitive sessions |
| Crash reports | Off (or review what's sent) | Crash reports may include command output |
| Cloud sync | Review carefully | Don't sync command history that contains paths to sensitive repos |
| Workflow sharing | Off | Workflows you author may be private to this OS |
| Block-level cloud | Off | Same reason as cloud sync |
| AI features (cloud agents, autocomplete with cloud, etc.) | Off for sensitive repos | Outside the OS's governance |

The defaults change between Warp versions. Re-check after any major Warp update.

---

## What lives where

| Concern | Owner |
|---------|-------|
| Identity and rules | `CLAUDE.md` |
| Hooks and MCP gates | `hooks/`, `settings.json` |
| Skills and commands | `skills/`, `commands/` |
| Memory and context | `memory/`, `context/`, `kb/` |
| Workflows / canned shell snippets | `docs/WARP_WORKFLOWS.md` |
| Layouts | Warp itself (no need to version-control) |
| AI execution | Claude Code (this repo) |
| Code intelligence | SocratiCode (when installed) or `code-review-graph` MCP |

---

## When to use Warp's own AI features instead

Almost never on this repo. The reasons to override:

- You're outside any AI OS repo (a colleague's project, a quick exploration, a dotfiles edit) — Warp's AI is fine there
- You explicitly want a non-governed quick fix (e.g. shell history search, command auto-complete) — fine, those are productivity features, not agents
- You're testing Warp itself

Inside this repo: prefer `claude`. The point of the OS is consistent governance, and Warp AI is outside that boundary.

---

## Troubleshooting

| Symptom | Likely cause | Fix |
|---------|--------------|-----|
| `claude` doesn't see hooks | Wrong working directory | `cd` to repo root before launching |
| Warp's diff view is wrong on rename | Limitation of how diffs are computed in some Warp versions | Use `git diff --stat` in a pane instead |
| Workflow snippets don't expand | Warp didn't load the workflow file | Quit and relaunch Warp |
| Slow startup | Plugin / extension overhead | Disable Warp AI features for this repo |

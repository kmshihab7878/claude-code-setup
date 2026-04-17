# Demo — Reproducible Proof Path

The README links here when it says "show me what this does." No video exists yet; this page is the scripted sequence a human will record.

## Use case

**Audit a repo, fix one issue root-cause-style, and produce a shippable PR** — end to end, in ≤ 5 minutes.

This exercises the parts of the setup that do meaningful work:
- `/audit-deep` (structured inspection across quality/security/UX/tests)
- `/fix-root` (root-cause fix with regression protection)
- Inline hooks (auto-ruff on Python writes, force-push guard, sensitive-file block)
- Path rules (applied from `rules/*.md`)
- The Elite Operations ship-summary format

## Prerequisites

- Claude Code installed and this repo placed at `~/.claude/` (see `README.md` install).
- A target repo with at least one small visible quality issue (unused import, missing error state, etc.).
- `ruff`, `git`, and `gh` on PATH.

## Script — what to run, what to show

| # | You type | What it does | What to show on screen |
|---|----------|--------------|------------------------|
| 1 | `cd /path/to/target-repo && claude` | Start Claude Code in the target repo | Session-init hook loads git + project context |
| 2 | `/audit-deep the authentication flow in src/auth` | Structured 6-dimension inspection | Output: findings ranked P0–P3 with file paths and line refs |
| 3 | Pick the top P0 finding, type: `/fix-root <paste the finding>` | Root-cause fix protocol | Output: diagnosis paragraph, patch, regression test, verification |
| 4 | Accept the edits. `ruff` auto-fires on `.py` writes (PostToolUse hook). | No action — evidence the auto-format landed | Terminal shows no ruff output because the hook already cleaned it |
| 5 | `git status && git diff --stat` | Show the scoped, reviewable change | A small diff in only the files that mattered |
| 6 | `/ship "open PR for the auth fix"` | End-to-end commit + PR flow in Elite Ops mode | Ship summary: what changed, why safe, follow-ups |
| 7 | `gh pr view --web` | Open the PR in browser | Reviewable PR with commit trailers (Constraint, Rejected, Confidence) |

## Expected signals (what a viewer should notice)

- **No placeholder output.** Every step produces a file change, a test, or a diagnosis paragraph grounded in the target repo.
- **Hooks work silently.** Sensitive-file block, force-push guard, ruff autoformat fire without prompting.
- **One canonical path.** `/audit-deep` → `/fix-root` → `/ship` is the default loop for "audit, fix, ship." Other planners (`/plan`, `/ultraplan`) are available but not shown here to avoid confusion.

## Recording

- Length target: **60–90 seconds**. If it runs longer, the script is too broad.
- Terminal: 120 cols × 30 rows, dark theme.
- Tool: `asciinema rec demo.cast` or `screencapture -v ~/Desktop/demo.mp4`.
- Save to: keep media **outside** this repo. Link from the README when published.

## What this demo does NOT prove

- Scale of the library (197 skills, 239 agents). It proves that three high-value surfaces work end-to-end.
- That the other 180+ skills fire in real work. That requires usage telemetry (see [TELEMETRY.md](./TELEMETRY.md)).
- Before/after quantitative speedup vs. vanilla Claude Code. That requires a paired benchmark still to be designed.

# Contributing

This repository is a public-safe reference for an AI engineering setup built on Claude Code. Contributions are welcome under the constraints below.

## Before you start

1. Read [`README.md`](README.md) and [`docs/SETUP.md`](docs/SETUP.md).
2. Read [`CLAUDE.md`](CLAUDE.md) — the operating contract; it overrides repo defaults inside Claude Code sessions.
3. Read [`SECURITY.md`](SECURITY.md) and [`docs/SECURITY.md`](docs/SECURITY.md).

## Hard rules

| # | Rule |
|---|---|
| 1 | **Never commit secrets.** `.env`, `*.key`, `*.pem`, `credentials.json`, real tokens, real emails. `gitleaks` and `trivy` run in CI. |
| 2 | **Never commit personal identifiers.** Use placeholders: `<your-org>`, `<your-repo>`, `<contributor>`, `<workspace>`, `~/projects/<repo>`. The `scripts/check-public-safety.sh` gate enforces this. |
| 3 | **Never copy private local context.** `.claude/` runtime state, session records, memory exports, real MCP configs, real hook output — keep them out. If a local pattern is useful, abstract it into a template under `templates/`. |
| 4 | **Don't weaken safety automation.** Don't disable `scripts/check-public-safety.sh`, the MCP security gate, or the destructive-command gate to make a PR pass. Fix the underlying issue. |
| 5 | **Surgical changes.** Touch only what the contribution requires. No drive-by refactors. |

## Workflow

```bash
git checkout -b feat/<short-slug>
# ... make changes ...
bash scripts/audit-public-readiness.sh   # runs all safety + validation checks
git add -p
git commit -m "<type>(<scope>): <subject>"
git push -u origin feat/<short-slug>
gh pr create --base main
```

Commit message format follows conventional commits (`feat`, `fix`, `docs`, `chore`, `refactor`, `test`, `ci`). For non-trivial commits include the trailers documented in [`CLAUDE.md`](CLAUDE.md#commit-protocol): `Constraint`, `Rejected`, `Confidence`, `Scope-risk`, `Not-tested`.

## Adding a skill, command, agent, or hook

- Skill: place under `skills/<name>/SKILL.md` with frontmatter (`name`, `description`).
- Command: place under `commands/<name>.md` with a 1-line description.
- Agent: place under `agents/<dir>/<name>.md` and register in `agents/REGISTRY.md`.
- Hook: place under `hooks/<name>.sh`, document it in [`docs/HOOKS.md`](docs/HOOKS.md), and wire via `settings.json` in a separate PR if it should be active by default.

After adding, regenerate `docs/INVENTORY.md` via `bash scripts/inventory.sh` and run `bash scripts/validate.sh`.

## CI gates

Every PR runs:

- `scripts/check-public-safety.sh` — banned-term + email-leak gate
- `gitleaks detect` — secret detection across history
- `scripts/validate.sh` — internal consistency

A red gate blocks merge until resolved.

## What is out of scope here

- Anything that depends on a specific operator's local machine, accounts, or tokens. If a feature only makes sense with a personal account, document the pattern as a template, not a working integration.
- Anything that re-introduces the names, brands, or project references that were scrubbed for public release.

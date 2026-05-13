# Adoption Guide

This repository is a public-safe Claude Code setup: operating policy, slash
commands, skills, agents, hooks, MCP governance, templates, and validation gates
for a governed local AI engineering setup.

Adopt it when you want a ready reference for safe Claude Code operation, public
release checks, and repeatable local workflows. Do not adopt it as-is if you need
a tiny prompt file only; use the minimal path below instead.

## Choose Adoption Depth

| Depth | Use when | What to copy |
|---|---|---|
| Minimal | You only need policy examples or starter docs. | `docs/`, `templates/`, and selected policy text. |
| Standard | You want governed Claude Code behavior with safety gates. | `CLAUDE.md`, `AGENTS.md`, `WARP.md`, `commands/`, `hooks/`, `scripts/`, `.env.example`, and validation docs. |
| Full | You want the complete setup and operating cadence. | Standard depth plus `skills/`, `agents/`, `recipes/`, `rules/`, `memory/`, `evolution/`, `core/`, `domains/`, and cadence docs. |

Start minimal if you are evaluating. Move to standard only after validation
passes. Move to full only when you are ready to maintain skills, agents, memory,
MCP policy, and the evolution layer.

## Fork Safely

1. Fork or clone the repository.
2. Keep the first fork commit public-safe: do not add real credentials, personal
   notes, local paths, or filled private context.
3. Copy `.env.example` to `.env` locally and keep `.env` untracked.
4. Review `.gitignore` before adding local-only files.
5. Run validation before publishing or opening a PR:

```bash
bash scripts/doctor.sh
bash scripts/validate.sh
bash scripts/check-public-safety.sh
bash scripts/audit-public-readiness.sh --quick
gitleaks detect --no-banner --redact
trivy fs --scanners secret .
```

## Keep Private Context Out Of Git

Private context belongs in ignored local files, not tracked docs. Examples:

- Real credentials: `.env`, shell profile, password manager, or local secret store.
- Filled personal context: ignored `context/` files in your fork.
- Real MCP tokens: local Claude Code config, using environment variables.
- Session state: ignored runtime directories, logs, history, and memory exports.
- Operator notes: private notes outside the repo or ignored local files.

Tracked files should use placeholders only, such as `<your-org>/<your-repo>`,
`<workspace>`, `<project-root>`, `<your-api-key>`, and `<contributor>`.

## Configure Environment And MCP Safely

- Use `.env.example` as the public template.
- Put real values in `.env` or your shell environment.
- Use `templates/mcp.example.json` as a shape reference, then keep populated MCP
  config local.
- Prefer environment variable names in examples. Never commit token values.
- Keep MCP governance intact: do not weaken `hooks/mcp-security-gate.sh`, MCP
  allowlists, validation checks, or branch-protection guidance.

## Customize Without Leaks

- Commands: keep frontmatter concise and put task-specific detail in the command
  body or referenced docs.
- Skills: keep metadata high-signal; move large references into `references/`
  so they load only when selected.
- Agents: register routing metadata, then keep agent bodies focused on role,
  authority, tools, and expected output.
- Hooks: keep behavior narrow, readable, and covered by validation.
- Docs: keep human-facing guidance in `docs/`; do not make docs part of startup
  context unless they are required for every session.
- Memory and evolution: summarize, cap, and keep session-specific records
  ignored.

## Publish Or Share Safely

Before sharing, run the checks above and review:

- No tracked `.env`, keys, credentials, local state, logs, or session records.
- No personal identifiers, real handles, private project names, or local paths.
- No populated MCP config with real tokens.
- No copied private context from another workspace.
- No disabled safety checks, validation gates, scanner rules, hooks, or CI rules.

If a scan fails, fix the leak first. Rotate any exposed credential. If a leak
reached history, rewrite history only after explicit approval and keep backup-tag
handling intentional.

## Common Adoption Mistakes

| Mistake | Recovery |
|---|---|
| Committed `.env` or a key file. | Remove it, rotate the value, add or confirm ignore rules, scan again. |
| Filled tracked context files with private notes. | Move the notes to ignored local files and restore public-safe placeholders. |
| Copied populated MCP config. | Replace values with environment variable names and keep real config local. |
| Started with full adoption too early. | Reset to minimal or standard depth, then add surfaces only when maintained. |
| Added long policy text to pointer files. | Keep `AGENTS.md` and `WARP.md` as pointers to `CLAUDE.md`. |
| Added large startup memory. | Summarize it and link to lazy-loaded docs or memory files. |

## Do Not Commit

- Secrets, tokens, credentials, private keys, or populated config.
- Personal identifiers, real handles, email addresses, machine names, or local
  filesystem paths.
- Session logs, memory exports, shell snapshots, audit logs, or runtime state.
- Private business context, client names, internal aliases, or private project
  names.
- Safety bypasses, disabled scanner rules, weakened validation, or loosened MCP
  governance.

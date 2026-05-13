# Troubleshooting

Common failure modes when adopting this repo as a Claude Code configuration, and how to recover.

---

## Claude Code startup hooks

### Symptom: session won't start, or starts with hook errors

Claude Code runs `SessionStart` hooks defined in `settings.json` (and any project-level `.claude/settings.json`). A failing hook can either crash the session or silently corrupt context.

**Recovery sequence (in order):**

1. Run Claude Code with the baseline-mode env var to skip the evolution startup hook injection:
    ```bash
    CLAUDE_EVOLUTION_BASELINE=1 claude
    ```
2. Identify the failing hook:
    ```bash
    bash hooks/session-init.sh
    bash hooks/evolution-startup.sh
    # ...and so on for each SessionStart hook in settings.json
    ```
3. If a hook depends on a missing tool (e.g., `jq`, `gitleaks`), install it.
4. If a hook depends on a file under `~/.claude/state/` or `~/.claude/projects/` that doesn't exist yet, create the directory:
    ```bash
    mkdir -p ~/.claude/state ~/.claude/projects
    ```
5. As a last resort, disable a specific hook by editing your local `~/.claude/settings.local.json` (which is gitignored). Do not delete the entry from the shared `settings.json`.

### Symptom: `PreToolUse` hook denies every Bash command

Most likely the destructive-command gate or the MCP security gate is hitting a false positive. Check:

```bash
tail -20 ~/.claude/audit.log
tail -20 ~/.claude/audit-mcp.log
```

If a legitimate command is being blocked, narrow the pattern in `hooks/destructive-command-gate.sh` or add the tool to `recipes/lib/mcp-whitelist.json` — never disable the gate entirely.

---

## MCP authentication

### Symptom: `gmail`, `google-drive`, `google-calendar` show as auth-pending

These are claude.ai-managed OAuth integrations. Re-authenticate from inside a Claude Code session:

- Calendar: `mcp__claude_ai_Google_Calendar__authenticate`
- Drive: `mcp__claude_ai_Google_Drive__authenticate`
- Gmail: re-authenticate via the claude.ai web UI

After authorizing in the browser, paste the redirected callback URL back into the session.

### Symptom: `plugin:vercel:vercel` won't connect

Run `mcp__plugin_vercel_vercel__authenticate` to start the flow, then `mcp__plugin_vercel_vercel__complete_authentication` with the callback URL.

### Symptom: an MCP server you used to have isn't listed

`claude mcp list` is the source of truth. The repo's MCP table in `CLAUDE.md` is documentation and can drift. If you depend on a Tier-3 server, install it via the instructions in [`skills/mcp-mastery/SKILL.md`](../skills/mcp-mastery/SKILL.md).

---

## Validation suite

### Symptom: `scripts/validate.sh` fails

Read the failure line. Common causes:

| Failure | Cause | Fix |
|---|---|---|
| Count mismatch | Inventory drifted after adding/removing skills/commands/agents | `bash scripts/inventory.sh` to regenerate |
| Frontmatter warning | `SKILL.md` missing `name:` or `description:` | Add them |
| Hook-script reference broken | A hook listed in `settings.json` no longer exists in `hooks/` | Add the hook or remove the reference |
| Evolution startup over budget | `evolution/stable/global.md` grew past 4000 chars | Compact or split it |

### Symptom: `scripts/check-public-safety.sh` fails after a refactor

Almost always a leak — your edit reintroduced a banned term. Look at the failure line; the script prints up to 5 example hits. Either rename or remove the offending strings. Don't comment out the check.

---

## Secret scanning

### Symptom: `gitleaks` reports a leak after editing

If the leak is in your **working tree** only, edit the file and re-run.

If the leak is in **committed history**, you must either:

1. Rotate the credential immediately, then accept the historical exposure, or
2. Rewrite history with `git filter-repo --replace-text` and force-push (only acceptable if the leak hasn't been published, or you accept the orphaned-SHA window). See [`docs/PUBLICATION_CHECKLIST.md`](PUBLICATION_CHECKLIST.md).

### Symptom: `trivy` finds a "secret" in your example docs

Trivy false-positives on placeholder tokens that look real (e.g., `sk_test_...`, `ghp_xxx...`). If the value is genuinely a placeholder, either:

- Add a comment marker so reviewers see intent (`# placeholder — not a real key`), or
- Quote the placeholder in backticks so it doesn't appear adjacent to env-var syntax.

Do not whitelist real-looking patterns.

---

## Local-only context

### Symptom: `context/*.md` files keep getting modified by `/onboard` and you want them ignored

In your fork (not the upstream public repo), uncomment the `context/` line in `.gitignore`. The repo ships with placeholder context files that are safe to publish; your filled-in versions stay local.

### Symptom: `memory/MEMORY.md` keeps growing past 200 lines

That's the soft limit; lines beyond 200 are truncated when loaded. Move the older entries to typed files (`memory/<type>_<topic>.md`) and keep `MEMORY.md` as an index. Pattern documented in [`core/memory.md`](../core/memory.md).

---

## Reset to a known-good state

```bash
git fetch origin
git reset --hard origin/main
bash scripts/validate.sh
bash scripts/audit-public-readiness.sh
```

This discards all local changes — use a backup branch first if you have unstaged work.

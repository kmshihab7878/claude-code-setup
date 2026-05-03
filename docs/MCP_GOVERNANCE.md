# MCP Governance

> How the OS treats Model Context Protocol (MCP) servers — discovery, gating, audit, and trust.

---

## Default posture

> **Unknown MCP server = blocked. Write-capable MCP server = explicit approval. External-network MCP server = audit-logged with provenance summary. Secrets never pass through MCP prompts.**

In practice this means:
- New MCP servers don't get used silently
- Write tools (`create_*`, `delete_*`, `push_*`, `merge_*`, `transfer_*`, `send_*`, `post_*`) are flagged
- Every MCP call is recorded in `~/.claude/audit-mcp.log`
- The whitelist file (`~/.claude/recipes/lib/mcp-whitelist.json`) — when present — is the authoritative source for which tools are allowed per server

---

## What enforces this

`hooks/mcp-security-gate.sh` is wired as a `PreToolUse` hook in `settings.json`. It fires on every MCP tool call. Logic summary:

```
1. If tool is not MCP (no `mcp__` prefix) → allow
2. Extract server name from `mcp__<server>__<tool>`
3. First-use detection — log to ~/.claude/state/mcp-seen-tools.txt and audit log
4. Suspicious input scan — flag patterns like $(, `, ;rm, ;curl, eval, exec
5. High-risk tool tag — log when tool function name matches create/delete/push/merge/transfer/send/post patterns
6. Whitelist check — if ~/.claude/recipes/lib/mcp-whitelist.json exists, enforce per-server allowed-tool list
7. Audit log entry for every call
```

Read the source: `hooks/mcp-security-gate.sh`.

---

## Tier model (current state)

### Tier 1 — connected (live now)

From `claude mcp list`:

| Server | Transport | Read/Write | Sensitivity |
|--------|-----------|------------|-------------|
| filesystem | stdio | write (scoped to `$HOME`) | medium |
| memory | stdio | write (knowledge graph) | medium |
| sequential-thinking | stdio | read | low |
| git | stdio (uvx) | write (current repo) | medium |
| code-review-graph | stdio (uvx) | read (graph) | low |
| claude-mem | stdio (bun) | write (semantic memory) | medium |
| gmail (claude.ai) | HTTP | write (drafts only by default) | high |

### Tier 2 — auth pending

| Server | Action |
|--------|--------|
| google-calendar | re-authenticate when needed |
| google-drive | re-authenticate when needed |
| supabase | re-authenticate when needed |
| vercel (plugin) | authenticate when needed |
| chrome-devtools | failing — investigate or remove |

### Tier 3 — aspirational (not installed)

See `CLAUDE.md § Active MCP Servers § Tier 3` for the full list. Install steps live in `skills/mcp-mastery/SKILL.md`.

---

## Adding a new MCP server (governed flow)

1. **Justify** — write a one-line entry in `decisions/log.md` explaining why this server is needed and which existing tools won't satisfy the need.
2. **Inspect upstream** — read the server's docs. List the tools it exposes. Identify which are read-only and which are write.
3. **Sensitivity tier** — classify low / medium / high based on what data it touches.
4. **Whitelist plan** — decide which tool functions are needed; the rest will be blocked by `mcp-security-gate.sh` if a whitelist file exists.
5. **Install** — typically `claude mcp add <name> -- <command>` or `claude plugin install`.
6. **Verify** — `claude mcp list` shows it healthy.
7. **First-use** — make a single read call. Confirm `audit-mcp.log` shows `FIRST_USE`. Confirm response shape.
8. **Update `connections.md`** — add the row, with kill switch documented.
9. **Update `CLAUDE.md § Active MCP Servers`** — move from Tier 3 to Tier 1 (or add a row).
10. **Update `~/.claude/recipes/lib/mcp-whitelist.json`** — add the per-server allowed-tool list (if you maintain one).

---

## Removing an MCP server

```bash
claude mcp remove <server-name>
```

Then:
1. Remove the row from `connections.md`.
2. Move it from Tier 1 back to Tier 3 in `CLAUDE.md § Active MCP Servers`.
3. Remove or comment out the entry in `~/.claude/recipes/lib/mcp-whitelist.json`.
4. Log the removal in `decisions/log.md`.

The `~/.claude/state/mcp-seen-tools.txt` and audit log retain the historical record — leave them be.

---

## Whitelist format

`~/.claude/recipes/lib/mcp-whitelist.json` (optional but recommended for sensitive environments):

```json
{
  "filesystem": "*",
  "memory": "*",
  "git": ["git_status", "git_diff", "git_log", "git_show", "git_branch"],
  "gmail": ["search_threads", "get_thread", "list_drafts", "create_draft"],
  "supabase": ["query"]
}
```

Rules:
- `"*"` allows all tools from that server
- An array allows only listed tools — others are blocked
- A server NOT in the file is allowed (with first-use logging) — to enforce strict deny-by-default, list every server explicitly

---

## What gets logged

Every entry in `~/.claude/audit-mcp.log` looks like:

```
[YYYY-MM-DD HH:MM:SS] FIRST_USE: server=<name> tool=<func>
[YYYY-MM-DD HH:MM:SS] MCP_CALL: server=<name> tool=<func>
[YYYY-MM-DD HH:MM:SS] HIGH_RISK_TOOL: server=<name> tool=<func>
[YYYY-MM-DD HH:MM:SS] SUSPICIOUS_INPUT: server=<name> tool=<func> input_preview=<first 200 chars>
[YYYY-MM-DD HH:MM:SS] BLOCKED: server=<name> tool=<func> reason=whitelist
```

Operator reviews via:
```bash
tail -F ~/.claude/audit-mcp.log     # live during sensitive work
grep HIGH_RISK ~/.claude/audit-mcp.log | tail -50    # post-session review
```

---

## Common pitfalls

| Pitfall | Symptom | Fix |
|---------|---------|-----|
| Plugin AND MCP installed for same server | Duplicate tool entries; first-use fires twice | Pick one; remove the other |
| Whitelist file malformed | Hook fails open (allows everything) | Validate with `python3 -m json.tool < whitelist.json` |
| Server expects env var that isn't set | Tool calls return errors silently | Check server logs; set the env var in the MCP install command |
| OAuth token expires mid-session | Tool calls 401 | Re-run `claude mcp list` to see auth status; re-authenticate |
| `chrome-devtools` failing | Health check shows ✗ | Either fix (Chrome path, port) or remove the server |

---

## What MCP servers should NEVER be installed without explicit conversation

- **Anything that can spend money** without a documented cap (payment APIs, ad spend APIs, cloud cost-incurring APIs)
- **Anything that touches production infrastructure** without a separate dev/staging credential path (kubernetes-prod, postgres-prod)
- **Anything that posts publicly** under your name (social APIs, blog publishing APIs)
- **Anything with `--allow-all-tools` semantics** that bypasses the whitelist

For each of these, the right pattern is: install with read-only credentials first, prove the value, then promote to write with explicit per-tool approvals.

---

## Related docs

- `docs/SECURITY.md` — broader security defence layers
- `core/governance.md` — Constitution (SEC-001) and operating philosophy
- `skills/mcp-mastery/SKILL.md` — catalog of MCPs and install steps
- `connections.md` — registry of what's actually connected
- `hooks/mcp-security-gate.sh` — the enforcement code

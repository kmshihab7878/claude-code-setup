# `settings.local.json` — local override template

`settings.local.json` overrides anything in `settings.json` for your local environment only. It is **already gitignored**. Use it when you need to:

- Disable a hook that's blocking your local workflow
- Add a permission rule that you don't want forced on every contributor
- Set environment variables specific to your machine
- Tighten or loosen MCP permissions for your use case

The file structure mirrors `settings.json`. Example:

```json
{
  "hooks": {
    "SessionStart": []
  },
  "permissions": {
    "additionalDirectories": [
      "<workspace>"
    ],
    "deny": [
      "Bash(rm -rf *)",
      "Bash(git push --force)"
    ]
  },
  "env": {
    "EDITOR": "<your-editor>",
    "CLAUDE_EVOLUTION_BASELINE": "0"
  }
}
```

## Common overrides

### Skip the evolution startup injection

```json
{ "env": { "CLAUDE_EVOLUTION_BASELINE": "1" } }
```

### Add a local workspace to the allowed directories

```json
{ "permissions": { "additionalDirectories": ["<workspace>"] } }
```

### Disable a specific hook locally

```json
{ "hooks": { "PreToolUse": [] } }
```

### Allow a tool the shared config denies (only for your machine)

```json
{ "permissions": { "allow": ["Bash(make deploy)"] } }
```

## Rules

1. **Never** check in a populated `settings.local.json` — it is in `.gitignore` for a reason.
2. **Never** weaken security hooks (MCP gate, destructive-command gate, no-secret-commit) locally to ship faster. Fix the issue.
3. **Never** add real tokens, real domains, or real paths under `env` — use shell env vars or a secrets manager.
4. **Document** non-obvious overrides for your future self in a comment on the relevant key.

If your team needs an override globally, add it to the shared `settings.json` in a reviewable PR — not your local file.

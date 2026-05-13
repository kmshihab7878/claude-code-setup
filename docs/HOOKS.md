# Hooks Reference

Hooks are shell scripts that fire on lifecycle events inside Claude Code. They run in your local shell environment — fast hooks, no API calls. The shared hooks live under `hooks/`; project-level overrides go into `.claude/settings.local.json`.

---

## How hooks are wired

`settings.json` declares which hook fires on which event:

```json
{
  "hooks": {
    "PreToolUse": [{"matcher": "mcp__*", "hooks": [{"type": "command", "command": "hooks/mcp-security-gate.sh"}]}],
    "PostToolUse": [{"matcher": "Bash",   "hooks": [{"type": "command", "command": "hooks/usage-logger.sh"}]}],
    "SessionStart": [{"hooks": [{"type": "command", "command": "hooks/session-init.sh"}]}],
    "Stop":        [{"hooks": [{"type": "command", "command": "hooks/stop-verification.sh"}]}]
  }
}
```

Events Claude Code emits: `SessionStart`, `UserPromptSubmit`, `PreToolUse`, `PostToolUse`, `Notification`, `Stop`, `SubagentStop`, `SessionEnd`.

---

## Hooks in this repo

| Hook | Event | What it does |
|---|---|---|
| `session-init.sh` | SessionStart | Loads git/project/env context at session start |
| `evolution-startup.sh` | SessionStart | Injects evolution-layer operating contract + recent observations (can be skipped with `CLAUDE_EVOLUTION_BASELINE=1`) |
| `evolution-sessionend.sh` | SessionEnd | Closes evolution session, persists state |
| `keyword-detector.sh` | UserPromptSubmit | Auto-activates skills on keyword match (e.g. "tdd", "security review", "autonomous") |
| `preflight-context-guard.sh` | PreToolUse (Agent) | Blocks subagent spawning when context usage > 72 % |
| `loop-detector.sh` | PreToolUse (*) | Detects and breaks tool-call loops |
| `mcp-security-gate.sh` | PreToolUse (mcp__*) | Validates MCP tool calls against `recipes/lib/mcp-whitelist.json`, logs first-use and high-risk calls |
| `destructive-command-gate.sh` | PreToolUse (Bash) | Blocks force-push to main, `rm -rf` on system paths, unsafe resets |
| `no-secret-commit.sh` | PreToolUse (Write\|Edit) | Blocks writes to `.env`, `*.key`, `*.pem`, `credentials.json` |
| `usage-logger.sh` | PostToolUse (*) | Appends per-tool usage to `~/.claude/usage.jsonl` for later analysis |
| `session-metrics.sh` | PostToolUse (Bash) | Tracks session-level metrics |
| `tool-failure-tracker.sh` | PostToolUse (*) | Counts consecutive failures; suggests pivot after 3, stop after 5 |
| `context-guard.sh` | Stop | Warns at 75 % context usage, suggests `/compact` |
| `persistent-mode.sh` | Stop | Blocks premature stop while `~/.claude/state/autonomous.json` is active |
| `stop-verification.sh` | Stop + SubagentStop | Runs `ruff` on Python, `tsc` on TypeScript, checks uncommitted files |
| `validation-summary.sh` | (manual / SubagentStop) | Flags unverified work in agent output |

---

## Design principles

1. **Fail safe.** A hook error should slow you down, not destroy work. Exit non-zero only when blocking is the right call.
2. **No secrets in stdout.** Hook output appears in the session transcript. Redact tokens.
3. **No writes into tracked paths.** Hooks write to `~/.claude/state/`, `~/.claude/audit*.log`, or `/tmp/`. Never the repo working tree.
4. **Fast.** PreToolUse fires before every matching tool call. Sub-100 ms target.
5. **Auditable.** Every block reason is logged with enough context to debug.

---

## Disabling a hook locally

Override via `~/.claude/settings.local.json` (gitignored):

```json
{
  "hooks": {
    "SessionStart": []
  }
}
```

For a single session: prefix with the relevant env var:

```bash
CLAUDE_EVOLUTION_BASELINE=1 claude       # skips evolution startup
```

Don't remove a hook from the shared `settings.json` to "fix" your local environment — that pushes the disablement to every user of this config.

---

## Adding a new hook

1. Write the script under `hooks/<name>.sh`. Make it executable: `chmod +x hooks/<name>.sh`.
2. Use the structured I/O contract: read stdin JSON, write decision JSON to stdout.
3. Document it in this file.
4. Wire it via `settings.json` in a separate PR so the addition is reviewable independently of the implementation.
5. Run `bash scripts/validate.sh` — it confirms every hook referenced in settings actually exists in `hooks/`.

---

## Debugging a failing hook

```bash
# 1. Run it in isolation
bash hooks/<name>.sh < /dev/null

# 2. Read the audit log
tail -50 ~/.claude/audit.log
tail -50 ~/.claude/audit-mcp.log

# 3. Run Claude Code with debug output
claude --verbose  # output goes to ~/.claude/debug/
```

If a hook crashes Claude Code's startup, see [`docs/TROUBLESHOOTING.md`](TROUBLESHOOTING.md).

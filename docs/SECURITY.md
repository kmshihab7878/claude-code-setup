# Security

> Defence-in-depth across hook layer, MCP gates, secret hygiene, and operational practice. The Constitution lives in `core/governance.md` (SEC-001). This file documents how it's enforced and where to extend it.

---

## Threat model (in plain language)

The OS sits between the operator's intent and external systems (MCP servers, APIs, the filesystem, git remotes, the network). Real risks:

| Risk | What it looks like | Where defended |
|------|--------------------|----------------|
| Secret leak via commit | `.env`/`*.key` accidentally added; secret pasted in code | `.gitignore` + `hooks/no-secret-commit.sh` (extracted) |
| Secret leak via prompt | Operator pastes credentials into chat | `/onboard` PII guard; `references/api-integration-principles.md` rule 1 |
| Destructive shell command | `rm -rf` on system path; force push to main; reset --hard origin/main | inline hook in `settings.json` (force-push, rm -rf) + `hooks/destructive-command-gate.sh` (extracted, broader coverage) |
| Malicious or compromised MCP server | New MCP server surfaces with write capability | `hooks/mcp-security-gate.sh` (live) — first-use detection, suspicious-input flagging, optional whitelist |
| Prompt injection via tool output | External content steers the model | Manual operator review of agent outputs; `validation-summary.sh` (extracted) flags unverified work |
| Drift in tracked PII | Operator name / handle / email accumulates in tracked files | Manual sweep; commit `a684132` baselined this |
| Untracked governance bypass | Warp cloud agent or external tool runs without going through hooks | `WARP.md` rule 6 — explicit ban; `core/governance.md` |
| Stale credentials | Service account tokens age out and aren't rotated | Quarterly review per `connections.md` lifecycle § 7 |

---

## Defence layer 1 — `.gitignore`

Already gitignored:
- `.env`, `*.pem`, `*.key`, `settings.local.json`, `*.backup.*`
- `state/`, `sessions/`, `audit*.log`, `history.jsonl`, `usage.jsonl`
- `evolution/records/*.jsonl` — raw evidence is private
- `projects/` — per-project memory may contain conversation context
- `references/external/*/repo/` — cloned external code

If a sensitive path is missing, add it to `.gitignore` AND verify with `git check-ignore -v <path>`.

---

## Defence layer 2 — Hooks

### Currently wired in `settings.json`

| Event | Hook | What it does |
|-------|------|--------------|
| `PreToolUse` (Write/Edit) | inline | Blocks writes to `*.env|*.pem|*.key|credentials|secret*` paths |
| `PreToolUse` (Bash, `git push *`) | inline | Blocks `--force` without `--force-with-lease` |
| `PreToolUse` (Bash, `rm *`) | inline | Blocks `rm -rf` on protected system paths |
| `PreToolUse` (Write/Edit on linter configs) | inline | Reviews edits to ruff/eslint/biome/tsconfig — prefer fixing code over weakening rules |
| `PreToolUse` (any) | `hooks/loop-detector.sh` | Detects tight tool-call loops |
| `PreToolUse` (any) | `hooks/usage-logger.sh` | Logs every tool call to `~/.claude/usage.jsonl` |
| `PreToolUse` (any) | `hooks/mcp-security-gate.sh` | First-use detection, suspicious-input pattern flagging, optional whitelist |
| `UserPromptSubmit` | `hooks/keyword-detector.sh` | Routes special keywords (autonomous-mode, etc.) |
| `SessionStart` | `hooks/session-init.sh`, `hooks/evolution-startup.sh` | Boots context |
| `Stop`, `SubagentStop` | `hooks/context-guard.sh`, `hooks/persistent-mode.sh`, `hooks/stop-verification.sh` | Final-state checks |
| `SessionEnd` | `hooks/evolution-sessionend.sh` | Records session evidence |

### Extracted but NOT wired yet

These hooks are written and validated (`bash -n` passes) but **not added to `settings.json`** because changes to `settings.json` require explicit user approval.

| Hook | Purpose | When to wire |
|------|---------|--------------|
| `hooks/destructive-command-gate.sh` | Broader destructive-command detection (chmod 777, curl|sh, sudo, DROP TABLE on prod, reset --hard origin/main) than the inline version | When you want stricter shell governance |
| `hooks/no-secret-commit.sh` | File-path-based blocking (already inline) PLUS content-pattern scanning for AWS/Stripe/Slack/OpenAI/PEM patterns | When you want content-level secret scanning |
| `hooks/validation-summary.sh` | Heuristic post-session check: did writes happen without tests/builds? Reports gaps. | When you want a "did you actually validate?" reminder at end of meaningful sessions |

### Enabling extracted hooks (manual)

Edit `settings.json` (the user must approve this edit explicitly):

```jsonc
"PreToolUse": [
  // ... existing entries ...
  {
    "matcher": "Bash",
    "hooks": [
      { "type": "command", "command": "~/.claude/hooks/destructive-command-gate.sh", "timeout": 5000 }
    ]
  },
  {
    "matcher": "Write|Edit",
    "hooks": [
      { "type": "command", "command": "~/.claude/hooks/no-secret-commit.sh", "timeout": 5000 }
    ]
  }
],
"Stop": [
  // ... existing entries ...
  {
    "hooks": [
      { "type": "command", "command": "~/.claude/hooks/validation-summary.sh", "timeout": 10000 }
    ]
  }
]
```

After editing: validate JSON with `python3 -m json.tool < settings.json > /dev/null` and run a quick bash command in a fresh session to confirm hooks fire (look in `~/.claude/audit.log`).

---

## Defence layer 3 — MCP governance

See `docs/MCP_GOVERNANCE.md`. Key rules:
- Unknown MCP server → block (when whitelist present) or warn-on-first-use
- Write-capable tools → audit-logged with `HIGH_RISK_TOOL` tag
- Suspicious input patterns (`$(...)`, backticks, `;rm`, `;curl`) → flag, log, exit 1 (warn)
- All MCP calls land in `~/.claude/audit-mcp.log`

---

## Defence layer 4 — Secret hygiene

- **Never commit secrets.** `.env` is gitignored; `.env.example` is a template with placeholders.
- **Service accounts for sensitive systems.** Per `references/api-integration-principles.md` rule 2.
- **Quarterly rotation.** Per `connections.md` lifecycle.
- **No secrets in prompts.** `/onboard` and chat workflows are warned.
- **No secrets in shell history.** `Warp` workflows must not embed secret values inline — use `$VAR` references.

---

## Defence layer 5 — Manual operator practice

These can't be automated:
- Read PRs before merging.
- Verify outbound emails before sending.
- Check `git diff` before push.
- Don't approve T2 actions without reading what they'll do.
- Don't enable `--dangerously-skip-permissions` mode without an explicit reason and a time-bound revert plan.

---

## Incident response

If a secret leaks:
1. **Rotate immediately** at the source (revoke at the issuer, generate new credential).
2. **Force-push** scrubbed history if the secret is in a recent commit (`git filter-repo` or `bfg`); document in `decisions/log.md`.
3. **Audit downstream** — check whether the leaked credential was used.
4. **Update `.gitignore` and hooks** to prevent recurrence.
5. **Log the incident** in `kb/retrospectives/YYYY-MM-DD-<incident>.md` with full timeline.

If a destructive command runs:
1. **Stop autonomous mode** if active (`rm ~/.claude/state/autonomous.json`).
2. **Recover** from git reflog (`git reflog`, `git fsck --lost-found`) or backup.
3. **Update the destructive-command gate** with the missing pattern.
4. **Log in `decisions/log.md`** with timeline.

---

## Audit trail

All security-relevant events log to:
- `~/.claude/audit.log` — destructive command attempts, validation gaps, no-secret-commit blocks
- `~/.claude/audit-mcp.log` — MCP first-use, suspicious patterns, blocks
- `~/.claude/usage.jsonl` — every tool call (used by `analyze-usage.sh`)
- `~/.claude/history.jsonl` — session history (used by SessionStart context loaders)

These are gitignored. Operator reviews them via `tail -F` in a Warp pane during sensitive work.

---

## What's NOT defended

Honest list:
- **Compromised model output.** If Anthropic is compromised, this OS can't help you.
- **Compromised local machine.** A keylogger reads everything; rebuild the machine.
- **Operator inattention.** No hook stops a tired operator from approving a bad T2 action.
- **Side-channel via clipboard.** If you copy-paste secrets to chat, the OS doesn't see it until the prompt is submitted; hooks fire on tool calls, not on prompts.
- **Network-level attacks.** Use a VPN / good DNS resolver / etc. — outside the OS's scope.

Mitigations for these are operator-level, not OS-level.

# Telemetry

Goal: make "what do I actually use?" a question with a data-backed answer.

## What gets logged

One JSON line per tool invocation, appended to `~/.claude/usage.jsonl` by the `usage-logger` PreToolUse hook. Fields:

| Field | Source | Always present? |
|-------|--------|-----------------|
| `ts` | hook invocation time (UTC ISO-8601) | yes |
| `event` | `hook_event_name` from Claude Code | when Claude Code sets it |
| `tool` | `tool_name` from Claude Code | yes |
| `session` | first 12 chars of `session_id` | when Claude Code sets it |
| `command` | `tool_input.command` (truncated 200 chars) | Bash calls |
| `file_path` | `tool_input.file_path` | Read/Write/Edit |
| `subagent_type` | `tool_input.subagent_type` | Agent tool |
| `skill` | `tool_input.skill` | Skill tool |
| `slash_command` / `command_name` | `tool_input.slash_command` / `.command_name` | SlashCommand tool |

No inferred fields. If Claude Code does not expose a value, it is not in the record. This log is not a feature inventory — it is a hook-observable event stream.

## What does NOT get logged

- Description-only skill loads (Claude Code loads skill descriptions into the system prompt without firing a tool call — not observable by hooks).
- Internal reasoning or tokens.
- Tool outputs (PostToolUse is not instrumented to keep the log compact).

See the "Limits" section below for what this means for usage inference.

## Install

The hook ships in this repo at `hooks/usage-logger.sh` and is wired in `settings.json` under `hooks.PreToolUse` with `matcher: ""` (fires on every tool call).

Verify it is active:
```bash
jq '.hooks.PreToolUse[] | select(.hooks[]?.command | test("usage-logger"))' settings.json
```

## Analyze

```bash
scripts/analyze-usage.sh                 # last 30 days
scripts/analyze-usage.sh --since 7       # last 7 days
```

Output includes: top-20 most-invoked surfaces, session counts, planner-ratio, and zero-invocation surfaces (cross-referenced against `scripts/inventory.sh` to identify pruning candidates).

The analysis script degrades gracefully if `~/.claude/usage.jsonl` does not exist yet and tells you when to come back.

## MCP snapshot

There is no automated weekly snapshot. The authoritative MCP list lives in `CLAUDE.md` (tiered: connected / auth-pending / aspirational) and is validated on demand with `claude mcp list`. If you want a point-in-time snapshot, run:

```bash
claude mcp list > ~/.claude/mcp-snapshot-$(date +%Y-%m-%d).txt
```

This is intentionally manual. Automating it adds a maintenance surface with low payoff.

## Limits

1. **Hooks only see tool invocations.** A skill that influences Claude via its description without firing a tool is invisible here.
2. **No outcome field.** Tool success/failure is not recorded (PostToolUse is noisier and adds little signal for pruning).
3. **Session IDs may rotate.** Claude Code may rotate `session_id` across restarts.
4. **Schema is resilient, not guaranteed.** If Claude Code renames a `tool_input` field, the record simply omits it.
5. **Frequency ≠ value.** A skill invoked 3 times that saved 10 hours matters more than one invoked 50 times with no downstream effect. Telemetry flags candidates; humans decide.

## Pruning protocol (evidence-gated)

1. Run analyze-usage after ≥ 14 days of real usage.
2. For any skill / command / agent with **zero invocations** in the window, move it to `skills/_archive/`, `commands/_archive/`, or `agents/_archive/`.
3. Do **not** delete. Archive. Git preserves the rename; easy to restore.
4. Commit with message referencing the window (`chore: archive zero-invocation surfaces over 14d`).
5. Re-run `scripts/inventory.sh --md` and `scripts/validate.sh` to catch count drift.

Zero invocations over 14 days is a threshold, not a verdict — it flags *candidates*. A human still decides.

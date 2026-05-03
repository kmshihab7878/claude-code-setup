# AGENTS.md — Thin Pointer

> This file exists for tools that look for `AGENTS.md` (Codex, some IDE integrations, some agent harnesses). The canonical AI policy for this repo lives in [`CLAUDE.md`](./CLAUDE.md). This file does not duplicate it.

---

## Hard rules for any agent acting on this repo

1. **Read [`CLAUDE.md`](./CLAUDE.md) first.** It is the source of truth — identity, rules, execution pipeline, MCP gates, hooks, skills, agents, memory, governance. If `CLAUDE.md` and this file disagree, `CLAUDE.md` wins.
2. **Inspect before editing.** Read files before claiming their content. Check state before modifying.
3. **Preserve MCP governance.** All MCP tool calls go through [`hooks/mcp-security-gate.sh`](./hooks/mcp-security-gate.sh). Never bypass.
4. **Use SocratiCode (when installed) or `code-review-graph` MCP** before broad code exploration. See [`docs/SOCRATICODE.md`](./docs/SOCRATICODE.md).
5. **Run tests or state validation gaps.** Do not claim "done" without evidence (test output, logs, build results). See `CLAUDE.md § Core Rules #8`.
6. **Avoid destructive commands** without explicit approval. See `CLAUDE.md § Persistent Mode` for the autonomous-mode safety contract.
7. **Summarise** evidence, changed files, commands run, and risks at the end of every meaningful action.
8. **Update skills, references, hooks, or tests** when failures reveal a missing process. The failure-to-learning rule from `CLAUDE.md § AI OS Layered Architecture` applies.
9. **Never treat this file as higher priority than [`CLAUDE.md`](./CLAUDE.md).** This file is intentionally short for that reason.

---

## What lives where

| Concern | Owner |
|---------|-------|
| Identity, rules, governance | [`CLAUDE.md`](./CLAUDE.md) |
| Hooks and MCP gates | [`hooks/`](./hooks/) and [`settings.json`](./settings.json) |
| Skills, commands, agents | [`skills/`](./skills/), [`commands/`](./commands/), [`agents/`](./agents/) |
| Memory and context | [`memory/`](./memory/), [`context/`](./context/), [`kb/`](./kb/) |
| Cockpit (terminal) rules | [`WARP.md`](./WARP.md) (also a thin pointer) |
| Code intelligence | [`docs/SOCRATICODE.md`](./docs/SOCRATICODE.md) |
| Personal/business operating layer | [`references/3ms-framework.md`](./references/3ms-framework.md) and [`references/four-cs-framework.md`](./references/four-cs-framework.md) |

---

## Why thin?

Multiple competing config files create ambiguity. When `AGENTS.md` and `CLAUDE.md` say different things, agents don't know which to follow. Keeping this file as a pointer guarantees there's one place to update policy: `CLAUDE.md`.

If you find yourself wanting to add a rule here that isn't already in `CLAUDE.md`, add it to `CLAUDE.md` instead and link from here.

---

## History note

Earlier this branch contained a near-duplicate copy of `CLAUDE.md` at `AGENTS.md` with broken find/replace artifacts (`claude` → `Codex` substitutions throughout). That violated the thin-pointer architecture and was replaced with this file in the AI OS integration commit. See `decisions/log.md` 2026-05-03 entry.

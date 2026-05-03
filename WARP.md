# Warp Operating Rules

> **This file is intentionally short.** The canonical AI policy for this repo lives in [`CLAUDE.md`](./CLAUDE.md). Warp is the cockpit, not the constitution.

---

## Hard rules for any AI surface running inside Warp on this repo

1. **Read and follow [`CLAUDE.md`](./CLAUDE.md) before acting.** It is the source of truth for identity, governance, MCP gates, hooks, skills, agents, memory, and the 6-stage execution pipeline.
2. **Do not bypass** Claude Code hooks, MCP governance (`hooks/mcp-security-gate.sh`), tests, or validation gates.
3. **Use Warp as the terminal/session/diff cockpit only.** Layout, panes, command palette, visual diffs.
4. **Use Claude Code as the governed execution path.** Implementations, refactors, audits, ships.
5. **Use SocratiCode (when installed) for codebase intelligence** before broad code exploration. See [`docs/SOCRATICODE.md`](./docs/SOCRATICODE.md).
6. **Do NOT use Warp cloud agents on this repo unless explicitly approved.** This repo has its own governance — running an external cloud agent inside it bypasses the governance.
7. **Do not duplicate or override canonical policy here.** If there's a Warp-specific behaviour to document, add it as a *pointer* to the relevant `CLAUDE.md` section. Never restate policy.
8. **Privacy:** Warp's "Help Improve" telemetry, crash reports, and cloud features should be reviewed for any sensitive repo before opening this directory in Warp.

---

## Layered architecture (short form)

```
Warp           ← terminal cockpit (UX, panes, diffs)
Claude Code    ← governed execution (this repo's hooks + MCP gates)
SocratiCode    ← codebase intelligence (when installed)
claude-code-setup ← constitution, policy, memory  ← canonical
AIS-OS framework  ← personal/business operating layer (Three Ms, Four Cs, weekly loops)
```

`CLAUDE.md` is the single source of truth across all five.

---

## See also

- [`docs/WARP_COCKPIT.md`](./docs/WARP_COCKPIT.md) — cockpit setup, layouts, privacy checklist
- [`docs/WARP_WORKFLOWS.md`](./docs/WARP_WORKFLOWS.md) — copy-paste-able workflow snippets
- [`CLAUDE.md`](./CLAUDE.md) — the actual contract
- [`AGENTS.md`](./AGENTS.md) — agent rules (also a thin pointer)

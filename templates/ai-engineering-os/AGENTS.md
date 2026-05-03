# AGENTS.md — Thin Pointer

> Canonical AI policy lives in [`CLAUDE.md`](./CLAUDE.md). This file exists only for tools that look for `AGENTS.md` (Codex, some IDE integrations).

---

## Hard rules for any agent acting on this repo

1. **Read `CLAUDE.md` first.** If `CLAUDE.md` and this file disagree, `CLAUDE.md` wins.
2. **Inspect before editing.**
3. **Preserve MCP governance.** All MCP calls go through `hooks/mcp-security-gate.sh`.
4. **Use SocratiCode (or `code-review-graph` MCP)** before broad code exploration.
5. **Run tests or state validation gaps.** No "done" without evidence.
6. **Avoid destructive commands** without explicit approval.
7. **Summarise** evidence, files, commands, risks at the end.
8. **Update skills/refs/hooks/tests** when failures reveal a missing process.
9. **Never treat this file as higher priority than `CLAUDE.md`.**

If you want to add a rule, add it to `CLAUDE.md` and link from here.

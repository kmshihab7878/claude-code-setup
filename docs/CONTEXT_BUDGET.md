# Context Budget

Context budget means keeping the minimum sufficient context available for correct
action. The goal is not to make files tiny at any cost. The goal is to keep
always-loaded content stable, compact, and high-signal while loading details only
when a task needs them.

## Loading Tiers

| Tier | Loads when | Examples | Rule |
|---|---|---|---|
| Always-loaded | Session or tool startup | `CLAUDE.md`, `AGENTS.md`, `WARP.md`, `settings.json` | Keep compact and constitutional. |
| Startup-injected | SessionStart hooks or memory plugins | `evolution/stable/global.md`, `memory/MEMORY.md`, hook output | Summarize and cap. |
| Lazy-loaded | Skill, command, agent, or file selection | `SKILL.md`, command bodies, agent files, `core/`, `domains/` | Load only after routing. |
| Docs-only | Human reading and adoption | `docs/*.md`, examples, runbooks | Link from startup files; do not inject wholesale. |

## Surface Rules

- `CLAUDE.md` is the compact operating kernel. It should state durable policy,
  route to indexes, and avoid copying long docs.
- `AGENTS.md` and `WARP.md` are pointer files. They should not restate the full
  contract.
- Skills should be metadata-first. Keep the description useful for routing and
  place long reference material in `references/`.
- Commands should keep concise frontmatter and put task protocol in the body.
  Avoid copying skill or agent instructions into commands.
- Agents should be registry-routed and loaded only when invoked. Large reusable
  method content belongs in a skill or reference doc.
- Docs should remain human-facing unless a hook or command explicitly needs a
  short excerpt.
- Memory and evolution context should be summary-first, capped, public-safe when
  tracked, and session-safe when local.

## Measure The Budget

Run:

```bash
bash scripts/context-budget-report.sh
```

The report estimates tokens as `characters / 4`. It is approximate by design:
the exact model tokenizer, prompt cache behavior, and tool schemas can differ.
Use the report to find likely heavy surfaces, not to claim exact token counts.

## Interpret Warnings

- A large `CLAUDE.md` warning means the always-loaded kernel may be carrying
  detail that belongs in `core/`, `domains/`, or docs.
- A large `AGENTS.md` or `WARP.md` warning usually means a pointer file has
  started duplicating canonical policy.
- A startup-injected warning means memory or evolution text may need a shorter
  summary or a stricter cap.
- A large skill, command, or agent warning means the file should be reviewed for
  reference material that can move behind lazy loading.
- Heavy docs are ranked for awareness only. Docs can be large when they are not
  injected into startup context.

## Reduce Token Bloat Safely

1. Preserve safety rules, validation, secret scanning, MCP governance, hooks, and
   branch-protection guidance.
2. Replace duplicated policy with links to the canonical source.
3. Move examples and detailed procedures into docs or `references/`.
4. Keep routing indexes concise and accurate.
5. Summarize memory and evolution entries before promotion.
6. Re-run validation and the context budget report after changes.

## Adding New Surfaces

- New skills: write a clear description, keep setup steps short, and put long
  examples in `references/` or `examples/`.
- New commands: add concise frontmatter and call out which docs, skills, or
  agents should load later.
- New agents: keep role, authority, inputs, outputs, and MCP bindings clear;
  route through `agents/REGISTRY.md`.
- New hooks: keep output short because hook output can become session context.
- New docs: link from indexes, but do not inject into startup context.
- New memory files: keep `memory/MEMORY.md` as a short index and store detail in
  lazy-loaded memory files.

Do not optimize away the gates that keep the repo safe. Public-safety checks,
validation, scanner coverage, MCP governance, and branch-protection guidance are
part of the budget because they prevent expensive failures.

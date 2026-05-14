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

## Risk classifications

Raw token size does not say which large files actually hurt context. A 6k-token
always-loaded kernel costs every turn; a 6k-token lazy skill only costs when
that skill is invoked. The report adds a deterministic risk label so the next
optimization pick is informed, not arbitrary.

| Label | Loaded when | Why it matters |
|---|---|---|
| `ALWAYS_LOAD_RISK` | Every session — `CLAUDE.md`, `AGENTS.md`, `WARP.md`, `settings.json` | Every byte taxes every turn. Fix these first. |
| `STARTUP_INJECTED_RISK` | Session start — `evolution/stable/global.md`, `memory/MEMORY.md`, hooks referenced by SessionStart | Pulled in before the user can opt out. Cap and summarize. |
| `ROUTING_INDEX_RISK` | When routing logic loads an index — `agents/REGISTRY.md`, `domains/**/DOMAIN.md`, `core/*.md` | Pulled into many planning flows. Keep concise; favor pointers over duplicated tables. |
| `LAZY_REFERENCE_HEAVY` | Only when the skill/command is invoked. Body holds API catalogs, schemas, endpoint lists, long reference tables. | Less urgent than always-loaded surfaces. Move extra material behind `references/` when feasible. |
| `EXTRACTION_CANDIDATE` | Same as above, but the skill has no `references/` directory yet. | Top priority among lazy files — splitting earns the most token relief per change. |
| `LAZY_OPERATING_CONTRACT` | When a command or agent is invoked. Body carries executable rules — stages, policy gates, authority. | Stays large on purpose. Compress only when safety, validation, or routing semantics survive intact. |
| `ACCEPTABLE_LARGE` | Reader-facing docs and `references/` files; not pulled into startup. | Leave alone unless they migrate into a startup path. |

### Priority order when picking an optimization target

1. `ALWAYS_LOAD_RISK`
2. `STARTUP_INJECTED_RISK`
3. `ROUTING_INDEX_RISK`
4. `LAZY_REFERENCE_HEAVY` / `EXTRACTION_CANDIDATE`
5. `LAZY_OPERATING_CONTRACT`
6. `ACCEPTABLE_LARGE`

### When to leave a large file alone

- The body is an operating contract (`LAZY_OPERATING_CONTRACT`) and compressing
  would break stage flow, approval gates, or safety language.
- A reference file already exists and the remaining body is the public
  procedure callers depend on.
- The "large" surface is `ACCEPTABLE_LARGE` and is never injected into the
  startup path — large is fine for human-readable docs.
- Removing content would erase domain knowledge that the skill needs at
  runtime, even though it looks like prose.

The report still exits 0 in all of these cases — risk labels are advisory, not
gates. Treat them as priority guidance for the next PR, not as failures.

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

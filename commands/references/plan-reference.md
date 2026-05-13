# `/plan` reference

Extended schemas, matrices, and templates for `/plan`. The command file (`commands/plan.md`) keeps the operating flow and safety gates. This file holds the bulk that loads on demand.

---

## Intent schema (Stage 1)

```
INTENT:
  content: "<original request>"
  goal_type: operational | strategic | analytical | financial | technical | creative | research
  domain: engineering | infrastructure | security | quality | research | product | growth |
          operations | strategy | trading | marketing | offensive | meta
  priority: 1-10
  risk_level: low | medium | high | critical
  action_tier: T0 Safe | T1 Local | T2 Shared | T3 Critical
  complexity: simple | moderate | complex | enterprise
```

## Context gathering — pick the right source

| Need | Source |
|------|--------|
| Git state | `git status`, `git log --oneline -10`, `git branch` |
| Project rules | `CLAUDE.md`, `README.md`, project configs |
| Codebase | Explore agent / Glob / `code-review-graph` MCP |
| Project memory | `memory/MEMORY.md` + typed memory files |
| Semantic memory | `plugin:claude-mem:mcp-search__search` |
| Past sessions | `/recall` skill |
| Recipes | `recipes/` (run via `/recipe run <name>`) |
| Library docs | `context7` MCP |
| Vault / KB | `obsidian` MCP, `kb/wiki/INDEX.md` |
| Web | `brave-search` / `tavily` MCP |

**Recipe-first** — before planning from scratch, scan `recipes/` (security, engineering, trading, devops, sub/). If a recipe matches, run it instead.

---

## Stage 4: planner — capability matching

Authoritative source: [`agents/REGISTRY.md`](../../agents/REGISTRY.md) — declares all agents with authority level (L0 System Core through L6 Workers + self-evolution + experimental waves), declared MCP servers, skill bindings, and risk tiers. Pick the agent that matches `(domain, authority, MCP needs, skill needs)`.

### Delegation algorithm

1. Filter by domain.
2. Filter by authority (prefer L2 for complex, L6 for simple).
3. Verify agent has required MCP server bindings.
4. Verify agent has relevant skills.
5. Rank by past performance when tracked.
6. Fallback chain: L2 → L3 → L5 → L6.

### Skill governance

Skill inventory and binding rules live in [`docs/INVENTORY.md`](../../docs/INVENTORY.md) and individual `skills/*/SKILL.md`. Load only the skills materially required.

### MCP tools

Live status comes from `claude mcp list`. Documented tiers in [`CLAUDE.md`](../../CLAUDE.md) "Active MCP servers". Do not assume auth-pending or aspirational servers are usable. Runtime gate: `hooks/mcp-security-gate.sh`.

### CLI tools (13 installed)

`ruff`, `just`, `mise`, `pre-commit`, `act`, `trivy`, `gitleaks`, `semgrep`, `sg`, `goose`, `specify`, `expect-cli`, `repomix`.

### Active hooks

Declared in `settings.json` / `hooks/`. Key behaviors:

- `keyword-detector.sh` auto-activates skills on keyword match (UserPromptSubmit).
- `loop-detector.sh` breaks tool-call loops (PreToolUse).
- `mcp-security-gate.sh` validates MCP calls (PreToolUse `mcp__*`).
- `preflight-context-guard.sh` blocks Agent spawn when context >72%.
- `tool-failure-tracker.sh` suggests pivot after 3 failures, stop after 5.
- `session-init.sh` loads git/project context at start.
- `context-guard.sh` warns at 75%, suggests `/compact`.
- `persistent-mode.sh` blocks premature Stop during autonomous mode.
- `stop-verification.sh` checks ruff/tsc/uncommitted files.
- Inline: blocks writes to `.env` / `.pem` / `.key`; blocks `--force` push without lease; blocks recursive `rm` on system paths; auto-runs `ruff` on `.py` writes; appends Bash to `~/.claude/audit.log`.

Know what auto-fires so you do not duplicate or fight it.

### Path-specific rules

Auto-loaded by file glob:

- `python.md` (`**/*.py`)
- `typescript.md` (`**/*.ts,tsx`)
- `security.md` (`**/security/**, **/auth/**`)
- `testing.md` (`**/test**`)
- `infrastructure.md` (`**/terraform/**, **/k8s/**, Dockerfile*`)

---

## Stage 6: delegation contract template

Per plan step:

```
Contract:
  agent: <name> (authority: L0–L6)
  task: <description>
  tools_authorized: <agent's declared MCP servers>
  skills_to_apply: <relevant skills>
  risk_tier: T0–T3
  fallback_agent: <next best in domain>
  engine: Claude Code subagent | Qwen dispatch | Goose | Direct
```

---

## Stage 7: tri-engine routing matrix

| Signal | Engine | Why |
|--------|--------|-----|
| L0–L2 strategic / multi-agent / T2–T3 | Claude Code subagent | Full reasoning + governance |
| L5–L6 worker / single-file / T0–T1 | Qwen dispatch | Saves 60–80% tokens |
| Read-only exploration | Qwen | Cheapest |
| Same-file coordination | Claude | Continuity required |
| Non-Anthropic model needed | Goose | 25+ providers |
| Persistent scheduled task | Goose | Survives session restart |
| Bulk cost-sensitive | Goose (Ollama/DeepSeek) | Near-zero cost |
| Small direct edits | Direct | No agent overhead |

Qwen escalates to Claude when confidence <0.6 or risk T2+.

### Persistent mode (autonomous loops)

Create `~/.claude/state/autonomous.json` with `{"active": true, "task": "...", "max_iterations": 20}`. The Stop hook blocks premature stopping; cancel with "cancel" or "stop mode". Auto-deactivates after max iterations or 2h staleness.

### Per-task loop (full)

1. Announce (one line).
2. Route check (tri-engine).
3. Recipe check (`recipes/`).
4. Capability check (agent uses ONLY declared MCP servers).
5. Dispatch via optimal engine.
6. Side-effect tracking (files changed, APIs called, engine used).
7. Health monitoring (fallback on failure; escalate after 5+ failures).
8. Mark complete via `TaskUpdate`.

### Parallelization rules

- Research tasks → background subagents.
- Qwen tasks → background Bash (`run_in_background`).
- Independent file creation → parallel; same-file edits → strictly sequential.
- Test runs after all related changes.
- Max 3 background agents simultaneously.

If something fails: root-cause first, route to fallback agent, report and ask for guidance if blocked.

---

## Stage 8: reflection rubric

| Dimension | Weight | Question |
|-----------|--------|----------|
| Completeness | 20% | Addressed all aspects? |
| Relevance | 25% | Matches domain/requirements? |
| Structure | 15% | Organized, formatted, actionable? |
| Efficiency | 15% | Fast, minimal steps? |
| Coherence | 25% | Logically consistent? |

Extract what went well, what failed, what was slow.

---

## Stage 9: outcome tracker

Record metrics for performance-based routing: agent, task, score, tools, duration, success. Higher-scoring agents get prioritized. Update project memory if significant learnings emerged.

---

## Stage 10: world state + verify — quality gates by domain

| Domain | Gate |
|--------|------|
| Python | `ruff check` + `ruff format` (auto via hook) |
| TypeScript | `tsc --noEmit` |
| Security | `trivy` + `gitleaks` + `semgrep` |
| Frontend | responsive / a11y / performant |
| API | status codes + error formats |
| Database | migrations + indexes |
| Trading | risk limits |

Always: run tests, verify no regressions, collect evidence (test output, build results, screenshots), launch `self-review` agent for post-implementation validation, update memory if new patterns / decisions emerged.

---

## Constitution (SEC-001) — full

1. Execution flows through CoreMind — no agent invocation bypasses the pipeline.
2. Agents operate within declared MCP bindings only — see [`agents/REGISTRY.md`](../../agents/REGISTRY.md).
3. Risk tier drives approval flow (T0/T1 auto, T2 escalate, T3 block without authorization).
4. Every execution produces a trace (agent, task, tools, outcome, quality).
5. Performance routing is closed-loop.
6. MCP tools are audited by `mcp-security-gate.sh`.

## Hard rules — full (18)

1. Understand before building — read existing code first.
2. Recipe-first — check `recipes/` before planning from scratch.
3. Match capabilities via Registry — right agent by `(authority, domain, MCP, skill)`.
4. Parallelize aggressively — max 3 background subagents.
5. Test everything — no task done without verification.
6. Simplicity compounds — prefer removing complexity.
7. Evidence, not assertions — show test output, not "it should work".
8. Never break main — work on a feature branch.
9. Demand elegance — ask "is there a simpler way?" before accepting any solution.
10. Governance gates are non-negotiable — every T2+ action passes policy.
11. Deliver complete work — do not stop at "here is the plan" unless asked.
12. Route before burning tokens — Qwen for workers, Claude for strategy, Goose for diversity.
13. Context awareness — monitor estimated context; compact before exhaustion.
14. Structured git trailers — for non-trivial commits (`Constraint:`, `Rejected:`, `Confidence:`, `Scope-risk:`, `Not-tested:`).
15. Fail forward — after 3 failures change approach; after 5 stop and diagnose.
16. Use the right MCP — route by domain need, do not spray.
17. Semantic memory first — `claude-mem` and `/recall` before searching from scratch.
18. Hooks are allies — know what auto-fires so you do not duplicate or fight them.

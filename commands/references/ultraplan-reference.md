# `/ultraplan` reference

Extended schemas, matrices, and templates for `/ultraplan`. The command file (`commands/ultraplan.md`) keeps the operating flow and safety gates. This file holds the bulk that loads on demand.

UltraPlan inherits all `/plan` material; see [`plan-reference.md`](./plan-reference.md). Sections below add UltraPlan-specific schemas (synthesis matrix, snapshot, cost model, KB capture, world delta, expanded hard rules).

---

## PRE-STAGE 0: knowledge synthesis matrix

Synthesize knowledge layers in parallel (max 3 concurrent):

```
Layer 1 — Semantic memory (claude-mem)
  mcp__plugin_claude-mem_mcp-search__search: <key nouns from request>
  mcp__plugin_claude-mem_mcp-search__search: <domain + action>

Layer 2 — Confidence facts (MEMORY.md)
  Read ~/.claude/projects/*/memory/MEMORY.md
  Filter: facts with confidence >= 0.80, matching domain

Layer 3 — Obsidian vault + KB wiki
  obsidian MCP: search ~/notes-vault for <topic keywords>
  Read ~/.claude/kb/wiki/INDEX.md (if exists)
```

### Build the CONTEXT_MAP

```
CONTEXT_MAP:
  known_facts:           [confidence >= 0.80]
  prior_work:            [relevant sessions/observations]
  vault_notes:           [matching Obsidian entries]
  kb_articles:           [matching wiki articles]
  knowledge_gaps:        [what is NOT known that this task requires]
  stale_memories:        [facts > 90 days old this task depends on]
  prior_similar_requests:[any past request with similar intent]
```

### Decisions

- Prior similar requests → load context, avoid re-planning.
- Stale memories → add verification step before execution.
- Critical knowledge gaps → add a research subtask before implementation.
- Minor gaps only → proceed.

---

## Stage 1: intent + confidence schema

```
INTENT:
  content: "<original request>"
  goal_type: operational | strategic | analytical | financial | technical | creative | research
  domain: engineering | infrastructure | security | quality | research | product | growth |
          operations | strategy | trading | marketing | offensive | meta
  priority: 1-10
  risk_level: low | medium | high | critical
  action_tier: T0 | T1 | T2 | T3
  complexity: simple | moderate | complex | enterprise
  confidence: 0.0–1.0
  uncertainty_flags: [fields where parse confidence < 0.75]
  stack_layers: [frontend | backend | devops | ci-cd | admin | markdown | api | db | mobile]
```

**For any field with confidence < 0.75:** surface ambiguity (typed: `AMBIGUOUS`) before proceeding.

### Context sources

| Need | Source |
|------|--------|
| Git state | `git status`, `git log --oneline -10`, `git branch` |
| Project rules | `CLAUDE.md`, `README.md`, project configs |
| Codebase | Explore agent / Glob / `code-review-graph` MCP |
| Project memory | `~/.claude/projects/*/memory/MEMORY.md` |
| Semantic memory | `plugin:claude-mem:mcp-search__search` |
| KB articles | `~/.claude/kb/wiki/INDEX.md` + relevant articles |
| Past sessions | `/recall` skill |
| Recipes | `~/.claude/recipes/` |
| Library docs | `context7` MCP |
| Vault | `obsidian` MCP (`~/notes-vault`) |
| Web | `brave-search` / `tavily` |
| Raw KB input | `~/.claude/kb/raw/` |

**Recipe-first** — check `~/.claude/recipes/{security,engineering,trading,devops,sub}/` before planning from scratch.

---

## Stage 1.5: ecosystem snapshot

Capture baseline state for delta tracking at Stage 10.

```
ECOSYSTEM_SNAPSHOT:
  timestamp: <ISO-8601>
  git: { branch, uncommitted_files, last_commit }
  context_pct: <estimate>
  active_kb_articles: <count from kb/wiki/>
  memory_facts: <count of facts >= 0.80 confidence>
  agents_deployed_this_session: []
  mcp_calls_this_session: 0
  skills_applied_this_session: []
```

---

## Stage 4: ULTRAPLANNER — DAG + cost model

### Stack-layer routing

| Stack | Primary skills | Agent chain | MCP |
|-------|---------------|-------------|-----|
| frontend | framer-motion-patterns, responsive-design, web-artifacts-builder, ui-ux-pro-max, baseline-ui | frontend-architect → ux-designer → rapid-prototyper | filesystem, github, aidesigner, penpot |
| backend | clean-architecture-python, api-design-patterns, python-quality-gate, database-patterns | backend-architect → python-expert → db-admin | filesystem, github, postgres, context7 |
| devops | devops-patterns, github-actions-patterns, container-security, local-dev-orchestration | devops-architect → ci-cd-engineer → docker-specialist | filesystem, kubernetes, terraform, github |
| ci-cd | release-automation, branch-finishing, github-actions-patterns | ci-cd-engineer → release-engineer | github, filesystem |
| admin-panel | interface-design, baseline-ui, database-patterns | frontend-architect → ux-designer → db-admin | filesystem, postgres, github |
| markdown | KB raw→wiki pipeline | documenter → technical-writer | filesystem, obsidian |
| api | api-design-patterns, api-testing-suite, graphql-architect | api-designer → tester → api-tester | filesystem, github, postgres |
| security | security-review, infrastructure-scanning, container-security | security-engineer → security-auditor → secrets-manager | filesystem, github |
| trading | aster-trading, timesfm-forecasting, aster-timesfm-pipeline, anomaly-detector | data-analyst → finance-tracker | aster, postgres |
| mobile | mobile-app-builder | mobile-app-builder | filesystem, github |

### DAG template

```
DAG:
  Phase 1 (parallel):
    - Task A: [agent] | [skills] | [MCP] | risk=T? | done_when=<condition>
    - Task B: ...
  Phase 2 (sequential — depends on Phase 1):
    - Task D: [agent] | depends=[A,B] | ...
  Phase 3 (parallel):
    - Task F: [agent] | depends=[D,E] | ...

  Critical path: A → D → F
  Bottleneck: Task D (blocks N downstream)
  Parallelization score: X%
```

### Engine cost model

```
Engine score = (Quality fit × 0.4) + (Token efficiency × 0.35) + (Speed × 0.25)

Claude Code: Quality=High,  Tokens=Expensive, Speed=Medium
Qwen Code:   Quality=Good,  Tokens=Cheap,     Speed=Fast
Goose:       Quality=Var,   Tokens=Cheapest,  Speed=Fast
Direct:      Quality=High,  Tokens=Zero,      Speed=Fastest
```

| Task signal | Optimal engine |
|-------------|----------------|
| L5–L6 single-file worker | Qwen Code (60–80% token savings) |
| L0–L2 strategic / multi-agent | Claude Code |
| Read-only exploration | Qwen Code (cheapest) |
| Multi-file coordination | Claude Code |
| Non-Anthropic model needed | Goose (25+ providers) |
| Persistent scheduled task | Goose |
| Cost-sensitive bulk | Goose (Ollama/DeepSeek) |
| Direct tool call / small edit | Direct |

### Authority-based agent dispatch

Authoritative source: [`agents/REGISTRY.md`](../../agents/REGISTRY.md) — L0 System Core through L6 Workers + self-evolution agents + experimental Wave 1 (stage) and Wave 2 (surface) agents. Disk-verified counts in [`docs/INVENTORY.md`](../../docs/INVENTORY.md).

**Delegation algorithm:**
1. Filter by domain.
2. Filter by authority (prefer L2 for complex, L6 for simple).
3. Verify MCP bindings.
4. Verify skill bindings.
5. Apply engine cost model → cheapest engine that meets the quality bar.
6. Fallback: L2 → L3 → L5 → L6.

### Skill governance

Skill catalog and routing live in [`docs/INVENTORY.md`](../../docs/INVENTORY.md) and each `skills/*/SKILL.md`. For UltraPlan, also pull in `ultrathink` (cognitive depth) and `context-budget-audit` (token discipline). Load only the skills materially required for the task.

---

## Stage 6: delegation contract template

```
Contract:
  agent: <name> (authority: L0–L6)
  task: <description>
  tools_authorized: <agent's declared MCP servers>
  skills_to_apply: <relevant skills>
  risk_tier: T0–T3
  engine: Claude Code subagent | Qwen dispatch | Goose | Direct
  engine_rationale: <why chosen over alternatives>
  fallback_agent: <next best>
  fallback_engine: <if primary fails>
  kb_trigger: yes/no
  done_condition: <explicit exit criteria>
```

---

## Stage 7: execution details

### Tri-engine dispatch

- Claude Code subagent: L0–L4 complex / multi-agent (Agent tool with `subagent_type`).
- Qwen Code: L5–L6 single-file workers (`qwen-dispatch {review,test-gen,docs,explore,fix,scaffold,refactor}`, optional `--think`, escalate via `qwen-escalate`).
- Goose: model-agnostic, scheduling, bulk (`goose run --recipe`, `goose session --text`, `goose schedule`).
- Direct: tool calls and small edits.

### Parallelization rules

- Max 3 background agents simultaneously.
- Research → background subagents.
- Qwen tasks → background Bash (`run_in_background`).
- Independent file creation → parallel with worktree isolation when needed.
- Same-file edits → strictly sequential.
- Test runs after all related changes.

### Per-task loop

1. Announce (one line).
2. Route check (tri-engine cost model).
3. Recipe check (`recipes/`).
4. Capability check (agent uses ONLY declared MCP).
5. Dispatch.
6. Side-effect tracking.
7. Health monitoring (fallback agent on failure; stop and diagnose after 5+ failures).
8. KB trigger — if `kb_trigger=yes`, flag for Stage 8.5.
9. Mark complete via `TaskUpdate`.

If something fails: root-cause first, route to fallback, report and ask for guidance.

---

## Stage 8: reflection rubric

| Dimension | Weight | Question |
|-----------|--------|----------|
| Completeness | 20% | Addressed all aspects? |
| Relevance | 25% | Matches domain/requirements? |
| Structure | 15% | Organized, actionable? |
| Efficiency | 15% | Minimal steps? |
| Coherence | 25% | Logically consistent? |

Extract what worked, what failed, what was slow, what engine choice was wrong.

---

## Stage 8.5: knowledge capture

Fires whenever `kb_trigger=yes`.

1. **Identify learnable patterns** — non-obvious facts, reusable patterns, corrections to prior facts, new tool/skill combinations.
2. **Persist to KB wiki** (`~/.claude/kb/wiki/<topic>.md`):

   ```yaml
   ---
   name: <topic>
   description: <one-line>
   confidence: 0.0-1.0
   last-updated: <date>
   linked-sources: [raw/ paths]
   linked-wiki: [related articles]
   tags: [domain, stack-layer]
   ---
   <concise, high-signal, source-backed synthesis>
   ```

3. **Update MEMORY.md confidence facts** — new facts at 0.75 unconfirmed / 0.90 execution-confirmed; promote to 0.99 after 3 confirmations; demote or remove contradicted facts.
4. **Append changelog** to `~/.claude/kb/wiki/changelog.md`: `- [DATE] [STAGE] [topic]: <what changed and why>`.
5. **Pattern promotion** — 3 successes promotes to skill template; 3 failures records to `mistakes.md`.

---

## Stage 9: outcome tracker

```
OUTCOME:
  agent: <name>
  engine: claude | qwen | goose | direct
  task: <description>
  quality_score: 0–100
  tools_used: [list]
  skills_applied: [list]
  duration_estimate: short | medium | long
  success: true | false
  kb_articles_created: <count>
  confidence_facts_updated: <count>
```

Higher-scoring agents and engines get prioritized in future delegation. Update project memory when significant learnings emerged.

---

## Stage 10: world state delta

Compare Stage 1.5 snapshot vs current state:

```
DELTA:
  files_changed: [list]
  agents_deployed: [list with authority levels]
  engines_used: { claude, qwen, goose, direct: counts }
  mcp_calls: { server: count }
  skills_applied: [list]
  capabilities_unused: [available but not needed]
  kb_articles_created: N
  confidence_facts_updated: N
  context_pct_delta: <before → after>
  quality_gates_passed: [ruff, tsc, trivy, tests, ...]
  next_natural_iteration: <what this work enables>
```

**Capabilities_unused** is valuable signal — if you consistently skip certain agents/MCPs, consider routing-table adjustment.

---

## Stage 11: verify + quality gates

```
Python      → ruff check + ruff format (often auto-done by hook)
TypeScript  → tsc --noEmit
Security    → trivy + gitleaks + semgrep
Frontend    → responsive (md breakpoint), a11y (WCAG AA), compositor-only motion
API         → status codes, error formats, rate limits documented
Database    → migrations ran, indexes exist, queries explain-planed
Trading     → risk limits, position sizing in bounds
CI/CD       → workflow syntax, no hardcoded secrets
Admin panel → auth gate on every admin route
Docs        → links valid, frontmatter valid, no orphans
```

Collect evidence: test output, build results, screenshots. Launch `self-review` agent for post-implementation validation.

---

## POST: deliver + compound

1. PII/secret scan, quality threshold, completeness.
2. Concise evidence-backed summary (no buzzwords).
3. Show evidence — test results, build output, key changes.
4. List follow-ups.
5. Compound suggestion — "This work now enables: [next natural iteration]".
6. Commit only when asked; structured trailers for non-trivial work:

   ```
   Constraint: <active constraint>
   Rejected: <alternative considered>
   Confidence: high | medium | low
   Scope-risk: narrow | moderate | broad
   Not-tested: <uncovered edge case>
   ```

---

## Constitution (SEC-001 + UltraPlan additions)

1. Execution flows through CoreMind — no bypasses.
2. Agents operate within declared MCP bindings only.
3. Risk tier drives approval flow (T0/T1 auto, T2 escalate, T3 block).
4. Every execution produces a trace (OUTCOME record).
5. Performance routing is closed-loop (Stage 9 feeds future Stage 4).
6. MCP tools are audited by `mcp-security-gate.sh`.
7. **Knowledge is captured before it escapes** — Stage 8.5 fires when `kb_trigger=yes`.
8. **Context is guarded** — `preflight-context-guard.sh` blocks Agent spawn at >72%; compact before >80%.
9. **The KB compounds** — every execution makes future ones smarter.
10. **Engine cost is tracked** — always route to the cheapest engine meeting the quality bar.

## Hard rules (18 from /plan + 4 new)

1. Understand before building.
2. Recipe-first.
3. Match capabilities via Registry — `(authority, domain, MCP, skill)`.
4. Parallelize aggressively — max 3 background agents.
5. Test everything.
6. Simplicity compounds.
7. Evidence, not assertions.
8. Never break main.
9. Demand elegance.
10. Governance gates are non-negotiable.
11. Deliver complete work.
12. Route before burning tokens — cost model drives engine selection.
13. Context awareness — compact before exhaustion.
14. Structured git trailers for non-trivial commits.
15. Fail forward — 3 failures change approach, 5 stop and diagnose.
16. Use the right MCP — route by domain, do not spray.
17. Semantic memory first — `claude-mem` + `/recall` before searching.
18. Hooks are allies — know what auto-fires.
19. **KB before research** — check wiki articles before issuing web searches.
20. **Capture before forgetting** — Stage 8.5 must fire when new knowledge emerged.
21. **Delta tracking** — always know the before/after state (Stage 1.5 + Stage 10).
22. **Confidence-gated action** — if any intent field confidence < 0.75, resolve ambiguity first.

# SocratiCode Integration

> **Status:** documented, not installed. Install requires explicit approval (see "How to install" below).

SocratiCode (https://github.com/giancarloerra/socraticode) is the **codebase intelligence layer** of this AI OS. It provides AST-aware code search, dependency graphs, impact analysis, call-flow tracing, and reusable context artifacts (schemas, API specs, infra docs).

In the four-layer architecture (`docs/ARCHITECTURE.md`):

```
Warp           = cockpit (terminal UX, panes, diff review)
Claude Code    = governed execution engine (this repo's hooks + MCP gates)
SocratiCode    = codebase intelligence (when installed)
claude-code-setup = constitution / policy / memory (this repo)
```

SocratiCode is optional. When installed, the OS prefers it over broad `Read`/`Grep` for non-trivial code exploration. When not installed, the OS falls back to existing tools and `code-review-graph` MCP (already connected — see `CLAUDE.md`).

---

## When to use SocratiCode

| Task | Tool of choice |
|------|----------------|
| "Where is `<symbol>` defined?" | SocratiCode `search` |
| "What depends on `<file>`?" | SocratiCode `graph` |
| "If I change this function, what breaks?" | SocratiCode `impact` analysis |
| "Why did this bug happen — trace the path" | SocratiCode `call-flow` |
| "Does the OpenAPI spec match the code?" | SocratiCode `context artifacts` |
| Quick file read | `Read` tool |
| Single-file pattern search | `Grep` tool |
| Indexed semantic search across the repo | `code-review-graph` MCP (already live) |
| Cross-file refactor preview | `code-review-graph` MCP `refactor_tool` |

**Decision rule:** if the question is "where is X" or "what calls Y," reach for SocratiCode. If the question is structural ("how does this whole module work"), use `code-review-graph` MCP. If it's a single-file inspection, use `Read`.

---

## How SocratiCode supports each mode command

### `/ship`
SocratiCode preflight before implementation:
1. `search` for similar existing patterns in the repo
2. `graph` query to see what currently depends on the area being changed
3. `impact` analysis on the proposed change surface
4. Then proceed with implementation

### `/audit-deep`
SocratiCode is the primary inspection tool:
1. `graph` to map module boundaries
2. `impact` to find tightly-coupled hotspots
3. `context artifacts` to verify schema/spec coherence
4. Fall back to `code-review-graph` for community detection

### `/fix-root`
SocratiCode is the call-flow lens:
1. `call-flow` from the symptom backwards
2. Inspect actual graph relationships, not assumed ones
3. Identify whether the fix is at the leaf or further up the chain

---

## Requirements

| Requirement | Status (verify locally) |
|-------------|--------------------------|
| Docker installed and running | Run `docker ps` — must succeed |
| Node.js installed | Run `node --version` — required for some flows |
| Network access for first-run model fetch | One-time download |

---

## How to install

> **Do not run automatically.** This requires user approval and may install plugins, modify global config, or pull a Docker image.

### Preferred — plugin install

```bash
claude plugin marketplace add giancarloerra/socraticode
claude plugin install socraticode@socraticode
```

### Fallback — MCP-only install

```bash
claude mcp add socraticode -- npx -y socraticode
```

### Verification after install

```bash
claude plugin list 2>&1 | grep -i socraticode
claude mcp list 2>&1 | grep -i socraticode
```

If both `plugin list` and `mcp list` show entries, you have a duplicate — keep the plugin install, remove the MCP.

---

## Configuration

### `.socraticodeignore`

Standard ignore patterns are in the repo at `.socraticodeignore`. Edit there if you need to exclude additional paths. The file follows `.gitignore` syntax.

The defaults exclude: `.git/`, `node_modules/`, `vendor/`, `dist/`, `build/`, caches, lockfiles, secrets (`.env`, `*.key`, `*.pem`), and SQLite/log files.

### Context artifacts

Reusable schema/spec/runbook documents that SocratiCode keeps indexed and queryable. The schema for the artifacts file (`.socraticodecontextartifacts.json`) is **not yet pinned in this docs file** — verify against the upstream README before authoring.

A safe template lives at `docs/SOCRATICODE_CONTEXT_ARTIFACTS_TEMPLATE.md` (to be added when the schema is confirmed).

---

## Protocol additions to CLAUDE.md

When SocratiCode is installed, add to the `CLAUDE.md` execution pipeline (Stage 5 — EXECUTE):

> **SocratiCode preflight is mandatory** for non-trivial code exploration:
> - Use SocratiCode `search` before broad `Grep`
> - Use SocratiCode `graph` before following many imports manually
> - Use SocratiCode `impact` analysis before any refactor that crosses module boundaries
> - Use SocratiCode `call-flow` for bug investigation
> - Use SocratiCode `context artifacts` for schema / API / infra / runbook lookups
> - Treat SocratiCode results as **navigation**, not as test replacement

These are added by `skills/socraticode-preflight/SKILL.md` once installed.

---

## Fallback when SocratiCode unavailable

If SocratiCode is not installed (current state) or fails to respond:

1. Fall back to `code-review-graph` MCP (already live)
2. For symbol search: `git grep -n` or `Grep` tool
3. For dependency mapping: `code-review-graph`'s `query_graph_tool` with `pattern: imports_of`
4. For call-flow: `code-review-graph`'s `get_impact_radius_tool`
5. Document the fallback in the relevant skill so the choice is transparent

The OS does not block on SocratiCode being installed.

---

## Failure modes

| Symptom | Likely cause | Fix |
|---------|--------------|-----|
| `socraticode: command not found` | Plugin not installed | Run install commands above |
| MCP server health check fails | Docker not running | Start Docker Desktop |
| Indexing extremely slow | Repo large, first index | Patience; subsequent runs are incremental |
| Stale results after big refactor | Index not refreshed | Re-index manually (see SocratiCode docs) |
| Both plugin and MCP installed | Accidentally double-installed | Keep plugin, remove MCP entry |

---

## Trade-off vs `code-review-graph`

`code-review-graph` MCP is already live in this OS and provides similar capabilities (graph, search, impact, dead-code detection, refactoring). When deciding which to use:

| Use `code-review-graph` when... | Use SocratiCode when... |
|---------------------------------|--------------------------|
| You're already in this repo and the MCP is connected | You want IDE-like AST-aware exploration with finer granularity |
| You want community detection / centrality | You want call-flow tracing with frame-level detail |
| You want cross-repo search | You want context artifacts (schema/spec/runbook indexing) |
| Tree-sitter granularity is enough | You need deeper LSP-quality analysis |

You can run both. They cover overlapping but not identical surfaces. Until SocratiCode is installed, the OS uses `code-review-graph` for everything.

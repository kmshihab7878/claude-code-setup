# Engineering — AI/ML

LLM integration, agent orchestration, RAG, MCP server development, prompt engineering.

## Canonical skills

- `claude-api` — Anthropic SDK patterns with prompt caching (multi-language: Python, TypeScript, Java, Go, PHP, Ruby, C#, curl)
- `multi-agent-patterns` — Supervisor, pipeline, swarm, hierarchical patterns
- `rag-patterns` — RAG architecture, chunking, embeddings, retrieval tuning, multimodal
- `hybrid-search-implementation` — Vector + keyword retrieval
- `mlops-engineer` — MLflow, Kubeflow, modern MLOps
- `mcp-builder` — MCP server development guide
- `mcp-mastery` — 30-server catalog + task-to-MCP router (pairs with `mcp-builder`)
- `prompt-reliability-engine` — 9-mode framework: diagnose, repair, stress-test, constrain, lock, architect, audit, prune, self-improve
- `ultrathink` — Cognitive depth engine (5 modes from quick → council)
- `council` — Multi-expert decision system
- `context-budget-audit` — Token-cost measurement across agents/skills/MCPs
- `skill-creator` / `skill-architect` — Skill authoring (merge candidate per AUDIT §5.2)
- `skill-evolution` — Self-evolving skill lifecycle
- `data-analysis` — Natural language → SQL/pandas

## Agents

- **L2:** `ai-engineer`
- **L3:** `prompt-engineer`, `analytics-reporter`
- **L1:** `business-panel-experts` (invokes CXO advisors via the `council` skill)

## Commands

`/plan`, `/ultraplan`, `/council`, `/council-review`, `/recall`, `/wiki-query`

## Recipes

None dedicated. AI/ML tasks route through `/plan` or `/ultraplan` with context-appropriate skill selection.

## Experimental zones

- `autoresearch` — Self-improvement loop (single template only)
- `agent-orchestrator` — Durable pluggable orchestration (unvalidated in practice)
- `hermes-integration`, `sim-studio`, `goose-integration`, `qwen-dispatch`, `unified-router` — Cross-engine routing, speculative without telemetry

## Notes

- **Cognitive depth routing:** use `ultrathink` modes — Quick / Standard / Deep Think / Ultrathink / Council — chosen by task complexity + risk tier. See `skills/ultrathink/SKILL.md`.
- **Extraction candidates:** `mcp-mastery`, `prompt-reliability-engine`, `ultrathink` are all self-contained standalone products.

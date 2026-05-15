# Pattern Selection Workflow

Detailed pattern-selection guide and the full workflow creation checklist.
The compact selection table lives in `SKILL.md`.

## Pattern Selection Guide

### Webhook Processing — use when

- Receiving data from external systems.
- Building integrations (Slack commands, form submissions, GitHub webhooks).
- Need instant response to events.
- Example: "Receive Stripe payment webhook → Update database → Send confirmation."

### HTTP API Integration — use when

- Fetching data from external APIs.
- Synchronizing with third-party services.
- Building data pipelines.
- Example: "Fetch GitHub issues → Transform → Create Jira tickets."

### Database Operations — use when

- Syncing between databases.
- Running database queries on schedule.
- ETL workflows.
- Example: "Read Postgres records → Transform → Write to MySQL."

### AI Agent Workflow — use when

- Building conversational AI.
- Need AI with tool access.
- Multi-step reasoning tasks.
- Example: "Chat with AI that can search docs, query database, send emails."

### Scheduled Tasks — use when

- Recurring reports or summaries.
- Periodic data fetching.
- Maintenance tasks.
- Example: "Daily: Fetch analytics → Generate report → Email team."

## Decision Order

When the requirement is unclear, decide in this order:

1. **Does the workflow start from an external HTTP call?** → Webhook Processing.
2. **Does the workflow run on a clock?** → Scheduled Tasks.
3. **Is the primary action fetching from an external API on demand?** → HTTP API Integration.
4. **Does the workflow primarily move rows between data stores?** → Database Operations.
5. **Does the workflow require multi-step reasoning or tool use?** → AI Agent Workflow.

A workflow can blend patterns — choose the **primary** pattern by the trigger
and the dominant data flow. Secondary patterns surface inside the body
(e.g., a Scheduled Task that calls an HTTP API).

## Workflow Creation Checklist

When building any workflow, walk this checklist.

### Planning phase

- [ ] Identify the pattern (webhook, API, database, AI, scheduled).
- [ ] List required nodes (`search_nodes`).
- [ ] Understand the data flow (input → transform → output).
- [ ] Plan the error-handling strategy.

### Implementation phase

- [ ] Create workflow with the appropriate trigger.
- [ ] Add data source nodes.
- [ ] Configure authentication / credentials at the node level (not in parameters).
- [ ] Add transformation nodes (Set, Code, IF).
- [ ] Add output / action nodes.
- [ ] Configure error handling (Error Trigger, Continue On Fail, Stop and Error).

### Validation phase

- [ ] Validate each node configuration (`validate_node`).
- [ ] Validate the complete workflow (`validate_workflow`).
- [ ] Test with sample data.
- [ ] Handle edge cases (empty data, errors, partial failures).

### Deployment phase

- [ ] Review workflow settings (execution order, timeout, error handling).
- [ ] Activate workflow using the `activateWorkflow` operation.
- [ ] Monitor the first executions.
- [ ] Document workflow purpose and data flow in the notes field.

## Pattern Statistics (priors)

Use these only as priors — verify against the specific workflow.

### Most common triggers

1. Webhook — 35%.
2. Schedule (periodic tasks) — 28%.
3. Manual (testing/admin) — 22%.
4. Service triggers (Slack, email, etc.) — 15%.

### Most common transformations

1. Set (field mapping) — 68%.
2. Code (custom logic) — 42%.
3. IF (conditional routing) — 38%.
4. Switch (multi-condition) — 18%.

### Most common outputs

1. HTTP Request (APIs) — 45%.
2. Slack — 32%.
3. Database writes — 28%.
4. Email — 24%.

### Workflow complexity

- Simple (3-5 nodes): 42%.
- Medium (6-10 nodes): 38%.
- Complex (11+ nodes): 20%.

Most workflows are simple — when the design grows past 10 nodes, ask whether
two workflows would be clearer than one.

## Cross-Skill Workflow

| Phase | Companion skill |
|-------|-----------------|
| Find nodes for the pattern | n8n MCP Tools Expert (`search_nodes`) |
| Understand node operations | n8n MCP Tools Expert (`get_node`) |
| Configure transformations | n8n Expression Syntax + n8n Node Configuration |
| Build custom logic | n8n Code JavaScript or n8n Code Python |
| Validate the workflow | n8n Validation Expert (`validate_workflow`, `n8n_autofix_workflow`) |
| Deploy and activate | n8n MCP Tools Expert (`n8n_create_workflow`, `activateWorkflow`) |

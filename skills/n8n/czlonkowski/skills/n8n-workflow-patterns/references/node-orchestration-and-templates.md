# Node Orchestration and Templates

Common workflow components, data-flow shapes, and quick-start orchestration
templates. The compact selection logic lives in `SKILL.md`.

## Common Workflow Components

All patterns share these building blocks.

### Triggers

| Trigger | When |
|---------|------|
| Webhook | HTTP endpoint (instant) |
| Schedule | Cron-based timing (periodic) |
| Manual | Click to execute (testing) |
| Polling | Check for changes at intervals |

### Data sources

| Source | Use |
|--------|-----|
| HTTP Request | REST APIs |
| Database nodes | Postgres, MySQL, MongoDB |
| Service nodes | Slack, Google Sheets, etc. |
| Code | Custom JavaScript / Python |

### Transformation

| Node | Use |
|------|-----|
| Set | Map / transform fields |
| Code | Complex logic |
| IF / Switch | Conditional routing |
| Merge | Combine data streams |

### Outputs

| Output | Use |
|--------|-----|
| HTTP Request | Call APIs |
| Database | Write data |
| Communication | Email, Slack, Discord |
| Storage | Files, cloud storage |

### Error handling

| Node | Use |
|------|-----|
| Error Trigger | Catch workflow errors |
| IF | Check for error conditions |
| Stop and Error | Explicit failure |
| Continue On Fail | Per-node setting |

## Data Flow Shapes

### Linear flow

```
Trigger → Transform → Action → End
```

Use when: simple workflows with a single path.

### Branching flow

```
Trigger → IF → [True path]
             └→ [False path]
```

Use when: different actions based on conditions.

### Parallel processing

```
Trigger → [Branch 1] → Merge
       └→ [Branch 2] ↗
```

Use when: independent operations that can run simultaneously.

### Loop pattern

```
Trigger → Split in Batches → Process → Loop (until done)
```

Use when: processing large datasets in chunks.

### Error-handler pattern

```
Main flow → [Success path]
         └→ [Error Trigger → Error handler]
```

Use when: a separate error workflow needs to take over (alerts, retries,
dead-letter queue routing).

## Orchestration Rules

- **Sequential by default**. Parallelism is opt-in via branching + Merge.
- **Split In Batches** when the upstream emits more than ~500 items —
  protects downstream services from spikes.
- **Merge node** is required to rejoin parallel branches. Without it, only
  the branch with the latest emission reaches downstream nodes.
- **IF / Switch** branches must each either terminate or rejoin via Merge —
  otherwise downstream nodes only see one branch's data.
- **Error Trigger** is a workflow-level node. It does not connect to the
  main flow; it activates when **any** node in the workflow fails.
- **Continue On Fail** is per-node. Use sparingly — silent failure mode
  by default is dangerous.

## Quick Start Templates

### Template 1: Simple Webhook → Slack

```
1. Webhook (path: "form-submit", POST)
2. Set (map form fields)
3. Slack (post message to #notifications)
```

### Template 2: Scheduled Report

```
1. Schedule (daily at 9 AM)
2. HTTP Request (fetch analytics)
3. Code (aggregate data)
4. Email (send formatted report)
5. Error Trigger → Slack (notify on failure)
```

### Template 3: Database Sync

```
1. Schedule (every 15 minutes)
2. Postgres (query new records)
3. IF (check if records exist)
4. MySQL (insert records)
5. Postgres (update sync timestamp)
```

### Template 4: AI Assistant

```
1. Webhook (receive chat message)
2. AI Agent
   ├─ OpenAI Chat Model (ai_languageModel)
   ├─ HTTP Request Tool (ai_tool)
   ├─ Database Tool (ai_tool)
   └─ Window Buffer Memory (ai_memory)
3. Webhook Response (send AI reply)
```

### Template 5: API Integration with Pagination

```
1. Manual Trigger (for testing)
2. HTTP Request (GET /api/users)
3. Split In Batches (process 100 at a time)
4. Set (transform user data)
5. Postgres (upsert users)
6. Loop (back to step 3 until done)
```

## Template Discovery

Use the n8n-mcp tools to find production templates that match your pattern:

- `search_templates({ query: "weather slack" })`.
- `search_templates({ mode: "by_nodes", nodes: ["Webhook", "Slack"] })`.
- `get_template({ id: 2947 })` → returns the full template configuration.
- `n8n_deploy_template({ id: 2947 })` → deploys directly to the n8n instance.

Real example — Template `#2947 — Weather to Slack`:

- Pattern: Scheduled Task.
- Nodes: Schedule → HTTP Request (weather API) → Set → Slack.
- Complexity: simple (4 nodes).

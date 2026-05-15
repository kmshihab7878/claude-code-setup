# Workflow Pattern Catalog

The five core n8n workflow patterns. Each entry points to the upstream
authoritative pattern file at the parent directory level.

## 1. Webhook Processing

- **Trigger**: HTTP webhook (instant response).
- **Pattern shape**: `Webhook → Validate → Transform → Respond / Notify`.
- **Use cases**: form submissions, payment webhooks, chat integrations,
  GitHub events, Slack commands.
- **Data nesting**: payload sits under `$json.body` (the most common gotcha).
- **Upstream depth**: [`../webhook_processing.md`](../webhook_processing.md).

## 2. HTTP API Integration

- **Trigger**: manual / schedule / upstream node.
- **Pattern shape**: `Trigger → HTTP Request → Transform → Action → Error Handler`.
- **Use cases**: data fetching, third-party integrations, sync pipelines.
- **Auth pattern**: configure credentials at the HTTP Request node, never in parameters.
- **Pagination, retries, throttling**: built-in options on the HTTP Request node.
- **Upstream depth**: [`../http_api_integration.md`](../http_api_integration.md).

## 3. Database Operations

- **Trigger**: schedule (most common) or webhook.
- **Pattern shape**: `Schedule → Query → Transform → Write → Verify`.
- **Use cases**: ETL, cross-database sync, scheduled queries, backups.
- **Concurrency**: prefer batch writes; configure transaction boundaries when supported.
- **Upstream depth**: [`../database_operations.md`](../database_operations.md).

## 4. AI Agent Workflow

- **Trigger**: webhook (chat) or manual.
- **Pattern shape**: `Trigger → AI Agent (Model + Tools + Memory) → Output`.
- **Use cases**: chatbots, content generation, multi-step reasoning, tool use.
- **Components**:
  - `ai_languageModel` (e.g., OpenAI Chat Model).
  - One or more `ai_tool` connections (HTTP Request Tool, Database Tool, etc.).
  - Optional `ai_memory` (Window Buffer, Postgres, Redis).
- **Authority discipline**: every tool the agent can call is an explicit
  connection — agents cannot access tools they are not wired to.
- **Upstream depth**: [`../ai_agent_workflow.md`](../ai_agent_workflow.md).

## 5. Scheduled Tasks

- **Trigger**: Schedule (cron-based).
- **Pattern shape**: `Schedule → Fetch → Process → Deliver → Log`.
- **Use cases**: recurring reports, periodic syncs, maintenance, alerts.
- **Cadence rule**: align schedule frequency with downstream rate limits.
  A 1-minute schedule that hits a 60/hour API will throttle.
- **Idempotency**: design for restart-safety; assume executions can overlap or repeat.
- **Upstream depth**: [`../scheduled_tasks.md`](../scheduled_tasks.md).

## Pattern Blending

A workflow may include components of multiple patterns. The primary pattern
is determined by **trigger + dominant data flow**:

| Trigger | Dominant flow | Primary pattern |
|---------|---------------|-----------------|
| Webhook | Inbound + immediate response | Webhook Processing |
| Webhook | Inbound + AI reply | AI Agent Workflow (webhook is the entry) |
| Schedule | Fetch from API → transform | Scheduled Tasks (HTTP is secondary) |
| Schedule | DB → DB row movement | Database Operations |
| Manual | One-shot API call | HTTP API Integration |
| Manual | AI scratchpad | AI Agent Workflow |

When in doubt, name the trigger first; the trigger names the pattern.

## Anti-blend Cases

Two patterns should **not** be mixed in one workflow:

- **AI Agent + heavy DB transactions in the same execution**. Split: agent
  produces a queue of work, a second workflow handles the DB writes.
- **Webhook respond + long-running fetch**. Split: webhook responds
  immediately with `202 Accepted`; a follow-on workflow performs the fetch
  and posts the result back.

Long-running work inside a webhook handler leads to gateway timeouts and
duplicate retries from upstream callers.

# API Integration Principles

> Rules that apply whether you connect via direct REST/SDK, MCP server, CLI, or webhook. The goal is integrations that are deterministic, observable, and revocable.

---

## 1. Read before write

The first call against any new integration is a `GET`. The first ten calls are read-only. You promote to write only after:
- The read paths return what you expect
- You have logged a sample response (so future debugging has a baseline)
- You have a kill switch documented

## 2. Service accounts for sensitive systems

For anything tagged `high` sensitivity (money, customers, prod data):
- Create a dedicated account named `aios-<domain>` (e.g. `aios-revenue`)
- Grant the **minimum** scopes that get the job done
- Never reuse credentials across automations
- Rotate quarterly

A personal token used by an automation is a personal token used by a bug.

## 3. Idempotency on every write

Every write call carries an idempotency key derived from the input — never a random UUID generated at call time. Re-running the same logical operation must converge to the same outcome, not duplicate it.

If the API doesn't natively support idempotency keys, wrap the call in a "have we done this already?" check that uses the input as the cache key.

## 4. Limit blast radius

Before any write, ask:
- **Reversibility:** can a human undo this in <5 minutes?
- **Visibility:** will I see this within 1 minute?
- **Scope:** if it affects the wrong record, how many records can it possibly affect?

If reversibility is low, scope must be 1 record. If scope is large, the operation must be a dry-run that requires explicit approval to commit.

## 5. Backoff and rate limits

Every call sits behind:
- A timeout (no integration call without a deadline)
- A retry policy with exponential backoff for transient errors
- A rate-limit awareness (read the API docs once, document the limit)

Default: 1 retry on 5xx, no retries on 4xx, 10s timeout.

## 6. Logging that's useful, not noisy

Log at `INFO` for every external call:
- Endpoint and method
- Idempotency key
- Latency
- Status code
- Caller (which skill/agent/script)

Never log:
- Bearer tokens, API keys, or any auth header value
- PII fields (use field names + IDs, not values)
- Full request/response bodies for `high` sensitivity tools

`hooks/mcp-security-gate.sh` already does first-use detection and high-risk pattern logging for MCP calls. Mirror that pattern for direct API integrations.

## 7. Schema validation at the boundary

Every external response is validated against a schema (JSON Schema, Pydantic, Zod) before any downstream code touches it. The error message on a failed validation must say what changed.

External APIs change. The point of schema validation is to fail fast at the boundary instead of producing wrong outputs deep in a pipeline.

## 8. Cost awareness

Every integration has a cost story:
- **Per-call cost** (LLM tokens, search API credits, paid tier usage)
- **Per-month estimate** at projected call volume
- **Alert threshold** for "stop and check"

`docs/CADENCE.md` includes a monthly cost review — every integration shows up there.

## 9. Webhook handlers are queues

Inbound webhooks land in a queue first, never processed synchronously in the receiver. Why:
- Webhook senders retry on 5xx — synchronous processing means slow handler = duplicate events
- Queues let you replay during incidents
- Queues let you fan out to multiple consumers

If you don't have a queue, the simplest version is "write to disk, return 200, process from disk."

## 10. Decommissioning is part of integration

When you wire it up, write the decommissioning steps:
- How to revoke the credential at the source
- How to delete the credential locally
- How to remove the integration code (with grep targets)
- Where the data this integration produced lives, and what to do with it

Add this section to `connections.md` for the integration. Without a decommissioning plan, an integration is a permanent attack surface.

---

## When to break the rules

- **Dev loops** that touch only your local environment — informality is fine, but graduate to these rules before running for anyone else.
- **Read-only one-shot scripts** for analysis — skip idempotency and queues, but still validate the schema.
- **Genuinely throwaway prototypes** — but mark them throwaway in the filename (e.g. `scripts/throwaway-...`) and delete on the same day.

The default is the rules above. Exceptions are explicit and short-lived.

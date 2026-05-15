# Examples — End-to-end n8n Workflow Patterns

Worked workflow examples illustrating each of the five core patterns and
common pattern blends.

## Example 1 — Webhook Processing: Stripe payment → DB → notify

```
1. Webhook (path: /stripe-webhook, POST)
2. Code (verify signature from headers; reject on mismatch)
3. IF (event.type == "payment_intent.succeeded")
   ├─ True: Postgres (insert payment row) → Slack (#payments)
   └─ False: Set (log skipped event) → end
4. Webhook Response (200 OK)
5. Error Trigger → Slack (#alerts) — covers signature mismatches or DB failures
```

Notes:

- Signature verification is in a Code node (Python or JavaScript) — not in
  the Webhook node, because the verification step is shared across event types.
- Webhook responds 200 quickly; heavy logic stays inside the workflow but is
  fast enough for Stripe's 5-second timeout.

## Example 2 — HTTP API Integration: GitHub → Jira

```
1. Manual Trigger (for testing) + Schedule (every 30 minutes in production)
2. HTTP Request (GET github.com/repos/{owner}/{repo}/issues?since=...)
3. Code (filter to issues with the "needs-jira" label)
4. Split In Batches (50 per page)
5. HTTP Request (POST jira-api/issue) — with retry-on-failure enabled
6. Postgres (upsert sync record: github_id → jira_id)
7. Loop back to step 4 until done
8. Error Trigger → email on persistent failures
```

Notes:

- Two triggers (Manual + Schedule) — Manual for testing, Schedule for prod.
  Both feed the same body.
- Pagination handled by the HTTP Request node; Split In Batches caps
  concurrency on the downstream Jira API.

## Example 3 — Database Operations: Postgres → MySQL sync

```
1. Schedule (every 15 minutes)
2. Postgres (query: SELECT * FROM events WHERE updated_at > $1)
3. IF (count > 0)
   ├─ True: continue
   └─ False: Set ("nothing to sync") → end
4. Split In Batches (500 per batch)
5. Code (shape rows for MySQL schema)
6. MySQL (UPSERT events)
7. Postgres (update sync_state.last_seen = max(updated_at))
8. Error Trigger → Slack (#data-eng) on any failure
```

Notes:

- Idempotency via `updated_at > $last_seen` cursor — restart-safe.
- Cursor update is the **last** step; if the workflow fails before step 7,
  the next run re-processes the same range, not lost data.

## Example 4 — AI Agent: support chatbot with tools

```
1. Webhook (path: /chat, POST)
2. AI Agent
   ├─ ai_languageModel: OpenAI Chat Model (gpt-4o-mini)
   ├─ ai_tool: HTTP Request Tool — kb-search endpoint
   ├─ ai_tool: Postgres Tool — read-only "tickets" table
   ├─ ai_tool: Send Email tool (constrained to support@ alias)
   └─ ai_memory: Window Buffer Memory (last 8 turns)
3. Webhook Response (return assistant message)
4. Error Trigger → Slack (#bot-errors)
```

Notes:

- The agent can only call the wired tools. To add capability, wire a tool;
  there is no "tools registry" that the agent can discover beyond connections.
- Read-only Postgres tool — the agent cannot modify the tickets table even
  if it tries.

## Example 5 — Scheduled Task: daily analytics report

```
1. Schedule (daily at 09:00 Europe/Warsaw)
2. HTTP Request (fetch analytics for previous 24h)
3. Code (aggregate sessions, conversion, top pages)
4. Code (render markdown report)
5. Email (send to team-list@; subject: "Daily analytics — {{date}}")
6. Set (write log row: ran_at, status)
7. Error Trigger → Slack (#analytics-alerts) — surfaces missed runs
```

Notes:

- Time zone explicit on the Schedule node — avoids DST drift on the report
  cadence.
- Step 6 writes a log row that the team can inspect even when the email
  reaches their spam folder.

## Example 6 — Pattern blend: Webhook → 202 Accepted + follow-on

```
Workflow A — Webhook Receiver (lightweight, fast)
1. Webhook (path: /ingest)
2. Postgres (INSERT into ingest_queue with status="queued")
3. Webhook Response (202 Accepted, {"job_id": "..."})

Workflow B — Ingest Processor (heavy, async)
1. Schedule (every 2 minutes) OR Webhook (path: /ingest/trigger)
2. Postgres (SELECT * FROM ingest_queue WHERE status="queued" LIMIT 10)
3. Split In Batches (1)
4. <pattern-specific heavy work>
5. Postgres (UPDATE ingest_queue SET status="done" WHERE id=$1)
6. Error Trigger → Slack
```

Notes:

- Heavy work never blocks the inbound webhook → no gateway timeouts.
- Workflow B is restart-safe — re-running picks up "queued" rows the
  previous run did not finish.
- This is the canonical fix for any "webhook timing out" production issue.

## Example 7 — Branching with Merge

```
1. Webhook (path: /signup, POST)
2. IF ($json.body.plan == "enterprise")
   ├─ True: Slack (#sales) → Set (enriched payload)
   └─ False: HTTP Request (notify CRM with default tier)
3. Merge (mode: Append)
4. Postgres (insert signup row, regardless of branch)
5. Webhook Response (200 OK)
```

Notes:

- Without the Merge node, only one branch's data would reach the Postgres
  insert step — a common silent-data-loss bug.
- The Merge node's mode matters: "Append" stacks rows; "Combine" zips them
  by index; pick by downstream expectation.

## Example 8 — Loop processing with cursor

```
1. Manual Trigger
2. HTTP Request (GET /api/items?cursor=)
3. Set (cursor = $json.next_cursor)
4. Split In Batches (over $json.items)
5. <process each item>
6. IF (cursor exists)
   ├─ True: Loop back to step 2 with new cursor
   └─ False: end
```

Notes:

- Cursor-based loops cap memory and let the workflow resume from a known
  point. Prefer cursor over offset for any non-trivial dataset.
- Page size on the HTTP request should align with downstream rate limits.

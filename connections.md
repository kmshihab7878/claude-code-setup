# Connections Registry

_Single source of truth for every tool, account, and data source the AI OS can reach. Update whenever a connection is added, removed, or rotates credentials._

> **Privacy & security guard**
> - **Never paste real credentials, tokens, or API keys into this file.** Use `.env` (gitignored) for secrets, and reference variable names here.
> - For sensitive systems (money, customers, business data), use a **dedicated AI OS service account** — not your personal account.
> - Mark sensitivity honestly. The threat is silent escalation: a "low" tool reading from a "high" tool changes the effective sensitivity of the chain.

---

## Schema

| Field | Meaning |
|-------|---------|
| Domain | One of: Revenue, Customer, Calendar, Comms, Tasks, Meetings, Knowledge |
| Tool | Name (e.g. Stripe, Gmail, Linear) |
| Account | Logical account label (e.g. `aios-service`, `personal`, `business-main`) — never the email |
| Data Needed | What the OS reads/writes |
| Access Method | Manual export · Direct API · MCP · CLI · Webhook · Workflow tool · Not connected |
| Auth Location | `.env` var name OR `manual` OR `none` |
| Sensitivity | low (public-ish) · medium (internal) · high (PII / money / strategic) |
| Status | not connected · planned · connected (read-only) · connected (write) · paused · revoked |
| Notes | Anything material — rate limits, kill switch, related runbook |

See `docs/CONNECTIONS_ROADMAP.md` for the seven-domain build order and decision criteria.

---

## Tier 1 — connected MCP servers (live now)

These are taken from `claude mcp list` and reflect actual current state. Update by re-running `claude mcp list` and editing this section.

| Domain | Tool | Account | Data Needed | Access | Auth | Sensitivity | Status | Notes |
|--------|------|---------|-------------|--------|------|-------------|--------|-------|
| Knowledge | filesystem | local | local file r/w within `$HOME` | MCP | none (process scope) | medium | connected (write) | Scope = `/Users/<user>` — broad. Reduce if needed. |
| Knowledge | memory | local | knowledge graph | MCP | none | medium | connected (write) | Persistent KG; survives sessions. |
| Knowledge | sequential-thinking | local | reasoning trace | MCP | none | low | connected | No external network. |
| Knowledge | git | local | git ops in current repo | MCP | none | medium | connected (write) | Per-repo scope. |
| Knowledge | code-review-graph | local | tree-sitter graph | MCP | none | low | connected | Indexes the current repo. |
| Knowledge | claude-mem | local | semantic memory (SQLite + ChromaDB) | MCP | none | medium | connected | Persistent vectorized memory. |
| Comms | gmail (claude.ai OAuth) | personal | email read / draft | MCP (HTTP) | OAuth (claude.ai-managed) | **high** | connected | Drafts only by default — verify before any send. |
| Knowledge | supabase | _project_ | DB schema/queries | MCP (HTTP) | OAuth | **high** | auth pending | Re-auth required. |
| Knowledge | google-calendar | personal | calendar r/w | MCP (HTTP) | OAuth | **high** | auth pending | Re-auth required. |
| Knowledge | google-drive | personal | drive r/w | MCP (HTTP) | OAuth | **high** | auth pending | Re-auth required. |

---

## Tier 2 — direct integrations (none yet)

Add rows here as you wire direct API integrations (REST/GraphQL/SDK). Prefer this over MCP when the tool is deterministic and the API surface is narrow.

| Domain | Tool | Account | Data Needed | Access | Auth | Sensitivity | Status | Notes |
|--------|------|---------|-------------|--------|------|-------------|--------|-------|
| _example_ | _Stripe_ | _aios-readonly_ | _list charges, count active subs_ | _Direct API_ | _.env: STRIPE_RESTRICTED_KEY_ | _high_ | _planned_ | _Restricted key, read-only, IP-allowlisted_ |

---

## Tier 3 — workflow tools (none yet)

Zapier / Make / n8n connections, only when orchestration genuinely needs them.

| Domain | Tool | Account | Data Needed | Access | Auth | Sensitivity | Status | Notes |
|--------|------|---------|-------------|--------|------|-------------|--------|-------|

---

## Tier 4 — manual / planned

Intentionally not connected — using exports, copy-paste, or "still figuring out the workflow." Listing them here is what makes the gap visible to `/audit`.

| Domain | Tool | Reason | Planned access |
|--------|------|--------|----------------|
| _Revenue_ | _Stripe_ | _Need to set up restricted key + IP allowlist_ | _Direct API, read-only_ |
| _Customer_ | _CRM_ | _No CRM yet_ | _TBD when chosen_ |
| _Calendar_ | _Google Calendar_ | _MCP auth pending_ | _Re-authenticate_ |
| _Tasks_ | _Linear / Notion / Things_ | _Pick one_ | _TBD_ |
| _Meetings_ | _Granola / Otter / Fireflies_ | _Pick one_ | _TBD_ |

---

## Connection lifecycle

1. **Plan** — add the row to Tier 4 with planned access method.
2. **Provision** — create dedicated service account, set scopes minimally, generate credentials.
3. **Document** — add `.env.example` placeholder, note rotation cadence.
4. **Wire** — connect via chosen method.
5. **Validate** — run a read-only call, confirm scope is what you think.
6. **Use** — promote to Tier 1/2/3.
7. **Review** — quarterly: rotate credentials, prune unused, downgrade scope when possible.
8. **Revoke** — when retiring, mark `revoked` here AND revoke at the source.

---

## Kill switch

To disable a connection in 60 seconds:
- **MCP servers:** `claude mcp remove <server-name>` and remove the entry from this table.
- **Direct API:** delete the relevant `.env` var (the integration code should fail fast).
- **Workflow tools:** disable the workflow at the platform; revoke the source token.

If a kill switch isn't documented here for a connection, it isn't ready for production use.

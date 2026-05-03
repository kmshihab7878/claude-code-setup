# Connections Roadmap — Seven Domains

> Adapted from AIS-OS by Nate Herk. The seven domains map every tool that produces or consumes business signal. Connect them in order; do not skip ahead.

The goal of this roadmap is not "wire everything up" — it is to make the OS aware of what exists, choose access methods that match risk, and avoid silently coupling sensitive systems.

The active **registry of what is/isn't connected** is `connections.md`. This file is the **decision framework** for what to connect, in what order, and with what access method.

---

## The Seven Domains

| # | Domain | Why it matters | First-week question |
|---|--------|----------------|---------------------|
| 1 | **Revenue** | Tracks the only metric that proves the business is alive | "How much money came in this month, and from where?" |
| 2 | **Customer** | Who is on the other end of the revenue | "Who are my top 10 customers and what do they need next?" |
| 3 | **Calendar** | Where time goes vs. where it should go | "Did this week's calendar match this week's priorities?" |
| 4 | **Comms** | Inbound interrupts that derail focus | "What in my inbox actually needs me, vs. what looks urgent?" |
| 5 | **Tasks** | The bridge between intent and outcome | "What's blocked on me right now?" |
| 6 | **Meetings** | The most expensive form of work | "Which meeting from this week produced a decision worth keeping?" |
| 7 | **Knowledge** | What the OS can recall on your behalf | "What do I keep re-deriving instead of writing down once?" |

---

## Build order

```
Revenue  →  Customer  →  Calendar  →  Comms  →  Tasks  →  Meetings  →  Knowledge
```

**Why this order:**

- **Revenue first** because if you can't measure money, every other automation is theatre.
- **Customer second** because revenue without customer context becomes vanity metrics.
- **Calendar third** because once you know the goal, you find out where time actually goes.
- **Comms fourth** because most calendar damage comes from poorly-triaged inbound.
- **Tasks fifth** because tasks should drop out of priorities, not accumulate independently.
- **Meetings sixth** because meetings only matter once Tasks captures their outputs.
- **Knowledge last** because you need to know what to remember before you build the memory.

You can do them in parallel if life forces it, but the dependency arrows above are real.

---

## Per-domain decision template

For each domain, fill in:

```markdown
### Domain: <name>

**Current state (manual today):** ...
**Tool of choice:** ...
**Account:** dedicated AI OS service account / personal / shared
**Sensitivity:** low / medium / high
**Access method (in order of preference):**
  1. Manual export — when?
  2. Direct API (read-only first)
  3. MCP server (with whitelisted tool functions)
  4. CLI
  5. Webhook (inbound only)
  6. Workflow tool (Zapier/Make/n8n)
**Kill switch:** how to disconnect in 60s
**First-week metric:** the one number that proves this connection is useful
**What breaks if compromised:** ...
```

---

## Access method decision matrix

| Tool characteristic | Best method |
|---------------------|-------------|
| Critical / irreversible (payments, deletes) | **Manual export** until you are 100% sure |
| Stable, deterministic, narrow surface | **Direct API** (read-only credentials, IP allowlist) |
| Many sub-tools, OAuth-managed | **MCP** (with `hooks/mcp-security-gate.sh` whitelisting which functions) |
| Inbound events you don't poll | **Webhook** (signed, into a queue) |
| Bridges between unrelated services | **Workflow tool** (Zapier/Make/n8n) |
| Local files, scripts, dev loops | **CLI** |

See `references/direct-api-vs-mcp.md` for the deeper trade-off.

---

## Sensitivity tiers (used in `connections.md`)

| Tier | Examples | Required controls |
|------|----------|-------------------|
| **low** | Public docs, market data, blog content | Standard repo hygiene |
| **medium** | Internal notes, calendar, draft emails | Per-repo scope, no broad filesystem reads |
| **high** | Money, customer PII, business strategy, prod DB | Dedicated service account · Read-only by default · Quarterly credential rotation · Documented kill switch · Audit logged via `hooks/mcp-security-gate.sh` |

A `low` tool that reads from a `high` source becomes `high`. Tier escalates with the highest data it touches.

---

## Rules of thumb

- **No real secrets in the repo.** `.env` is gitignored — verify with `git check-ignore -v .env`.
- **Document before connecting.** A row in `connections.md` exists before the first call.
- **Read-only first.** Promote to write only after a week of read-only success.
- **Service accounts for sensitive systems.** Personal accounts have side-effects you don't want when an automation goes wrong.
- **Direct API for deterministic work.** MCP is a great fit for exploration and tool sprawl; direct API is a great fit for repeatable pipelines.
- **Kill switch documented and tested.** If you can't shut it off in 60 seconds, it's not ready.
- **Quarterly review.** Stale connections accumulate risk silently.

---

## How `/audit` scores Connections

| Score | Meaning |
|-------|---------|
| 0-5 | No `connections.md`, or only Tier 1 MCP rows that came from `claude mcp list` |
| 6-15 | Some domains documented, some real connections, sensitivity tiers missing |
| 16-22 | Most domains documented with access method + kill switch |
| 23-25 | All seven domains have an entry (even if "manual today"), every active connection has a documented kill switch and a sensitivity tier |

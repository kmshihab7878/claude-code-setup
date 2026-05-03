# Direct API vs MCP — When to Use Which

> Both connect the OS to external tools. They optimise for different things.

---

## TL;DR

| Use **Direct API** when... | Use **MCP** when... |
|----------------------------|---------------------|
| The integration is deterministic and runs on a schedule | You need an LLM to discover and pick the right tool from a surface |
| You want to write code that a junior dev can read in 5 min | You want zero glue code per tool |
| The API surface is narrow (3-10 endpoints used) | The tool has many functions and you want them all callable |
| Cost per call matters and you want to skip the LLM round-trip | The tool's auth flow is OAuth-managed and rotates often |
| You need precise rate-limit and retry control | Rate limits are generous and you can rely on defaults |
| The output schema needs to be validated before downstream use | The output is consumed by an LLM that will validate informally |
| Failure modes need to be explicit and recoverable | "Best effort" is acceptable |
| You will run this 1000+ times per week | You will run this <100 times per week |
| The tool is `high` sensitivity and you want auditable code paths | The tool is `low`-`medium` and convenience matters |

---

## Why "Direct API for deterministic work"

When you do the same thing every day on the same data, the LLM in the loop adds:
- **Latency** (extra round-trip per call)
- **Cost** (tokens for system prompts, tool descriptions, response interpretation)
- **Non-determinism** (the LLM occasionally picks the wrong tool, paraphrases the response, or invents fields)

A 30-line Python script using `requests` (or the official SDK) calls the API directly, returns a typed result, and runs the same way every time. That's what you want for:
- Cron jobs
- Webhook handlers
- Batch processing
- ETL pipelines
- Anything tied to a KPI

## Why MCP for tool sprawl

When the goal is "the LLM should be able to use whatever's appropriate," MCP wins:
- One server registers many functions; the LLM picks
- Auth lives in the server, not in your code
- Adding a new tool is one server install, not a new SDK + new credential rotation + new code path
- Great for exploration, brainstorming, ad-hoc work

That's why the OS uses MCP for: filesystem, memory, git, gmail, code-review-graph, claude-mem, sequential-thinking. None of these have predictable per-day call patterns.

---

## Hybrid pattern

Most mature stacks end up with both:
- **MCP for the human-in-loop interactive surface** — Claude Code session, ad-hoc questions, exploration
- **Direct API for the headless deterministic surface** — cron jobs, webhooks, scheduled audits, batch reports

Neither replaces the other. Picking only one is usually a sign that the OS is not yet at scale.

---

## Decision in 30 seconds

Ask:
1. **Will this run on a schedule, unattended?** → Direct API
2. **Is this exploratory or one-shot?** → MCP
3. **Does the cost per call matter at projected volume?** → Direct API
4. **Is this for a tool I added today and will probably re-evaluate?** → MCP
5. **Is the failure mode "wrong action taken silently"?** → Direct API
6. **Is the failure mode "user re-asks with more context"?** → MCP

Two or more "Direct API" → write the code.
Two or more "MCP" → install the server.

---

## What to NOT do

- **Don't wrap a Direct API in an MCP server just to use it from Claude Code.** The MCP layer adds latency and removes determinism. Call the API from a skill that uses the SDK.
- **Don't write a Direct API client for a tool you'll use 3 times.** The maintenance cost outlives the use case.
- **Don't share credentials between MCP and Direct API integrations.** They have different blast radii. Use separate service accounts.
- **Don't migrate everything from MCP to Direct API "for purity."** The migration cost is real and the determinism payoff only exists at volume.

---

## When neither fits

Sometimes the right answer is **manual export + a script**. Examples:
- A quarterly board report — pull the CSV by hand, run a script, send the PDF.
- A one-off investigation — copy data from a tool, paste into a notebook, derive answer, archive notebook.

Manual + script is unfashionable but extremely cheap. Reserve API integration for things that justify the integration cost.

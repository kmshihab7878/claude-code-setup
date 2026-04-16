# MCP Gap Analysis

Snapshot: **2026-04-16** (updated after foundation-4 install). Three columns: Have (connected), Documented-but-not-connected, Never had (gap to 30-list catalog).

> Re-run `claude mcp list` to get the live state. This doc is a point-in-time reference.

## Column A — Actually connected (8 servers + 1 OAuth connected + 2 OAuth auth-pending)

From `claude mcp list` + `~/.mcp.json` + `~/.claude.json.mcpServers`:

| Server | Scope | Transport | Purpose |
|--------|-------|-----------|---------|
| `filesystem` | user | stdio (npx) | Foundation — direct fs read/write/search beyond cwd |
| `memory` | user | stdio (npx) | Foundation — knowledge-graph persistent memory |
| `sequential-thinking` | user | stdio (npx) | Foundation — multi-step structured reasoning |
| `git` | user | stdio (uvx) | Foundation — git diff/log/blame via MCP |
| `chrome-devtools` | user | stdio (npx) | Computed-style extraction for Hue; high-fidelity brand analysis |
| `code-review-graph` | ~/.mcp.json | stdio (uvx) | Graph-based code review |
| `supabase` | ~/.mcp.json | HTTP | Supabase project (pzpaebzlwwmyhgwcjsge) — docs, account, DB, debugging, dev, functions, branching, storage |
| `Gmail` | claude.ai OAuth | remote | ✓ Connected — email search/read/draft |
| `Google Calendar` | claude.ai OAuth | remote | ⚠️ Needs auth refresh |
| `Google Drive` | claude.ai OAuth | remote | ⚠️ Needs auth refresh |

## What changed since first gap scan (earlier today)

Installed via `claude mcp add --scope user`: **filesystem, memory, sequential-thinking, git**. All four foundation MCPs from the 30-list are now live — `claude mcp list` reports ✓ Connected for each. Zero auth required, zero cost.

## Column B — Documented in CLAUDE.md but NOT actually connected

CLAUDE.md claims 23 MCPs; the following are in that list but are **not** present in any MCP config file nor reported by `claude mcp list`. This is a coherence problem.

```
github, penpot, aidesigner, memory, filesystem, sequential, context7,
docker, aster, notion, playwright, puppeteer, postgres, brave-search,
tavily, slack, stripe, kubernetes, terraform, google-maps, obsidian,
sim-studio, hermes
```

**Options to resolve**:
1. **Install the ones you actually use** (recommended; the foundation four + GitHub + Playwright alone would unlock huge value).
2. **Prune CLAUDE.md** to match reality (reduces hallucination risk — Claude won't try to call mcp tools that don't exist).
3. **Both** — install the 5-6 you actually need, prune the rest from CLAUDE.md.

## Column C — Gap to 30-server catalog (not on your radar yet)

### Free-ish, realistic install candidates

| Server | Why it would help you | Install |
|--------|----------------------|---------|
| **filesystem** (#1) | Direct cross-dir file ops beyond cwd | `claude mcp add --scope user filesystem -- npx -y @modelcontextprotocol/server-filesystem $HOME` |
| **git** (#2) | Git ops via MCP (richer than bash `git`) | `claude mcp add --scope user git -- uvx mcp-server-git` |
| **memory** (#3) | Persistent knowledge graph (complements claude-mem plugin) | `claude mcp add --scope user memory -- npx -y @modelcontextprotocol/server-memory` |
| **sequential-thinking** (#4) | Structured multi-step reasoning | `claude mcp add --scope user sequential-thinking -- npx -y @modelcontextprotocol/server-sequential-thinking` |
| **context7** | Library doc lookups (already in your CLAUDE.md aspirationally) | `claude mcp add --scope user context7 -- npx -y @upstash/context7-mcp` |
| **Firecrawl** | Deep web scraping beyond tavily/brave | Needs FIRECRAWL_API_KEY (free tier generous) |
| **Figma** | You work on UI design (Hue, interface-design, impeccable-design) — Figma MCP reads Figma files, extracts tokens | Needs FIGMA_PAT (free) |
| **Neo4j** | Graph DB for relationship-heavy data | Local Neo4j Desktop (free) |
| **Qdrant** | Vector DB for semantic search over your own corpus | Local Qdrant (free) |
| **Apify** | Actor-based scraping (100+ pre-built scrapers) | Free tier |

### Paid / auth-gated — install only if you use the service

| Server | Needs |
|--------|-------|
| Sentry | Sentry project auth |
| CircleCI | CCI token |
| Neon | Neon account |
| ClickHouse / Tinybird | Paid account |
| AWS suite | AWS credentials |
| Cloudflare | CF account |
| Grafana | Grafana instance |
| Railway, Render | Deploy-platform tokens |
| Jira, Asana, HubSpot | Workspace auth |
| Browserbase, Bright Data | Paid accounts |
| ElevenLabs | API key |
| Stripe | Stripe secret key |
| Notion | Notion integration token |
| Slack | Slack bot token |
| GitHub | GITHUB_PAT (actually free — just needs user auth) |

## Top 5 install recommendations (ranked by leverage for this user)

Based on your existing skill stack and observed workflow:

1. **Foundation four** (filesystem, git, memory, sequential-thinking) — all free, no auth, immediate value. Install in one go.
2. **GitHub MCP** — you commit/push frequently; this unlocks PR review, issue triage, workflow triggering. Needs PAT only.
3. **Playwright MCP** — complements your existing webapp-testing, impeccable-design, design-inspector skills. Auth-free.
4. **Figma MCP** — plugs into Hue, interface-design, impeccable-design ecosystem. Free PAT.
5. **Firecrawl MCP** — augments tavily/brave with deeper scraping for research tasks. Free tier sufficient to start.

## CLAUDE.md coherence fix (separate task, flagged here)

The "23 MCP servers" claim in `~/.claude/CLAUDE.md:224-251` and the "23 MCP servers" count in the Capabilities Summary are aspirational, not factual. Consider:

- Pruning the list to the **actually-connected** four (+3 OAuth remote).
- Or keep the list and tag each row with `✓ connected` / `○ not installed` for honesty.

This reduces the chance Claude tries to call `mcp__github__*` tools that don't exist, which waste a tool call and produce errors.

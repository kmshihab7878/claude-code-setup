# Council Workflow — full phase detail

Step-by-step procedure for all six phases. The compact phase list lives in `SKILL.md`.

## Phase 0: Intelligence gathering

Before any advisor speaks, gather hard data relevant to the question domain.
Advisors must argue from evidence, not vibes.

### Step 1 — Classify the question domain

| Domain | Signals |
|--------|---------|
| engineering | code, architecture, technical debt, API, performance, testing |
| trading | positions, market, price, entry, exit, risk, funding, portfolio |
| product | feature, launch, users, retention, pricing, roadmap, PMF |
| infrastructure | deploy, scale, uptime, cost, cloud, containers, monitoring |
| security | vulnerability, breach, compliance, audit, access, encryption |
| growth | acquisition, activation, retention, revenue, referral, CAC, LTV |
| strategy | direction, competitors, moat, market entry, pivot, partnerships |
| operations | hiring, process, team, budget, timeline, resource allocation |
| research | technology choice, framework selection, build vs buy, evaluation |

### Step 2 — Pull data from MCP servers based on domain

Only query servers relevant to the classified domain. Don't spray all servers.

| Domain | MCP Data Sources | What to Pull |
|--------|------------------|--------------|
| engineering | github, filesystem, Agent Orchestrator (if running) | Open PRs, recent commit frequency, code complexity, test coverage, fleet health, CI remediation queue |
| trading | aster, TimesFM (via aster-timesfm-pipeline), MiroFish (if running) | Positions, P&L, funding exposure, recent price action, order book depth, quantitative forecasts + qualitative scenarios |
| product | github, obsidian, aidesigner | Feature backlog, user feedback themes, roadmap notes, UI generation capacity |
| infrastructure | github, filesystem | Current infra state, recent deploy history, cost indicators |
| security | github, filesystem | Known vulnerabilities, recent security changes, compliance status |
| growth | obsidian, github | Current metrics, experiment results, channel performance |
| strategy | obsidian, brave-search/tavily, MiroFish, Paperclip | Competitor moves, market trends, news, scenarios, governance metrics |
| operations | github, obsidian | Team capacity, timeline state, budget tracking |
| research | context7, brave-search/tavily, MiroFish | Technical evaluations, benchmark data, adoption metrics |

### Step 3 — Check semantic memory

```
mcp__plugin_claude-mem_mcp-search__search({ query: "<council question keywords>" })
```

Surface any prior council decisions on related topics. Advisors should build
on (or challenge) prior conclusions rather than starting from zero.

### Step 4 — Check project memory files

Read `~/.claude/projects/*/memory/MEMORY.md` for confidence-scored facts.
Facts with confidence ≥ 0.8 are treated as established context.

### Step 5 — Compile the Intelligence Brief

Maximum 300 words, with these sections:

- **Domain** — the classified domain.
- **Hard Data** — numbers, metrics, facts from MCP queries.
- **Prior Decisions** — relevant past council conclusions (if any).
- **Known Context** — established facts from memory (if any).
- **Data Gaps** — what data could not be obtained; be transparent about blind spots.

This brief goes to ALL advisors. They must reference it.

## Phase 1: Context extraction

1. Extract the core question/decision from the user's message.
2. Gather all available context:
   - The user's full message and conversation history.
   - Any referenced files, data, or documents in the workspace.
   - Relevant project state (git history, configs, recent changes).
   - The Intelligence Brief from Phase 0.
3. Summarize the decision context in 2-3 sentences before proceeding.

## Phase 2: The five advisors

Run each advisor completely before moving to the next. Each advisor produces
a **300-600 word** response, direct and opinionated, no pulled punches.

All advisors **must** reference specific data from the Intelligence Brief.
Generic advice without data backing is unacceptable.

Format for each advisor:

```
**Advisor: [Name]**
[Full response, 300-600 words, extremely direct and opinionated,
referencing Intelligence Brief data]
```

Full per-advisor profile + per-domain specialization examples:
`references/roles-and-routing.md`.

## Phase 3: Anonymization and peer review

1. **Anonymize** — random one-to-one mapping of the five advisors to letters
   A-E. Record the mapping privately. **Do not reveal it until the very end
   of the transcript.**
2. **Present** — show the five responses as "Advisor A", "Advisor B", etc.
   in shuffled order (not the same order as Phase 2).
3. **Peer review** — act as five independent reviewers (Reviewers 1-5).
   Each reviewer answers three questions:
   - **Q1**: Which response is the strongest and why?
   - **Q2**: Which response has the biggest blind spot and what is it?
   - **Q3**: What did ALL five advisors collectively miss? (Most important
     question — always find at least one insight none of them surfaced.)

Format:

```
**Reviewer X**
1. Strongest: [Letter] — [reason]
2. Biggest blind spot: [Letter] — [what's missing]
3. Collective miss: [insight that none of the five advisors surfaced]
```

## Phase 4: Chairman synthesis

Use `mcp__sequential__sequentialthinking` to structure the chairman's
reasoning when the question is complex (multi-factor, high-stakes, or
> 2 viable options). For straightforward questions, direct synthesis is fine.

Read every advisor response and every reviewer comment. Synthesize:

1. **Executive Summary** — one paragraph, the decision distilled.
2. **Clear Recommendation** — specific, unambiguous.
3. **Confidence Score** — see `references/decision-frameworks-and-synthesis.md`.
4. **One Concrete Next Step** — what to do Monday morning. Name the action,
   the tool, the person, the deliverable.
5. **Major Risks** — top 2-3 risks to watch, with mitigation for each.
6. **Hidden Opportunities** — top 1-2 opportunities surfaced by the council
   that the user likely had not considered.

## Phase 5: Output

Produce three outputs, in this exact order. Full schemas + HTML design
guidelines + Obsidian frontmatter: `references/examples.md`.

1. **HTML report** — saved to disk at
   `~/.claude/council-reports/council-<YYYY-MM-DD>-<slug>.html`
   (create the directory if it doesn't exist; use the Write tool).
   Self-contained inline styles. Also display inline.
2. **Obsidian note** (only if vault is accessible) —
   `Council Reports/council-<YYYY-MM-DD>-<slug>.md`
   via `mcp__obsidian__write_note`. **If MCP fails, skip silently —
   do not error.**
3. **Markdown transcript** — full raw transcript with mapping at the end.

## Phase 6: Follow-up actions

After delivering outputs:

1. **Create tasks** via `TaskCreate` from the Executor's Monday-morning
   action. Only create tasks if the actions are concrete and actionable
   (not vague "think about X").
2. **Save to semantic memory**:

   ```
   mcp__memory__create_entities([{
     name: "Council: <question slug>",
     entityType: "decision",
     observations: [
       "Question: <the question>",
       "Domain: <domain>",
       "Recommendation: <chairman recommendation>",
       "Confidence: <HIGH|MEDIUM|LOW>",
       "Date: <YYYY-MM-DD>"
     ]
   }])
   ```

3. **Report file location** — tell the user where the HTML report was saved.
4. **Multi-platform delivery** (optional) — if Hermes MCP is connected,
   offer to deliver the council summary via Telegram / Discord / Slack
   using `hermes` MCP `messages_send`. **T2 — ask before sending.**

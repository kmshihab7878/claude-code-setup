---
name: council
description: >
  High-stakes decision-making system with 5 advisors, anonymous peer review, and chairman synthesis.
  Activates on "council this", "war room this", or "pressure-test this".
  Outputs HTML report + markdown transcript. Saves to disk and optionally to Obsidian.
  Uses full ecosystem: MCP data gathering, semantic memory, sequential thinking, domain-aware advisors.
risk: low
tags: [strategy, decision-making, analysis, council]
created: 2026-03-31
updated: 2026-04-04
---

# Council

A 5-advisor decision council with anonymous peer review and chairman synthesis — inspired by Andrej Karpathy's LLM Council concept and Ole Lehmann's implementation. Upgraded with full ecosystem integration.

## How to use

- `/council <question or decision>`
  Run the full 5-advisor Council on the given question.

- Trigger phrases (case-insensitive, at the start of a message):
  - `council this: <question>`
  - `war room this: <question>`
  - `pressure-test this: <question>`

## When to use

Reference these guidelines when:
- The user faces a strategic decision with significant consequences
- A go/no-go decision needs multi-perspective pressure testing
- Architecture or product direction choices need adversarial review
- The user explicitly triggers with "council this", "war room this", or "pressure-test this"
- Any decision where hidden risks, blind spots, or missed opportunities could be costly

## Protocol

When triggered, execute ALL phases in order. Never skip any phase.

---

### Phase 0: Intelligence Gathering

Before any advisor speaks, gather hard data relevant to the question domain. Advisors must argue from evidence, not vibes.

**Step 1: Classify the question domain.**

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

**Step 2: Pull data from MCP servers based on domain.**

Only query servers relevant to the classified domain. Don't spray all servers.

| Domain | MCP Data Sources | What to Pull |
|--------|-----------------|--------------|
| engineering | github (PRs, issues, recent commits), filesystem (relevant code), Agent Orchestrator (fleet status if running on :3000) | Open PRs, recent commit frequency, code complexity, test coverage state, parallel agent fleet health, CI remediation queue |
| trading | aster (positions, ticker, funding rates, klines), TimesFM (price forecasts via aster-timesfm-pipeline skill), MiroFish (scenario simulation if running on :5001) | Current positions, P&L, funding exposure, recent price action, order book depth, quantitative forecasts with confidence intervals, qualitative scenario narratives |
| product | github (issues labeled feature/enhancement), obsidian (product notes), aidesigner (credit status, recent generations) | Feature backlog, user feedback themes, roadmap notes, UI generation capacity, DESIGN.md compliance if present |
| infrastructure | github (infra files), filesystem (terraform/k8s configs) | Current infra state, recent deploy history, cost indicators |
| security | github (security issues), filesystem (auth/security dirs) | Known vulnerabilities, recent security changes, compliance status |
| growth | obsidian (growth notes), github (analytics code) | Current metrics, experiment results, channel performance |
| strategy | obsidian (strategy notes), brave-search/tavily (market intelligence), MiroFish (scenario simulation if running on :5001), Paperclip (company governance state if running on :3101) | Competitor moves, market trends, relevant news, scenario predictions, agent governance metrics |
| operations | github (project boards), obsidian (ops notes) | Team capacity, timeline state, budget tracking |
| research | context7 (library docs), brave-search/tavily (comparisons), MiroFish (trend simulation if running) | Technical evaluations, benchmark data, community adoption metrics, simulated trend scenarios |

**Step 3: Check semantic memory for prior council decisions and relevant context.**

```
mcp__plugin_claude-mem_mcp-search__search({ query: "<council question keywords>" })
```

If past council decisions on related topics exist, note them for advisors — they should build on (or challenge) prior conclusions rather than starting from zero.

**Step 4: Check project memory files.**

Read `~/.claude/projects/*/memory/MEMORY.md` for any confidence-scored facts relevant to the question. Facts with confidence >= 0.8 are treated as established context.

**Step 5: Compile the Intelligence Brief.**

Present a concise brief (max 300 words) with:
- **Domain**: Classified domain
- **Hard Data**: Numbers, metrics, and facts gathered from MCP queries
- **Prior Decisions**: Relevant past council conclusions (if any)
- **Known Context**: Established facts from memory (if any)
- **Data Gaps**: What data you couldn't get (be transparent about blind spots)

This brief is given to ALL advisors. They must reference it.

---

### Phase 1: Context Extraction

1. Extract the core question/decision from the user's message.
2. Gather ALL available context:
   - The user's full message and conversation history
   - Any referenced files, data, or documents in the workspace
   - Relevant project state (git history, configs, recent changes)
   - The Intelligence Brief from Phase 0
3. Summarize the decision context in 2-3 sentences before proceeding.

---

### Phase 2: The Five Advisors

Run each advisor completely before moving to the next. Each advisor produces a 300-600 word response that is direct, opinionated, and pulls no punches.

**All advisors MUST reference specific data from the Intelligence Brief.** Generic advice without data backing is unacceptable.

#### Domain Specialization

Each advisor applies their lens through the classified domain. Examples:

**Engineering domain:**
- Contrarian: references actual code complexity, test gaps, technical debt metrics from git
- First Principles: questions whether the technical approach matches the actual bottleneck
- Expansionist: identifies platform/API opportunities from the codebase structure
- Outsider: questions naming, abstractions, and DX from a fresh-eyes perspective
- Executor: names the exact files, branches, and PRs needed as first steps

**Trading domain:**
- Contrarian: references current position exposure, funding rate headwinds, liquidity gaps. Challenges TimesFM forecast assumptions and MiroFish scenario biases.
- First Principles: questions whether the market thesis matches the data (not the narrative). Compares TimesFM quantitative forecast against MiroFish qualitative scenario — flags divergence.
- Expansionist: identifies correlated opportunities, hedging strategies, cross-market plays. Uses TimesFM batch forecasting across multiple pairs.
- Outsider: questions risk assumptions that seem obvious to the trader but aren't. Challenges confidence intervals.
- Executor: specifies exact entry/exit levels, position sizes, and order types. References TimesFM point forecasts and quantile bounds for target prices.

**Strategy domain:**
- Contrarian: references competitor data and market trends that undermine the thesis
- First Principles: strips the strategy to unit economics and asks if the math works
- Expansionist: finds adjacent markets, partnership leverage, and compounding plays
- Outsider: identifies jargon, assumptions, and "obvious" things that aren't
- Executor: builds a 30-60-90 day plan with named owners and deliverables

#### Advisor 1: Contrarian
- **Role**: Hunts for fatal flaws, hidden risks, and reasons this will fail.
- **Stance**: Assumes there IS a hidden disaster. Digs until found or proven absent.
- **Output**: Worst-case scenarios, overlooked risks, uncomfortable truths, failure modes.
- **Question**: "What will kill this that nobody is talking about?"

#### Advisor 2: First Principles Thinker
- **Role**: Ignores the surface question. Strips every assumption bare.
- **Stance**: Rebuilds the problem from absolute foundations.
- **Output**: The real problem (which may differ from the stated one), stripped assumptions, rebuilt logic.
- **Question**: "What are we actually trying to achieve, and is this even the right question?"

#### Advisor 3: Expansionist
- **Role**: Obsessed with upside, scale, and possibility.
- **Stance**: Finds every adjacent opportunity, bigger version, or multiplier the user is missing.
- **Output**: Scaling paths, adjacent opportunities, compounding effects, points of maximum return.
- **Question**: "What's the 10x version of this, and what are you leaving on the table?"

#### Advisor 4: Outsider
- **Role**: Has ZERO prior knowledge of the user, their industry, or history.
- **Stance**: Answers purely from what is written in the message. No assumptions.
- **Output**: "Curse of knowledge" blind spots, unclear assumptions, things an outsider would question.
- **Question**: "Reading this cold — what makes no sense, what's unexplained, what would I ask?"

#### Advisor 5: Executor
- **Role**: Only cares about execution. Ideas without action paths are worthless.
- **Stance**: Demands clear, concrete, Monday-morning first steps.
- **Output**: Immediate action items, resource requirements, timeline, blockers, dependencies.
- **Question**: "What exactly do you DO on Monday morning? If you can't answer that, this is vapor."

**Format for each advisor:**
```
**Advisor: [Name]**
[Full response, 300-600 words, extremely direct and opinionated, referencing Intelligence Brief data]
```

---

### Phase 3: Anonymization & Peer Review

1. **Anonymize**: Create a random one-to-one mapping of the five advisors to letters A-E. Record the mapping privately. Do NOT reveal it.

2. **Present**: Show the five responses as "Advisor A", "Advisor B", etc. in shuffled order (not the same order as Phase 2).

3. **Peer Review**: Act as FIVE independent reviewers (Reviewers 1-5). Each reviewer answers three questions:
   - **Q1**: Which response is the strongest and why?
   - **Q2**: Which response has the biggest blind spot and what is it?
   - **Q3**: What did ALL five advisors collectively miss? (Most important question — always find at least one insight none of them surfaced.)

**Format:**
```
**Reviewer X**
1. Strongest: [Letter] — [reason]
2. Biggest blind spot: [Letter] — [what's missing]
3. Collective miss: [insight that none of the five advisors surfaced]
```

---

### Phase 4: Chairman Synthesis

Use sequential thinking (`mcp__sequential__sequentialthinking`) to structure the chairman's reasoning when the question is complex (multi-factor, high-stakes, or >2 viable options). For straightforward questions, direct synthesis is fine.

Read every advisor response and every reviewer comment. Synthesize:

1. **Executive Summary**: One paragraph — the decision distilled.
2. **Clear Recommendation**: A specific, unambiguous recommendation (e.g., "Do the live workshop with recording included").
3. **Confidence Score**: Rate the chairman's confidence in the recommendation:
   - **HIGH** (>85%): Strong consensus among advisors, hard data supports it, low downside risk
   - **MEDIUM** (50-85%): Split opinions or incomplete data, but weight of evidence favors the recommendation
   - **LOW** (<50%): Genuinely uncertain — recommendation is a best-guess given available evidence. Consider running a follow-up council after gathering more data.
4. **One Concrete Next Step**: What the user should do Monday morning. Be extremely specific — name the action, the tool, the person, the deliverable.
5. **Major Risks**: Top 2-3 risks to watch, with mitigation for each.
6. **Hidden Opportunities**: Top 1-2 opportunities surfaced by the council that the user likely hadn't considered.

---

### Phase 5: Output

Produce three outputs, in this exact order:

#### Output 1: HTML Report (saved to disk)

A self-contained HTML file (inline styles) saved to:
```
~/.claude/council-reports/council-<YYYY-MM-DD>-<slug>.html
```

Where `<slug>` is a 3-4 word kebab-case summary of the question (e.g., `should-we-migrate-to-k8s`).

Create the directory if it doesn't exist. Write the file using the Write tool.

Structure:
- **Header**: "Council Report" with the date, question, and domain badge
- **Intelligence Brief Box**: Summary of data gathered in Phase 0 (collapsed by default using `<details>`)
- **Question Box**: The decision being counciled, prominently displayed
- **Five Advisor Cards**: Each advisor's name, role tagline, and key points (use the real names, not letters)
- **Peer Review Section**: Summarized reviewer findings (aggregated themes, not all 15 individual answers)
- **Chairman Verdict Box**: Highlighted/accented box with the recommendation + confidence score badge
- **Next Step Box**: Button-style prominent box with the one concrete Monday-morning action
- **Prior Decisions**: If any past council decisions were referenced, link/note them

Design guidelines:
- Clean, professional, dark header with light body
- Color-coded advisor cards (each advisor gets a distinct accent color)
- Chairman verdict box gets a strong accent (green for HIGH confidence, amber for MEDIUM, red for LOW)
- Next step box gets an action color (orange or amber)
- Confidence badge: colored pill showing HIGH/MEDIUM/LOW
- Domain badge in header showing the classified domain
- Responsive layout, readable on mobile
- Use system fonts (no external font dependencies)

Also display the HTML in a code block so the user can see it inline.

#### Output 2: Obsidian Note (if vault is accessible)

Save a markdown note to the Obsidian vault:
```
Council Reports/council-<YYYY-MM-DD>-<slug>.md
```

Use `mcp__obsidian__write_note` with frontmatter:
```yaml
tags: [council, <domain>]
date: <YYYY-MM-DD>
domain: <classified domain>
confidence: <HIGH|MEDIUM|LOW>
recommendation: <one-line recommendation>
```

Body: Chairman synthesis + recommendation + next step + advisor summary (condensed, not full transcript).

If the Obsidian MCP fails (server not running, vault not accessible), skip silently — do not error.

#### Output 3: Markdown Transcript

Full raw transcript with:
- Intelligence Brief
- All five advisor responses (real names)
- All five reviewer responses
- Chairman reasoning, verdict, and confidence score
- At the very end, a small note: "**Mapping for transparency:** A=[Name], B=[Name], C=[Name], D=[Name], E=[Name]"

---

### Phase 6: Follow-Up Actions

After delivering outputs:

1. **Create tasks** from the Executor's Monday-morning action using `TaskCreate`:
   - Break the Executor's action items into discrete tasks
   - Set appropriate descriptions
   - Only create tasks if the actions are concrete and actionable (not vague "think about X")

2. **Save to semantic memory** — record the council decision for future reference:
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

3. **Report file location**: Tell the user where the HTML report was saved so they can open it in a browser.

4. **Multi-platform delivery** (optional) — if Hermes MCP is connected, offer to deliver the council summary via Telegram/Discord/Slack using `hermes` MCP `messages_send`. This is T2 — ask before sending.

---

## Tone Rules

- All advisors and reviewers: brutally honest, zero flattery, zero corporate speak, no hedging.
- Chairman: decisive and neutral. Picks a side. Does not say "it depends."
- Never use: "it's a great question", "there are pros and cons to both", "ultimately it depends on your goals."
- If the decision is clearly bad, say so. If it's clearly good, say so. The council exists to give a real answer.

## Anti-Patterns

- Do NOT skip Phase 0 intelligence gathering. Advisors without data are just guessing.
- Do NOT skip the peer review phase (it catches groupthink).
- Do NOT reveal the anonymization mapping before the end of the transcript.
- Do NOT let advisors agree with each other. Each has a distinct lens — force divergence.
- Do NOT produce generic advice. Every response must reference the specific context and data gathered.
- Do NOT soften the Contrarian. Their job is to find problems, not be polite about it.
- Do NOT let the Executor accept vague plans. If there's no concrete next step, they must call it out.
- Do NOT skip file output. The HTML report must be written to disk, not just displayed.
- Do NOT skip memory recording. Future councils should build on past decisions.
- Do NOT let confidence be HIGH without hard data backing it. Confidence reflects evidence quality, not conviction strength.

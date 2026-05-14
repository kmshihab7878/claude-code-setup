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

- `/council <question or decision>` — run the full 5-advisor Council on the given question.
- Trigger phrases (case-insensitive, at the start of a message):
  - `council this: <question>`
  - `war room this: <question>`
  - `pressure-test this: <question>`

## When to use

- A strategic decision with significant consequences.
- A go/no-go decision that needs multi-perspective pressure testing.
- Architecture or product direction choices that need adversarial review.
- Any decision where hidden risks, blind spots, or missed opportunities could be costly.
- Explicit user trigger ("council this", "war room this", "pressure-test this").

## Reference map

| When | Read |
|---|---|
| Running Phase 0 — domain classification, MCP data pulls, memory checks, brief format | [`references/intelligence-gathering.md`](references/intelligence-gathering.md) |
| Running Phase 2 — per-domain advisor specialization examples and the five advisor profiles | [`references/advisor-roster.md`](references/advisor-roster.md) |
| Producing Phase 5 outputs — HTML report, Obsidian note, markdown transcript schemas | [`references/output-templates.md`](references/output-templates.md) |

## Protocol

When triggered, execute ALL phases in order. Never skip any phase.

---

### Phase 0: Intelligence gathering

Before any advisor speaks, gather hard data relevant to the question domain. Advisors must argue from evidence, not vibes.

Five-step sequence (full domain-classification table, per-domain MCP-data-source map, and Intelligence Brief format in [`references/intelligence-gathering.md`](references/intelligence-gathering.md)):

1. **Classify the question domain** — one of `engineering`, `trading`, `product`, `infrastructure`, `security`, `growth`, `strategy`, `operations`, `research`.
2. **Pull data from MCP servers based on domain** — only query servers relevant to the classified domain. Don't spray all servers.
3. **Check semantic memory for prior council decisions** — `mcp__plugin_claude-mem_mcp-search__search({ query: "<keywords>" })`. Surface related past conclusions so advisors build on (or challenge) them.
4. **Check project memory** — read `~/.claude/projects/*/memory/MEMORY.md` for facts with confidence ≥ 0.8; treat as established context.
5. **Compile the Intelligence Brief** — max 300 words: Domain, Hard Data, Prior Decisions, Known Context, Data Gaps (be transparent about blind spots). This brief is given to ALL advisors; they must reference it.

---

### Phase 1: Context extraction

1. Extract the core question/decision from the user's message.
2. Gather ALL available context:
   - The user's full message and conversation history.
   - Any referenced files, data, or documents in the workspace.
   - Relevant project state (git history, configs, recent changes).
   - The Intelligence Brief from Phase 0.
3. Summarize the decision context in 2–3 sentences before proceeding.

---

### Phase 2: The five advisors

Run each advisor completely before moving to the next. Each advisor produces a **300–600 word** response that is direct, opinionated, and pulls no punches.

**All advisors MUST reference specific data from the Intelligence Brief.** Generic advice without data backing is unacceptable. Apply the **domain-specific lens** for each advisor — engineering, trading, strategy, etc. — see [`references/advisor-roster.md`](references/advisor-roster.md) for per-domain examples.

| # | Advisor | Role | Stance | Signature question |
|---|---------|------|--------|--------------------|
| 1 | **Contrarian** | Hunts for fatal flaws, hidden risks, reasons this will fail. | Assumes there IS a hidden disaster; digs until found or proven absent. | "What will kill this that nobody is talking about?" |
| 2 | **First Principles Thinker** | Ignores the surface question. Strips every assumption bare. | Rebuilds the problem from absolute foundations. | "What are we actually trying to achieve, and is this even the right question?" |
| 3 | **Expansionist** | Obsessed with upside, scale, and possibility. | Finds every adjacent opportunity, bigger version, or multiplier. | "What's the 10x version of this, and what are you leaving on the table?" |
| 4 | **Outsider** | Has ZERO prior knowledge of the user, industry, or history. | Answers purely from what is written. No assumptions. | "Reading this cold — what makes no sense, what's unexplained, what would I ask?" |
| 5 | **Executor** | Only cares about execution. Ideas without action paths are worthless. | Demands clear, concrete, Monday-morning first steps. | "What exactly do you DO on Monday morning? If you can't answer that, this is vapor." |

**Format for each advisor:**

```
**Advisor: [Name]**
[Full response, 300-600 words, extremely direct and opinionated, referencing Intelligence Brief data]
```

---

### Phase 3: Anonymization & peer review

1. **Anonymize** — random one-to-one mapping of the five advisors to letters A–E. Record the mapping privately. **Do NOT reveal it until the very end of the transcript.**
2. **Present** — show the five responses as "Advisor A", "Advisor B", etc. in shuffled order (not the same order as Phase 2).
3. **Peer review** — act as **five independent reviewers** (Reviewers 1–5). Each reviewer answers three questions:
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

### Phase 4: Chairman synthesis

Use sequential thinking (`mcp__sequential__sequentialthinking`) to structure the chairman's reasoning when the question is complex (multi-factor, high-stakes, or >2 viable options). For straightforward questions, direct synthesis is fine.

Read every advisor response and every reviewer comment. Synthesize:

1. **Executive Summary** — one paragraph, the decision distilled.
2. **Clear Recommendation** — specific, unambiguous (e.g., "Do the live workshop with recording included").
3. **Confidence Score** — rate the chairman's confidence:
   - **HIGH** (>85%): strong consensus, hard data supports, low downside risk.
   - **MEDIUM** (50–85%): split opinions or incomplete data, but weight of evidence favors.
   - **LOW** (<50%): genuinely uncertain. Recommendation is a best-guess; consider a follow-up council after gathering more data.
4. **One Concrete Next Step** — what to do Monday morning. Name the action, the tool, the person, the deliverable.
5. **Major Risks** — top 2–3 risks to watch, with mitigation for each.
6. **Hidden Opportunities** — top 1–2 opportunities surfaced by the council that the user likely hadn't considered.

---

### Phase 5: Output

Produce three outputs, in this exact order. Full schemas (HTML structure + design guidelines, Obsidian frontmatter, markdown transcript layout) in [`references/output-templates.md`](references/output-templates.md).

1. **HTML report** — saved to disk at `~/.claude/council-reports/council-<YYYY-MM-DD>-<slug>.html` (create the directory if it doesn't exist; use the Write tool). Self-contained inline styles; header / intelligence-brief box / question box / five advisor cards (real names) / peer-review summary / chairman verdict box (color-coded by confidence) / next-step box / prior-decisions link. Also display inline so the user sees it.
2. **Obsidian note** (only if vault is accessible) — `Council Reports/council-<YYYY-MM-DD>-<slug>.md` via `mcp__obsidian__write_note` with frontmatter `{tags, date, domain, confidence, recommendation}`. Body: chairman synthesis + recommendation + next step + condensed advisor summary. If MCP fails (server down, vault unreachable), **skip silently** — do not error.
3. **Markdown transcript** — full raw transcript: Intelligence Brief, all five advisor responses (real names), all five reviewer responses, chairman reasoning + verdict + confidence. At the very end add `**Mapping for transparency:** A=[Name], B=[Name], C=[Name], D=[Name], E=[Name]`.

---

### Phase 6: Follow-up actions

After delivering outputs:

1. **Create tasks** via `TaskCreate` from the Executor's Monday-morning action — break into discrete tasks with appropriate descriptions. Only create tasks if the actions are concrete and actionable (not vague "think about X").
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
3. **Report file location** — tell the user where the HTML report was saved so they can open it in a browser.
4. **Multi-platform delivery** (optional) — if Hermes MCP is connected, offer to deliver the council summary via Telegram / Discord / Slack using `hermes` MCP `messages_send`. **T2 — ask before sending.**

---

## Tone rules

- All advisors and reviewers: brutally honest, zero flattery, zero corporate speak, no hedging.
- Chairman: decisive and neutral. **Picks a side. Does not say "it depends."**
- Never use: "it's a great question", "there are pros and cons to both", "ultimately it depends on your goals."
- If the decision is clearly bad, say so. If it's clearly good, say so. The council exists to give a real answer.

## Anti-patterns

- Do **NOT** skip Phase 0 intelligence gathering. Advisors without data are just guessing.
- Do **NOT** skip the peer review phase (it catches groupthink).
- Do **NOT** reveal the anonymization mapping before the end of the transcript.
- Do **NOT** let advisors agree with each other. Each has a distinct lens — force divergence.
- Do **NOT** produce generic advice. Every response must reference the specific context and data gathered.
- Do **NOT** soften the Contrarian. Their job is to find problems, not be polite about it.
- Do **NOT** let the Executor accept vague plans. If there's no concrete next step, they must call it out.
- Do **NOT** skip file output. The HTML report must be written to disk, not just displayed.
- Do **NOT** skip memory recording. Future councils should build on past decisions.

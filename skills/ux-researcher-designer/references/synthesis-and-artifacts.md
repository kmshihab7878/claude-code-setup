# Synthesis and Artifacts

Coding, clustering, prioritization, and reporting templates. Pair with
`references/research-workflow.md` for the synthesis workflow.

## Coding Scheme

Apply codes to every data point during the first read-through.

| Code | Captures |
|------|----------|
| `[GOAL]` | What the user wants to achieve |
| `[PAIN]` | What frustrates them |
| `[BEHAVIOR]` | What they actually do |
| `[CONTEXT]` | When/where they use the product |
| `[QUOTE]` | Direct user words |
| `[WORKAROUND]` | Hacks or alternate paths |
| `[MENTAL_MODEL]` | How they think the system works |

A pattern is only a pattern when it appears in ≥ 3 participants. Anything
below that is a hypothesis, not a finding.

## Affinity Clustering

1. Print or list every coded snippet.
2. Group snippets that "feel similar" without naming the group yet.
3. Once clusters stabilize, name each cluster with a noun phrase.
4. Note outliers — they often reveal a secondary persona or edge case.
5. Calculate segment sizes and viability.

| Cluster | Users | % | Viability |
|---------|-------|---|-----------|
| Power Users | 18 | 36% | Primary persona |
| Business Users | 15 | 30% | Primary persona |
| Casual Users | 12 | 24% | Secondary persona |
| One-off | 5 | 10% | Edge case |

## Finding Statement Template

```
FINDING: <One-sentence statement of the insight>

EVIDENCE:
- <Direct quote 1> — Participant <ID>
- <Direct quote 2> — Participant <ID>
- Frequency: <N of M> participants

BUSINESS IMPACT: <One-sentence link to a metric or goal>

RECOMMENDATION: <Specific, actionable next step>
```

Findings without evidence are opinions. Findings without business impact get ignored.

## Opportunity Prioritization

Two compatible scoring approaches:

### Frequency × Severity × Solvability

```
Priority Score = Frequency × Severity × Solvability   (1-5 each)
```

Highest score = address first. Score Solvability low when the fix requires
cross-team coordination or unproven technology.

### FBS-S (four-axis, 1-5)

| Factor | Score 1-5 |
|--------|-----------|
| Frequency | How often does this occur? |
| Severity | How much does it hurt? |
| Breadth | How many users affected? |
| Solvability | Can we fix this? |

Use FBS-S when the audience is product / executive — the four-factor format
maps cleanly to roadmap impact scoring.

## Persona Confidence

| Sample Size | Confidence | Use Case |
|-------------|------------|----------|
| 5-10 users | Low | Exploratory |
| 11-30 users | Medium | Directional |
| 31+ users | High | Production |

State the confidence level on every persona artifact. A persona without a
stated confidence level will be over-trusted by stakeholders.

## Usability Issue Severity

| Severity | Definition | Action |
|----------|------------|--------|
| 4 - Critical | Prevents task completion | Fix immediately |
| 3 - Major | Significant difficulty | Fix before release |
| 2 - Minor | Causes hesitation | Fix when possible |
| 1 - Cosmetic | Noticed but not problematic | Low priority |

Severity is a property of the user impact, not the implementation cost.
Keep the two judgments separate.

## Reporting Templates

### Research Readout (executive summary)

```
1. Research Question
2. Method + Sample (one paragraph)
3. Top 3 Findings (one paragraph each, with frequency)
4. Recommendations (table: recommendation | priority | owner)
5. Confidence Level + Limitations
```

### Persona One-Pager

```
Persona Name + Archetype
Quote
Demographics
Goals (3-5, prioritized)
Frustrations (with frequency counts)
Scenario (one paragraph)
Design Implications (3-5 bullets)
Sample size + confidence
```

### Journey Map One-Pager

```
Persona + Goal + Timeframe
Stages across the top
Layers down the side: Actions | Touchpoints | Emotions (1-5) |
                       Pain Points | Opportunities
Top 3 prioritized opportunities below the map
```

### Usability Test Report

```
1. Research Questions + Tasks
2. Participants (N, demographics, recruitment criteria)
3. Findings ranked by severity (4 → 1)
   - Each finding: description | evidence | severity | recommendation
4. Success metrics vs targets (table)
5. Verbatim quotes appendix
```

# UX Research Workflows

Step-by-step procedures for the four core workflows. The summaries live in
`SKILL.md`.

## Workflow 1: Generate User Persona

Situation: You have user data (analytics, surveys, interviews) and need to
create a research-backed persona.

### Step 1 — Prepare user data

Required format (JSON):

```json
[
  {
    "user_id": "user_1",
    "age": 32,
    "usage_frequency": "daily",
    "features_used": ["dashboard", "reports", "export"],
    "primary_device": "desktop",
    "usage_context": "work",
    "tech_proficiency": 7,
    "pain_points": ["slow loading", "confusing UI"]
  }
]
```

### Step 2 — Run persona generator

```bash
# Human-readable output
python scripts/persona_generator.py

# JSON output for integration
python scripts/persona_generator.py json
```

### Step 3 — Review generated components

| Component | What to Check |
|-----------|---------------|
| Archetype | Does it match the data patterns? |
| Demographics | Are they derived from actual data? |
| Goals | Are they specific and actionable? |
| Frustrations | Do they include frequency counts? |
| Design implications | Can designers act on these? |

### Step 4 — Validate persona

- Show to 3-5 real users: "Does this sound like you?"
- Cross-check with support tickets.
- Verify against analytics data.

## Workflow 2: Create Journey Map

Situation: visualize the end-to-end user experience for a specific goal.

### Step 1 — Define scope

| Element | Description |
|---------|-------------|
| Persona | Which user type |
| Goal | What they're trying to achieve |
| Start | Trigger that begins journey |
| End | Success criteria |
| Timeframe | Hours/days/weeks |

### Step 2 — Gather journey data

Sources:

- User interviews ("walk me through...").
- Session recordings.
- Analytics (funnel, drop-offs).
- Support tickets.

### Step 3 — Map the stages

Typical B2B SaaS stages:

```
Awareness → Evaluation → Onboarding → Adoption → Advocacy
```

### Step 4 — Fill in layers for each stage

```
Stage: [Name]
├── Actions: What does user do?
├── Touchpoints: Where do they interact?
├── Emotions: How do they feel? (1-5)
├── Pain Points: What frustrates them?
└── Opportunities: Where can we improve?
```

### Step 5 — Identify opportunities

`Priority Score = Frequency × Severity × Solvability`

## Workflow 3: Plan Usability Test

Situation: validate a design with real users.

### Step 1 — Define research questions

Transform vague goals into testable questions:

| Vague | Testable |
|-------|----------|
| "Is it easy to use?" | "Can users complete checkout in < 3 min?" |
| "Do users like it?" | "Will users choose Design A or B?" |
| "Does it make sense?" | "Can users find settings without hints?" |

### Step 2 — Select method

| Method | Participants | Duration | Best For |
|--------|--------------|----------|----------|
| Moderated remote | 5-8 | 45-60 min | Deep insights |
| Unmoderated remote | 10-20 | 15-20 min | Quick validation |
| Guerrilla | 3-5 | 5-10 min | Rapid feedback |

### Step 3 — Design tasks

Good task format:

```
SCENARIO: "Imagine you're planning a trip to Paris..."
GOAL: "Book a hotel for 3 nights in your budget."
SUCCESS: "You see the confirmation page."
```

Task progression: Warm-up → Core → Secondary → Edge case → Free exploration.

### Step 4 — Define success metrics

| Metric | Target |
|--------|--------|
| Completion rate | > 80% |
| Time on task | < 2× expected |
| Error rate | < 15% |
| Satisfaction | > 4/5 |

### Step 5 — Prepare moderator guide

- Think-aloud instructions.
- Non-leading prompts.
- Post-task questions.

Full moderator-guide template: `references/methods-and-templates.md`.

## Workflow 4: Synthesize Research

Situation: raw research data needs to become actionable insights.

### Step 1 — Code the data

Tag each data point:

- `[GOAL]` — what they want to achieve.
- `[PAIN]` — what frustrates them.
- `[BEHAVIOR]` — what they actually do.
- `[CONTEXT]` — when/where they use product.
- `[QUOTE]` — direct user words.

### Step 2 — Cluster similar patterns

```
User A: Uses daily, advanced features, shortcuts
User B: Uses daily, complex workflows, automation
User C: Uses weekly, basic needs, occasional

Cluster 1: A, B (Power Users)
Cluster 2: C (Casual User)
```

### Step 3 — Calculate segment sizes

| Cluster | Users | % | Viability |
|---------|-------|---|-----------|
| Power Users | 18 | 36% | Primary persona |
| Business Users | 15 | 30% | Primary persona |
| Casual Users | 12 | 24% | Secondary persona |

### Step 4 — Extract key findings

For each theme:

- Finding statement.
- Supporting evidence (quotes, data).
- Frequency (X / Y participants).
- Business impact.
- Recommendation.

### Step 5 — Prioritize opportunities

| Factor | Score 1-5 |
|--------|-----------|
| Frequency | How often does this occur? |
| Severity | How much does it hurt? |
| Breadth | How many users affected? |
| Solvability | Can we fix this? |

## Method Selection — extended

| Question Type | Best Method | Sample Size |
|---------------|-------------|-------------|
| "What do users do?" | Analytics, observation | 100+ events |
| "Why do they do it?" | Interviews | 8-15 users |
| "How well can they do it?" | Usability test | 5-8 users |
| "What do they prefer?" | Survey, A/B test | 50+ users |
| "What do they feel?" | Diary study, interviews | 10-15 users |
| "How does this evolve over time?" | Longitudinal / diary | 10-15 users, 2-4 weeks |
| "Is there a difference across segments?" | Segmented survey + targeted interviews | 50+ + 5 per segment |

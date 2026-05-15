# Methods and Templates

Interview, survey, usability test, and moderator-guide templates. Pair with
`references/research-workflow.md` for the workflows that consume them.

## Interview Question Types

| Type | Example | Use For |
|------|---------|---------|
| Context | "Walk me through your typical day" | Understanding environment |
| Behavior | "Show me how you do X" | Observing actual actions |
| Goals | "What are you trying to achieve?" | Uncovering motivations |
| Pain | "What's the hardest part?" | Identifying frustrations |
| Reflection | "What would you change?" | Generating ideas |
| Hypothetical | "If you had a magic wand..." | Surfacing latent needs (use sparingly) |

## Discovery Interview Template (60 min)

```
1. Warm-up (5 min)
   - Tell me about your role.
   - What does a typical week look like?

2. Context (10 min)
   - Walk me through how you currently solve X.
   - What tools/people are involved?

3. Tasks (25 min) — observe and ask
   - Show me how you would do X right now.
   - Where do you typically get stuck?
   - What workarounds have you built?

4. Goals + Pain (15 min)
   - What does success look like for you?
   - What's the hardest part?
   - What's the most time-consuming part?

5. Closing (5 min)
   - Anything I should have asked?
   - May I follow up if I have questions?
```

Always end with the "anything I should have asked" question — it consistently
surfaces material the script missed.

## Survey Template Patterns

### Single screener question

```
How often do you use [product] in a typical week?
[ ] Daily
[ ] 3-5 times
[ ] 1-2 times
[ ] Less than weekly
[ ] Never
```

### Frequency + severity pair (pain points)

```
For each issue, rate how often you encounter it AND how much it bothers you.

                              Frequency           Severity
                       (Never → Always)   (No problem → Critical)
Slow loading              1  2  3  4  5      1  2  3  4  5
Confusing navigation      1  2  3  4  5      1  2  3  4  5
```

### Open-ended at the end only

```
Is there anything else you wish [product] could do?
[__________________________________________]
```

## Usability Test — Moderator Guide

```
INTRO (5 min)
- Thank participant; restate consent; remind them we are testing the design,
  not them.
- Encourage think-aloud: "Tell me what you're thinking as you go."
- Note: video/audio recording confirmation.

TASKS (30-40 min)
- Read scenario.
- Read goal.
- Do NOT explain how to complete it.
- Do NOT correct misunderstandings until after the task (note for debrief).
- Probes (use sparingly):
   "What are you thinking right now?"
   "What did you expect to happen?"
   "Where would you go next?"

POST-TASK (5 min each)
- SEQ: "On a scale of 1-7, how easy was that?"
- "What was the hardest part?"
- "What would you change?"

DEBRIEF (5 min)
- "Overall, what stood out?"
- "What would you tell a friend about this?"
```

## Persona Archetypes

| Archetype | Signals | Design Focus |
|-----------|---------|--------------|
| power_user | Daily use, 10+ features | Efficiency, customization |
| casual_user | Weekly use, 3-5 features | Simplicity, guidance |
| business_user | Work context, team use | Collaboration, reporting |
| mobile_first | Mobile primary | Touch, offline, speed |

## Persona Components

| Component | Description |
|-----------|-------------|
| demographics | Age range, location, occupation, tech level |
| psychographics | Motivations, values, attitudes, lifestyle |
| behaviors | Usage patterns, feature preferences |
| needs_and_goals | Primary, secondary, functional, emotional |
| frustrations | Pain points with evidence (frequency counts) |
| scenarios | Contextual usage stories |
| design_implications | Actionable recommendations |
| data_points | Sample size, confidence level |

## Empathy Map Template

```
   THINK & FEEL                SEE
   - Worries                   - Environment
   - Aspirations               - Friends/colleagues use
   - Beliefs                   - Market offerings

   ----------------- USER ------------------

   HEAR                        SAY & DO
   - From boss / peers         - Attitude in public
   - From friends              - Appearance / behavior
   - Influencers               - What they tell others

   PAIN                        GAIN
   - Fears                     - Wants/needs met
   - Frustrations              - Success measures
   - Obstacles                 - Strategies to win
```

Fill from interview data, not assumptions. Cite at least one data point per cell.

## Journey-Map Layer Template

```
Stage: <name>
Persona: <persona name>

Actions:        <what the user is doing>
Touchpoints:    <where the interaction happens>
Emotions (1-5): <emotion + 1-5 score>
Pain Points:    <verbatim or summarized frustrations>
Opportunities:  <design opportunities, with priority score>
```

## Tool Reference — persona_generator.py

| Argument | Values | Default | Description |
|----------|--------|---------|-------------|
| format | (none), json | (none) | Output format |

See `references/examples.md` for a sample output.

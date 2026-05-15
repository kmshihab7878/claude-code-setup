# Examples — UX Artifacts

Worked outputs for each artifact the skill produces.

## Persona Output (persona_generator.py)

```
============================================================
PERSONA: Alex the Power User
============================================================

A daily user who primarily uses the product for work purposes.

Archetype: Power User
Quote: "I need tools that can keep up with my workflow"

Demographics:
  - Age Range: 25-34
  - Location Type: Urban
  - Tech Proficiency: Advanced

Goals & Needs:
  - Complete tasks efficiently
  - Automate workflows
  - Access advanced features

Frustrations:
  - Slow loading times (14/20 users)
  - No keyboard shortcuts (11/20 users)
  - Limited API access (8/20 users)

Design Implications:
  - Optimize for speed and efficiency
  - Provide keyboard shortcuts and power features
  - Expose API and automation capabilities

Data: Based on 45 users
Confidence: High
```

## Journey Map Snippet

```
Persona: Alex (Power User)
Goal: Set up a new dashboard for weekly reporting
Timeframe: 30 minutes

| Stage          | Actions                | Touchpoints     | Emotions | Pain                       | Opportunities                                  |
|----------------|------------------------|-----------------|----------|----------------------------|------------------------------------------------|
| Awareness      | Hears from colleague   | Internal chat   | 4/5      | Doesn't know capabilities  | In-product feature spotlight                   |
| Onboarding     | Creates account, tour  | Web app, email  | 3/5      | Tour too long, irrelevant  | Skip-able tour with role-tailored shortcuts    |
| First setup    | Builds first dashboard | Web app         | 2/5      | Cannot find widget library | Quick-start templates + searchable widget tray |
| Adoption       | Schedules weekly run   | Web app         | 4/5      | Schedule UI hidden         | Surface schedule action on dashboard header    |
| Advocacy       | Shares with team       | Slack, email    | 5/5      | Sharing flow asks for role | Pre-filled team list from workspace            |

Top 3 prioritized opportunities (Frequency × Severity × Solvability):
1. Quick-start templates (score 64)
2. Surface schedule action (score 45)
3. Skip-able tour (score 40)
```

## Usability Test Findings (severity-ranked)

```
Finding 1 (Severity 4 — Critical)
  Users could not complete checkout when payment method dropdown was empty.
  Evidence: 5/8 participants gave up; P03 said "I thought it was broken."
  Recommendation: pre-select default payment method; add "+ Add payment" affordance.

Finding 2 (Severity 3 — Major)
  Users misinterpreted the "Continue" button as "Finish" on step 2 of 3.
  Evidence: 4/8 participants hesitated; 2 navigated back to check.
  Recommendation: label button "Continue to review (2 of 3)".

Finding 3 (Severity 2 — Minor)
  Users questioned the meaning of "express" shipping vs "priority".
  Evidence: 3/8 participants asked aloud; 1 opened FAQ.
  Recommendation: inline tooltip with delivery time and price delta.
```

## Research Readout (executive summary)

```
Research Question
  How do power users discover and adopt new features?

Method + Sample
  8 moderated 60-minute interviews + analytics review (N=4,200 users).
  Power-user segment defined as daily-active + 10+ features used in 30 days.

Top Findings
  1. Discovery is colleague-driven, not in-product (7/8). Power users learn
     about new features from a peer or community post within 14 days of
     release; in-product cues are noticed in 2/8 cases.
  2. Setup friction kills adoption (6/8). Median first-setup attempt is
     abandoned within 4 minutes when no template exists.
  3. Schedule/automation is invisible (5/8). The schedule action sits in a
     secondary menu and is the single most missed power-user feature.

Recommendations
  | Recommendation                | Priority | Owner       |
  |-------------------------------|----------|-------------|
  | Quick-start dashboard templates| P1      | Dashboards  |
  | Surface schedule on header    | P1       | Reporting   |
  | In-product feature spotlight  | P2       | Growth      |

Confidence: Medium (N=8 qual + 4200 quant). Refresh in 6 months.
```

## Synthesis Finding (single)

```
FINDING: Power users abandon dashboard setup when no starting template exists.

EVIDENCE:
- "I had no idea where to even begin" — P02
- "I just gave up and asked Slack for a template" — P05
- Frequency: 6 of 8 participants

BUSINESS IMPACT: First-week dashboard creation correlates 2.3x with 90-day
retention in the power-user segment.

RECOMMENDATION: Ship 4-6 quick-start templates segmented by role; surface them
above the empty-state on first dashboard creation.
```

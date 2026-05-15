# Privacy, Validation, and Troubleshooting

Consent and privacy rules, per-artifact validation, and anti-patterns.

## Privacy and Consent

Research data is PII by default. Treat it as such even when the analysis
artifacts are anonymized.

### Pre-research

- Obtain explicit, recorded consent before any session.
- State purpose, recording, retention, anonymization, and right to withdraw.
- Confirm jurisdiction-specific requirements (e.g., GDPR consent basis, CCPA
  notice, COPPA for users under 13).
- Compensation must be disclosed up front and unconditional on completing the session.

### During research

- Confirm consent on recording before starting capture.
- Allow withdrawal without penalty at any point.
- Mask sensitive data (names, account numbers, addresses) on screen-share
  before recording.

### Post-research

- Redact direct identifiers in transcripts and artifacts.
- Use participant IDs (P01, P02), not names.
- Apply the retention window stated in consent. Default: 90 days raw, 12 months redacted.
- Store recordings in access-controlled storage.
- Never paste raw participant data into shared chat tools or third-party LLMs
  without an explicit data-handling check.

### Off-limits content

Never produce:

- Re-identification of pseudonymized participants.
- Quotes attributed by name when consent was anonymous.
- Demographic claims that effectively single out an individual in a small segment.
- Decisions to share recordings outside the team listed in the consent.

## Validation Checklists

### Persona Quality

- [ ] Based on 20+ users (minimum).
- [ ] At least 2 data sources (quant + qual).
- [ ] Specific, actionable goals.
- [ ] Frustrations include frequency counts.
- [ ] Design implications are specific.
- [ ] Confidence level stated.

### Journey Map Quality

- [ ] Scope clearly defined (persona, goal, timeframe).
- [ ] Based on real user data, not assumptions.
- [ ] All layers filled (actions, touchpoints, emotions, pain, opportunity).
- [ ] Pain points identified per stage.
- [ ] Opportunities prioritized.

### Usability Test Quality

- [ ] Research questions are testable.
- [ ] Tasks are realistic scenarios, not instructions.
- [ ] 5+ participants per design.
- [ ] Success metrics defined.
- [ ] Findings include severity ratings.

### Research Synthesis Quality

- [ ] Data coded consistently.
- [ ] Patterns based on 3+ data points.
- [ ] Findings include evidence.
- [ ] Recommendations are actionable.
- [ ] Priorities justified.

## Anti-Patterns

| Anti-Pattern | Why it harms | Fix |
|--------------|--------------|-----|
| Persona-of-one | Built from a single power user or stakeholder opinion | Require 20+ users + 2 data sources |
| Demographic shell | Demographics only, no goals/pain/behaviors | Run the persona components checklist |
| Leading interview questions | Confirms hypotheses rather than uncovering reality | Use open-ended Context/Behavior/Goals/Pain prompts |
| Task as instruction | "Click the X button" — measures instruction-following, not usability | Rewrite as scenario + goal + success criterion |
| Hypothesis-stretched cluster | Cluster of 1-2 promoted to persona | Apply the ≥ 3 participants rule |
| Findings without evidence | "Users want simpler UI" with no quotes or frequency | Require quote + frequency + business impact |
| Unprioritized opportunities | "Here are 47 opportunities" | Score with Frequency × Severity × Solvability; ship top 3-5 |
| Demographic single-out | A redacted persona that still identifies a real user | Coarsen demographics; combine segments; remove direct identifiers |
| Sample size for show | N=200 reported but unrepresentative | State sampling method + confidence level |
| Stale persona | Persona from 18+ months ago still being cited | Add refresh date; review every 6-12 months |

## Troubleshooting

| Symptom | Likely cause | Fix |
|---------|--------------|-----|
| Persona feels generic | Sample too small, or all signals collapsed into one archetype | Increase N; cluster into 2-3 personas instead of 1 |
| Stakeholders ignore the persona | No business impact stated; no quotes | Add business-impact line; pull 2-3 direct quotes |
| Journey map disagreed with by sales | Mapped from internal assumption, not interviews | Re-base on 5+ recent customer interviews |
| Usability test results contradict analytics | Sample bias or task framing issue | Compare task framing; re-run with broader recruitment |
| "Power users want X" but X is rarely used | Mistaking vocal users for representative users | Cross-check with analytics on actual feature use |
| Findings repeat the brief | The team's prior beliefs leaked into the synthesis | Run a blind re-cluster with a peer |

## When to Escalate

- Findings imply a regulated decision (accessibility compliance, age-gating,
  consent flows) — pull in legal/compliance.
- Findings imply changes to data collection or retention — pull in privacy/CISO.
- Findings contradict a recently shipped major decision — surface to product
  leadership before publishing the report.

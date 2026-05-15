# Decision Frameworks and Synthesis

Chairman synthesis structure, confidence scoring, and the decision patterns
the chairman applies. Pair with `references/council-workflow.md` Phase 4.

## Chairman Synthesis Structure

The chairman produces six elements, in this order:

1. **Executive Summary** — one paragraph, the decision distilled.
2. **Clear Recommendation** — specific and unambiguous. No "it depends".
3. **Confidence Score** — HIGH / MEDIUM / LOW with rationale.
4. **One Concrete Next Step** — Monday morning action, named.
5. **Major Risks** — 2-3 risks with mitigation.
6. **Hidden Opportunities** — 1-2 opportunities the user likely hadn't considered.

## Confidence Score Framework

| Score | Threshold | Conditions |
|-------|-----------|------------|
| **HIGH** | > 85% | Strong consensus across advisors, hard data supports the conclusion, low downside risk if wrong |
| **MEDIUM** | 50–85% | Split advisor opinions or incomplete data, but the weight of evidence favors one direction |
| **LOW** | < 50% | Genuine uncertainty. Recommendation is a best-guess; consider a follow-up council after gathering more data |

### When to drop confidence

- The Intelligence Brief flagged significant Data Gaps that the advisors
  could not work around → drop one band.
- The Contrarian surfaced a fatal flaw with no proposed mitigation → drop one band.
- All five advisors agreed unanimously → check for groupthink; if the
  agreement is suspicious, drop one band.
- Reviewers' Q3 surfaced a collective miss that materially changes the
  decision → drop one band.

### When to hold or raise confidence

- Hard data (numbers, metrics) supports the recommendation directly → hold or raise.
- The Executor produces a concrete Monday-morning step that the user can
  execute today → hold.
- Past council decisions (from semantic memory) align with this one → hold.

## Decision Patterns

The chairman classifies the decision shape before synthesizing. Each shape
has a default synthesis pattern.

### Binary go / no-go

The advisors implicitly vote yes or no. Chairman:

- Counts the implicit votes.
- Weights by the strength of evidence each advisor brought.
- States the recommendation in one sentence ("Go", "No-go", "Defer").
- Names the one condition under which the answer flips.

### A-vs-B selection

Two viable options are on the table. Chairman:

- Builds a one-paragraph comparison from advisor data.
- Names the dimension on which the options differ most.
- Recommends the option that wins on the most-weighted dimensions.
- Flags the dimensions where the rejected option is genuinely better.

### Multi-option / open-ended

More than two viable paths. Chairman:

- Eliminates dominated options first (any option that another option beats
  on every dimension).
- Reduces to A-vs-B if possible.
- If three or more options survive, ranks them and recommends the top one
  with the explicit rejection rationale for the others.

### Strategic direction (no immediate action)

The decision is about positioning, not action. Chairman:

- Frames the recommendation as a stance, not a step.
- Adds a "tripwire" — the signal that would invalidate the stance.
- Asks the Executor to translate the stance into a 30-60-90 day plan in
  Phase 6 follow-up.

## Synthesis Discipline

- **Pick a side.** The chairman does not say "it depends" or "consider both."
  If the data genuinely supports both, default to the option with the lower
  reversibility cost.
- **Reference data, not vibes.** Every claim in the synthesis must be
  traceable to an advisor response or the Intelligence Brief.
- **Address the collective miss.** Phase 3 Q3 always surfaces at least one
  insight none of the advisors had. The synthesis must integrate this.
- **Name the Monday morning step.** If the chairman cannot name a concrete
  first step, the recommendation is incomplete — re-run synthesis.
- **Honor dissent.** If the Contrarian's flaw is unresolved, surface it in
  Major Risks with a mitigation that the user can verify.

## Tone Discipline (chairman-specific)

- Decisive and neutral. Picks a side; does not flatter the user.
- No "great question," "pros and cons," "depends on your goals."
- If the decision is clearly bad, say so. If it's clearly good, say so.

## Disagreement Resolution Within the Synthesis

When advisors disagree:

- **Contrarian vs Expansionist** — typically resolves to: take the
  Expansionist's opportunity *only* after the Contrarian's risk is mitigated.
- **First Principles vs Executor** — typically resolves to: rebuild the
  problem as First Principles describes, then ship the Executor's
  Monday-morning step toward that rebuilt problem.
- **Outsider vs everyone** — if the Outsider couldn't follow the problem,
  the user's framing is unclear and the recommendation must include a
  clarification step before action.

If two advisors stake equally strong positions and the data is genuinely
silent, default to the lower-reversibility option and add a tripwire.

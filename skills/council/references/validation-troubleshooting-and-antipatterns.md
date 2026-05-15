# Validation, Troubleshooting, and Anti-Patterns

Validation gates per phase, anti-patterns with detection and remediation,
and a debugging playbook for council runs that go off-rails.

## Validation Gates

A council run must clear all six gates before the chairman delivers.

| Gate | When | Pass criterion |
|------|------|----------------|
| Phase 0 | After Intelligence Brief | Brief ≤ 300 words; Data Gaps section is honest, not empty |
| Phase 1 | After context summary | 2-3-sentence summary names the core decision and the deciding stakeholder |
| Phase 2 | After all five advisors | Each advisor 300-600 words; each references Intelligence Brief data; no two advisors converge to the same position |
| Phase 3 | After peer review | All five reviewers answered Q1, Q2, Q3; Q3 surfaced at least one collective miss |
| Phase 4 | After chairman synthesis | Recommendation is specific; confidence is one of HIGH/MEDIUM/LOW with rationale; Monday-morning step is named |
| Phase 5 | Before delivery | HTML written to disk; transcript ends with mapping; Obsidian skipped silently if unreachable |

Skipping any gate is grounds to rerun the affected phase, not to proceed.

## Anti-Patterns

The bold "do not" list in `SKILL.md` is the runtime guardrail; this section
explains the failure mode behind each and how to detect it.

### Skipping Phase 0 intelligence gathering

- **Failure mode**: advisors argue from vibes; the Contrarian becomes generic;
  the Outsider can't tell what's actually unclear.
- **Detection**: advisor responses contain no specific numbers or named facts.
- **Fix**: pause the council, run Phase 0, rerun Phase 2.

### Skipping peer review

- **Failure mode**: groupthink. The five advisors converge on a comfortable
  recommendation; the user gets validation, not insight.
- **Detection**: chairman synthesis has no "collective miss" element.
- **Fix**: rerun Phase 3; require Q3 to produce a non-trivial insight.

### Revealing the anonymization mapping early

- **Failure mode**: reviewers default to known advisor identities and recycle
  the original arguments instead of evaluating them.
- **Detection**: a reviewer's text references "the Contrarian" by name before
  the mapping is revealed.
- **Fix**: redact the leak; rerun the affected reviewer; reinforce the
  end-of-transcript-only mapping rule.

### Advisors converging

- **Failure mode**: divergence is the council's purpose. Two advisors with
  the same conclusion is one wasted advisor.
- **Detection**: two advisor responses recommend the same action with the
  same reasoning.
- **Fix**: force the divergent advisor to apply their lens harder. If the
  Expansionist agrees with the Contrarian, the Expansionist hasn't found
  the upside yet — make them work.

### Generic advice

- **Failure mode**: response could apply to any decision in the domain.
  Provides no insight specific to this question.
- **Detection**: response can be cut-and-pasted onto a different question
  without changing.
- **Fix**: require references to specific Intelligence Brief items in every
  paragraph.

### Soft Contrarian

- **Failure mode**: the Contrarian hedges or apologizes. The user gets a
  polite warning instead of a clear flaw.
- **Detection**: phrases like "you might want to consider", "it could
  potentially be the case that".
- **Fix**: rerun with the Contrarian explicitly told to be brutal. Their
  job is to find problems, not be polite about it.

### Executor accepting vague plans

- **Failure mode**: chairman's "Monday morning step" is "think about X" or
  "consider Y" — not actionable.
- **Detection**: the next step does not name a tool, deliverable, or person.
- **Fix**: rerun the Executor with the explicit demand for a concrete action.
  If none exists, the recommendation itself is incomplete.

### Skipping file output

- **Failure mode**: HTML report not written to disk; the user has no
  artifact to revisit or share.
- **Detection**: no file path reported in Phase 6.
- **Fix**: write the file before declaring complete.

### Skipping memory recording

- **Failure mode**: future councils start from zero; the same flaws get
  re-discovered.
- **Detection**: no `mcp__memory__create_entities` call in Phase 6.
- **Fix**: always write the decision record in Phase 6, even for LOW-confidence outcomes.

## Troubleshooting Recipes

| Symptom | First check | Likely cause |
|---------|-------------|--------------|
| Advisors all agree | Phase 2 outputs | Domain wasn't applied to advisor lens; each advisor used the same default |
| Reviewers picked the same "strongest" | Phase 3 outputs | Anonymization shuffle was insufficient or response quality was uniformly low |
| Chairman says "it depends" | Phase 4 synthesis | Confidence framework not applied; force HIGH/MEDIUM/LOW and a recommendation |
| HTML report not written | Phase 5 step 1 | Directory creation failed silently; check `~/.claude/council-reports/` permissions |
| Obsidian step errored | Phase 5 step 2 | MCP unreachable; skip silently, do not block the rest of Phase 5 |
| Monday-morning step is vague | Phase 4 element 4 | Executor didn't push hard enough; rerun with explicit demand for tool + deliverable |
| Council ran without Intelligence Brief | Phase 0 | Trigger phrase fired without classifying domain first; pause and run Phase 0 |
| Confidence labeled HIGH but disagreement was real | Phase 4 confidence | Confidence framework not honored; drop one band per the rules |

## Recovery Procedures

### Partial advisor failure (one advisor empty)

If a single advisor produces a stub or empty response, rerun that advisor
alone with the Intelligence Brief and explicit role prompt. Do not collapse
to four advisors — the lens diversity is the value.

### Reviewer Q3 produces nothing

If every reviewer's Q3 ("collective miss") is empty or generic, the panel
agreed too easily. Either rerun Phase 2 with stronger divergence prompts,
or rerun Phase 3 explicitly demanding at least one non-obvious insight.

### Chairman synthesis contradicts evidence

If the chairman's recommendation contradicts the dominant advisor signal,
re-read the Intelligence Brief and advisor responses; either the chairman
mis-weighted evidence, or the dominant signal is actually wrong and the
chairman is correct. State the conflict openly in the synthesis.

### MCP outage mid-run

- Intelligence-Brief MCPs unreachable → state the data gap and proceed with
  reduced confidence.
- Sequential-thinking MCP unreachable → fall back to direct synthesis.
- Obsidian MCP unreachable → skip silently in Phase 5.
- Memory MCP unreachable in Phase 6 → record the decision in a local file
  and surface the failure to the user.

Never silently degrade quality — always state the gap.

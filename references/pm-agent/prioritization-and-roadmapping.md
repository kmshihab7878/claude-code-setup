# Prioritization and Roadmapping — sprint ceremonies and key actions

Sprint ceremony patterns, key PM actions (post-implementation, mistake
documentation, pattern extraction, monthly pruning, knowledge-base evolution),
and the focus areas catalog.

## Sprint Ceremony Patterns

### Planning

- Review last 3 sprints' velocity.
- Tasks estimable in < 8h.
- Every story has acceptance criteria.
- Reserve 20% capacity for bugs / tech debt / unplanned.

### Daily standup (async)

- Done / Doing / Blocked, 2-3 bullets each.
- Flag blockers immediately.
- Update the task board before standup.

### Review

- Demo working software (not slides).
- Collect feedback in structured form.
- Link demo items to sprint goal + acceptance criteria.

### Retrospective

- Start / Stop / Continue or 4Ls (Liked / Learned / Lacked / Longed-for).
- ≤ 3 actionable improvements per retro.
- Assign owner + deadline.
- Review previous actions at the start of the next retro.

## Five Key Actions (full detail)

### 1. Post-implementation recording

- Identify new patterns / decisions.
- Document in appropriate `docs/*.md`.
- Update `CLAUDE.md` if global.
- Record edge cases.
- Note integration points.

Template:

- What was implemented.
- Why.
- Alternatives considered.
- Edge cases handled.
- Lessons learned.

### 2. Immediate mistake documentation

- Halt further implementation.
- Root cause analysis.
- Document with:
  - What Happened (現象).
  - Root Cause (根本原因).
  - Why Missed (なぜ見逃したか).
  - Fix Applied (修正内容).
  - Prevention Checklist (防止策).
  - Lesson Learned (教訓).

### 3. Pattern extraction

- Recurring successful approaches.
- Common mistake patterns.
- Working architecture patterns.

Extract to:

- Reusable form.
- Pattern library.
- `CLAUDE.md` (global patterns only).
- Examples / templates.

### 4. Monthly documentation pruning

Review:

- Docs older than 6 months.
- No-reference files.
- Duplicate or overlapping content.

Actions:

- Delete unused.
- Merge duplicates.
- Update versions / dates.
- Fix broken links.
- Reduce verbosity.

### 5. Knowledge base evolution

- **`CLAUDE.md`** — global patterns and anti-patterns.
- **Project docs** — new patterns, refinements, examples.
- **Quality standards** — Latest, Minimal, Clear, Practical.

## Focus Areas

### Implementation documentation

Patterns, decision rationale, edge cases, integration points.

### Mistake analysis

Root causes, prevention checklists, recurring patterns, immediate recording.

### Pattern recognition

- Success patterns (what + why).
- Anti-patterns (what didn't work + alternatives).
- Best practices (codified).
- Context mapping (when patterns apply).

### Knowledge maintenance

Monthly review, noise reduction, duplicate merging, freshness updates.

### Self-improvement loop

Continuous learning, feedback integration, quality evolution, cross-project synthesis.

## Outputs

| Output | What it contains |
|--------|------------------|
| Implementation documentation | Pattern documents, decision records, edge-case solutions, integration guides |
| Mistake analysis reports | Root cause analysis, prevention checklists, recurring patterns, lesson summaries |
| Pattern library | Best practices in `CLAUDE.md`, anti-patterns, architecture patterns, reusable code templates |
| Monthly maintenance reports | Documentation health, pruning results, update summary, noise reduction |

## Performance Metrics

### Documentation coverage

- % of implementations documented.
- Time from implementation to documentation.

### Mistake prevention

- % of recurring mistakes.
- Time to document.
- Checklist effectiveness.

### Knowledge maintenance

- Documentation age distribution.
- Reference frequency.
- Signal-to-noise ratio.

### Quality evolution

- Freshness.
- Example recency.
- Link validity rate.

## Connection to Global Self-Improvement

PM Agent implements principles from `~/.claude/CLAUDE.md`, project-level
`CLAUDE.md`, and `docs/self-improvement-workflow.md`. Ensures:

- Knowledge accumulates over time.
- Mistakes are not repeated.
- Documentation stays fresh and relevant.
- Best practices evolve continuously.

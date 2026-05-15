# Examples — output schemas and a worked council run

Full output templates for Phase 5 plus a sketch of a complete council run.

## Output 1: HTML Report — full schema

Saved to disk at:

```
~/.claude/council-reports/council-<YYYY-MM-DD>-<slug>.html
```

Where `<slug>` is a 3-4 word kebab-case summary of the question (e.g.,
`should-we-migrate-to-k8s`). Create the directory if it doesn't exist.
Write the file using the Write tool. Also display the HTML inline.

### Structure

- **Header** — "Council Report" with the date, question, and domain badge.
- **Intelligence Brief Box** — summary of Phase 0 data, collapsed by default
  using `<details>`.
- **Question Box** — the decision being counciled, prominently displayed.
- **Five Advisor Cards** — each advisor's name, role tagline, and key points
  (use the real names, not letters).
- **Peer Review Section** — summarized reviewer findings (aggregated themes,
  not all 15 individual answers).
- **Chairman Verdict Box** — highlighted/accented box with the recommendation
  + confidence score badge.
- **Next Step Box** — button-style prominent box with the one concrete
  Monday-morning action.
- **Prior Decisions** — if any past council decisions were referenced,
  link/note them.

### Design guidelines

- Clean, professional, dark header with light body.
- Color-coded advisor cards (each advisor gets a distinct accent color).
- Chairman verdict box gets a strong accent: green for HIGH confidence,
  amber for MEDIUM, red for LOW.
- Next-step box gets an action color (orange or amber).
- Confidence badge: colored pill showing HIGH/MEDIUM/LOW.
- Domain badge in header showing the classified domain.
- Responsive layout, readable on mobile.
- Use system fonts (no external font dependencies).
- Self-contained inline styles — no external stylesheet.

## Output 2: Obsidian Note — full schema

Path:

```
Council Reports/council-<YYYY-MM-DD>-<slug>.md
```

Tool:

```
mcp__obsidian__write_note
```

Frontmatter:

```yaml
tags: [council, <domain>]
date: <YYYY-MM-DD>
domain: <classified domain>
confidence: <HIGH|MEDIUM|LOW>
recommendation: <one-line recommendation>
```

Body: chairman synthesis + recommendation + next step + condensed advisor
summary (not the full transcript).

If the Obsidian MCP fails (server not running, vault not accessible),
skip silently — do not error.

## Output 3: Markdown Transcript

Full raw transcript:

- Intelligence Brief.
- All five advisor responses (real names).
- All five reviewer responses.
- Chairman reasoning, verdict, and confidence score.
- At the very end, a small note:
  `**Mapping for transparency:** A=[Name], B=[Name], C=[Name], D=[Name], E=[Name]`.

## Worked Run — sketch

The example below shows the shape of a complete run. Quoted text is
illustrative, not a literal template.

### Trigger

> User: `pressure-test this: should we migrate the analytics service to Kubernetes this quarter?`

### Phase 0 — Intelligence Brief (≤ 300 words)

- **Domain**: infrastructure.
- **Hard Data**: current service runs on a single EC2; deployment via SSH +
  shell script; 14 incidents in last 90 days, 11 are deploy-related;
  monthly cost $480; team is 3 backend, 0 DevOps.
- **Prior Decisions**: 2025-11-10 council recommended consolidating
  observability stack; that work is 80% complete.
- **Known Context**: company runs no other Kubernetes workloads today.
- **Data Gaps**: no actual capacity forecast for next 12 months; no SLO targets.

### Phase 1 — Context summary

> "Decision is whether to move the analytics service to Kubernetes this
> quarter. The driver is deploy reliability (11 of 14 recent incidents);
> the constraint is no in-house Kubernetes expertise."

### Phase 2 — Five advisors (300-600 words each)

- **Contrarian** — fatal flaw: introducing Kubernetes adds an unfamiliar
  failure surface to a team with no operator. Deploy reliability is a
  shell-script problem, not a platform problem.
- **First Principles** — strips to: "we want fewer deploy incidents."
  Kubernetes is one path; managed CI/CD with the existing stack is another.
- **Expansionist** — if Kubernetes lands well, it unlocks autoscaling,
  multi-service consolidation, and a faster onboarding path for future hires.
- **Outsider** — questions why analytics is on a single EC2 at this scale;
  asks what the SLO is and why there isn't one.
- **Executor** — Monday morning: write the deploy script as a one-page
  postmortem of the last 11 incidents. Three cheap fixes (lockfile, health
  check, rollback flag) likely resolve 8 of 11.

### Phase 3 — Anonymized peer review

Reviewers run on shuffled letters A-E. Q3 surfaces: "None of the advisors
asked what migrating buys that managed CI + the three cheap fixes wouldn't."

### Phase 4 — Chairman synthesis

- **Executive Summary**: deploy-reliability problem is a shell-script
  problem first. Kubernetes might be right later — not this quarter.
- **Recommendation**: defer Kubernetes migration; ship the three cheap
  deploy fixes this sprint; revisit Kubernetes after 90 days of incident data.
- **Confidence**: MEDIUM. Strong advisor signal; data gap on capacity forecast.
- **Next Step**: open a PR with the lockfile + healthcheck + rollback flag
  changes; owner is the senior backend engineer; deliverable is a green
  deploy of the existing service by Friday.
- **Major Risks**: (1) cheap fixes don't address all 11 incidents; mitigation:
  track residual incident rate for 30 days. (2) capacity may force the
  migration regardless; mitigation: build the capacity forecast in parallel.
- **Hidden Opportunities**: the deploy script postmortem could be reused
  for two other services with similar pain.

### Phase 5 — Output

HTML written to `~/.claude/council-reports/council-2026-05-15-defer-k8s-migration.html`.
Obsidian note created (vault available). Transcript ends with mapping reveal.

### Phase 6 — Follow-up

- Tasks created for the three deploy fixes (lockfile, healthcheck, rollback flag).
- Memory entity created: `Council: defer-k8s-migration` with HIGH-confidence
  Recommendation + MEDIUM Confidence + Domain=infrastructure.
- User told: HTML report at `~/.claude/council-reports/council-2026-05-15-defer-k8s-migration.html`.

## Slug Generation

The `<slug>` should be 3-4 kebab-case words capturing the decision verb +
subject. Examples:

| Question | Slug |
|----------|------|
| "Should we migrate analytics to Kubernetes?" | `defer-k8s-migration` (after decision) or `should-we-k8s-analytics` (pre-decision) |
| "Hire a senior platform engineer now?" | `hire-senior-platform-now` |
| "Sunset the legacy pricing API?" | `sunset-legacy-pricing-api` |

Prefer the decision-resolved slug when possible — easier to scan in the
report directory later.

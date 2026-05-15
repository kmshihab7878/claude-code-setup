# Architecture and Platform — CTO Reference

Strategy, ADR templates, technology evaluation, and platform/vendor frameworks.

## Technology Strategy

Strategy is the bridge from business priorities to engineering investment.

| Component | What it answers |
|-----------|-----------------|
| Technology vision (3-year) | Where the platform is going |
| Architecture roadmap | What to build, refactor, or replace |
| Innovation budget | 10–20% of engineering capacity for experimentation |
| Build vs buy stance | Default: buy unless it is core IP |
| Technical debt strategy | Management, not elimination |

A strategy without an explicit innovation budget defaults to 0%, and the team
loses the ability to learn at the rate the market changes.

## Architecture Decision Records (ADRs)

ADRs exist to make significant decisions discoverable, contestable, and
supersedable. The CTO's job is to create the framework for good decisions —
not to make every decision personally.

### ADR Template

```text
Title: [Short noun phrase]
Status: Proposed | Accepted | Superseded by ADR-NNN
Date: YYYY-MM-DD
Authors: [names]

Context
-------
What is the problem? What constraints (technical, business, regulatory)
shape this decision? What does success look like?

Options Considered
------------------
Option A — [description]
  - TCO (3-year): $X
  - Risk: Low | Medium | High
  - Reversibility: Easy | Hard | One-way

Option B — [description]
  - TCO (3-year): $Y
  - Risk: Low | Medium | High
  - Reversibility: Easy | Hard | One-way

Option C — Do nothing / status quo
  - Why this is a real option
  - What we forgo by choosing it

Decision
--------
[Chosen option and the specific factors that decided it]

Consequences
------------
- What becomes easier
- What becomes harder
- What we will need to revisit, and when
- Migration path if we need to reverse
```

### Decision Governance

- Every significant decision gets documented: context, options, decision, consequences.
- Decisions are discoverable — committed to the repository, not buried in chat.
- Decisions can be superseded — supersession produces a new ADR linking the old one.
- ADRs are reviewed in the architecture sync; objections produce comments,
  not vetoes.

## Technology Evaluation Framework

Use this framework when comparing technologies (databases, queues, frameworks,
vendors) for an architectural decision.

### Four-axis Evaluation

| Axis | Question |
|------|----------|
| Problem fit | Does it solve the actual problem we have today and the next one we will have? |
| Operational maturity | Are run-books, monitoring patterns, and on-call expertise readily available? |
| Reversibility | If we are wrong, can we migrate away within one quarter? |
| Total cost (3 year) | License + integration + maintenance + opportunity cost |

### Technology Radar

Categorize each candidate technology:

- **Adopt** — proven for our context; recommended default.
- **Trial** — adopt for a bounded pilot with success criteria.
- **Assess** — interesting; track but do not commit yet.
- **Hold** — known issues for our context; do not start new work here.

Refresh the radar each quarter. Move items between rings only with evidence.

## Vendor and Platform Management

Every vendor is a dependency. Every dependency is a risk.

### Evaluation Criteria

| Criterion | Check |
|-----------|-------|
| Real problem | Does the vendor solve a real problem we measured, or one we imagined? |
| Migration path | Can we migrate away in one quarter without rewriting customers? |
| Vendor stability | Funding, customer concentration, key-person risk |
| Total cost | License + integration + maintenance + lock-in tax |
| Data portability | Can we get our data back in a usable format? |

### Lock-in Posture

- Prefer vendors that support open standards (e.g., S3 API, OpenTelemetry).
- Avoid vendors whose pricing escalates faster than your usage.
- For each strategic vendor, document a 90-day "what if they disappear" plan.

## Platform Engineering

Platform investments amplify every engineer that touches them. Treat them as
products with users, not as side effects of feature work.

| Indicator | Healthy signal |
|-----------|----------------|
| Developer experience | Onboarding to first deploy < 1 day |
| Self-service | Engineers ship without filing a ticket |
| Adoption | Net-promoter score from internal users > 30 |
| Cost | Cloud spend per engineer trending flat or down |

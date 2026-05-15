# CTO Advisory Workflows

Detailed step-by-step procedures for the three core CTO advisory workflows.
The summaries live in `SKILL.md`.

## Tech Debt Assessment Workflow

### Step 1 — Run the analyzer

```bash
python scripts/tech_debt_analyzer.py --output report.json
```

### Step 2 — Interpret results

The analyzer produces a severity-scored inventory. Review each item against:

- **Severity (P0–P3)**: how much is it blocking velocity or creating risk?
- **Cost-to-fix**: engineering days estimated to remediate.
- **Blast radius**: how many systems / teams are affected?

### Step 3 — Build a prioritized remediation plan

Sort by: `(Severity × Blast Radius) / Cost-to-fix` — highest score = fix first.

Group items into:

1. Immediate sprint.
2. Next quarter.
3. Tracked backlog.

### Step 4 — Validation checkpoint

Before presenting to stakeholders:

- [ ] Every P0/P1 item has an owner and a target date.
- [ ] Cost-to-fix estimates reviewed with the relevant tech lead.
- [ ] Debt ratio calculated: maintenance work / total engineering capacity (target: < 25%).
- [ ] Remediation plan fits within capacity — do not promise 40 points of debt
  reduction in a 2-week sprint.

## ADR Creation Workflow

### Step 1 — Identify the decision

Trigger an ADR when the decision:

- Affects more than one team.
- Is hard to reverse.
- Has cost or risk implications greater than one sprint of effort.

### Step 2 — Draft the ADR

Use the template from `references/architecture-and-platform.md`:

```text
Title: [Short noun phrase]
Status: Proposed | Accepted | Superseded
Context: What is the problem? What constraints exist?
Options Considered:
  - Option A: [description] — TCO: $X | Risk: Low/Med/High
  - Option B: [description] — TCO: $X | Risk: Low/Med/High
Decision: [Chosen option and rationale]
Consequences: [What becomes easier? What becomes harder?]
```

### Step 3 — Validation checkpoint

Before finalizing:

- [ ] All options include a 3-year TCO estimate.
- [ ] At least one "do nothing" or "buy" alternative is documented.
- [ ] Affected team leads have reviewed and signed off.
- [ ] Consequences section addresses reversibility and migration path.
- [ ] ADR is committed to the repository — not left in a doc or chat thread.

### Step 4 — Communicate and close

Share the accepted ADR in the engineering all-hands or architecture sync.
Link it from the relevant service's README.

## Build vs Buy Analysis Workflow

### Step 1 — Define requirements

Functional and non-functional. Capture the must-haves separately from the
nice-to-haves before any vendor enters the conversation.

### Step 2 — Identify candidates

List both internal-build scope and 2-3 external vendor candidates. If only one
vendor exists, flag it: single-vendor markets are a different decision.

### Step 3 — Score each option

```
Criterion              | Weight | Build Score | Vendor A Score | Vendor B Score
-----------------------|--------|-------------|----------------|---------------
Solves core problem    | 30%    | 9           | 8              | 7
Migration risk         | 20%    | 2 (low risk)| 7              | 6
3-year TCO             | 25%    | $X          | $Y             | $Z
Vendor stability       | 15%    | N/A         | 8              | 5
Integration effort     | 10%    | 3           | 7              | 8
```

### Step 4 — Apply the default rule

Buy unless:

- The capability is core IP, **or**
- No vendor meets ≥ 70% of weighted requirements.

### Step 5 — Document as ADR

Run the ADR Creation Workflow to commit the decision. Build vs buy decisions
without an ADR almost always get re-litigated within 12 months.

## Reasoning Technique: ReAct

Research the technical landscape first. Analyze options against constraints
(time, team skill, cost, risk). Then recommend action. Ground every
recommendation in evidence — benchmarks, case studies, or measured data from
the operator's own systems. "I think" is not enough — show the data.

## Communication Standard

All output passes the Internal Quality Loop before reaching the founder
(see `agent-protocol/SKILL.md`):

- **Self-verify**: source attribution, assumption audit, confidence scoring.
- **Peer-verify**: cross-functional claims validated by the owning role.
- **Critic pre-screen**: high-stakes decisions reviewed by Executive Mentor.

Output format: **Bottom Line → What (with confidence) → Why → How to Act → Your Decision.**

Findings tagged: 🟢 verified, 🟡 medium, 🔴 assumed.

## Context Integration Rules

- **Always** read `company-context.md` before responding when it exists.
- **During board meetings**: use only your own analysis in Phase 2 (no cross-pollination).
- **Invocation**: request input from other roles with `[INVOKE:role|question]`.

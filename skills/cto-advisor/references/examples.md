# Examples — CTO Advisory Artifacts

Worked examples of each artifact the cto-advisor produces. Pair with
`references/advisory-workflow.md` for the workflow that yields each.

## Tech Debt Inventory

```
Item                  | Severity | Cost-to-Fix | Blast Radius | Priority Score
----------------------|----------|-------------|--------------|---------------
Auth service (v1 API) | P1       | 8 days      | 6 services   | HIGH
Unindexed DB queries  | P2       | 3 days      | 2 services   | MEDIUM
Legacy deploy scripts | P3       | 5 days      | 1 service    | LOW
```

Inventory is sorted by `(Severity × Blast Radius) / Cost-to-fix`. Top
two go into the next sprint; the rest enter the tracked backlog with a
quarterly review cadence.

## Build vs Buy Scorecard

```
Criterion              | Weight | Build | Vendor A | Vendor B
-----------------------|--------|-------|----------|----------
Solves core problem    | 30%    | 9     | 8        | 7
Migration risk         | 20%    | 2     | 7        | 6
3-year TCO             | 25%    | $480k | $310k    | $220k
Vendor stability       | 15%    | N/A   | 8        | 5
Integration effort     | 10%    | 3     | 7        | 8
-----------------------|--------|-------|----------|----------
Weighted score         |        | 5.6   | 7.6      | 6.7
```

Decision: Vendor A. Rationale: meets ≥ 70% of weighted requirements; TCO
favorable vs build; vendor stability score above the 7 threshold; capability
is not core IP.

Decision committed as ADR-027.

## ADR — example

```text
Title: Use Vendor A for Authentication Service
Status: Accepted
Date: 2026-04-12
Authors: CTO, Platform Lead

Context
-------
Current auth service is a v1 build from 2022. Outage risk has grown 3x in
the last 12 months. Re-platforming has been deferred twice. Mounting tech
debt and 6 dependent services are at risk.

Options Considered
------------------
Option A — Rebuild in-house (v2)
  - TCO (3-year): $480k
  - Risk: Medium — staffing constraints
  - Reversibility: Easy

Option B — Vendor A
  - TCO (3-year): $310k
  - Risk: Low — incumbent in segment
  - Reversibility: Hard — schema lock-in, but data export is supported

Option C — Status quo
  - TCO (3-year): unbounded (outage cost trending up)
  - Risk: High — cannot pass next compliance review

Decision
--------
Vendor A. Score 7.6 vs build at 5.6. Auth is not core IP; vendor stability
is acceptable; we have a 90-day data-export plan documented.

Consequences
------------
- Easier: SSO/MFA features ship in weeks, not quarters.
- Harder: Vendor escalation path is now a dependency for security audits.
- Revisit: in 18 months, or sooner if vendor pricing escalates > 30%.
- Migration: 12-week parallel run with cutover by service.
```

## Engineering Health Dashboard

```
Quarter: Q2 2026

Velocity
  Deployment frequency:    4.2/day        🟢 on target
  Lead time for changes:   18h            🟡 trending up from 6h
Quality
  Change failure rate:     7%             🟡 above 5% target
  Mean time to recovery:   42 min         🟢 within target
Debt
  Tech debt ratio:         28%            🔴 above 25% target
  P0 bugs open:            0              🟢
Team
  Engineering satisfaction:7.4/10         🟢
  Regrettable attrition:   12%            🟡 above 10% target
Architecture
  Uptime:                  99.94%         🟢
  API p95 latency:         185 ms         🟢
Cost
  Cloud spend / revenue:   8.1%           🟡 flat, target is declining
```

Top 3 risks named: lead-time regression, debt ratio drift, attrition above
target. Each has a named owner and a corrective action in the current sprint.

## Hiring Plan Snippet

```
Role            | Level | Target start | Ramp model              | Budget
----------------|-------|--------------|-------------------------|---------
Staff Eng (Plat)| L6    | Jun 2026     | 90-day pairing rotation | $315k+eq
Senior SRE      | L5    | Jul 2026     | 30/60/90 plan           | $260k+eq
Junior Eng x2   | L3    | Aug 2026     | Mentor pairs, eng buddy | $145k+eq
```

Bottom line for the CEO: 4 hires, $865k loaded comp, lifts platform capacity
+22% by end of Q3 with manageable mentoring load (Senior:Junior remains 1:2
in the platform org after these hires).

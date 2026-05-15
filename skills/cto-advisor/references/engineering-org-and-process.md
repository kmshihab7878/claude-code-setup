# Engineering Org and Process — CTO Reference

Team scaling, culture, metrics, and C-suite integration.

## Engineering Team Leadership

Scale the engineering organization's productivity — not individual output.

### Scaling Rules

- Hire for the next stage, not the current one.
- Every 3x in team size requires a reorganization.
- Manager:IC ratio: 5–8 direct reports is the productive band.
- Senior:junior ratio: at least 1:2. Invert it and senior time drowns in mentoring.
- Introduce a new layer of management at ~25–30 engineers and again at ~75–100.

### Culture

| Practice | Why it matters |
|----------|----------------|
| Blameless post-mortems | Incidents are system failures, not people failures |
| Documentation as first-class | Knowledge survives departures and onboarding |
| Code review as mentoring | Quality goes up, gatekeeping goes down |
| Sustainable on-call | Heroic on-call burns out senior engineers first |

### Hiring Process

| Step | Owner | Success criterion |
|------|-------|-------------------|
| Role definition | Hiring manager | One sentence purpose, three success metrics |
| Sourcing | Recruiter | Pipeline diverse on 2+ dimensions |
| Phone screen | Hiring manager | Bar set explicitly; consistent rubric |
| Technical interview | Senior IC | Realistic task, not a trivia quiz |
| System design | Staff IC | Probe trade-off reasoning, not memorized patterns |
| Values / collaboration | Manager + peer | Behavioral, evidence-based |
| Decision | Hiring committee | Documented, not majority vote |

## DORA Metrics

The four DORA metrics are the engineering equivalent of company-level OKRs.

| Metric | Elite | High | Medium | Low |
|--------|-------|------|--------|-----|
| Deployment frequency | On-demand | Daily–weekly | Weekly–monthly | < monthly |
| Lead time for changes | < 1 hour | < 1 day | < 1 week | > 1 week |
| Change failure rate | 0–15% | 16–30% | — | — |
| Mean time to recovery | < 1 hour | < 1 day | < 1 week | > 1 week |

Track all four together — improving one in isolation is usually a measurement
artifact rather than a real gain.

## Engineering Health Dashboard

| Category | Metric | Target | Frequency |
|----------|--------|--------|-----------|
| Velocity | Deployment frequency | Daily (or per-commit) | Weekly |
| Velocity | Lead time for changes | < 1 day | Weekly |
| Quality | Change failure rate | < 5% | Weekly |
| Quality | Mean time to recovery | < 1 hour | Weekly |
| Debt | Tech debt ratio | < 25% | Monthly |
| Debt | P0 bugs open | 0 | Daily |
| Team | Engineering satisfaction | > 7/10 | Quarterly |
| Team | Regrettable attrition | < 10% | Monthly |
| Architecture | System uptime | > 99.9% | Monthly |
| Architecture | API p95 latency | < 200 ms | Weekly |
| Cost | Cloud spend / revenue ratio | Declining trend | Monthly |

## Integration with C-Suite Roles

| When... | CTO works with... | To... |
|---------|-------------------|-------|
| Roadmap planning | CPO | Align technical and product roadmaps |
| Hiring engineers | CHRO | Define roles, comp bands, hiring criteria |
| Budget planning | CFO | Cloud costs, tooling, headcount budget |
| Security posture | CISO | Architecture review, compliance requirements |
| Scaling operations | COO | Infrastructure capacity vs growth plans |
| Revenue commitments | CRO | Technical feasibility of enterprise deals |
| Technical marketing | CMO | Developer relations, technical content |
| Strategic decisions | CEO | Technology as competitive advantage |
| Hard calls | Executive Mentor | "Should we rewrite?" "Should we switch stacks?" |

## Output Artifacts

Map common requests to the artifact the CTO produces.

| Request | You produce |
|---------|-------------|
| "Assess our tech debt" | Tech debt inventory with severity, cost-to-fix, prioritized plan |
| "Should we build or buy X?" | Build vs buy analysis with 3-year TCO |
| "We need to scale the team" | Hiring plan with roles, timing, ramp model, budget |
| "Review this architecture" | ADR with options evaluated, decision, consequences |
| "How's engineering doing?" | Engineering health dashboard (DORA + debt + team) |

## Key CTO Questions

Use as a cognitive primer before any major review.

- What is our biggest technical risk right now — not the most annoying, the most dangerous?
- If we 10x our traffic tomorrow, what breaks first?
- How much of our engineering time goes to maintenance vs new features?
- What would a new engineer say about our codebase after their first week?
- Which technical decision from two years ago is hurting us most today?
- Are we building this because it is the right solution, or because it is the interesting one?
- What is our bus factor on critical systems?

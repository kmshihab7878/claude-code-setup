# Risk, Security, and Validation — CTO Reference

Crisis management, red flags, proactive triggers, validation checkpoints, and
communication standards.

## Crisis Management

Incidents, security breaches, major outages, data loss.

### CTO's Role in a Crisis

1. Ensure the right people are on it — incident commander, comms, technical leads.
2. Ensure communication is flowing — status page, exec updates, customer comms.
3. Ensure the business is informed — CEO, CRO, legal/CISO as applicable.

The CTO is not the incident commander unless the team is too small for that
role to exist. The CTO's job is to remove obstacles, not to type commands.

### Post-Incident

- Blameless retrospective within 48 hours.
- Action items have owners and target dates.
- Architectural causes feed back into the ADR backlog.
- Public post-mortem when customer-facing, per the operator's disclosure policy.

## Red Flags

Treat any of the following as an immediate escalation trigger.

- Tech debt ratio > 30% and growing faster than it is being paid down.
- Deployment frequency declining over four or more consecutive weeks.
- No ADRs for the last three major decisions.
- The CTO is the only person who can deploy to production.
- Build times exceed 10 minutes (a 10-engineer team loses an engineer-week per week).
- Single points of failure on critical systems with no mitigation plan.
- The team dreads on-call rotation.
- Cloud spend growing faster than revenue for two consecutive quarters.
- A core engineer leaves and load-bearing knowledge leaves with them.

## Proactive Triggers

Surface these without being asked when the operator's context contains the signal.

| Signal | Action |
|--------|--------|
| Deployment frequency dropping | Early signal of team health issues — propose a health check |
| Tech debt ratio > 30% | Recommend a tech debt sprint |
| No ADRs filed in 30+ days | Architecture decisions going undocumented — propose ADR retroactively |
| SPOF on critical system | Flag bus factor risk — propose redundancy plan |
| Cloud costs growing faster than revenue | Trigger cost optimization review |
| Security audit overdue (> 12 months) | Escalate to CISO |

## Validation Checkpoints

Each major workflow has a validation checkpoint that must pass before the
artifact is presented to the founder or board.

### Tech debt assessment

- [ ] Every P0/P1 has an owner and target date.
- [ ] Cost-to-fix reviewed with the relevant tech lead.
- [ ] Remediation plan fits within capacity.
- [ ] Debt ratio calculated and trending tracked.

### ADR creation

- [ ] All options carry a 3-year TCO.
- [ ] A "do nothing" or "buy" alternative is documented.
- [ ] Affected team leads have signed off.
- [ ] Reversibility and migration path addressed.
- [ ] Committed to the repo, not chat.

### Build vs buy

- [ ] Requirements separated into must-have vs nice-to-have.
- [ ] Two or more vendor candidates evaluated.
- [ ] Default rule applied (buy unless core IP or no vendor meets ≥ 70%).
- [ ] Decision committed as an ADR.

### Engineering health review

- [ ] All four DORA metrics tracked together.
- [ ] Team satisfaction signal current within 90 days.
- [ ] Top 3 risks named with owners.
- [ ] At least one corrective action in flight per identified red flag.

## Security and Compliance Posture

The CTO collaborates with the CISO; this skill does not replace dedicated
security tooling or assessment.

| Domain | Minimum stance |
|--------|----------------|
| Identity | SSO + MFA enforced, least privilege, audited access |
| Secrets | Centralized secret store, rotated regularly, no secrets in code |
| Supply chain | SBOM produced for production, dependencies pinned, scanners gating CI |
| Data | Encryption at rest and in transit, retention policy documented |
| Incident readiness | Run-books current, tabletop exercise every six months |

Anything below the minimum stance is a red flag.

## Communication Standard

All output passes the Internal Quality Loop before reaching the founder.

- Self-verify: source attribution, assumption audit, confidence scoring.
- Peer-verify: cross-functional claims validated by the owning role.
- Critic pre-screen: high-stakes decisions reviewed by the Executive Mentor.

Output format:

**Bottom Line → What (with confidence) → Why → How to Act → Your Decision.**

Tag every finding: 🟢 verified, 🟡 medium, 🔴 assumed. Do not collapse the
tags into the prose — the founder uses them to triage.

# Council framework (Section 6 detail)

Full council compositions table (Product / Engineering / Recovery / Delivery), council decision format (Assessment / Recommendation / Rationale, with Block and Escalate rules), and when-to-convene table (Solo / Lead+Reviewer / Full Council). SKILL.md keeps a compact council-mode summary; this file holds the full schemas.

## 6. Council Framework

Councils provide **multi-perspective review** for complex decisions.

### Council Compositions

| Council | Agents | When |
|---------|--------|------|
| **Product** | requirements-analyst, architect, business-panel-experts | New products, major features, pivots |
| **Engineering** | python-expert, code-reviewer, quality-engineer | Architecture decisions, major refactors |
| **Recovery** | debugger, root-cause-analyst, incident-responder | Critical bugs, production incidents |
| **Delivery** | security-auditor, ci-cd-engineer, devops-architect | Deployments, infrastructure changes |

### Council Decision Format

Each council member provides:
- **Assessment**: What they see
- **Recommendation**: One of: Approve / Approve with conditions / Block / Escalate
- **Rationale**: Why

A **Block** from any member halts progress until resolved.
An **Escalate** means the decision exceeds the council's authority — ask the user.

### When to Convene

| Council Mode | Trigger |
|--------------|---------|
| **Solo** | T0-T1, single domain, clear path |
| **Lead + Reviewer** | T1-T2, needs a second opinion |
| **Full Council** | T2-T3, multi-domain, high stakes |


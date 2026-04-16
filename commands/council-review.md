---
description: "Multi-perspective senior review board. Debate across architecture, UX, implementation risk, and testing. Converge on one path, then execute it."
---

# /council-review — Review Board + Execution

Act as a multi-perspective senior review board before building. This extends your existing `council` skill with mandatory execution after convergence.

## Phase 1: Debate (brief, 4 perspectives)

### Architect
- Does this approach fit the existing architecture?
- Are the abstractions right-sized?
- Will this scale or create debt?

### Product/UX
- Does this serve the user's actual goal?
- Are the interaction patterns intuitive?
- What edge cases matter to real users?

### Implementation Risk
- What is the riskiest part of this change?
- What is most likely to break?
- Where are the integration seams?

### Quality/Release
- How do we validate this?
- What regression risk exists?
- Is this safe to ship quickly?

## Phase 2: Converge

Synthesize the four perspectives into one recommended path. State:
- The chosen approach and why
- What each perspective contributed to the decision
- What was traded off and why that is acceptable

## Phase 3: Execute

Proceed with full `/ship` mode using the converged path. Do not stop at the recommendation.

Follow the complete execution protocol:
1. Build Intent
2. 3 Key Decisions
3. Locked Assumptions
4. Implementation Plan
5. Implementation
6. Validation
7. Ship Summary

## Target

$ARGUMENTS

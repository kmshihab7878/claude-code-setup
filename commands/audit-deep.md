---
description: "Full-stack audit: architecture, code quality, performance, UX debt, security, test gaps. Produces prioritized fix list. Does not implement — only inspects."
---

# /audit-deep — Full-Stack Audit Mode

Do not implement anything yet. Inspect first, report second.

## Audit Dimensions

Evaluate the target area across these dimensions:

### 1. Architecture
- Module boundaries and coupling
- Abstraction quality (over/under-abstracted?)
- Data flow coherence
- State management consistency
- API contract quality

### 2. Code Quality
- Dead code, unused imports, naming inconsistencies
- Duplicated logic
- Error handling gaps
- Type safety holes
- Unfinished patterns (TODOs, mock values, placeholder handlers)

### 3. Performance
- Unnecessary re-renders or re-fetches
- N+1 queries or missing indexes
- Bundle size concerns
- Missing memoization on expensive operations
- Unoptimized assets

### 4. UX Debt
- Missing loading states
- Missing error states
- Missing empty states
- Broken keyboard navigation
- Accessibility gaps (contrast, labels, focus management)
- Inconsistent visual patterns

### 5. Security
- Auth/permission gaps
- Input validation holes
- Injection vectors
- Secrets exposure risk
- Dependency vulnerabilities

### 6. Test Gaps
- Untested critical paths
- Missing edge case coverage
- Fragile test patterns
- Missing integration tests for user-visible flows

## Output Format

For each finding:
- **Severity**: P0 (fix now) / P1 (fix this sprint) / P2 (fix soon) / P3 (nice to have)
- **Location**: File and line/function
- **Issue**: What is wrong
- **Impact**: What breaks or degrades
- **Fix**: Concrete recommendation

End with a prioritized action plan grouped by severity.

## Target

$ARGUMENTS

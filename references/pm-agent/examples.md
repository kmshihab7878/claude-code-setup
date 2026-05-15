# Examples — PM Agent Workflows in Practice

Worked walkthroughs for each of the PM Agent's primary activities.

## Example 1 — Post-implementation documentation

**Context**: A specialist agent (e.g., `backend-architect` + `security-engineer`)
just implemented authentication using Kong + OIDC.

### PM Agent activation

1. Read the implemented code.
2. Identify the new pattern and the decisions taken.
3. Decide where it lives:
   - First time this pattern is seen → `docs/temp/experiment-2026-05-15-kong-oidc.md`.
   - Confirmed pattern (second successful application) → promote to
     `docs/patterns/auth-kong-oidc.md`.
   - Global enough to be the default → reference from `CLAUDE.md`.

### Output document — `docs/patterns/auth-kong-oidc.md`

```
# Auth: Kong + OIDC

Last Verified: 2026-05-15
Status: pattern (single confirmed application)

## When to use
- B2B SaaS with enterprise SSO needs.
- Kong already deployed as the gateway.

## How (copy-paste-ready)
[concrete config snippets, redirect URI, scope list]

## Decisions
- Chose Kong's OIDC plugin over a custom JWT proxy because [rationale].
- Rejected Auth0 because [rationale].

## Edge cases handled
- Token refresh under concurrent requests.
- Session timeout vs SSO session lifetime mismatch.

## Tests + metrics
- Test coverage: 87% on `internal/auth/...`.
- Synthetic login probe deployed; alerts on > 2s p95.

## Integration points
- Kong → backend service: JWT in `Authorization: Bearer`.
- Backend → tenants: claims mapped to `tenant_id` header.
```

### CLAUDE.md update (only if global)

A single bullet under "Auth": "Use Kong + OIDC for B2B SSO unless a
specific reason rules it out — pattern in `docs/patterns/auth-kong-oidc.md`."

## Example 2 — Immediate mistake analysis

**Context**: An implementation broke production for 12 minutes because the
agent rolled out a config change without first reading
`docs/kong-gateway.md`.

### Halt → root cause → document

1. Halt: stop the deploy pipeline.
2. Root cause: `docs/kong-gateway.md` was not consulted; the agent
   skipped the BEFORE-phase doc-read check.
3. Document the mistake in `docs/mistakes/mistake-2026-05-15-kong-rollout.md`:

```
# Kong rollout regression — 2026-05-15

What Happened
  Deploy of feature flag `auth_v2` caused Kong to reject 100% of
  incoming requests for 12 minutes. Reverted via `n8n_autofix_workflow`
  rollback path.

Root Cause
  Config change required a Kong consumer plugin update; the order in
  docs/kong-gateway.md (Section 4) was not followed.

Why Missed
  Specialist agent skipped the BEFORE-phase check; PM Agent did not
  verify docs/kong-gateway.md had been read.

Fix Applied
  Reverted config; re-applied in the order documented; service
  restored at 14:32 UTC.

Prevention Checklist
  - [ ] Before any Kong config change, confirm docs/kong-gateway.md
        Section 4 has been read in the current session.
  - [ ] PM Agent: hard-block deploys to Kong if the BEFORE-phase
        check has no positive signal for docs/kong-gateway.md.

Lesson Learned
  Document-order dependencies must be checked, not assumed. The
  BEFORE-phase check is non-optional for shared infrastructure.
```

### CLAUDE.md change

Adds: "For Kong config changes, PM Agent enforces a BEFORE-phase
verification that `docs/kong-gateway.md` Section 4 was read."

The mistake doc is intentionally specific. The CLAUDE.md change is the
generalized rule.

## Example 3 — Monthly maintenance

**Context**: Last day of the month. PM Agent runs the monthly pruning
workflow.

### Pre-maintenance scan

```
Doc count:         142
Patterns:           58
Mistakes:           19
Temp (> 7 days):     4   ← expired, must triage
> 6 months old:     27
Duplicates flagged:  6
Broken links:        3
```

### Actions

1. **Expired temp files** — promote 1 to `docs/patterns/`, demote 3 to
   archive (no follow-up was scheduled).
2. **Old docs** — refresh Last Verified on 18 still-relevant; archive 9
   that no agent has referenced in 6 months.
3. **Duplicates** — merge 6 pairs into 6 canonical entries; add
   redirect notes.
4. **Broken links** — fix 2; remove 1 that points to a sunset external service.
5. **Verbosity** — trim two pattern docs that exceeded 300 lines.

### Maintenance report

```
Monthly Maintenance — 2026-05-31

Before:           142 docs, total ~720k chars, 3 broken links
After:            127 docs, total ~610k chars, 0 broken links
Median age:       4.1 months (was 5.7 months)
Reference rate:   78% docs referenced last 90 days (was 64%)
Notable removals: 3 archived (no references in 6+ months)
Notable promotions: 1 temp -> pattern (kong-oidc)

Next focus:       commands/ docs — 8 of them lack Last Verified dates.
```

The report is committed to `docs/maintenance/2026-05-31.md` and surfaced
to the operator.

## Example 4 — Session start (auto-restore)

**Context**: Operator opens a new Claude Code session in this repo.

### What the operator sees (within ~5s)

```
Last session (2026-05-14)
  Worked on: skill-creator/SKILL.md compaction. Branch:
  perf/skill-creator-reference-extraction. Status: ready for review.

Current plan
  Continue the reference-extraction queue. Next target after merge:
  skills/n8n/.../n8n-code-javascript.

Planned next actions
  1. Confirm PR #54 merged.
  2. Begin n8n-code-javascript extraction on a new branch.
  3. Run validation suite before commit.

Blockers
  None.
```

The operator can immediately continue with "go ahead with n8n-code-javascript"
without re-explaining anything.

## Example 5 — Handoff to a specialist agent

**Context**: PM Agent is in the middle of restoring context and detects
that the user's actual request is a code change, not a documentation task.

### Handoff packet (YAML)

```yaml
Handoff:
  context:
    task: "Implement retry-with-backoff in the analytics ingest service"
    status: in-progress
    branch: feat/analytics-retry
    key_files:
      - services/ingest/retry.ts
      - services/ingest/retry.test.ts
  completed:
    - "Initial scaffold of retry function"
    - "Three unit tests for happy path"
  remaining:
    - "Exponential backoff + jitter"
    - "Integration test against staging"
  blockers: []
  decisions_made:
    - decision: "Use full-jitter exponential backoff"
      rationale: "AWS Architecture Blog recommends it for shared-tenant systems"
      alternatives_rejected: ["fixed delay", "decorrelated jitter"]
  notes:
    - "Specialist agent (backend-architect) takes over for the implementation."
    - "PM Agent will auto-activate post-implementation to document the pattern."
```

The PM Agent then steps out of execution and only re-engages after the
specialist finishes.

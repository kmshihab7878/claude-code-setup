# Troubleshooting — False Positives, Recovery, Best Practices

Common failure modes, false-positive interpretation, recovery recipes, and best-practice detail. The minimal lists live in `SKILL.md`. The comprehensive false-positives catalog lives in [`../FALSE_POSITIVES.md`](../FALSE_POSITIVES.md).

## False Positives

Validation warnings that are technically "wrong" but acceptable in specific use cases. Treat them as advisory, not blocking.

### 1. "Missing error handling"

**Warning**: no error handling configured.

**When acceptable**:

- Simple workflows where failures are obvious.
- Testing/development workflows.
- Non-critical notifications.

**When to fix**: production workflows handling important data.

### 2. "No retry logic"

**Warning**: node doesn't retry on failure.

**When acceptable**:

- APIs with their own retry logic.
- Idempotent operations.
- Manual-trigger workflows.

**When to fix**: flaky external services, production automation.

### 3. "Missing rate limiting"

**Warning**: no rate limiting for API calls.

**When acceptable**:

- Internal APIs with no limits.
- Low-volume workflows.
- APIs with server-side rate limiting.

**When to fix**: public APIs, high-volume workflows.

### 4. "Unbounded query"

**Warning**: `SELECT` without `LIMIT`.

**When acceptable**:

- Small, known datasets.
- Aggregation queries.
- Development/testing.

**When to fix**: production queries on large tables.

### Reducing false positives

Switch the validation profile to reduce noise:

```javascript
validate_node({
  nodeType: "nodes-base.slack",
  config: {...},
  profile: "ai-friendly"  // Fewer false positives
})
```

Document the false positives you accept in your workflow's notes so reviewers don't keep "fixing" them.

## Recovery Strategies — full detail

### Strategy 1: Start fresh

**When**: configuration is severely broken.

**Steps**:

1. Note required fields from `get_node`.
2. Create a minimal valid configuration.
3. Add features incrementally.
4. Validate after each addition.

### Strategy 2: Binary search

**When**: workflow validates but executes incorrectly.

**Steps**:

1. Remove half the nodes.
2. Validate and test.
3. If it works → the problem is in the removed nodes.
4. If it fails → the problem is in the remaining nodes.
5. Repeat until the problem is isolated.

### Strategy 3: Clean stale connections

**When**: "Node not found" errors.

```javascript
n8n_update_partial_workflow({
  id: "workflow-id",
  operations: [{
    type: "cleanStaleConnections"
  }]
})
```

### Strategy 4: Use auto-fix

**When**: validation errors that can be automatically resolved.

```javascript
// Preview fixes (default — doesn't apply)
n8n_autofix_workflow({
  id: "workflow-id",
  applyFixes: false,
  confidenceThreshold: "medium"
})

// Review fixes, then apply
n8n_autofix_workflow({
  id: "workflow-id",
  applyFixes: true
})
```

See [`auto-fix-patterns.md`](auto-fix-patterns.md) for full fix-type detail and confidence thresholds.

## Best Practices — full guidance

### ✅ Do

- **Validate after every significant change** — catch issues early when they're cheap to fix.
- **Read error messages completely** — the `fix` field usually contains the exact remediation.
- **Fix errors iteratively (one at a time)** — bundling fixes makes regressions hard to attribute.
- **Use `runtime` profile for pre-deployment** — balanced and operationally meaningful.
- **Check `valid` field before assuming success** — never assume validation passed without inspecting the result.
- **Trust auto-sanitization for operator issues** — don't manually patch what the system fixes deterministically.
- **Use `get_node` when unclear about requirements** — `standard` detail covers 95% of needs.
- **Document false positives you accept** — note in workflow description / decisions / ADR so reviewers know.

### ❌ Don't

- **Skip validation before activation** — production failures cost more than a 23s feedback loop.
- **Try to fix all errors at once** — one cycle = one fix.
- **Ignore error messages** — they contain fix guidance in the `fix` / `suggestion` fields.
- **Use `strict` profile during development** — too noisy; switch to it only for production gating.
- **Assume validation passed** — always check `result.valid` explicitly.
- **Manually fix auto-sanitization issues** — fighting the system regenerates the issue next save.
- **Deploy with unresolved errors** — `valid: false` blocks for a reason.
- **Ignore all warnings** — some are important (e.g., missing error handling on production webhooks).

## Debugging recipes

| Symptom | Investigation | Likely fix |
|---|---|---|
| Same error after fix | Re-run `validate_node` to confirm; check that `n8n_update_partial_workflow` actually persisted the change | Re-apply via correct operation; check operation index |
| New error after fix | Validation surfaced the next-required field | Normal — continue iterating |
| Warning re-appears after each save | Auto-sanitization is "fixing" what you set | Stop manually setting it; let the system manage |
| Workflow valid but fails at runtime | Validation doesn't simulate execution | Switch to `strict` profile, or use `n8n_test_workflow` |
| "Node not found" but node exists | Stale connection from earlier rename/delete | Run `cleanStaleConnections` operation |
| Auto-fix won't apply | Confidence below threshold | Inspect `postUpdateGuidance`; apply manually or lower threshold with review |

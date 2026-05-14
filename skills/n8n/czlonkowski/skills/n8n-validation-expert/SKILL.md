---
name: n8n-validation-expert
description: Interpret validation errors and guide fixing them. Use when encountering validation errors, validation warnings, false positives, operator structure issues, or need help understanding validation results. Also use when asking about validation profiles, error types, or the validation loop process.
---

# n8n Validation Expert

Expert guide for interpreting and fixing n8n validation errors.

## Reference map

Reference material lives in `references/`. Load only what the current task needs.

| When | Read |
|---|---|
| Full iterative validation example, profile decision table, result-reading code | [`references/validation-workflow.md`](references/validation-workflow.md) |
| Error types 1–5 full before/after examples + workflow-level error examples | [`references/error-catalog.md`](references/error-catalog.md) · base detail: [`ERROR_CATALOG.md`](ERROR_CATALOG.md) |
| Auto-sanitization full before/after, `n8n_autofix_workflow` fix-type catalog + confidence levels + safety matrix | [`references/auto-fix-patterns.md`](references/auto-fix-patterns.md) |
| False positives full detail, recovery strategies, best-practice rationale, debugging recipes | [`references/troubleshooting.md`](references/troubleshooting.md) · base detail: [`FALSE_POSITIVES.md`](FALSE_POSITIVES.md) |
| End-to-end validation scenarios (Slack loop, expression fix, operator auto-sanitize, broken connection, profile escalation, preview-then-apply) | [`references/examples.md`](references/examples.md) |

---

## Validation Philosophy

**Validate early, validate often.** Validation is iterative — expect 2–3 cycles. Telemetry from production usage: 23s thinking about errors, 58s fixing, per cycle. Each cycle surfaces the next required field.

**Key insight**: validation is a feedback loop, not a one-shot check.

---

## Error Severity Levels

| Severity | Blocks execution? | Types | When to act |
|---|---|---|---|
| **Errors** | ✅ Yes — must fix before activation | `missing_required`, `invalid_value`, `type_mismatch`, `invalid_reference`, `invalid_expression` | Always, before deploying |
| **Warnings** | ❌ No — workflow can activate | `best_practice`, `deprecated`, `performance` | Production yes; dev / testing case-by-case |
| **Suggestions** | ❌ No — nice to have | `optimization`, `alternative` | Optional |

Always fix errors. Review warnings — some are important (production webhooks need error handling), some are false positives ("missing rate limiting" on an internal API).

---

## The Validation Loop

The most common workflow-building pattern in n8n — 7,841 telemetry occurrences:

```
1. Configure node
   ↓
2. validate_node (23 seconds thinking about errors)
   ↓
3. Read error messages carefully
   ↓
4. Fix errors
   ↓
5. validate_node again (58 seconds fixing)
   ↓
6. Repeat until valid (usually 2-3 iterations)
```

Multiple iterations are **normal**. Full worked Slack example: [`references/validation-workflow.md`](references/validation-workflow.md#worked-example--three-iterations).

---

## Validation Profiles

| Profile | When | Use |
|---|---|---|
| `minimal` | Quick checks during editing | Fastest, most permissive — may miss issues |
| **`runtime`** (recommended) | Pre-deployment validation | Balanced — catches real errors. **Default for most cases.** |
| `ai-friendly` | AI-generated configurations | Same as runtime + reduced false positives |
| `strict` | Production / critical workflows | Everything + best practices + performance + security |

Full per-profile validates/trade-offs detail: [`references/validation-workflow.md`](references/validation-workflow.md#profile-choice--when-to-use-which).

---

## Common Error Types

| Type | What it means | Fix approach |
|---|---|---|
| `missing_required` | Required field not provided | Use `get_node` → add field with appropriate value |
| `invalid_value` | Value doesn't match allowed options | Check error message → use a valid option |
| `type_mismatch` | Wrong data type | Convert to expected type (e.g., `"100"` → `100`) |
| `invalid_expression` | Expression syntax error | Add `={{...}}` wrapper; verify references |
| `invalid_reference` | Referenced node doesn't exist | Check spelling; verify node is in workflow |

Full before/after code for each type: [`references/error-catalog.md`](references/error-catalog.md) and [`ERROR_CATALOG.md`](ERROR_CATALOG.md).

---

## Auto-Sanitization (automatic)

**Runs automatically** on every workflow save (`n8n_create_workflow`, `n8n_update_partial_workflow`, any save). You don't call it; it's part of every save.

**Fixes**:

- **Binary operators** (equals, notEquals, contains, etc.) — removes incorrect `singleValue` property.
- **Unary operators** (isEmpty, isNotEmpty, true, false) — adds required `singleValue: true`.
- **IF/Switch metadata** — adds complete `conditions.options` for IF v2.2+ and Switch v3.2+.

**Cannot fix** (require manual intervention):

- Broken connections to non-existent nodes → use `cleanStaleConnections` operation.
- Branch count mismatches (Switch rules ≠ output connections) → add/remove to match.
- Paradoxical corrupt states (API returns corrupt data but rejects updates) → may need DB intervention.

**Critical rule**: **trust auto-sanitization** — don't manually patch operator structure. Manual fixes fight the system and regenerate the issue on the next save.

Full before/after examples: [`references/auto-fix-patterns.md`](references/auto-fix-patterns.md#auto-sanitization-system).

---

## Auto-Fix Capabilities (`n8n_autofix_workflow`)

Opt-in tool. **Always preview before applying.**

| Fix type | What |
|---|---|
| `expression-format` | Adds missing `=` prefix (`{{...}}` → `={{...}}`) |
| `typeversion-correction` | Downgrades unsupported `typeVersion` |
| `error-output-config` | Removes conflicting `onError` settings |
| `node-type-correction` | Fixes unknown node types via similarity (90%+) |
| `webhook-missing-path` | Generates UUIDs for missing webhook paths |
| `typeversion-upgrade` | Smart upgrades with auto-migration |
| `version-migration` | Guidance for breaking changes needing manual steps |

**Confidence levels** — safety boundary:

| Level | Match | Action |
|---|---|---|
| `high` | 90%+ | Safe to auto-apply |
| `medium` | 70–89% | Review recommended |
| `low` | <70% | **Manual review required** |

**Operational rule**: default to `applyFixes: false` (preview), inspect the diff, then apply with `confidenceThreshold: "high"`. For `medium` / `low`, review every fix. Check `postUpdateGuidance` in the response — some upgrades need follow-up manual changes.

Full safety matrix + usage code: [`references/auto-fix-patterns.md`](references/auto-fix-patterns.md).

---

## False Positives

Warnings that are technically "wrong" but acceptable in your use case. **Don't blanket-suppress** — interpret each.

| Warning | When acceptable | When to fix |
|---|---|---|
| Missing error handling | Dev / testing / non-critical notifications | Production workflows handling important data |
| No retry logic | APIs with own retries, idempotent ops, manual trigger | Flaky external services, production automation |
| Missing rate limiting | Internal APIs, low-volume, server-side limits | Public APIs, high-volume workflows |
| Unbounded query | Small known datasets, aggregations, dev | Production queries on large tables |

**Reduce false positives**: switch to `profile: "ai-friendly"` for LLM-generated configs. Document accepted false positives in workflow notes so reviewers don't keep re-fixing them.

Full when-acceptable/when-to-fix detail + full false-positives catalog: [`references/troubleshooting.md`](references/troubleshooting.md#false-positives) and [`FALSE_POSITIVES.md`](FALSE_POSITIVES.md).

---

## Validation Result — Reading It

```javascript
const result = validate_node({...});

if (!result.valid) {
  // Fix errors first
  result.errors.forEach(e => console.log(`Error in ${e.property}: ${e.message} — Fix: ${e.fix}`));
}

// Review warnings — decide per case
result.warnings.forEach(w => console.log(`Warning: ${w.message} — Suggestion: ${w.suggestion}`));
```

The shape: `{ valid, errors[], warnings[], suggestions[], summary: { hasErrors, errorCount, warningCount, suggestionCount } }`. Each error has `type`, `property`, `message`, and `fix` — the `fix` field usually contains the exact remediation.

Full shape + step-by-step reading guide: [`references/validation-workflow.md`](references/validation-workflow.md#reading-the-validation-result).

---

## Workflow Validation (`validate_workflow` / `n8n_validate_workflow`)

Validates the **entire workflow** (not just nodes): node configurations, connections (no broken references), expressions (syntax + references valid), flow (logical structure).

```javascript
validate_workflow({
  workflow: { nodes: [...], connections: {...} },
  options: {
    validateNodes: true,
    validateConnections: true,
    validateExpressions: true,
    profile: "runtime"
  }
})
```

**Common workflow-level errors**: broken connections (→ `cleanStaleConnections`), circular dependencies (→ restructure), multiple start nodes (→ remove extras), disconnected nodes (→ connect or remove).

Full per-error JSON shapes + fixes: [`references/error-catalog.md`](references/error-catalog.md#workflow-level-errors).

---

## Recovery Strategies

| Strategy | When to use |
|---|---|
| **Start fresh** | Configuration is severely broken — `get_node` → minimal valid → add features incrementally, validating after each |
| **Binary search** | Workflow validates but executes incorrectly — remove half, test, narrow down |
| **Clean stale connections** | "Node not found" errors — `n8n_update_partial_workflow` with `cleanStaleConnections` operation |
| **Use auto-fix** | Errors that can be automatically resolved — preview with `applyFixes: false`, review, then apply with `confidenceThreshold: "high"` |

Full code for each strategy + a debugging-recipes table: [`references/troubleshooting.md`](references/troubleshooting.md#recovery-strategies--full-detail).

---

## Best Practices

### ✅ Do

- Validate after every significant change.
- Read error messages completely — the `fix` field is the remediation.
- Fix errors iteratively, one at a time.
- Use `runtime` profile for pre-deployment.
- Check `valid` before assuming success.
- **Trust auto-sanitization** for operator structure.
- Use `get_node` when requirements are unclear.
- Document accepted false positives in workflow notes.

### ❌ Don't

- Skip validation before activation.
- Try to fix all errors at once.
- Ignore error messages.
- Use `strict` during development (too noisy).
- Assume validation passed (always check `result.valid`).
- **Manually fight auto-sanitization** — it regenerates the fix on next save.
- Deploy with unresolved errors.
- Blanket-ignore warnings — some are important.

Full guidance with rationale: [`references/troubleshooting.md`](references/troubleshooting.md#best-practices--full-guidance).

---

## Output Expectations

When invoked, this skill produces:

- A diagnosed error list with severity, type, property, and fix per item.
- A recommended next action (which error to fix first, when to escalate profile, when to invoke `n8n_autofix_workflow` preview).
- For auto-fix scenarios: clear preview-before-apply gating with `confidenceThreshold` recommendation.
- For false positives: documented acceptance reasoning, not blanket suppression.

---

## Integration with Other Skills

- **n8n MCP Tools Expert** — how to call `validate_node`, `validate_workflow`, `n8n_autofix_workflow`, `n8n_update_partial_workflow` correctly.
- **n8n Node Configuration** — interpret missing-required errors, understand property dependencies.
- **n8n Expression Syntax** — fix `invalid_expression` errors (`={{...}}` wrapping, `$json.body` access).
- **n8n Workflow Patterns** — handle workflow-level structure errors.
- **n8n Code JavaScript / Python** — when validation surfaces Code-node-specific errors.

---

## Summary

**Key points**:

1. Validation is **iterative** (avg 2–3 cycles, 23s + 58s telemetry).
2. **Errors must be fixed**; warnings are case-by-case; suggestions are optional.
3. **Auto-sanitization** fixes operator structures automatically — trust it.
4. Use **`runtime` profile** as the balanced default.
5. **False positives exist** — interpret rather than suppress.
6. **Read error messages** — they contain fix guidance in the `fix` field.

**Process**:

1. Validate → read errors → fix → validate again.
2. Repeat until `valid: true` (usually 2–3 iterations).
3. Review warnings and decide if acceptable.
4. Deploy with confidence.

## Detailed Guides

- [`references/validation-workflow.md`](references/validation-workflow.md) — full validation walkthrough + profile detail
- [`references/error-catalog.md`](references/error-catalog.md) — error types with before/after code
- [`references/auto-fix-patterns.md`](references/auto-fix-patterns.md) — auto-sanitization + auto-fix safety matrix
- [`references/troubleshooting.md`](references/troubleshooting.md) — false positives, recovery, best practices
- [`references/examples.md`](references/examples.md) — end-to-end scenarios
- [`ERROR_CATALOG.md`](ERROR_CATALOG.md) — comprehensive error catalog
- [`FALSE_POSITIVES.md`](FALSE_POSITIVES.md) — comprehensive false-positives catalog

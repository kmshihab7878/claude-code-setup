# Auto-Fix Patterns — Safe / Unsafe Boundaries

Detailed examples of auto-sanitization (runs on every save) and `n8n_autofix_workflow` (opt-in). The minimal what-runs-when summary and safety boundaries live in `SKILL.md`.

## Auto-Sanitization System

**What it does**: automatically fixes common operator structure issues on **every** workflow update.

**Runs when**:

- `n8n_create_workflow`
- `n8n_update_partial_workflow`
- Any workflow save operation

You don't call it explicitly — it runs as part of every save.

### What it fixes

#### 1. Binary operators (two values)

**Operators**: `equals`, `notEquals`, `contains`, `notContains`, `greaterThan`, `lessThan`, `startsWith`, `endsWith`.

**Fix**: removes `singleValue` property (binary operators compare two values).

**Before**:

```javascript
{
  "type": "boolean",
  "operation": "equals",
  "singleValue": true  // ❌ Wrong!
}
```

**After (automatic)**:

```javascript
{
  "type": "boolean",
  "operation": "equals"
  // singleValue removed ✅
}
```

#### 2. Unary operators (one value)

**Operators**: `isEmpty`, `isNotEmpty`, `true`, `false`.

**Fix**: adds `singleValue: true` (unary operators check a single value).

**Before**:

```javascript
{
  "type": "boolean",
  "operation": "isEmpty"
  // Missing singleValue ❌
}
```

**After (automatic)**:

```javascript
{
  "type": "boolean",
  "operation": "isEmpty",
  "singleValue": true  // ✅ Added
}
```

#### 3. IF/Switch metadata

**Fix**: adds the complete `conditions.options` metadata for IF v2.2+ and Switch v3.2+.

### What it CANNOT fix

These require manual intervention or different tooling.

#### 1. Broken connections

References to non-existent nodes.

**Solution**: use the `cleanStaleConnections` operation in `n8n_update_partial_workflow`.

#### 2. Branch count mismatches

3 Switch rules but only 2 output connections.

**Solution**: add missing connections or remove extra rules.

#### 3. Paradoxical corrupt states

API returns corrupt data but rejects updates.

**Solution**: may require manual database intervention.

---

## `n8n_autofix_workflow` — opt-in workflow-level fixes

The `n8n_autofix_workflow` tool fixes these issue types. Unlike auto-sanitization, you **call this explicitly** and it has a preview mode.

| Fix type | What it does |
|---|---|
| `expression-format` | Adds missing `=` prefix in expressions (`{{ $json.field }}` → `={{ $json.field }}`) |
| `typeversion-correction` | Downgrades nodes with unsupported `typeVersion` |
| `error-output-config` | Removes conflicting `onError` settings |
| `node-type-correction` | Fixes unknown node types using similarity matching (90%+ confidence) |
| `webhook-missing-path` | Generates UUIDs for webhook nodes missing path configuration |
| `typeversion-upgrade` | Smart upgrades to latest node versions with auto-migration |
| `version-migration` | Guidance for complex breaking changes requiring manual steps |

### Confidence levels

| Level | Match certainty | Recommendation |
|---|---|---|
| `high` | 90%+ | Safe to auto-apply |
| `medium` | 70–89% | Review recommended |
| `low` | <70% | Manual review required |

### Usage patterns

**Preview all fixes** (default — does not apply):

```javascript
n8n_autofix_workflow({
  id: "workflow-id",
  applyFixes: false,
  confidenceThreshold: "medium"
})
```

**Apply only high-confidence fixes**:

```javascript
n8n_autofix_workflow({
  id: "workflow-id",
  applyFixes: true,
  confidenceThreshold: "high"
})
```

**Target specific fix types**:

```javascript
n8n_autofix_workflow({
  id: "workflow-id",
  fixTypes: ["expression-format", "typeversion-upgrade"],
  applyFixes: true
})
```

### Post-update guidance

For version upgrades, check the `postUpdateGuidance` field in the response for step-by-step migration instructions. Some upgrades require follow-up manual changes — don't assume `applyFixes: true` is a complete fix.

## Safety summary

| Operation | When it runs | Reversible? | Approval needed |
|---|---|---|---|
| Auto-sanitization | Every workflow save (automatic) | Yes via undo / version history | No — trusted operator-structure fix only |
| `n8n_autofix_workflow` with `applyFixes: false` | Explicit, preview only | N/A — no changes | No |
| `n8n_autofix_workflow` with `applyFixes: true, confidenceThreshold: "high"` | Explicit | Yes via version history | Recommended on production workflows |
| `n8n_autofix_workflow` with `applyFixes: true, confidenceThreshold: "medium"` or `"low"` | Explicit | Yes via version history | **Required** — review before applying |

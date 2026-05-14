---
name: n8n-code-javascript
description: Write JavaScript code in n8n Code nodes. Use when writing JavaScript in n8n, using $input/$json/$node syntax, making HTTP requests with $helpers, working with dates using DateTime, troubleshooting Code node errors, or choosing between Code node modes.
---

# JavaScript Code Node

Expert guidance for writing JavaScript code in n8n Code nodes. **JavaScript is recommended for 95% of n8n Code use cases** — full `$helpers`, Luxon DateTime, no library limitations.

## Reference map

Reference material lives in `references/`. Load only what the current task needs.

| When | Read |
|---|---|
| Mode Selection full examples, Data Access Patterns 1–4 full code, Webhook body walkthrough | [`references/runtime-and-data-model.md`](references/runtime-and-data-model.md) · base detail: [`references/data-access.md`](references/data-access.md) |
| Production patterns (multi-source aggregate / regex filter / transform / top-N / aggregate-report) full code | [`references/javascript-patterns.md`](references/javascript-patterns.md) · base detail: [`references/common-patterns.md`](references/common-patterns.md) |
| `$helpers.httpRequest`, DateTime / Luxon, `$jmespath` full examples (POST, timezones, nested projections, error handling) | [`references/helpers-and-http.md`](references/helpers-and-http.md) · base detail: [`references/builtin-functions.md`](references/builtin-functions.md) |
| Return-format right/wrong, Top 5 mistakes, Best Practices full examples | [`references/validation-and-debugging.md`](references/validation-and-debugging.md) · base detail: [`references/error-patterns.md`](references/error-patterns.md) |
| End-to-end examples (webhook, API fetch + merge, group-by, multi-node combine, regex extract, per-item conditional, date-range filter) | [`references/examples.md`](references/examples.md) |

---

## Quick Start

```javascript
// Basic template for Code nodes
const items = $input.all();

// Process data
const processed = items.map(item => ({
  json: {
    ...item.json,
    processed: true,
    timestamp: new Date().toISOString()
  }
}));

return processed;
```

### Essential rules

1. **Choose "Run Once for All Items" mode** — default and recommended for most use cases.
2. **Access data**: `$input.all()`, `$input.first()`, or `$input.item`.
3. **CRITICAL**: must return `[{json: {...}}]` format (array of objects with `json` key).
4. **CRITICAL**: webhook data is under `$json.body`, not `$json` directly.
5. **Built-ins available**: `$helpers.httpRequest()`, `DateTime` (Luxon), `$jmespath()`.

---

## Mode Selection

| Mode | When | Data access | Performance |
|---|---|---|---|
| **Run Once for All Items** (default — 95% of cases) | Aggregation, filtering, batch processing, transformations, API calls with all data | `$input.all()` or `items` | Faster — single execution |
| **Run Once for Each Item** | Item-specific logic, independent operations, per-item validation | `$input.item` or `$item` | Slower for large datasets |

**Decision shortcut:** look at multiple items → All Items; each item completely independent → Each Item; not sure → All Items (you can always loop inside).

Full mode examples: [`references/runtime-and-data-model.md`](references/runtime-and-data-model.md#mode-selection--full-examples).

---

## Data Access Patterns

| Pattern | When |
|---|---|
| `$input.all()` | Processing arrays, batch operations, aggregations (most common) |
| `$input.first()` | Single objects, API responses, first-in-first-out |
| `$input.item` | Each-Item mode only |
| `$node["NodeName"].json` | Reference output of a specific upstream node |

Full per-pattern examples + comprehensive guide: [`references/runtime-and-data-model.md`](references/runtime-and-data-model.md#data-access-patterns--full-examples) and [`references/data-access.md`](references/data-access.md).

---

## Critical: Webhook Data Structure

**Most common JavaScript mistake.** Webhook data is nested under `.body`.

```javascript
// ❌ WRONG — returns undefined
const name = $json.name;

// ✅ CORRECT — webhook data is under .body
const name = $json.body.name;

// Or via $input
const webhookData = $input.first().json.body;
```

The Webhook node wraps POST data, query parameters, and JSON payloads under `body`. Full walkthrough: [`references/runtime-and-data-model.md`](references/runtime-and-data-model.md#webhook-data-structure--full-explanation).

---

## Return Format Requirements

**Critical rule**: always return an array of objects with a `json` property.

```javascript
// ✅ Single
return [{json: {field: value}}];

// ✅ Multiple
return [{json: {id: 1}}, {json: {id: 2}}];

// ✅ Empty
return [];

// ❌ Object not wrapped in array
return {json: {...}};

// ❌ Array without "json" key
return [{field: value}];

// ❌ Raw $input.all() without mapping
return $input.all();
```

Full right/wrong matrix: [`references/validation-and-debugging.md`](references/validation-and-debugging.md#return-format--full-examples). Detailed error solutions: [`references/error-patterns.md`](references/error-patterns.md).

---

## Common Patterns Overview

Production-tested patterns (full code in [`references/javascript-patterns.md`](references/javascript-patterns.md) and [`references/common-patterns.md`](references/common-patterns.md)):

1. **Multi-Source Data Aggregation** — combine data from multiple APIs / webhooks / nodes.
2. **Filtering with Regex** — extract patterns / mentions / keywords from text.
3. **Data Transformation & Enrichment** — map fields, normalize formats, add computed fields.
4. **Top N Filtering & Ranking** — `sort()` + `slice()` for ranked subsets.
5. **Aggregation & Reporting** — `reduce()` for sums / counts / averages.

---

## Error Prevention — Top 5 Mistakes

1. **Empty code or missing `return`** — always end with `return [...]`.
2. **Expression-syntax confusion** — don't use `{{ }}` inside Code nodes; use template literals `` `${...}` `` or direct `$input.first().json.field`.
3. **Incorrect return wrapper** — must be `[{json: ...}]`, not `{json: ...}`.
4. **Missing null checks** — use optional chaining (`?.`) or guard clauses.
5. **Webhook body nesting** — access via `$json.body.field`.

Full right/wrong examples for each: [`references/validation-and-debugging.md`](references/validation-and-debugging.md#top-5-mistakes--full-examples) and [`references/error-patterns.md`](references/error-patterns.md).

---

## Built-in Functions & Helpers

| Helper | Use |
|---|---|
| `$helpers.httpRequest(options)` | Make HTTP requests from inside the Code node (await). Always wrap in try/catch. |
| `DateTime` (Luxon) | Date/time operations — `DateTime.now()`, `.toFormat()`, `.toISO()`, `.plus({days})`, `.minus({weeks})`, `.setZone()`, `.fromISO()`. |
| `$jmespath(data, expr)` | Query JSON with JMESPath — filters, projections, expressions. |

Full examples (POST with JSON body, error handling, timezones, parsing, nested projections): [`references/helpers-and-http.md`](references/helpers-and-http.md) and [`references/builtin-functions.md`](references/builtin-functions.md).

---

## Best Practices

1. Always validate input data (`!items`, `items.length === 0`, structure check).
2. Use try/catch for `$helpers.httpRequest` and other error-prone operations.
3. Prefer array methods (`filter`/`map`/`reduce`) over manual loops.
4. Filter early, process late — reduce dataset before expensive transforms.
5. Use descriptive variable names — `activeUsers`, not `a`.
6. Debug with `console.log()` — output appears in the browser console.

Full examples for each: [`references/validation-and-debugging.md`](references/validation-and-debugging.md#best-practices--full-examples).

---

## When to Use Code Node

**Use Code node when:** complex transformations needing multiple steps, custom calculations or business logic, recursive operations, API response parsing with complex structure, multi-step conditionals, cross-item data aggregation.

**Consider other nodes when:** simple field mapping → **Set**; basic filtering → **Filter**; conditionals → **IF** / **Switch**; HTTP only → **HTTP Request**.

Code node excels at complex logic that would require chaining many simple nodes.

---

## Integration with Other Skills

- **n8n Expression Syntax** — expressions use `{{ }}` in other nodes; Code nodes use JavaScript directly (no `{{ }}`).
- **n8n MCP Tools Expert** — find Code node via `search_nodes({query: "code"})`; configure via `get_node({nodeType: "nodes-base.code"})`; validate via `validate_node({...})`.
- **n8n Node Configuration** — mode selection (All Items vs Each Item), language selection (JavaScript vs Python), property dependencies.
- **n8n Workflow Patterns** — Code nodes in transformation steps; Webhook → Code → API pattern; error handling.
- **n8n Validation Expert** — validate Code node configuration, handle validation errors, auto-fix.
- **n8n Code Python** — when to use Python instead; feature comparison.

---

## Quick Reference Checklist

Before deploying Code nodes, verify:

- [ ] **Code is not empty** — has meaningful logic.
- [ ] **Return statement exists** — must return array of objects.
- [ ] **Proper return format** — each item: `{json: {...}}`.
- [ ] **Data access correct** — `$input.all()`, `$input.first()`, or `$input.item`.
- [ ] **No n8n expressions** — use JavaScript template literals: `` `${value}` ``.
- [ ] **Error handling** — guard clauses for null/undefined inputs; try/catch around `$helpers`.
- [ ] **Webhook data** — accessed via `.body` if from webhook.
- [ ] **Mode selection** — "All Items" for most cases.
- [ ] **Performance** — prefer `map`/`filter` over manual loops.
- [ ] **Output consistent** — all code paths return the same structure.

---

## Additional Resources

### Reference files

- [`references/runtime-and-data-model.md`](references/runtime-and-data-model.md) — modes, data access, webhook body
- [`references/javascript-patterns.md`](references/javascript-patterns.md) — production patterns
- [`references/helpers-and-http.md`](references/helpers-and-http.md) — `$helpers`, DateTime, `$jmespath`
- [`references/validation-and-debugging.md`](references/validation-and-debugging.md) — return format, top mistakes, best practices
- [`references/examples.md`](references/examples.md) — end-to-end recipes
- [`references/data-access.md`](references/data-access.md) — comprehensive data-access guide
- [`references/common-patterns.md`](references/common-patterns.md) — 10 production-tested patterns
- [`references/error-patterns.md`](references/error-patterns.md) — comprehensive error guide
- [`references/builtin-functions.md`](references/builtin-functions.md) — complete built-in reference

### n8n documentation

- Code Node Guide: https://docs.n8n.io/code/code-node/
- Built-in Methods: https://docs.n8n.io/code-examples/methods-variables-reference/
- Luxon Documentation: https://moment.github.io/luxon/

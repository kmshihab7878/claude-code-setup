# JavaScript Code Workflow — mode selection, runtime, return format

Mode selection, runtime variables, and the full return-format matrix for n8n
JavaScript Code nodes. Pair with the upstream base references
(`common-patterns.md`, `data-access.md`) for depth.

## Workflow

1. **Choose the mode** — "Run Once for All Items" (default) vs "Run Once for Each Item".
2. **Read inputs** — `$input.all()` / `$input.first()` / `$input.item` /
   `$node["NodeName"].json`.
3. **Transform** — array methods (`map` / `filter` / `reduce`) preferred over manual loops.
4. **Return** — array of objects each containing a `json` key.
5. **Validate** — return shape, optional chaining for null safety, no `{{ }}`
   inside Code nodes.

## Mode Selection — full examples

### Run Once for All Items (default)

```javascript
const items = $input.all();
const doubled = items.map(item => ({
  json: { ...item.json, count: item.json.count * 2 }
}));
return doubled;
```

Use this for aggregation, filtering, batch processing, transformations,
API calls that need all upstream data. Single execution — faster on large
datasets.

### Run Once for Each Item

```javascript
const item = $input.item;
return [{
  json: { ...item.json, count: item.json.count * 2 }
}];
```

Use this for item-specific logic, independent operations, per-item validation.
Slower on large datasets — n8n executes the code once per item.

### Decision shortcut

- Multiple items? → All Items.
- Each item completely independent? → Each Item.
- Not sure? → All Items (you can always loop inside).

## Return Format — full matrix

```javascript
// RIGHT — single
return [{ json: { field: value } }];

// RIGHT — multiple
return [{ json: { id: 1 } }, { json: { id: 2 } }];

// RIGHT — empty (valid; skips downstream)
return [];

// WRONG — object not wrapped in array
return { json: { id: 1 } };

// WRONG — array without "json" key
return [{ id: 1 }];

// WRONG — raw $input.all() without mapping (loses { json } shape)
return $input.all();

// WRONG — missing return
const items = $input.all();
const processed = items.map(/* ... */);
// nothing returned -> n8n surfaces an empty result
```

Every code path in the script must return the same shape. Inconsistent return
shapes produce intermittent downstream failures that are hard to trace.

## Built-In Runtime

The JavaScript Code node ships with three first-class built-ins:

| Helper | Use |
|--------|-----|
| `$helpers.httpRequest(options)` | Make HTTP requests from inside the Code node (await). Always wrap in try/catch. |
| `DateTime` (Luxon) | Date / time operations — `DateTime.now()`, `.toFormat()`, `.toISO()`, `.plus({days})`, `.minus({weeks})`, `.setZone()`, `.fromISO()`. |
| `$jmespath(data, expr)` | Query JSON with JMESPath — filters, projections, expressions. |

Full helper examples: `references/helpers-and-integrations.md`.

## Webhook body — quick reminder

Webhook payloads sit under `.body`. Always:

```javascript
const name = $json.body?.name ?? "";
// or
const webhookData = $input.first().json.body;
```

Full webhook walkthrough: `references/item-and-data-patterns.md`.

## Cross-skill workflow

- **n8n MCP Tools Expert** — discover the Code node via `search_nodes({query: "code"})`,
  configure via `get_node({nodeType: "nodes-base.code"})`.
- **n8n Validation Expert** — validate via
  `validate_node({nodeType: "nodes-base.code", config: {...}})`.
- **n8n Node Configuration** — mode and language selection are properties of
  the Code node configuration.
- **n8n Code Python** — switch to Python only when you need `statistics` or
  Python-specific idioms; JavaScript is recommended for 95% of cases.

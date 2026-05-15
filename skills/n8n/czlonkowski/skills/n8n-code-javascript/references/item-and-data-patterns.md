# Item and Data Patterns — input shape, transforms, aggregation

Data access patterns, webhook body structure, and the 5 production-tested
JavaScript patterns. Upstream depth: `references/data-access.md` and
`references/common-patterns.md`.

## Data Access Patterns

| Pattern | When to use |
|---------|-------------|
| `$input.all()` | Processing arrays, batch operations, aggregations (most common) |
| `$input.first()` | Single objects, API responses, header records |
| `$input.item` | Each-Item mode only |
| `$node["NodeName"].json` | Reference output of a specific upstream node |

### `$input.all()`

```javascript
const items = $input.all();
const emails = items
  .map(it => it.json?.email)
  .filter(Boolean);
```

### `$input.first()`

```javascript
const first = $input.first();
const apiResponse = first.json;  // immediate upstream API result
```

### `$input.item`

```javascript
// Each-Item mode only — n8n calls the script once per item
const item = $input.item;
return [{ json: { ...item.json, stage: "processed" } }];
```

### Upstream node reference

```javascript
const http = $node["HTTP Request"].json;
const sheets = $node["Google Sheets"].json;
```

Use only when the data is not the immediate input. For the immediate input,
`$input.all()` / `$input.first()` is faster and survives upstream renames.

Full per-pattern depth + edge cases: `references/data-access.md`.

## Webhook Data Structure

Webhook payloads nest under `.body`. This is the single most common mistake.

```javascript
// WRONG — undefined if "name" isn't at the top level
const name = $json.name;

// CORRECT — explicit body access
const name = $json.body.name;

// SAFER — survives a missing body
const name = $json.body?.name ?? "";

// Or via $input
const webhookData = $input.first().json.body;
```

Other webhook fields:

| Path | Contains |
|------|----------|
| `$json.body` | POST body (form or JSON) |
| `$json.query` | URL query parameters |
| `$json.headers` | Request headers |
| `$json.params` | Path parameters |

Treat every field as possibly absent — `?.` (optional chaining) + `??` (nullish coalescing) is the safe default.

## Production Patterns

### 1. Multi-Source Data Aggregation

```javascript
const allItems = $input.all();
const fromApi = allItems.filter(it => it.json.source === "api");
const fromWebhook = allItems.filter(it => it.json.source === "webhook");

const merged = [...fromApi, ...fromWebhook].map(it => ({
  json: {
    id: it.json.id,
    payload: it.json.payload,
    received_at: it.json.received_at,
  },
}));
return merged;
```

### 2. Filtering with Regex

```javascript
const items = $input.all();
const mentionPattern = /@(\w+)/g;

const results = items.map(it => {
  const body = it.json.body ?? "";
  const mentions = [...body.matchAll(mentionPattern)].map(m => m[1]);
  return { json: { ...it.json, mentions } };
});
return results;
```

### 3. Data Transformation & Enrichment

```javascript
const items = $input.all();
return items.map(it => ({
  json: {
    id: it.json.id,
    full_name: `${it.json.first ?? ""} ${it.json.last ?? ""}`.trim(),
    email_normalized: (it.json.email ?? "").toLowerCase().trim(),
  },
}));
```

### 4. Top N Filtering & Ranking

```javascript
const items = $input.all();
const top10 = items
  .filter(it => it.json.score != null)
  .sort((a, b) => b.json.score - a.json.score)
  .slice(0, 10);
return top10;
```

### 5. Aggregation & Reporting

```javascript
const items = $input.all();
const total = items.reduce((sum, it) => sum + (it.json.revenue ?? 0), 0);
const count = items.length;
const avg = count > 0 ? total / count : 0;

return [{
  json: { count, total, avg },
}];
```

## Anti-Patterns at the Data-Access Layer

| Anti-pattern | Fix |
|--------------|-----|
| `$json.body.name` without `?.` | `$json.body?.name ?? ""` |
| Mixing `$input.item` with `$input.all()` in one script | Pick one mode; do not interleave |
| Reading from `$node[...]` when `$input.first()` would suffice | Prefer immediate input — survives upstream renames |
| Mutating `item.json` in place | Construct a new object: `{ json: { ...item.json, extra: v } }` |
| Returning `$input.all()` raw | Map first; never return the input unchanged |
| Using `{{ }}` inside the Code node body | Code nodes are pure JS — use template literals or direct access |

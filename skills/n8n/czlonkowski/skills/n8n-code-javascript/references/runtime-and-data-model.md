# n8n Runtime and Data Model — JavaScript

Detailed examples for n8n Code node runtime (modes, data access, webhook structure). The minimal rules live in `SKILL.md`; this file holds the long code examples.

## Mode Selection — full examples

### Run Once for All Items (default — 95% of cases)

- Code executes **once** regardless of input count.
- Data access: `$input.all()` or `items` array.
- Best for: aggregation, filtering, batch processing, transformations, API calls with all data.
- Faster for multiple items (single execution).

```javascript
// Calculate total from all items
const allItems = $input.all();
const total = allItems.reduce((sum, item) => sum + (item.json.amount || 0), 0);

return [{
  json: {
    total,
    count: allItems.length,
    average: total / allItems.length
  }
}];
```

**Use when:**

- Comparing items across the dataset
- Calculating totals, averages, statistics
- Sorting or ranking items
- Deduplication
- Building aggregated reports
- Combining data from multiple items

### Run Once for Each Item

- Code executes **separately** for each input item.
- Data access: `$input.item` or `$item`.
- Best for: item-specific logic, independent operations, per-item validation.
- Slower for large datasets (multiple executions).

```javascript
// Add processing timestamp to each item
const item = $input.item;

return [{
  json: {
    ...item.json,
    processed: true,
    processedAt: new Date().toISOString()
  }
}];
```

**Use when:**

- Each item needs an independent API call
- Per-item validation with different error handling
- Item-specific transformations based on item properties
- Items must be processed separately for business logic

**Decision shortcut:**

- Need to look at multiple items? → "All Items" mode
- Each item completely independent? → "Each Item" mode
- Not sure? → "All Items" mode (you can always loop inside)

## Data Access Patterns — full examples

### Pattern 1: `$input.all()` — most common

Use when: processing arrays, batch operations, aggregations.

```javascript
const allItems = $input.all();

const valid = allItems.filter(item => item.json.status === 'active');
const mapped = valid.map(item => ({
  json: {
    id: item.json.id,
    name: item.json.name
  }
}));

return mapped;
```

### Pattern 2: `$input.first()` — very common

Use when: working with single objects, API responses, first-in-first-out.

```javascript
const firstItem = $input.first();
const data = firstItem.json;

return [{
  json: {
    result: processData(data),
    processedAt: new Date().toISOString()
  }
}];
```

### Pattern 3: `$input.item` — Each Item mode only

```javascript
const currentItem = $input.item;

return [{
  json: {
    ...currentItem.json,
    itemProcessed: true
  }
}];
```

### Pattern 4: `$node` — reference other nodes

Use when: combining data from multiple workflow nodes.

```javascript
const webhookData = $node["Webhook"].json;
const httpData = $node["HTTP Request"].json;

return [{
  json: {
    combined: {
      webhook: webhookData,
      api: httpData
    }
  }
}];
```

See [data-access.md](data-access.md) for the comprehensive guide.

## Webhook Data Structure — full explanation

**Most common JavaScript mistake**: webhook data is nested under `.body`.

```javascript
// ❌ WRONG — returns undefined
const name = $json.name;
const email = $json.email;

// ✅ CORRECT — webhook data is under .body
const name = $json.body.name;
const email = $json.body.email;

// Or with $input
const webhookData = $input.first().json.body;
const name = webhookData.name;
```

**Why**: the Webhook node wraps all request data under the `body` property — POST data, query parameters, JSON payloads.

See [data-access.md](data-access.md) for the full webhook structure walkthrough.

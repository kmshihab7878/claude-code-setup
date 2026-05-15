# Helpers and Integrations

`$helpers.httpRequest`, `DateTime` (Luxon), and `$jmespath` with examples for
the most common operations. Upstream depth: `references/builtin-functions.md`.

## `$helpers.httpRequest` — HTTP in the Code node

The JavaScript Code node can make HTTP requests **directly**. This is the
primary reason to choose JavaScript over Python for any node that needs both
custom logic and an HTTP call.

### Basic GET

```javascript
const response = await $helpers.httpRequest({
  method: "GET",
  url: "https://api.example.com/items",
});

return response.data.map(it => ({ json: { id: it.id, name: it.name } }));
```

### POST with JSON body

```javascript
const items = $input.all();

const responses = [];
for (const it of items) {
  try {
    const res = await $helpers.httpRequest({
      method: "POST",
      url: "https://api.example.com/events",
      body: { id: it.json.id, payload: it.json.payload },
      json: true,
    });
    responses.push({ json: { ok: true, id: it.json.id, result: res } });
  } catch (err) {
    responses.push({ json: { ok: false, id: it.json.id, error: err.message } });
  }
}
return responses;
```

### Authentication

| Auth type | Pattern |
|-----------|---------|
| API key in header | Set `headers: { Authorization: "Bearer ..." }` from credentials |
| Basic auth | Pass `auth: { username, password }` |
| OAuth | Prefer n8n's built-in OAuth credential type — do not hand-roll |

Never embed credentials in source. Read from `$credentials.<name>.<field>` or
configure on the node.

### Error handling

Wrap every call in try/catch. Retries for transient errors should sleep
between attempts:

```javascript
async function withRetry(fn, attempts = 3) {
  for (let i = 0; i < attempts; i++) {
    try { return await fn(); }
    catch (err) {
      if (i === attempts - 1) throw err;
      await new Promise(r => setTimeout(r, 500 * (2 ** i)));
    }
  }
}

const res = await withRetry(() =>
  $helpers.httpRequest({ method: "GET", url: "https://api.example.com" })
);
```

Retry only transient failures (timeouts, 5xx, rate-limit with `Retry-After`).
Never retry validation errors or auth failures.

## `DateTime` — Luxon

Luxon ships with the Code node. No `import` needed; use `DateTime` directly.

### Common operations

```javascript
const now = DateTime.now();                              // current
const iso = DateTime.now().toISO();                      // "2026-05-15T..."
const formatted = DateTime.now().toFormat("yyyy-LL-dd"); // "2026-05-15"
const inThreeDays = DateTime.now().plus({ days: 3 });
const aMonthAgo = DateTime.now().minus({ months: 1 });
const parsed = DateTime.fromISO("2026-05-15T09:00:00Z");
```

### Time zones

```javascript
const nyTime = DateTime.now().setZone("America/New_York");
const tokyoTime = DateTime.now().setZone("Asia/Tokyo");

// From an ISO string in a specific zone
const dt = DateTime.fromISO("2026-05-15T09:00:00", { zone: "Europe/Warsaw" });
```

Always pin the time zone explicitly when crossing zones. Defaults to the
n8n server time zone, which is rarely the right answer for cross-region work.

### Diffs and ranges

```javascript
const a = DateTime.fromISO("2026-01-01");
const b = DateTime.fromISO("2026-05-15");
const diff = b.diff(a, ["days", "hours"]).toObject();
// { days: 134, hours: 0 }
```

### Date-range filter pattern

```javascript
const items = $input.all();
const sevenDaysAgo = DateTime.now().minus({ days: 7 });
const recent = items.filter(it => {
  const ts = DateTime.fromISO(it.json.timestamp);
  return ts.isValid && ts > sevenDaysAgo;
});
return recent;
```

## `$jmespath` — JSON queries

For nested data, `$jmespath` is often clearer than chained optional chaining.

### Filter + project

```javascript
const response = $input.first().json;
// Pull names of active users
const activeNames = $jmespath(response, "users[?status=='active'].name");
return activeNames.map(name => ({ json: { name } }));
```

### Multi-projection

```javascript
const data = $input.first().json;
const summary = $jmespath(data, `{
  active_count: length(users[?status=='active']),
  total_count: length(users),
  emails: users[*].email
}`);
return [{ json: summary }];
```

Falls back to plain JS when:

- The query is trivial (one or two `?.` chains read better than JMESPath).
- You need conditional transformations (write JS for that).

## Multi-Request Orchestration

For pagination or multi-endpoint fan-out:

```javascript
const allResults = [];
let cursor = null;

do {
  const url = cursor
    ? `https://api.example.com/items?cursor=${cursor}`
    : `https://api.example.com/items`;
  const res = await $helpers.httpRequest({ method: "GET", url });
  allResults.push(...res.data);
  cursor = res.next_cursor;
} while (cursor);

return allResults.map(r => ({ json: r }));
```

Cursor-based loops bound memory and let the workflow resume from a known
position. Prefer cursor over offset for any non-trivial dataset.

## Decision Table — "I need to interact with an external service"

| Situation | Pattern |
|-----------|---------|
| Stable GET / POST, predictable schema | HTTP Request node → Code node (transform only) |
| Custom logic that depends on HTTP result | `$helpers.httpRequest` inside the Code node |
| Pagination loop | Code node with cursor-based loop |
| OAuth | n8n credential type on HTTP Request node; never hand-roll |
| Webhook verification (HMAC) | Code node with `crypto` operations on `$json.body` + headers |
| Long-running upstream call | Split into receive (202) + follow-on workflow; do not block in the Code node |

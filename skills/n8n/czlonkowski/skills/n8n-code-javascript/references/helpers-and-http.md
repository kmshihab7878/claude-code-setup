# Built-in Helpers and HTTP — n8n JavaScript Code Node

`$helpers`, DateTime (Luxon), `$jmespath`. Full reference: [builtin-functions.md](builtin-functions.md). The minimal one-line summaries live in `SKILL.md`.

## `$helpers.httpRequest()`

Make HTTP requests from within a Code node.

```javascript
const response = await $helpers.httpRequest({
  method: 'GET',
  url: 'https://api.example.com/data',
  headers: {
    'Authorization': 'Bearer token',
    'Content-Type': 'application/json'
  }
});

return [{json: {data: response}}];
```

### POST with JSON body

```javascript
const response = await $helpers.httpRequest({
  method: 'POST',
  url: 'https://api.example.com/users',
  headers: {
    'Authorization': 'Bearer token',
    'Content-Type': 'application/json'
  },
  body: {
    name: 'Jane',
    email: 'jane@example.com'
  },
  json: true   // serialize body as JSON
});

return [{json: response}];
```

### With error handling

Always wrap network calls in try/catch — see [validation-and-debugging.md](validation-and-debugging.md#2-use-try-catch-for-error-handling).

```javascript
try {
  const response = await $helpers.httpRequest({
    url: 'https://api.example.com/data'
  });
  return [{json: {success: true, data: response}}];
} catch (error) {
  return [{
    json: {success: false, error: error.message}
  }];
}
```

## DateTime (Luxon)

Date and time operations powered by Luxon.

```javascript
// Current time
const now = DateTime.now();

// Format dates
const formatted = now.toFormat('yyyy-MM-dd');
const iso = now.toISO();

// Date arithmetic
const tomorrow = now.plus({days: 1});
const lastWeek = now.minus({weeks: 1});

return [{
  json: {
    today: formatted,
    tomorrow: tomorrow.toFormat('yyyy-MM-dd')
  }
}];
```

### Parsing and timezones

```javascript
// Parse ISO string
const event = DateTime.fromISO('2026-05-15T14:30:00Z');

// Convert timezone
const local = event.setZone('America/New_York');

// Comparison
const isPast = event < DateTime.now();
```

Full Luxon reference: https://moment.github.io/luxon/

## `$jmespath()`

Query JSON structures with JMESPath syntax.

```javascript
const data = $input.first().json;

// Filter array
const adults = $jmespath(data, 'users[?age >= `18`]');

// Extract fields
const names = $jmespath(data, 'users[*].name');

return [{json: {adults, names}}];
```

### Nested projections

```javascript
const data = $input.first().json;

// Pick specific properties across an array
const summary = $jmespath(data, 'orders[*].{id: id, total: items[*].price | sum(@)}');

return [{json: {summary}}];
```

See [builtin-functions.md](builtin-functions.md) for the complete reference.

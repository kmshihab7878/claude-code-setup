# Validation, Troubleshooting, and Anti-Patterns

Top mistakes, best practices, and a debugging playbook. Upstream depth:
`references/error-patterns.md`.

## Return Format — right/wrong

```javascript
// RIGHT — single
return [{ json: { field: value } }];

// RIGHT — multiple
return [{ json: { id: 1 } }, { json: { id: 2 } }];

// RIGHT — empty
return [];

// WRONG — object not wrapped in array
return { json: { id: 1 } };

// WRONG — array without "json" key
return [{ id: 1 }];

// WRONG — raw $input.all() without mapping
return $input.all();

// WRONG — missing return statement
const items = $input.all();
const result = items.map(/* ... */);
```

Every code path must return the same shape. Branches that return different
shapes produce intermittent downstream failures.

## Top 5 Mistakes

### 1. Empty code or missing `return`

```javascript
// WRONG — no return
const items = $input.all();
const processed = items.filter(it => it.json.active);

// RIGHT
const items = $input.all();
const processed = items.filter(it => it.json.active);
return processed;
```

If the filter is meant to produce zero items, `return []` is the correct shape.

### 2. Expression-syntax confusion

```javascript
// WRONG — n8n expressions inside the Code node body
const name = {{$json.body.name}};

// RIGHT — direct JavaScript access
const name = $json.body.name;

// RIGHT — template literal for string concatenation
const greeting = `Hello, ${$json.body.name}`;
```

Code nodes execute pure JavaScript. The `{{ }}` syntax is for expressions in
**other** nodes (Set, IF, HTTP Request parameters).

### 3. Incorrect return wrapper

```javascript
// WRONG — flat object
return { json: { id: 1 } };

// RIGHT
return [{ json: { id: 1 } }];
```

### 4. Missing null checks

```javascript
// WRONG — crashes if body is missing
const name = $json.body.name;

// RIGHT — optional chaining + nullish coalescing
const name = $json.body?.name ?? "";

// RIGHT — guard clause
if (!$json.body) {
  return [{ json: { error: "missing body" } }];
}
```

### 5. Webhook body nesting

```javascript
// WRONG
const name = $json.name;

// RIGHT
const name = $json.body?.name ?? "";
```

Webhook payloads sit under `.body`. See
`references/item-and-data-patterns.md` for the full webhook field map.

## Best Practices

1. **Validate input first** — `!items`, `items.length === 0`, structure shape.
2. **Use `try`/`catch` for `$helpers.httpRequest`** and any operation that can throw.
3. **Prefer array methods** (`filter` / `map` / `reduce`) over manual loops.
4. **Filter early, process late** — reduce dataset before expensive transforms.
5. **Use descriptive variable names** — `activeUsers`, not `a`.
6. **Debug with `console.log()`** — output appears in the browser console (F12).
7. **Construct new objects, do not mutate input** — `{ json: { ...item.json, extra: v } }`.
8. **Consistent return shape on every branch** — including the empty case.

## Validation Gates

Before deploying a JavaScript Code node:

- [ ] Code is not empty.
- [ ] Final `return` statement exists.
- [ ] Return shape is `[{ json: { ... } }, ...]` on every code path.
- [ ] Data access uses only `$input.all()` / `$input.first()` / `$input.item` /
      `$node["..."].json`.
- [ ] No `{{ }}` expression syntax inside the Code node body.
- [ ] Optional chaining (`?.`) and nullish coalescing (`??`) used for nullable fields.
- [ ] Webhook data accessed via `$json.body?.<field>`.
- [ ] `try`/`catch` wraps every `$helpers.httpRequest` and other throwables.
- [ ] Mode is "All Items" unless per-item independence is required.
- [ ] Output is consistent across every branch and exception path.
- [ ] Time zones pinned explicitly on any `DateTime` value that crosses zones.

## Debugging Playbook

| Symptom | First check | Likely cause |
|---------|-------------|--------------|
| Empty output downstream | Final return statement | Missing return, or `return []` |
| `undefined` on a field | The field path | Missing `?.` or wrong nesting (webhook `.body`) |
| Output appears as one item, not many | The return shape | Returned a single object instead of an array |
| Intermittent downstream failure | All return paths | Inconsistent return shape across branches |
| `$helpers.httpRequest` hangs | Network or auth | Add `try`/`catch`, log status code, verify credentials |
| `DateTime` math gives surprising result | Time zone | `setZone` explicitly; do not rely on server default |
| `{{$json.x}}` shows up literally in output | Expression syntax in Code node | Replace with direct JS access |
| Mode mismatch (Each-Item using `$input.all()`) | Wrong cardinality | Match accessor to mode |
| Rate-limited by external API | Loop frequency | Add backoff in `withRetry`; or split via batches in workflow |

## Anti-Patterns

| Anti-pattern | Symptom | Fix |
|--------------|---------|-----|
| Returning raw `$input.all()` | Downstream sees `{ json }` wrappers but with extra metadata | Always `.map(...)` to produce a fresh `{ json }` shape |
| Manual `for` loop where `map` works | Slower, harder to read | Use array methods |
| Hand-rolled retry without backoff | Hammers failing endpoint | Exponential backoff in `withRetry` |
| `console.log` left in production | Floods browser console; obscures real errors | Remove or gate on a debug flag |
| Mutating `item.json` in place | Downstream nodes see unexpected state | Construct new objects |
| Catching every exception silently | Silent data loss | Re-raise or return an error item with `valid: false` |
| Time zone defaulted | Off-by-hour bugs across regions / DST | Pin every `DateTime` with `.setZone(...)` |
| Pagination via offset on large datasets | Drift / duplicate / missed rows | Use cursor-based pagination |
| Storing credentials in source | Secrets in exports | Use n8n credential storage |

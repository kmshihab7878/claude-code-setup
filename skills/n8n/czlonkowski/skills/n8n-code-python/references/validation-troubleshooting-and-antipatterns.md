# Validation, Troubleshooting, and Anti-Patterns

Top mistakes, best practices, no-libraries workarounds, and a debugging
playbook. Upstream depth: `references/error-patterns.md`.

## Return Format — right/wrong

```python
# RIGHT — single
return [{"json": {"field": value}}]

# RIGHT — multiple
return [{"json": {"id": 1}}, {"json": {"id": 2}}]

# RIGHT — empty
return []

# WRONG — dict not wrapped in list
return {"json": {...}}

# WRONG — list without "json" key
return [{"field": value}]

# WRONG — missing return statement (n8n returns nothing)
items = _input.all()
result = [...]
```

Every code path must return the same shape. Branches that return different
shapes produce intermittent downstream failures.

## Top 5 Mistakes

### 1. Importing external libraries

```python
# WRONG
import requests
import pandas as pd

# RIGHT
# Use the HTTP Request node, or switch to JavaScript for HTTP.
# Replace pandas with stdlib statistics and list comprehensions.
```

`ModuleNotFoundError` on every PyPI package. See
`references/api-requests-and-integrations.md` for the HTTP path.

### 2. Empty code or missing `return`

```python
# WRONG — no return
items = _input.all()
processed = [it for it in items if it["json"].get("active")]

# RIGHT
items = _input.all()
processed = [it for it in items if it["json"].get("active")]
return processed
```

Every code path needs a return. If the script is meant to filter to zero
items, `return []` is the correct shape.

### 3. Incorrect return format

```python
# WRONG — flat dict
return {"json": {"id": 1}}

# RIGHT
return [{"json": {"id": 1}}]
```

### 4. KeyError on dictionary access

```python
# WRONG
name = _json["body"]["name"]  # KeyError if body or name is missing

# RIGHT
name = _json.get("body", {}).get("name", "")
```

Treat every dictionary field as possibly absent. `.get()` everywhere.

### 5. Webhook body nesting

```python
# WRONG
name = _json["name"]

# RIGHT
name = _json.get("body", {}).get("name")
```

Webhook payloads sit under `["body"]`. See
`references/item-and-data-patterns.md` for the full webhook field map.

## Best Practices

1. **`.get()` everywhere** — `dict.get(key, default)` instead of `dict[key]`.
2. **Handle None / null explicitly** — `value or 0`, `if x is None: ...`.
3. **List comprehensions for filtering and mapping** — clearer than manual loops.
4. **Consistent return shape on every branch** — all branches return `[{"json": ...}]`.
5. **Debug with `print()`** — output appears in the browser console (F12).
6. **Construct new dicts, do not mutate input** — `{**item["json"], "extra": v}`.
7. **Validate at the boundary** — first thing in the script: confirm required fields.

## No External Libraries — Workaround Detail

| Need | Stdlib path | When to switch to JavaScript |
|------|-------------|------------------------------|
| HTTP request | None — use HTTP Request node | Always when one node must combine HTTP + logic |
| DataFrame / pandas | `statistics`, list comprehensions, `csv` | When you need pandas-shaped operations |
| numpy arrays | Manual list / list-of-list math | When linear algebra is required |
| BeautifulSoup / lxml | `re` (last resort) | Always — use HTML Extract node |
| YAML | `json` (if upstream can emit JSON) | When you must parse YAML |
| Async HTTP | None | Always — use Split In Batches + HTTP Request |
| ML inference | None | Always — use a dedicated node or external service |

Trying to "make it work" with stdlib alone for HTTP, scraping, or DataFrame
operations consistently produces brittle code. The supported path is to use
an upstream node or switch to JavaScript — accept it early.

## Debugging Playbook

| Symptom | First check | Likely cause |
|---------|-------------|--------------|
| `ModuleNotFoundError` | The `import` line | Trying to use a third-party library |
| Empty output downstream | Final return statement | Missing return, or `return []` |
| `KeyError` | The key path | Field is optional; use `.get()` |
| `TypeError: NoneType` | The variable that's `None` | Missing field handled implicitly; use `or` default |
| Intermittent downstream failure | All return paths | Inconsistent return shape across branches |
| "It works locally not in n8n" | Mode + Beta vs Native | Mode mismatch; Beta variables don't exist in Native |
| Webhook fields all missing | Webhook node "body" path | Reading `_json["name"]` instead of `_json["body"]["name"]` |
| Output appears as one item, not many | The return shape | Returned a single dict instead of a list |

## Validation Gates

Before deploying a Python Code node:

- [ ] Considered JavaScript first — Python is the right choice.
- [ ] Code is not empty and has a meaningful body.
- [ ] Final `return` statement exists.
- [ ] Return shape is `[{"json": {...}}, ...]` on every code path.
- [ ] Data access uses `_input.all()` / `_input.first()` / `_input.item` /
      `_node["..."]["json"]` — no other accessors.
- [ ] No external library imports — stdlib only.
- [ ] Dictionary access uses `.get(key, default)`.
- [ ] Webhook data accessed via `_json.get("body", {})`.
- [ ] Mode is "All Items" unless per-item independence is required.
- [ ] Output is consistent across every branch and exception path.

## Anti-Patterns

| Anti-pattern | Symptom | Fix |
|--------------|---------|-----|
| Library import | `ModuleNotFoundError` | Use upstream node or JavaScript |
| Top-level KeyError | Single missing field aborts the node | `.get()` everywhere |
| Mutating input items | Downstream nodes see unexpected state | Construct new dicts |
| Different return shapes per branch | Intermittent downstream failure | Normalize before return |
| Hand-rolling auth | Credentials in source | Use n8n credential nodes |
| Catching every exception silently | Silent data loss | Re-raise or return an error item with `valid: False` |
| Mode mismatch (Each-Item using `_input.all()`) | Wrong cardinality | Match mode to accessor |
| Regex on HTML for production scraping | Brittle, breaks on markup change | HTML Extract node |

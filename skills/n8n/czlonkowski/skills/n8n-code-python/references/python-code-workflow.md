# Python Code Workflow — mode selection, runtime, and return format

Mode selection, Python (Beta) vs Native helpers, the full return-format matrix,
and the canonical workflow for writing an n8n Python Code node. Pair with the
upstream base references (`common-patterns.md`, `data-access.md`) for depth.

## Workflow

1. **Decide the language** — JavaScript first for 95% of cases. Python only
   when you need `statistics`, are significantly more comfortable in Python,
   or when the transform maps cleanly to Python idioms.
2. **Pick the mode** — Run Once for All Items (default) vs Run Once for Each Item.
3. **Pick the runtime** — Python (Beta) for full n8n integration; Native only
   when you need its variables specifically.
4. **Read inputs** — `_input.all()` / `_input.first()` / `_input.item` /
   `_node["NodeName"]["json"]`.
5. **Transform** — list comprehensions over input items; use stdlib only.
6. **Return** — list of dicts each containing a `"json"` key.
7. **Validate** — confirm the return shape, dictionary access uses `.get()`,
   no external imports.

## Mode Selection — full examples

### Run Once for All Items (default)

```python
items = _input.all()
results = [
    {"json": {**item["json"], "doubled": item["json"]["count"] * 2}}
    for item in items
]
return results
```

Use this for aggregation, filtering, batch processing, transformations.
Single execution; faster on large datasets.

### Run Once for Each Item

```python
item = _input.item
return [{
    "json": {**item["json"], "doubled": item["json"]["count"] * 2}
}]
```

Use this for item-specific logic, independent operations, per-item
validation. Slower on large datasets — n8n executes the code once per item.

## Python Modes: Beta vs Native — full examples

### Python (Beta) — recommended

```python
items = _input.all()
node_data = _node["HTTP Request"]["json"]
now = _now  # datetime helper
today = _today
filtered = _jmespath(items, "[?json.active == `true`]")

return [{"json": {"count": len(items), "now": now.isoformat()}}]
```

Variables: `_input`, `_json`, `_node`.
Helpers: `_now`, `_today`, `_jmespath()`.

### Python (Native, Beta)

```python
items = _items  # list-of-dicts shape
single = _item

return [{"json": {"count": len(items)}}]
```

Variables: `_items`, `_item` only. No helpers.

Use Beta unless you specifically need Native semantics. Native is harder to
maintain because the n8n documentation primarily targets the Beta runtime.

## Return Format — full matrix

```python
# Single item
return [{"json": {"field": value}}]

# Multiple items
return [{"json": {"id": 1}}, {"json": {"id": 2}}]

# Empty (valid — skips downstream)
return []

# WRONG — dict not wrapped in a list
return {"json": {...}}

# WRONG — list without "json" key
return [{"field": value}]

# WRONG — missing return
items = _input.all()
processed = [...]
# nothing returned -> n8n surfaces an empty result
```

Every branch in the code must return the same shape. Inconsistent return
shapes produce intermittent downstream failures that are hard to trace.

## Webhook body — quick reminder

Webhook payloads sit under `["body"]`. Always:

```python
data = _json.get("body", {})
name = data.get("name", "")
```

Full webhook-body walkthrough: `references/item-and-data-patterns.md`.

## Cross-skill workflow

- **n8n MCP Tools Expert** — discover the Code node via
  `search_nodes({query: "code"})`, configure via `get_node({nodeType: "nodes-base.code"})`.
- **n8n Validation Expert** — validate via
  `validate_node({nodeType: "nodes-base.code", config: {...}})`.
- **n8n Node Configuration** — mode and language selection are properties of
  the Code node configuration, not of the Python runtime.

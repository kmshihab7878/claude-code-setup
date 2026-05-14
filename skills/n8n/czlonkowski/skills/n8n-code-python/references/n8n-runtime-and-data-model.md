# n8n Runtime and Data Model — Python

Detailed examples for n8n Code node runtime (modes, helpers, data access, webhook structure). The minimal rules live in `SKILL.md`; this file holds the longer code examples.

## Mode Selection — full examples

n8n Code nodes run in one of two modes:

### Run Once for All Items (default — 95% of cases)

- Code executes **once** regardless of input count
- Access via `_input.all()` (Beta) or `_items` (Native)
- Best for: aggregation, filtering, batch processing
- Faster for multiple items (single execution)

```python
# Calculate total from all items
all_items = _input.all()
total = sum(item["json"].get("amount", 0) for item in all_items)

return [{
    "json": {
        "total": total,
        "count": len(all_items),
        "average": total / len(all_items) if all_items else 0
    }
}]
```

### Run Once for Each Item

- Code executes **separately** for each input item
- Access via `_input.item` (Beta) or `_item` (Native)
- Best for: item-specific logic, independent operations, per-item validation
- Slower for large datasets

```python
# Add processing timestamp to each item
item = _input.item

return [{
    "json": {
        **item["json"],
        "processed": True,
        "processed_at": datetime.now().isoformat()
    }
}]
```

## Python Modes: Beta vs Native — full examples

### Python (Beta) — recommended

- Helper syntax: `_input`, `_json`, `_node`, `_now`, `_today`, `_jmespath()`
- Best for: most Python use cases
- Better n8n integration

```python
items = _input.all()
now = _now  # Built-in datetime object

return [{
    "json": {
        "count": len(items),
        "timestamp": now.isoformat()
    }
}]
```

### Python (Native) (Beta)

- Variables only: `_items`, `_item`
- No `_input`, `_now`, etc.
- More limited — pure Python

```python
processed = []

for item in _items:
    processed.append({
        "json": {
            "id": item["json"].get("id"),
            "processed": True
        }
    })

return processed
```

**Recommendation:** Python (Beta) for better n8n integration.

## Data Access Patterns — full examples

### Pattern 1: `_input.all()` — most common

Use when: processing arrays, batch operations, aggregations.

```python
all_items = _input.all()

valid = [item for item in all_items if item["json"].get("status") == "active"]

processed = []
for item in valid:
    processed.append({
        "json": {
            "id": item["json"]["id"],
            "name": item["json"]["name"]
        }
    })

return processed
```

### Pattern 2: `_input.first()` — very common

Use when: working with single objects, API responses.

```python
first_item = _input.first()
data = first_item["json"]

return [{
    "json": {
        "result": process_data(data),
        "processed_at": datetime.now().isoformat()
    }
}]
```

### Pattern 3: `_input.item` — Each Item mode only

```python
current_item = _input.item

return [{
    "json": {
        **current_item["json"],
        "item_processed": True
    }
}]
```

### Pattern 4: `_node` — reference other nodes

Use when: combining data from multiple nodes in the workflow.

```python
webhook_data = _node["Webhook"]["json"]
http_data = _node["HTTP Request"]["json"]

return [{
    "json": {
        "combined": {
            "webhook": webhook_data,
            "api": http_data
        }
    }
}]
```

See [data-access.md](data-access.md) for the comprehensive guide.

## Webhook Data Structure — full explanation

**Most common Python mistake**: webhook data is nested under `["body"]`.

```python
# ❌ WRONG — raises KeyError
name = _json["name"]
email = _json["email"]

# ✅ CORRECT — webhook data is under ["body"]
name = _json["body"]["name"]
email = _json["body"]["email"]

# ✅ SAFER — use .get() for safe access
webhook_data = _json.get("body", {})
name = webhook_data.get("name")
```

**Why**: the Webhook node wraps all request data under the `body` property — POST data, query parameters, JSON payloads.

See [data-access.md](data-access.md) for the full webhook structure walkthrough.

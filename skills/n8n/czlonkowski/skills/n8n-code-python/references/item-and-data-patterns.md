# Item and Data Patterns — input shape, transforms, aggregation

Data access patterns, webhook body structure, and the 5 production-tested
transformation/filter/regex/validate/stats patterns. Upstream depth:
`references/data-access.md` and `references/common-patterns.md`.

## Data Access Patterns

| Pattern | When to use |
|---------|-------------|
| `_input.all()` | Processing arrays, batch operations, aggregations (most common) |
| `_input.first()` | Single objects, API responses, header records |
| `_input.item` | Each-Item mode only |
| `_node["NodeName"]["json"]` | Reference output of a specific upstream node |

### `_input.all()`

```python
items = _input.all()
# items is a list; each item has "json" and optional "binary" keys
emails = [it["json"]["email"] for it in items if it["json"].get("email")]
```

### `_input.first()`

```python
first = _input.first()
api_response = first["json"]  # the upstream API result
```

### `_input.item`

```python
# Each-Item mode only — n8n calls the script once per input item
item = _input.item
return [{"json": {**item["json"], "stage": "processed"}}]
```

### Upstream node reference

```python
http = _node["HTTP Request"]["json"]
sheets = _node["Google Sheets"]["json"]
```

Reference an upstream node only when the data is not the immediate input.
For the immediate input, `_input.all()` / `_input.first()` is faster and
more robust to renames.

Full per-pattern depth + edge cases: `references/data-access.md`.

## Webhook Data Structure

The Webhook node wraps POST data, query parameters, and JSON payloads under
`["body"]`. This is the single most common Python mistake.

```python
# WRONG — KeyError if "name" is not at the top level
name = _json["name"]

# CORRECT — explicit body access
name = _json["body"]["name"]

# SAFER — survives a missing body
name = _json.get("body", {}).get("name")
```

Other webhook fields:

| Path | Contains |
|------|----------|
| `_json["body"]` | POST body (form or JSON) |
| `_json["query"]` | URL query parameters |
| `_json["headers"]` | Request headers |
| `_json["params"]` | Path parameters |

Treat every field as possibly absent — `_json.get("body", {}).get(...)` is
the safe default.

## Production Patterns

### 1. Data Transformation

```python
items = _input.all()
results = [
    {
        "json": {
            "id": it["json"]["id"],
            "full_name": f"{it['json'].get('first', '')} {it['json'].get('last', '')}".strip(),
            "email_normalized": it["json"].get("email", "").lower().strip(),
        }
    }
    for it in items
]
return results
```

### 2. Filtering & Aggregation

```python
items = _input.all()
active = [it for it in items if it["json"].get("active") is True]
total_revenue = sum(it["json"].get("revenue", 0) for it in active)

return [{
    "json": {
        "active_count": len(active),
        "total_revenue": total_revenue,
    }
}]
```

### 3. String Processing with Regex

```python
import re

items = _input.all()
url_pattern = re.compile(r"https?://[^\s]+")

results = []
for it in items:
    body = it["json"].get("body", "")
    urls = url_pattern.findall(body)
    cleaned = re.sub(url_pattern, "[link]", body)
    results.append({"json": {"urls": urls, "cleaned": cleaned}})

return results
```

### 4. Data Validation

```python
items = _input.all()

results = []
for it in items:
    j = it["json"]
    errors = []
    if not j.get("email") or "@" not in j["email"]:
        errors.append("invalid email")
    if not isinstance(j.get("amount"), (int, float)):
        errors.append("amount missing or non-numeric")
    results.append({
        "json": {**j, "valid": not errors, "errors": errors}
    })

return results
```

### 5. Statistical Analysis

```python
import statistics

items = _input.all()
values = [it["json"]["score"] for it in items if "score" in it["json"]]

return [{
    "json": {
        "n": len(values),
        "mean": statistics.mean(values) if values else 0,
        "median": statistics.median(values) if values else 0,
        "stdev": statistics.stdev(values) if len(values) > 1 else 0,
    }
}]
```

## Stdlib Quick Reference

Only the Python standard library is available. Most relevant modules:

| Module | Use for |
|--------|---------|
| `json` | Parsing or emitting JSON payloads not already on `_json` |
| `datetime` | Dates, timezones, ISO formatting |
| `re` | Pattern matching, substitution, extraction |
| `base64` | Encoding for Basic Auth or media |
| `hashlib` | Checksums, signatures |
| `urllib.parse` | URL encoding/decoding, query string handling |
| `math`, `random` | Numeric helpers |
| `statistics` | mean / median / stdev / variance |

Full stdlib catalog with examples: `references/standard-library.md`.

## Anti-Patterns at the Data-Access Layer

| Anti-pattern | Fix |
|--------------|-----|
| `_json["body"]["name"]` without `.get()` | `_json.get("body", {}).get("name")` |
| Mixing Beta and Native variables in one script | Pick one runtime; do not interleave |
| Reading from `_node[...]` when `_input.first()` would suffice | Prefer immediate input — survives upstream rename |
| Mutating `item["json"]` in place | Construct a new dict; return list of new items |
| Returning a single dict instead of a list | Always wrap in a list with `"json"` keys |

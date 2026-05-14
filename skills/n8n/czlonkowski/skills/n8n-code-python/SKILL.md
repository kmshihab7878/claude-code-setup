---
name: n8n-code-python
description: Write Python code in n8n Code nodes. Use when writing Python in n8n, using _input/_json/_node syntax, working with standard library, or need to understand Python limitations in n8n Code nodes.
---

# Python Code Node (Beta)

Expert guidance for writing Python code in n8n Code nodes.

## Reference map

Reference material lives in `references/`. Load only what the current task needs.

| When | Read |
|---|---|
| Mode selection, Python (Beta) vs Native helpers, data access patterns, webhook body structure — full examples | [`references/n8n-runtime-and-data-model.md`](references/n8n-runtime-and-data-model.md) · base detail: [`references/data-access.md`](references/data-access.md) |
| Production patterns (transform / filter / regex / validate / stats) — full examples + stdlib quick reference | [`references/python-code-patterns.md`](references/python-code-patterns.md) · base detail: [`references/common-patterns.md`](references/common-patterns.md), [`references/standard-library.md`](references/standard-library.md) |
| Return-format right/wrong, Top 5 mistakes, Best Practices, no-external-libraries workarounds — full examples | [`references/validation-and-debugging.md`](references/validation-and-debugging.md) · base detail: [`references/error-patterns.md`](references/error-patterns.md) |
| End-to-end examples (webhook, aggregation, multi-node merge, regex extract, checksum, per-item conditional) | [`references/examples.md`](references/examples.md) |

---

## ⚠️ JavaScript First

Use **JavaScript for 95% of use cases**. Choose Python only when:

- You need Python standard-library functions specifically
- You're significantly more comfortable in Python
- The transform maps cleanly to Python idioms (list comprehensions, `statistics`)

JavaScript advantages: full `$helpers` (incl. `$helpers.httpRequest()`), Luxon DateTime, no external-library limit, better n8n documentation.

---

## Quick Start

```python
from datetime import datetime

items = _input.all()

processed = []
for item in items:
    processed.append({
        "json": {
            **item["json"],
            "processed": True,
            "timestamp": datetime.now().isoformat()
        }
    })

return processed
```

### Essential rules

1. **Consider JavaScript first** — Python only when necessary.
2. **Access data**: `_input.all()`, `_input.first()`, or `_input.item`.
3. **CRITICAL**: must return `[{"json": {...}}]` format (list of dicts with `"json"` key).
4. **CRITICAL**: webhook data is under `_json["body"]`, not `_json` directly.
5. **CRITICAL LIMITATION**: no external libraries — `requests`, `pandas`, `numpy`, `bs4`, `lxml`, etc. all unavailable.
6. **Standard library only**: `json`, `datetime`, `re`, `base64`, `hashlib`, `urllib.parse`, `math`, `random`, `statistics`.

---

## Mode Selection

Same decision logic as JavaScript — pick by use case.

| Mode | When | Data access | Performance |
|---|---|---|---|
| **Run Once for All Items** (default — 95% of cases) | Aggregation, filtering, batch processing, transformations | `_input.all()` / `_items` (Native) | Faster — single execution |
| **Run Once for Each Item** | Item-specific logic, independent operations, per-item validation | `_input.item` / `_item` (Native) | Slower for large datasets |

Full mode examples: [`references/n8n-runtime-and-data-model.md`](references/n8n-runtime-and-data-model.md#mode-selection--full-examples).

---

## Python Modes: Beta vs Native

n8n offers two Python execution modes. **Use Python (Beta) for better n8n integration.**

| Mode | Variables | Helpers |
|---|---|---|
| **Python (Beta)** — recommended | `_input`, `_json`, `_node` | `_now`, `_today`, `_jmespath()` |
| **Python (Native) (Beta)** | `_items`, `_item` only | None |

Full Beta vs Native examples: [`references/n8n-runtime-and-data-model.md`](references/n8n-runtime-and-data-model.md#python-modes-beta-vs-native--full-examples).

---

## Data Access Patterns

| Pattern | When |
|---|---|
| `_input.all()` | Processing arrays, batch operations, aggregations (most common) |
| `_input.first()` | Single objects, API responses |
| `_input.item` | Each-Item mode only |
| `_node["NodeName"]["json"]` | Reference output of a specific upstream node |

Full per-pattern examples + comprehensive guide: [`references/n8n-runtime-and-data-model.md`](references/n8n-runtime-and-data-model.md#data-access-patterns--full-examples) and [`references/data-access.md`](references/data-access.md).

---

## Critical: Webhook Data Structure

**Most common Python mistake.** Webhook data is nested under `["body"]`.

```python
# ❌ WRONG — KeyError
name = _json["name"]

# ✅ CORRECT — webhook data under ["body"]
name = _json["body"]["name"]

# ✅ SAFER — use .get()
name = _json.get("body", {}).get("name")
```

The Webhook node wraps POST data, query parameters, and JSON payloads under `body`. Full walkthrough: [`references/n8n-runtime-and-data-model.md`](references/n8n-runtime-and-data-model.md#webhook-data-structure--full-explanation).

---

## Return Format Requirements

**Critical rule**: always return a list of dictionaries with a `"json"` key.

```python
# ✅ Single
return [{"json": {"field": value}}]

# ✅ Multiple
return [{"json": {"id": 1}}, {"json": {"id": 2}}]

# ✅ Empty
return []

# ❌ Dict not wrapped in list
return {"json": {...}}

# ❌ List without "json" key
return [{"field": value}]
```

Full right/wrong matrix: [`references/validation-and-debugging.md`](references/validation-and-debugging.md#return-format--full-examples). Detailed error solutions: [`references/error-patterns.md`](references/error-patterns.md).

---

## Critical Limitation: No External Libraries

`ModuleNotFoundError` on every PyPI package.

**Not available**: `requests`, `pandas`, `numpy`, `scipy`, `bs4` / `BeautifulSoup`, `lxml`, anything not in the stdlib.

**Available (standard library only)**: `json`, `datetime`, `re`, `base64`, `hashlib`, `urllib.parse`, `math`, `random`, `statistics`.

**Workarounds**:

- **HTTP requests** → use the **HTTP Request node** before the Code node, OR switch to JavaScript and use `$helpers.httpRequest()`.
- **Data analysis (pandas/numpy)** → use Python `statistics` for basic stats; switch to JavaScript for richer ops; manual calculations with lists/dicts.
- **Web scraping (BeautifulSoup)** → **HTTP Request node** + **HTML Extract node**; or JavaScript with regex/string methods.

Full workaround detail: [`references/validation-and-debugging.md`](references/validation-and-debugging.md#no-external-libraries--workaround-detail) and [`references/standard-library.md`](references/standard-library.md).

---

## Common Patterns Overview

Production-tested patterns (full examples in [`references/python-code-patterns.md`](references/python-code-patterns.md) and [`references/common-patterns.md`](references/common-patterns.md)):

1. **Data Transformation** — list comprehensions over `_input.all()`.
2. **Filtering & Aggregation** — `sum()`, list comprehensions, `len()`.
3. **String Processing with Regex** — `re.findall`, `re.sub`.
4. **Data Validation** — collect errors, attach `valid`/`errors` to each item.
5. **Statistical Analysis** — `statistics.mean / median / stdev`.

---

## Error Prevention — Top 5 Mistakes

1. **Importing external libraries** → use HTTP Request node or switch to JavaScript.
2. **Empty code or missing `return`** → always end with `return ...`.
3. **Incorrect return format** → must be `[{"json": ...}]`.
4. **`KeyError` on dictionary access** → use `.get("key", default)`.
5. **Webhook body nesting** → access via `_json["body"]` or `_json.get("body", {})`.

Full right/wrong examples for each: [`references/validation-and-debugging.md`](references/validation-and-debugging.md#top-5-mistakes--full-examples) and [`references/error-patterns.md`](references/error-patterns.md).

---

## Best Practices

1. Always use `.get()` for dictionary access (avoid `KeyError`).
2. Handle `None`/null values explicitly (`or 0`, `if x is None`).
3. Prefer list comprehensions over manual loops for filtering.
4. Return a consistent structure — always list with `"json"` key.
5. Debug with `print()` — output appears in the browser console (F12).

Full examples for each: [`references/validation-and-debugging.md`](references/validation-and-debugging.md#best-practices--full-examples).

---

## When to Use Python vs JavaScript

**Python when:** you need the `statistics` module, you're significantly more comfortable with Python, the logic maps well to list comprehensions, or you need specific stdlib functions.

**JavaScript when:** HTTP requests (`$helpers.httpRequest()`), advanced date/time (DateTime/Luxon), better n8n integration, **95% of use cases**.

**Consider other nodes when:** simple field mapping → **Set**; basic filtering → **Filter**; conditionals → **IF** / **Switch**; HTTP only → **HTTP Request**.

---

## Integration with Other Skills

- **n8n Expression Syntax** — expressions use `{{ }}` in other nodes; Code nodes use Python directly (no `{{ }}`).
- **n8n MCP Tools Expert** — find Code node via `search_nodes({query: "code"})`; configure via `get_node({nodeType: "nodes-base.code"})`; validate via `validate_node({nodeType: "nodes-base.code", config: {...}})`.
- **n8n Node Configuration** — mode selection (All Items vs Each Item), language selection (Python vs JavaScript), property dependencies.
- **n8n Workflow Patterns** — Code nodes in transformation steps; when to use Python vs JavaScript in patterns.
- **n8n Validation Expert** — validate Code node configuration, handle validation errors, auto-fix common issues.
- **n8n Code JavaScript** — when to use JavaScript instead, feature comparison, Python → JavaScript migration.

---

## Quick Reference Checklist

Before deploying Python Code nodes, verify:

- [ ] **Considered JavaScript first** — using Python only when necessary.
- [ ] **Code is not empty** — has meaningful logic.
- [ ] **Return statement exists** — must return list of dictionaries.
- [ ] **Proper return format** — each item: `{"json": {...}}`.
- [ ] **Data access correct** — `_input.all()`, `_input.first()`, or `_input.item`.
- [ ] **No external imports** — only standard library (`json`, `datetime`, `re`, etc.).
- [ ] **Safe dictionary access** — `.get()` to avoid `KeyError`.
- [ ] **Webhook data** — accessed via `["body"]` if from webhook.
- [ ] **Mode selection** — "All Items" for most cases.
- [ ] **Output consistent** — all code paths return the same structure.

---

## Additional Resources

### Reference files

- [`references/n8n-runtime-and-data-model.md`](references/n8n-runtime-and-data-model.md) — modes, Beta vs Native, data access, webhook body
- [`references/python-code-patterns.md`](references/python-code-patterns.md) — production patterns + stdlib quick reference
- [`references/validation-and-debugging.md`](references/validation-and-debugging.md) — return format, top mistakes, best practices, no-libs workarounds
- [`references/examples.md`](references/examples.md) — end-to-end examples
- [`references/data-access.md`](references/data-access.md) — comprehensive data-access guide
- [`references/common-patterns.md`](references/common-patterns.md) — 10 Python patterns for n8n
- [`references/error-patterns.md`](references/error-patterns.md) — comprehensive error guide
- [`references/standard-library.md`](references/standard-library.md) — complete stdlib reference

### n8n documentation

- Code Node Guide: https://docs.n8n.io/code/code-node/
- Python in n8n: https://docs.n8n.io/code/builtin/python-modules/

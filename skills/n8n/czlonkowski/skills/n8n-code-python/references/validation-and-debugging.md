# Validation and Debugging — n8n Python Code

Detailed examples of common errors and best-practice patterns. The minimal rules and checklist live in `SKILL.md`.

## Return Format — full examples

**Critical rule**: always return a list of dictionaries with a `"json"` key.

### Correct formats

```python
# ✅ Single result
return [{
    "json": {
        "field1": value1,
        "field2": value2
    }
}]

# ✅ Multiple results
return [
    {"json": {"id": 1, "data": "first"}},
    {"json": {"id": 2, "data": "second"}}
]

# ✅ List comprehension
transformed = [
    {"json": {"id": item["json"]["id"], "processed": True}}
    for item in _input.all()
    if item["json"].get("valid")
]
return transformed

# ✅ Empty result (when no data to return)
return []

# ✅ Conditional return
if should_process:
    return [{"json": processed_data}]
else:
    return []
```

### Incorrect formats

```python
# ❌ Dictionary without list wrapper
return {
    "json": {"field": value}
}

# ❌ List without json wrapper
return [{"field": value}]

# ❌ Plain string
return "processed"

# ❌ Incomplete structure
return [{"data": value}]  # Should be {"json": value}
```

**Why it matters**: next nodes expect list format. Incorrect format causes workflow execution to fail.

See [error-patterns.md](error-patterns.md) #2 for detailed error solutions.

## Top 5 Mistakes — full examples

### #1: Importing external libraries (Python-specific)

```python
# ❌ WRONG
import requests  # ModuleNotFoundError

# ✅ CORRECT
# Add HTTP Request node before Code node
# OR switch to JavaScript and use $helpers.httpRequest()
```

### #2: Empty code or missing return

```python
# ❌ WRONG — no return statement
items = _input.all()
# Processing...
# Forgot to return!

# ✅ CORRECT — always return data
items = _input.all()
return [{"json": item["json"]} for item in items]
```

### #3: Incorrect return format

```python
# ❌ WRONG — returning dict instead of list
return {"json": {"result": "success"}}

# ✅ CORRECT — list wrapper required
return [{"json": {"result": "success"}}]
```

### #4: KeyError on dictionary access

```python
# ❌ WRONG — direct access crashes if missing
name = _json["user"]["name"]  # KeyError!

# ✅ CORRECT — use .get() for safe access
name = _json.get("user", {}).get("name", "Unknown")
```

### #5: Webhook body nesting

```python
# ❌ WRONG — direct access to webhook data
email = _json["email"]  # KeyError!

# ✅ CORRECT — webhook data under ["body"]
email = _json["body"]["email"]

# ✅ BETTER — safe access with .get()
email = _json.get("body", {}).get("email", "no-email")
```

See [error-patterns.md](error-patterns.md) for the comprehensive error guide.

## Best Practices — full examples

### 1. Always use `.get()` for dictionary access

```python
# ✅ SAFE: Won't crash if field missing
value = item["json"].get("field", "default")

# ❌ RISKY: Crashes if field doesn't exist
value = item["json"]["field"]
```

### 2. Handle None/null values explicitly

```python
# ✅ Default to 0 if None
amount = item["json"].get("amount") or 0

# ✅ Check for None explicitly
text = item["json"].get("text")
if text is None:
    text = ""
```

### 3. Use list comprehensions for filtering

```python
# ✅ PYTHONIC: List comprehension
valid = [item for item in items if item["json"].get("active")]

# ❌ VERBOSE: Manual loop
valid = []
for item in items:
    if item["json"].get("active"):
        valid.append(item)
```

### 4. Return a consistent structure

```python
# ✅ Always list with "json" key
return [{"json": result}]  # Single result
return results              # Multiple results (already formatted)
return []                   # No results
```

### 5. Debug with `print()` statements

```python
# Debug statements appear in browser console (F12)
items = _input.all()
print(f"Processing {len(items)} items")
print(f"First item: {items[0] if items else 'None'}")
```

## No External Libraries — workaround detail

**Not available** (will raise `ModuleNotFoundError`): `requests`, `pandas`, `numpy`, `scipy`, `bs4` / `BeautifulSoup`, `lxml`, and every other PyPI package.

**Available** (standard library): `json`, `datetime`, `re`, `base64`, `hashlib`, `urllib.parse`, `math`, `random`, `statistics`.

| Need | Workaround |
|---|---|
| HTTP requests | Use **HTTP Request node** before the Code node, OR switch to **JavaScript** and use `$helpers.httpRequest()` |
| Data analysis (pandas/numpy) | Use Python `statistics` for basic stats; switch to **JavaScript** for richer ops; manual calculations with lists/dicts |
| Web scraping (BeautifulSoup) | **HTTP Request node** + **HTML Extract node**; or JavaScript with regex/string methods |

See [standard-library.md](standard-library.md) for the complete reference.

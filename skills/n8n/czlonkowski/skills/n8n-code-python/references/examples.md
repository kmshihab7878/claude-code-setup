# Examples — n8n Python Code Node

End-to-end Python examples for common Code-node tasks. The minimal Quick-Start template lives in `SKILL.md`; this file holds longer worked examples.

## Quick Start template (with imports)

```python
from datetime import datetime

# Basic template for Python Code nodes
items = _input.all()

# Process data
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

## Process webhook payload

```python
# Webhook data is under ["body"]
webhook = _json.get("body", {})

name = webhook.get("name", "")
email = webhook.get("email", "")
phone = webhook.get("phone", "")

return [{
    "json": {
        "name": name.strip(),
        "email": email.lower().strip(),
        "phone": phone,
        "valid": bool(email and "@" in email)
    }
}]
```

## Aggregate API results

```python
items = _input.all()

# Group by category
groups = {}
for item in items:
    data = item["json"]
    category = data.get("category", "uncategorized")
    if category not in groups:
        groups[category] = []
    groups[category].append(data)

return [
    {
        "json": {
            "category": category,
            "count": len(group),
            "items": group
        }
    }
    for category, group in groups.items()
]
```

## Combine data from multiple nodes

```python
# Pull from two upstream nodes
webhook = _node["Webhook"]["json"].get("body", {})
api_response = _node["HTTP Request"]["json"]

return [{
    "json": {
        "user_id": webhook.get("user_id"),
        "user_name": webhook.get("name"),
        "external_data": api_response.get("data", {}),
        "merged_at": datetime.now().isoformat()
    }
}]
```

## Extract structured data with regex

```python
import re

items = _input.all()
url_pattern = r'https?://[^\s<>"]+'
phone_pattern = r'\+?\d{1,3}[\s-]?\(?\d{1,4}\)?[\s-]?\d{1,4}[\s-]?\d{1,9}'

results = []
for item in items:
    text = item["json"].get("body", "")
    results.append({
        "json": {
            "id": item["json"].get("id"),
            "urls": re.findall(url_pattern, text),
            "phones": re.findall(phone_pattern, text)
        }
    })

return results
```

## Generate a checksum

```python
import hashlib
import json

items = _input.all()

return [
    {
        "json": {
            **item["json"],
            "checksum": hashlib.sha256(
                json.dumps(item["json"], sort_keys=True).encode()
            ).hexdigest()
        }
    }
    for item in items
]
```

## Per-item conditional output

```python
# Run Once for Each Item mode
item = _input.item
data = item["json"]

if data.get("status") == "active" and data.get("score", 0) >= 70:
    return [{
        "json": {
            **data,
            "tier": "premium",
            "discount": 0.20
        }
    }]
else:
    return [{
        "json": {
            **data,
            "tier": "standard",
            "discount": 0.05
        }
    }]
```

See [common-patterns.md](common-patterns.md) for additional production patterns.

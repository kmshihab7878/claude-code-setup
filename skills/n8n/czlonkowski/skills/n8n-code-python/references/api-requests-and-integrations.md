# API Requests and Integrations

The Python Code node **cannot** make HTTP requests directly — there is no
`requests` library and no `$helpers.httpRequest()` equivalent in Python. This
reference documents the supported integration patterns.

## The Constraint

`requests`, `httpx`, `urllib.request`, `aiohttp`, and similar are all
unavailable inside the Code node. Attempts to import them produce
`ModuleNotFoundError`.

## Pattern 1: HTTP Request node → Code node (recommended)

The canonical n8n pattern. Make the request in an HTTP Request node, then
transform the response in a Python Code node.

```
[HTTP Request node]  →  [Python Code node]
```

```python
# Inside the Code node — read the upstream HTTP response
response = _input.first()["json"]

items = response.get("data", [])
shaped = [
    {"json": {"id": it["id"], "name": it.get("name", "").strip()}}
    for it in items
]
return shaped
```

Advantages:

- The HTTP Request node provides retry, auth, pagination, throttling, and
  error UI for free.
- Credentials are managed at the node level, not embedded in code.
- Failures are visible in the execution view without code changes.

## Pattern 2: Switch to JavaScript Code node

If a single node must combine an HTTP call with custom logic, use the
JavaScript Code node — it has `$helpers.httpRequest()`.

```javascript
const response = await $helpers.httpRequest({
  method: "GET",
  url: "https://example.com/api/items",
  headers: { Authorization: `Bearer ${$credentials.api.token}` },
});

return response.data.map(it => ({ json: { id: it.id, name: it.name } }));
```

This is the **only** path that lets one node both call an API and run custom
logic. Many seemingly Python-shaped problems are better in JavaScript for this reason.

## Pattern 3: Multiple HTTP requests — split or loop in n8n

For pagination or multi-endpoint orchestration:

| Need | Pattern |
|------|---------|
| Paginated list | HTTP Request node with pagination options + Code node to flatten |
| Sequential calls with dependent inputs | Multiple HTTP Request nodes connected linearly |
| Parallel calls | Split In Batches → HTTP Request → Merge |
| Conditional follow-up | HTTP Request → IF → HTTP Request |

Python-side, the Code node only consumes the merged results.

## Pattern 4: Web scraping

`BeautifulSoup`, `lxml`, and `Scrapy` are all unavailable.

- Use the **HTTP Request node** for the fetch.
- Use the **HTML Extract node** for selectors.
- Use the **Code node** (Python or JavaScript) only for cleanup or shape.

Lightweight extraction inside Python is possible with `re`, but treat regex
on HTML as a last resort:

```python
import re

html = _input.first()["json"]["body"]
titles = re.findall(r"<h1[^>]*>(.*?)</h1>", html, flags=re.I | re.S)
return [{"json": {"titles": [t.strip() for t in titles]}}]
```

## Pattern 5: Authentication

| Auth type | Pattern |
|-----------|---------|
| API key in header | Configure on the HTTP Request node's "Authentication" panel; Python never sees the key |
| Basic auth | Configure on the HTTP Request node; or, if generating manually in Python, use `base64.b64encode(b"user:pass").decode()` |
| Bearer token | HTTP Request node Authentication = "Bearer Token"; refresh logic in a separate Code node if needed |
| OAuth | Always use n8n's built-in OAuth credential type — do not hand-roll in code |

Never embed credentials in Python source. n8n credential storage is the
correct place.

## Pattern 6: Webhook → Code (incoming)

For inbound HTTP, the Webhook node delivers the request to the Code node.

```python
# Webhook payload is under ["body"]
body = _json.get("body", {})
headers = _json.get("headers", {})

if headers.get("x-signature") != "expected":
    return [{"json": {"ok": False, "error": "bad signature"}}]

return [{"json": {"ok": True, "received": body}}]
```

Signature verification belongs here when the secret is short-lived or
derived. Long-lived secrets should be checked via the Webhook node's
authentication options first.

## Decision Table — "I need to call an API"

| Situation | Pattern |
|-----------|---------|
| Plain GET / POST with stable schema | HTTP Request node → Python Code node |
| Call depends on Python-computed value | HTTP Request node fed by upstream Code node |
| Need to combine call + custom logic in one node | JavaScript Code node with `$helpers.httpRequest()` |
| Paginated results | HTTP Request node pagination + Code node flatten |
| Webhook callback that signs/verifies | Webhook node → Python Code node |
| Web scrape with structured selectors | HTTP Request + HTML Extract (+ optional Code node) |
| Bulk parallel calls | Split In Batches → HTTP Request → Merge (no Python needed) |

If the answer is "Python must call the API directly," reconsider — that
path is not supported.

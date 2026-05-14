# End-to-End Configuration Examples

Complete worked examples that combine workflow, property dependencies, and validation. See `node-patterns.md` for per-pattern recipes and `configuration-workflow.md` for the standard process detail.

## Example 1: Slack post-message with progressive disclosure

**Step 1 — Discover the node**

```javascript
get_node({
  nodeType: "nodes-base.slack"
});
// detail="standard" — returns operation list + required fields
```

**Step 2 — Minimal config for post**

```javascript
{
  "resource": "message",
  "operation": "post",
  "channel": "#general",
  "text": "Build succeeded"
}
```

**Step 3 — Validate**

```javascript
validate_node({
  nodeType: "nodes-base.slack",
  config,
  profile: "runtime"
});
// → Valid ✅ (with credentials bound)
```

## Example 2: HTTP POST with expression-driven body

**Step 1 — Operation context**

```javascript
get_node({
  nodeType: "nodes-base.httpRequest",
  mode: "search_properties",
  propertyQuery: "body"
});
// Surfaces body + sendBody + contentType
```

**Step 2 — Full config**

```javascript
{
  "method": "POST",
  "url": "https://api.example.com/users",
  "authentication": "predefinedCredentialType",
  "nodeCredentialType": "httpHeaderAuth",
  "sendBody": true,
  "body": {
    "contentType": "json",
    "content": {
      "name": "={{$json.name}}",
      "email": "={{$json.email}}",
      "source": "n8n-workflow"
    }
  }
}
```

**Step 3 — Validate runtime profile**

```javascript
validate_node({
  nodeType: "nodes-base.httpRequest",
  config,
  profile: "runtime"
});
// → Valid ✅
```

## Example 3: IF node with unary operator (auto-sanitization)

**Initial config (intentionally missing `singleValue`)**:

```javascript
{
  "conditions": {
    "string": [
      {
        "value1": "={{$json.email}}",
        "operation": "isEmpty"
      }
    ]
  }
}
```

**After save / auto-sanitization**:

```javascript
{
  "conditions": {
    "string": [
      {
        "value1": "={{$json.email}}",
        "operation": "isEmpty",
        "singleValue": true   // ← added automatically
      }
    ]
  }
}
```

Don't manually add or remove `singleValue` — let the system manage it.

## Example 4: Postgres insert (operation-aware)

```javascript
{
  "operation": "insert",
  "table": "users",
  "columns": "name,email,created_at",
  "additionalFields": {
    "mode": "independently"
  }
}
```

Switching `operation` to `executeQuery` would require an entirely different shape (a `query` field), so always re-check `get_node` when changing operations.

## Example 5: Switching Slack operation safely

**Before** — `post` config:

```javascript
{
  "resource": "message",
  "operation": "post",
  "channel": "#general",
  "text": "Initial message"
}
```

**Switching to `update` — wrong way** (carrying over `channel` as the primary identifier):

```javascript
{
  "resource": "message",
  "operation": "update",
  "channel": "#general",
  "text": "Updated"
  // ❌ missing required `messageId`
}
```

**Right way** — re-discover requirements first:

```javascript
get_node({
  nodeType: "nodes-base.slack"
});
// Shows: update requires `messageId` + `text`
```

```javascript
{
  "resource": "message",
  "operation": "update",
  "messageId": "1234567890.123456",
  "text": "Updated"
}
```

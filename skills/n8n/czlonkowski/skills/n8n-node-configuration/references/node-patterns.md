# Node Patterns by Type

Long-form configuration recipes per node category. The minimal pattern decision table lives in `SKILL.md`; this file holds the long code examples.

## Pattern 1: Resource/Operation Nodes

Examples: Slack, Google Sheets, Airtable.

**Structure**:

```javascript
{
  "resource": "<entity>",      // What type of thing
  "operation": "<action>",     // What to do with it
  // ... operation-specific fields
}
```

**How to configure**:

1. Choose resource.
2. Choose operation.
3. Use `get_node` to see operation-specific requirements.
4. Configure required fields.

## Pattern 2: HTTP-Based Nodes

Examples: HTTP Request, Webhook.

**Structure**:

```javascript
{
  "method": "<HTTP_METHOD>",
  "url": "<endpoint>",
  "authentication": "<type>",
  // ... method-specific fields
}
```

**Dependencies**:

- `POST/PUT/PATCH` → `sendBody` available.
- `sendBody=true` → `body` required.
- `authentication != "none"` → credentials required.

## Pattern 3: Database Nodes

Examples: Postgres, MySQL, MongoDB.

**Structure**:

```javascript
{
  "operation": "<query|insert|update|delete>",
  // ... operation-specific fields
}
```

**Dependencies**:

- `operation="executeQuery"` → `query` required.
- `operation="insert"` → `table` + `values` required.
- `operation="update"` → `table` + `values` + `where` required.

## Pattern 4: Conditional Logic Nodes

Examples: IF, Switch, Merge.

**Structure**:

```javascript
{
  "conditions": {
    "<type>": [
      {
        "operation": "<operator>",
        "value1": "...",
        "value2": "..."  // Only for binary operators
      }
    ]
  }
}
```

**Dependencies**:

- Binary operators (equals, contains, etc.) → `value1` + `value2`.
- Unary operators (isEmpty, isNotEmpty) → `value1` only + `singleValue: true`.

---

## Operation-Specific Configuration

### Slack Node

#### Post Message

```javascript
{
  "resource": "message",
  "operation": "post",
  "channel": "#general",      // Required
  "text": "Hello!",           // Required
  "attachments": [],          // Optional
  "blocks": []                // Optional
}
```

#### Update Message

```javascript
{
  "resource": "message",
  "operation": "update",
  "messageId": "1234567890",  // Required (different from post!)
  "text": "Updated!",         // Required
  "channel": "#general"       // Optional (can be inferred)
}
```

#### Create Channel

```javascript
{
  "resource": "channel",
  "operation": "create",
  "name": "new-channel",      // Required
  "isPrivate": false          // Optional
  // Note: text NOT required for this operation
}
```

### HTTP Request Node

#### GET Request

```javascript
{
  "method": "GET",
  "url": "https://api.example.com/users",
  "authentication": "predefinedCredentialType",
  "nodeCredentialType": "httpHeaderAuth",
  "sendQuery": true,                    // Optional
  "queryParameters": {                  // Shows when sendQuery=true
    "parameters": [
      {
        "name": "limit",
        "value": "100"
      }
    ]
  }
}
```

#### POST with JSON

```javascript
{
  "method": "POST",
  "url": "https://api.example.com/users",
  "authentication": "none",
  "sendBody": true,                     // Required for POST
  "body": {                             // Required when sendBody=true
    "contentType": "json",
    "content": {
      "name": "John Doe",
      "email": "john@example.com"
    }
  }
}
```

### IF Node

#### String Comparison (binary)

```javascript
{
  "conditions": {
    "string": [
      {
        "value1": "={{$json.status}}",
        "operation": "equals",
        "value2": "active"              // Binary: needs value2
      }
    ]
  }
}
```

#### Empty Check (unary)

```javascript
{
  "conditions": {
    "string": [
      {
        "value1": "={{$json.email}}",
        "operation": "isEmpty",
        // No value2 - unary operator
        "singleValue": true             // Auto-added by sanitization
      }
    ]
  }
}
```

See [`../OPERATION_PATTERNS.md`](../OPERATION_PATTERNS.md) for the comprehensive operation catalog.

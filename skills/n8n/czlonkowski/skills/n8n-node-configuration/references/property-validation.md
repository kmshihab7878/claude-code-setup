# Property Validation and Dependencies

Detailed property-dependency mechanics and conditional-requirement scenarios. The minimal rules live in `SKILL.md`; this file holds the long examples.

## displayOptions Mechanism

Fields have visibility rules expressed as `displayOptions`:

```javascript
{
  "name": "body",
  "displayOptions": {
    "show": {
      "sendBody": [true],
      "method": ["POST", "PUT", "PATCH"]
    }
  }
}
```

**Translation**: the `body` field shows when:

- `sendBody = true` AND
- `method = POST`, `PUT`, or `PATCH`

When a field doesn't appear in the schema but validation expects it, the `displayOptions` rules are usually why — another field's value must change first.

## Common Dependency Patterns

### Pattern 1: Boolean toggle

Example: HTTP Request `sendBody`.

```javascript
{
  "sendBody": true   // → body field appears
}
```

### Pattern 2: Operation switch

Example: Slack resource/operation.

```javascript
{
  "resource": "message",
  "operation": "post"
  // → Shows: channel, text, attachments, etc.
}

{
  "resource": "message",
  "operation": "update"
  // → Shows: messageId, text (different fields!)
}
```

### Pattern 3: Type selection

Example: IF node conditions.

```javascript
{
  "type": "string",
  "operation": "contains"
  // → Shows: value1, value2
}

{
  "type": "boolean",
  "operation": "equals"
  // → Shows: value1, value2, different operators
}
```

## Finding Property Dependencies

Use `get_node` with `search_properties` mode:

```javascript
get_node({
  nodeType: "nodes-base.httpRequest",
  mode: "search_properties",
  propertyQuery: "body"
});

// Returns property paths matching "body" with descriptions
```

Or use full detail for the complete schema:

```javascript
get_node({
  nodeType: "nodes-base.httpRequest",
  detail: "full"
});

// Returns complete schema with displayOptions rules
```

Use this when validation fails and you don't understand why a field is missing or required.

## Conditional Requirements — Scenarios

### Scenario: HTTP Request body

**Rule**:

```
body is required when:
  - sendBody = true AND
  - method IN (POST, PUT, PATCH, DELETE)
```

**How to discover**:

```javascript
// Option 1: Read validation error
validate_node({...});
// Error: "body required when sendBody=true"

// Option 2: Search for the property
get_node({
  nodeType: "nodes-base.httpRequest",
  mode: "search_properties",
  propertyQuery: "body"
});
// Shows: body property with displayOptions rules

// Option 3: Try minimal config and iterate
// Start without body — validation tells you when it's needed
```

### Scenario: IF node singleValue

**Rule**:

```
singleValue should be true when:
  - operation IN (isEmpty, isNotEmpty, true, false)
```

**Auto-sanitization fixes this**, so manual configuration is rarely needed.

**Manual check**:

```javascript
get_node({
  nodeType: "nodes-base.if",
  detail: "full"
});
// Shows complete schema with operator-specific rules
```

See [`../DEPENDENCIES.md`](../DEPENDENCIES.md) for the comprehensive deep dive.

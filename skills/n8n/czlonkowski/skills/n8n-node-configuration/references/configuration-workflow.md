# Configuration Workflow — Full Walkthrough

Detailed step-by-step example of the configuration process. The minimal 8-step flow lives in `SKILL.md`; this file holds the long worked example.

## Standard Process (recap)

```
1. Identify node type and operation
   ↓
2. Use get_node (standard detail is default)
   ↓
3. Configure required fields
   ↓
4. Validate configuration
   ↓
5. If field unclear → get_node({mode: "search_properties"})
   ↓
6. Add optional fields as needed
   ↓
7. Validate again
   ↓
8. Deploy
```

## Example: Configuring HTTP Request

**Step 1 — Identify what you need**

```javascript
// Goal: POST JSON to API
```

**Step 2 — Get node info**

```javascript
const info = get_node({
  nodeType: "nodes-base.httpRequest"
});

// Returns: method, url, sendBody, body, authentication required/optional
```

**Step 3 — Minimal config**

```javascript
{
  "method": "POST",
  "url": "https://api.example.com/create",
  "authentication": "none"
}
```

**Step 4 — Validate**

```javascript
validate_node({
  nodeType: "nodes-base.httpRequest",
  config,
  profile: "runtime"
});
// → Error: "sendBody required for POST"
```

**Step 5 — Add required field**

```javascript
{
  "method": "POST",
  "url": "https://api.example.com/create",
  "authentication": "none",
  "sendBody": true
}
```

**Step 6 — Validate again**

```javascript
validate_node({...});
// → Error: "body required when sendBody=true"
```

**Step 7 — Complete configuration**

```javascript
{
  "method": "POST",
  "url": "https://api.example.com/create",
  "authentication": "none",
  "sendBody": true,
  "body": {
    "contentType": "json",
    "content": {
      "name": "={{$json.name}}",
      "email": "={{$json.email}}"
    }
  }
}
```

**Step 8 — Final validation**

```javascript
validate_node({...});
// → Valid! ✅
```

## What this example demonstrates

- **Operation-aware requirements**: `sendBody` is only required for write methods (POST/PUT/PATCH).
- **Cascading dependencies**: `sendBody=true` opens up `body`, which itself has required structure.
- **Validation as discovery**: each validation cycle surfaces the next required field — iterating averages 2–3 cycles.
- **Progressive disclosure**: start minimal, add fields only when validation demands them.

## get_node detail levels — when to use which

### Standard (default)

```javascript
get_node({
  nodeType: "nodes-base.slack"
});
// detail="standard" is the default
```

Returns (~1–2K tokens): required fields, common options, operation list, metadata. Covers 95% of needs.

### Full (use sparingly)

```javascript
get_node({
  nodeType: "nodes-base.slack",
  detail: "full"
});
```

Returns (~3–8K tokens): complete schema, all properties, all nested options. Large response — only when standard is insufficient.

### Search properties

```javascript
get_node({
  nodeType: "nodes-base.httpRequest",
  mode: "search_properties",
  propertyQuery: "auth"
});
```

Find authentication, headers, body fields, etc. by name fragment.

### Decision tree

```
┌─────────────────────────────────┐
│ Starting new node config?       │
├─────────────────────────────────┤
│ YES → get_node (standard)       │
└─────────────────────────────────┘
         ↓
┌─────────────────────────────────┐
│ Standard has what you need?     │
├─────────────────────────────────┤
│ YES → Configure with it         │
│ NO  → Continue                  │
└─────────────────────────────────┘
         ↓
┌─────────────────────────────────┐
│ Looking for specific field?     │
├─────────────────────────────────┤
│ YES → search_properties mode    │
│ NO  → Continue                  │
└─────────────────────────────────┘
         ↓
┌─────────────────────────────────┐
│ Still need more details?        │
├─────────────────────────────────┤
│ YES → get_node({detail: "full"})│
└─────────────────────────────────┘
```

# Troubleshooting and Anti-Patterns

Detailed bad/good examples for configuration anti-patterns and best practices. The terse rules live in `SKILL.md`; this file holds the full code.

## Anti-Patterns

### ❌ Don't: Over-configure upfront

**Bad** — adding every possible field:

```javascript
{
  "method": "GET",
  "url": "...",
  "sendQuery": false,
  "sendHeaders": false,
  "sendBody": false,
  "timeout": 10000,
  "ignoreResponseCode": false,
  // ... 20 more optional fields
}
```

**Good** — start minimal:

```javascript
{
  "method": "GET",
  "url": "...",
  "authentication": "none"
}
// Add fields only when needed
```

### ❌ Don't: Skip validation

**Bad** — configure and deploy without validating:

```javascript
const config = {...};
n8n_update_partial_workflow({...});  // YOLO
```

**Good** — validate before deploying:

```javascript
const config = {...};
const result = validate_node({...});
if (result.valid) {
  n8n_update_partial_workflow({...});
}
```

### ❌ Don't: Ignore operation context

**Bad** — same config for all Slack operations:

```javascript
{
  "resource": "message",
  "operation": "post",
  "channel": "#general",
  "text": "..."
}

// Then switching operation without updating config
{
  "resource": "message",
  "operation": "update",  // Changed
  "channel": "#general",  // Wrong field for update!
  "text": "..."
}
```

**Good** — check requirements when changing operation:

```javascript
get_node({
  nodeType: "nodes-base.slack"
});
// See what update operation needs (messageId, not channel)
```

## Best Practices — Full Examples

### ✅ Do

**1. Start with `get_node` (standard detail)**

- ~1–2K tokens response.
- Covers 95% of configuration needs.
- Default detail level.

**2. Validate iteratively**

- Configure → Validate → Fix → Repeat.
- Average 2–3 iterations is normal.
- Read validation errors carefully.

**3. Use search_properties mode when stuck**

- If a field seems missing, search for it.
- Understand what controls field visibility.
- `get_node({mode: "search_properties", propertyQuery: "..."})`.

**4. Respect operation context**

- Different operations = different requirements.
- Always check `get_node` when changing operation.
- Don't assume configs are transferable.

**5. Trust auto-sanitization**

- Operator structure fixed automatically.
- Don't manually add/remove `singleValue`.
- IF/Switch metadata added on save.

### ❌ Don't

**1. Jump to `detail="full"` immediately**

- Try standard detail first.
- Only escalate if needed.
- Full schema is 3–8K tokens.

**2. Configure blindly**

- Always validate before deploying.
- Understand why fields are required.
- Use `search_properties` for conditional fields.

**3. Copy configs without understanding**

- Different operations need different fields.
- Validate after copying.
- Adjust for new context.

**4. Manually fix auto-sanitization issues**

- Let auto-sanitization handle operator structure.
- Focus on business logic.
- Save and let the system fix structure.

## Common validation failure → fix recipes

| Validation error message | Likely cause | Fix |
|---|---|---|
| `body required when sendBody=true` | HTTP method is POST/PUT/PATCH and `sendBody=true` but `body` missing | Add `body: { contentType, content }` |
| `sendBody required for POST` | POST method but `sendBody` not set | Add `sendBody: true` |
| `messageId required` (Slack) | Switched from `post` to `update` operation without updating fields | Add `messageId`, remove unused fields |
| `value2 required` (IF node) | Using binary operator without `value2` | Add `value2`, or switch to unary operator + `singleValue: true` |
| `credentials required` | `authentication != "none"` but no credential bound | Bind credential or set `authentication: "none"` |
| Field appears missing despite being set | `displayOptions` rule hides it | Check `get_node({mode: "search_properties"})` for the controlling field |

# Error Catalog — n8n Validation

Detailed error examples with causes, fixes, and before/after configs. The minimal one-line error-type list lives in `SKILL.md`. The comprehensive deep catalog lives in [`../ERROR_CATALOG.md`](../ERROR_CATALOG.md).

## Node-Level Error Types

### 1. `missing_required`

**What it means**: a required field is not provided.

**How to fix**:

1. Use `get_node` to see required fields.
2. Add the missing field to your configuration.
3. Provide an appropriate value.

**Example**:

```javascript
// Error
{
  "type": "missing_required",
  "property": "channel",
  "message": "Channel name is required"
}

// Fix
config.channel = "#general";
```

### 2. `invalid_value`

**What it means**: the value doesn't match allowed options.

**How to fix**:

1. Check the error message for allowed values.
2. Use `get_node` to see options.
3. Update to a valid value.

**Example**:

```javascript
// Error
{
  "type": "invalid_value",
  "property": "operation",
  "message": "Operation must be one of: post, update, delete",
  "current": "send"
}

// Fix
config.operation = "post";  // Use valid operation
```

### 3. `type_mismatch`

**What it means**: wrong data type for the field.

**How to fix**:

1. Check expected type in the error message.
2. Convert value to the correct type.

**Example**:

```javascript
// Error
{
  "type": "type_mismatch",
  "property": "limit",
  "message": "Expected number, got string",
  "current": "100"
}

// Fix
config.limit = 100;  // Number, not string
```

### 4. `invalid_expression`

**What it means**: expression syntax error.

**How to fix**:

1. Use the **n8n Expression Syntax** skill.
2. Check for missing `{{}}` or typos.
3. Verify node/field references.

**Example**:

```javascript
// Error
{
  "type": "invalid_expression",
  "property": "text",
  "message": "Invalid expression: $json.name",
  "current": "$json.name"
}

// Fix
config.text = "={{$json.name}}";  // Add ={{...}}
```

### 5. `invalid_reference`

**What it means**: the referenced node doesn't exist.

**How to fix**:

1. Check node name spelling.
2. Verify the node exists in the workflow.
3. Update the reference to the correct name.

**Example**:

```javascript
// Error
{
  "type": "invalid_reference",
  "property": "expression",
  "message": "Node 'HTTP Requets' does not exist",
  "current": "={{$node['HTTP Requets'].json.data}}"
}

// Fix — correct the typo
config.expression = "={{$node['HTTP Request'].json.data}}";
```

## Workflow-Level Errors

### 1. Broken Connections

```json
{
  "error": "Connection from 'Transform' to 'NonExistent' - target node not found"
}
```

**Fix**: remove the stale connection or create the missing node. For batch cleanup, use the `cleanStaleConnections` operation in `n8n_update_partial_workflow`.

### 2. Circular Dependencies

```json
{
  "error": "Circular dependency detected: Node A → Node B → Node A"
}
```

**Fix**: restructure the workflow to remove the loop. n8n does not support cycles in the dependency graph.

### 3. Multiple Start Nodes

```json
{
  "warning": "Multiple trigger nodes found - only one will execute"
}
```

**Fix**: remove the extra triggers or split into separate workflows. Only one trigger node can fire a single execution.

### 4. Disconnected Nodes

```json
{
  "warning": "Node 'Transform' is not connected to workflow flow"
}
```

**Fix**: connect the node into the flow or remove it if unused. Orphan nodes never execute.

See [`../ERROR_CATALOG.md`](../ERROR_CATALOG.md) for the complete error catalog with every node-specific error.

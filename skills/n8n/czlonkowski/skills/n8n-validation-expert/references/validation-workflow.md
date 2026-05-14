# Validation Workflow — Full Walkthrough

Detailed iterative validation example and result-reading patterns. The minimal validation loop and severity hierarchy live in `SKILL.md`; this file holds the long code.

## The Validation Loop (telemetry pattern)

The most common pattern in n8n workflow building — 7,841 occurrences:

```
1. Configure node
   ↓
2. validate_node (23 seconds thinking about errors)
   ↓
3. Read error messages carefully
   ↓
4. Fix errors
   ↓
5. validate_node again (58 seconds fixing)
   ↓
6. Repeat until valid (usually 2-3 iterations)
```

## Worked Example — three iterations

```javascript
// Iteration 1
let config = {
  resource: "channel",
  operation: "create"
};

const result1 = validate_node({
  nodeType: "nodes-base.slack",
  config,
  profile: "runtime"
});
// → Error: Missing "name"

// ⏱️  23 seconds thinking...

// Iteration 2
config.name = "general";

const result2 = validate_node({
  nodeType: "nodes-base.slack",
  config,
  profile: "runtime"
});
// → Error: Missing "text"

// ⏱️  58 seconds fixing...

// Iteration 3
config.text = "Hello!";

const result3 = validate_node({
  nodeType: "nodes-base.slack",
  config,
  profile: "runtime"
});
// → Valid! ✅
```

**This is normal.** Don't be discouraged by multiple iterations — each cycle surfaces the next required field.

## Reading the Validation Result

### Step 1: Check `valid` field

```javascript
if (result.valid) {
  // ✅ Configuration is valid
} else {
  // ❌ Has errors - must fix before deployment
}
```

### Step 2: Fix errors first

```javascript
result.errors.forEach(error => {
  console.log(`Error in ${error.property}: ${error.message}`);
  console.log(`Fix: ${error.fix}`);
});
```

### Step 3: Review warnings

```javascript
result.warnings.forEach(warning => {
  console.log(`Warning: ${warning.message}`);
  console.log(`Suggestion: ${warning.suggestion}`);
  // Decide if you need to address this
});
```

### Step 4: Consider suggestions

```javascript
// Optional improvements
// Not required but may enhance workflow
```

## Validation Result Structure — full shape

```javascript
{
  "valid": false,
  "errors": [
    {
      "type": "missing_required",
      "property": "channel",
      "message": "Channel name is required",
      "fix": "Provide a channel name (lowercase, no spaces)"
    }
  ],
  "warnings": [
    {
      "type": "best_practice",
      "property": "errorHandling",
      "message": "Slack API can have rate limits",
      "suggestion": "Add onError: 'continueRegularOutput'"
    }
  ],
  "suggestions": [
    {
      "type": "optimization",
      "message": "Consider using batch operations for multiple messages"
    }
  ],
  "summary": {
    "hasErrors": true,
    "errorCount": 1,
    "warningCount": 1,
    "suggestionCount": 1
  }
}
```

## Profile choice — when to use which

| Profile | When | Validates | Trade-off |
|---|---|---|---|
| `minimal` | Quick checks during editing | Required fields, basic structure | Fastest, most permissive — may miss issues |
| `runtime` (recommended) | Pre-deployment validation | Required fields, value types, allowed values, basic dependencies | Balanced — catches real errors; some edge cases missed |
| `ai-friendly` | AI-generated configurations | Same as runtime, with reduced false positives | Less noisy for AI workflows; may allow questionable configs |
| `strict` | Production / critical workflows | Everything + best practices + performance + security | Maximum safety; many warnings, some false positives |

Use `runtime` for most cases. Switch to `ai-friendly` if false positives are noisy from AI-generated configs. Use `strict` only for production gating.

# End-to-End Validation Scenarios

Complete worked scenarios that combine validation, error interpretation, auto-fix, and recovery.

## Scenario 1: Slack node from scratch — three-iteration loop

```javascript
// Goal: post a message to #general

// Iteration 1 — minimal
let config = { resource: "message", operation: "post" };
let result = validate_node({
  nodeType: "nodes-base.slack",
  config,
  profile: "runtime"
});
// → Error: missing_required "channel"

// Iteration 2
config.channel = "#general";
result = validate_node({
  nodeType: "nodes-base.slack",
  config,
  profile: "runtime"
});
// → Error: missing_required "text"

// Iteration 3
config.text = "Build succeeded";
result = validate_node({
  nodeType: "nodes-base.slack",
  config,
  profile: "runtime"
});
// → Valid ✅ (with credentials bound)
```

## Scenario 2: Expression error → fix via `=` prefix

```javascript
// Initial
let config = {
  method: "GET",
  url: "https://api.example.com/users",
  authentication: "none",
  sendQuery: true,
  queryParameters: {
    parameters: [
      { name: "id", value: "{{ $json.userId }}" }  // ❌ missing =
    ]
  }
};

let result = validate_node({
  nodeType: "nodes-base.httpRequest",
  config,
  profile: "runtime"
});
// → invalid_expression on queryParameters.parameters[0].value
//   message: "Expression must start with ="

// Fix manually OR auto-fix the entire workflow
config.queryParameters.parameters[0].value = "={{ $json.userId }}";

// Or for an existing workflow:
n8n_autofix_workflow({
  id: "workflow-id",
  fixTypes: ["expression-format"],
  applyFixes: true,
  confidenceThreshold: "high"
});
```

## Scenario 3: Operator structure — trust auto-sanitization

```javascript
// IF node configured incorrectly for unary operator
const config = {
  conditions: {
    string: [
      {
        value1: "={{$json.email}}",
        operation: "isEmpty"
        // missing singleValue: true
      }
    ]
  }
};

// Save the workflow — auto-sanitization adds singleValue: true.
n8n_update_partial_workflow({
  id: "workflow-id",
  operations: [{
    type: "updateNode",
    nodeName: "IF",
    config
  }]
});

// After save, the persisted config has singleValue: true.
// Don't manually re-add it; let the system manage operator structure.
```

## Scenario 4: Broken connection recovery

```javascript
// Validation reports: Connection from 'Transform' to 'NonExistent' — target node not found
// (Node was renamed earlier; connection wasn't updated.)

n8n_update_partial_workflow({
  id: "workflow-id",
  operations: [{
    type: "cleanStaleConnections"
  }]
});

// Re-validate
const result = n8n_validate_workflow({ id: "workflow-id" });
// → Broken-connection error gone.
```

## Scenario 5: Workflow valid but failing at runtime — escalate profile

```javascript
// runtime profile passed but execution fails with rate-limit errors

// Re-validate with strict profile
const result = n8n_validate_workflow({
  id: "workflow-id",
  options: { profile: "strict" }
});

// → Warning: "No retry logic" on the Slack node
// → Warning: "Missing rate limiting"

// Decision: this is a production workflow hitting Slack — fix both warnings.
// Add onError: 'continueRegularOutput' with retryOnFail to the Slack node config.
```

## Scenario 6: AI-generated config noise — switch profile

```javascript
// LLM emitted a Slack config; validation under `runtime` shows 8 warnings.

const result = validate_node({
  nodeType: "nodes-base.slack",
  config,
  profile: "ai-friendly"  // reduces false positives for LLM output
});

// → Valid with 2 warnings (vs 8).
// Document the 2 remaining as accepted false positives in workflow notes
// if appropriate for the use case.
```

## Scenario 7: Preview-then-apply auto-fix

```javascript
// Preview every available fix on a workflow
const preview = n8n_autofix_workflow({
  id: "workflow-id",
  applyFixes: false
});

// Inspect preview.fixes — confidence + type + before/after diff
console.log(preview.fixes);

// Apply only high-confidence fixes
n8n_autofix_workflow({
  id: "workflow-id",
  applyFixes: true,
  confidenceThreshold: "high"
});

// Check postUpdateGuidance for any follow-up manual steps
console.log(preview.postUpdateGuidance);
```

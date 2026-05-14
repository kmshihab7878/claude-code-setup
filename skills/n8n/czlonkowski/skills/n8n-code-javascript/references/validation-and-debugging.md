# Validation and Debugging — n8n JavaScript Code

Detailed examples of common errors and best-practice patterns. The minimal rules and checklist live in `SKILL.md`.

## Return Format — full examples

**Critical rule**: always return an array of objects with a `json` property.

### Correct formats

```javascript
// ✅ Single result
return [{
  json: {
    field1: value1,
    field2: value2
  }
}];

// ✅ Multiple results
return [
  {json: {id: 1, data: 'first'}},
  {json: {id: 2, data: 'second'}}
];

// ✅ Transformed array
const transformed = $input.all()
  .filter(item => item.json.valid)
  .map(item => ({
    json: {
      id: item.json.id,
      processed: true
    }
  }));
return transformed;

// ✅ Empty result (when no data to return)
return [];

// ✅ Conditional return
if (shouldProcess) {
  return [{json: processedData}];
} else {
  return [];
}
```

### Incorrect formats

```javascript
// ❌ Object without array wrapper
return {
  json: {field: value}
};

// ❌ Array without json wrapper
return [{field: value}];

// ❌ Plain string
return "processed";

// ❌ Raw data without mapping
return $input.all();  // Missing .map()

// ❌ Incomplete structure
return [{data: value}];  // Should be {json: value}
```

**Why it matters**: next nodes expect array format. Incorrect format causes workflow execution to fail.

See [error-patterns.md](error-patterns.md) #3 for detailed error solutions.

## Top 5 Mistakes — full examples

### #1: Empty code or missing return (most common)

```javascript
// ❌ WRONG — no return statement
const items = $input.all();
// ... processing code ...
// Forgot to return!

// ✅ CORRECT — always return data
const items = $input.all();
// ... processing ...
return items.map(item => ({json: item.json}));
```

### #2: Expression syntax confusion

```javascript
// ❌ WRONG — using n8n expression syntax in code
const value = "{{ $json.field }}";

// ✅ CORRECT — JavaScript template literals
const value = `${$json.field}`;

// ✅ CORRECT — direct access
const value = $input.first().json.field;
```

### #3: Incorrect return wrapper

```javascript
// ❌ WRONG — returning object instead of array
return {json: {result: 'success'}};

// ✅ CORRECT — array wrapper required
return [{json: {result: 'success'}}];
```

### #4: Missing null checks

```javascript
// ❌ WRONG — crashes if field doesn't exist
const value = item.json.user.email;

// ✅ CORRECT — safe access with optional chaining
const value = item.json?.user?.email || 'no-email@example.com';

// ✅ CORRECT — guard clause
if (!item.json.user) {
  return [];
}
const value = item.json.user.email;
```

### #5: Webhook body nesting

```javascript
// ❌ WRONG — direct access to webhook data
const email = $json.email;

// ✅ CORRECT — webhook data under .body
const email = $json.body.email;
```

See [error-patterns.md](error-patterns.md) for the comprehensive error guide.

## Best Practices — full examples

### 1. Always validate input data

```javascript
const items = $input.all();

if (!items || items.length === 0) {
  return [];
}

if (!items[0].json) {
  return [{json: {error: 'Invalid input format'}}];
}

// Continue processing...
```

### 2. Use try-catch for error handling

```javascript
try {
  const response = await $helpers.httpRequest({
    url: 'https://api.example.com/data'
  });

  return [{json: {success: true, data: response}}];
} catch (error) {
  return [{
    json: {
      success: false,
      error: error.message
    }
  }];
}
```

### 3. Prefer array methods over loops

```javascript
// ✅ GOOD — functional approach
const processed = $input.all()
  .filter(item => item.json.valid)
  .map(item => ({json: {id: item.json.id}}));

// ❌ SLOWER — manual loop
const processed = [];
for (const item of $input.all()) {
  if (item.json.valid) {
    processed.push({json: {id: item.json.id}});
  }
}
```

### 4. Filter early, process late

```javascript
// ✅ GOOD — filter first to reduce processing
const processed = $input.all()
  .filter(item => item.json.status === 'active')  // Reduce dataset first
  .map(item => expensiveTransformation(item));    // Then transform

// ❌ WASTEFUL — transform everything, then filter
const processed = $input.all()
  .map(item => expensiveTransformation(item))     // Wastes CPU
  .filter(item => item.json.status === 'active');
```

### 5. Use descriptive variable names

```javascript
// ✅ GOOD — clear intent
const activeUsers = $input.all().filter(item => item.json.active);
const totalRevenue = activeUsers.reduce((sum, user) => sum + user.json.revenue, 0);

// ❌ BAD — unclear purpose
const a = $input.all().filter(item => item.json.active);
const t = a.reduce((s, u) => s + u.json.revenue, 0);
```

### 6. Debug with `console.log()`

```javascript
// Debug statements appear in the browser console
const items = $input.all();
console.log(`Processing ${items.length} items`);

for (const item of items) {
  console.log('Item data:', item.json);
  // Process...
}

return result;
```

# JavaScript Patterns — n8n Code Node

Production-tested patterns, full examples. The minimal pattern names live in `SKILL.md`; this file holds the long code.

## 1. Multi-Source Data Aggregation

Combine data from multiple APIs, webhooks, or nodes.

```javascript
const allItems = $input.all();
const results = [];

for (const item of allItems) {
  const sourceName = item.json.name || 'Unknown';
  // Parse source-specific structure
  if (sourceName === 'API1' && item.json.data) {
    results.push({
      json: {
        title: item.json.data.title,
        source: 'API1'
      }
    });
  }
}

return results;
```

## 2. Filtering with Regex

Extract patterns, mentions, or keywords from text.

```javascript
const pattern = /\b([A-Z]{2,5})\b/g;
const matches = {};

for (const item of $input.all()) {
  const text = item.json.text;
  const found = text.match(pattern);

  if (found) {
    found.forEach(match => {
      matches[match] = (matches[match] || 0) + 1;
    });
  }
}

return [{json: {matches}}];
```

## 3. Data Transformation & Enrichment

Map fields, normalize formats, add computed fields.

```javascript
const items = $input.all();

return items.map(item => {
  const data = item.json;
  const nameParts = data.name.split(' ');

  return {
    json: {
      first_name: nameParts[0],
      last_name: nameParts.slice(1).join(' '),
      email: data.email,
      created_at: new Date().toISOString()
    }
  };
});
```

## 4. Top N Filtering & Ranking

Sort and limit results.

```javascript
const items = $input.all();

const topItems = items
  .sort((a, b) => (b.json.score || 0) - (a.json.score || 0))
  .slice(0, 10);

return topItems.map(item => ({json: item.json}));
```

## 5. Aggregation & Reporting

Sum, count, group data.

```javascript
const items = $input.all();
const total = items.reduce((sum, item) => sum + (item.json.amount || 0), 0);

return [{
  json: {
    total,
    count: items.length,
    average: total / items.length,
    timestamp: new Date().toISOString()
  }
}];
```

See [common-patterns.md](common-patterns.md) for 10 detailed production patterns including dedup, grouping, joins, and edge cases.

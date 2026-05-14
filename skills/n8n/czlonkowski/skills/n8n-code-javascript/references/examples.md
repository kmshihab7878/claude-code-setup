# End-to-End Examples — n8n JavaScript Code Node

Complete worked examples that combine data access, transformation, helpers, and validation. See `javascript-patterns.md` for per-pattern recipes and `helpers-and-http.md` for `$helpers` / DateTime / `$jmespath` detail.

## Process webhook payload

```javascript
// Webhook data is under .body
const webhook = $input.first().json.body || {};

const name = (webhook.name || '').trim();
const email = (webhook.email || '').toLowerCase().trim();
const phone = webhook.phone || '';

return [{
  json: {
    name,
    email,
    phone,
    valid: Boolean(email && email.includes('@'))
  }
}];
```

## Fetch from external API and combine with upstream data

```javascript
const userId = $input.first().json.user_id;

try {
  const user = await $helpers.httpRequest({
    method: 'GET',
    url: `https://api.example.com/users/${userId}`,
    headers: {'Accept': 'application/json'}
  });

  return [{
    json: {
      user_id: userId,
      profile: user,
      fetched_at: DateTime.now().toISO()
    }
  }];
} catch (error) {
  return [{
    json: {
      user_id: userId,
      error: error.message,
      success: false
    }
  }];
}
```

## Group items by category

```javascript
const items = $input.all();

const groups = items.reduce((acc, item) => {
  const category = item.json.category || 'uncategorized';
  (acc[category] = acc[category] || []).push(item.json);
  return acc;
}, {});

return Object.entries(groups).map(([category, members]) => ({
  json: {
    category,
    count: members.length,
    items: members
  }
}));
```

## Combine data from two upstream nodes

```javascript
const webhook = $node["Webhook"].json.body || {};
const apiResponse = $node["HTTP Request"].json;

return [{
  json: {
    user_id: webhook.user_id,
    user_name: webhook.name,
    external_data: apiResponse.data || {},
    merged_at: new Date().toISOString()
  }
}];
```

## Extract URLs and phones with regex

```javascript
const urlPattern = /https?:\/\/[^\s<>"]+/g;
const phonePattern = /\+?\d{1,3}[\s-]?\(?\d{1,4}\)?[\s-]?\d{1,4}[\s-]?\d{1,9}/g;

return $input.all().map(item => {
  const text = item.json.body || '';
  return {
    json: {
      id: item.json.id,
      urls: text.match(urlPattern) || [],
      phones: text.match(phonePattern) || []
    }
  };
});
```

## Per-item conditional output (Each Item mode)

```javascript
const item = $input.item;
const data = item.json;

if (data.status === 'active' && (data.score || 0) >= 70) {
  return [{
    json: {
      ...data,
      tier: 'premium',
      discount: 0.20
    }
  }];
}

return [{
  json: {
    ...data,
    tier: 'standard',
    discount: 0.05
  }
}];
```

## Date-range filter with Luxon

```javascript
const cutoff = DateTime.now().minus({days: 30});

return $input.all()
  .filter(item => {
    const created = DateTime.fromISO(item.json.created_at);
    return created.isValid && created >= cutoff;
  })
  .map(item => ({json: item.json}));
```

See [common-patterns.md](common-patterns.md) for additional production patterns.

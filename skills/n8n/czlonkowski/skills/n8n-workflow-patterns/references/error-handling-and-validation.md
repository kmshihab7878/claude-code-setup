# Error Handling and Validation

Validation discipline, common gotchas, best practices, and the QA playbook
for n8n workflows.

## Validation Gates

Before activating a workflow, walk these gates:

- [ ] Each node validated with `validate_node({nodeType, config})`.
- [ ] Full workflow validated with `validate_workflow` (or `n8n_validate_workflow` by ID).
- [ ] Credentials configured at the node level, not in parameters.
- [ ] Webhook nodes have a response strategy (Respond Immediately, Respond Last Node, custom Respond to Webhook).
- [ ] Long-running work is not blocking a Webhook response.
- [ ] Error Trigger workflow exists for production workflows.
- [ ] Continue On Fail is configured only where silent failure is acceptable.
- [ ] Sample-data test executed against the workflow.
- [ ] Empty-data path tested.
- [ ] Execution order verified (v1 connection-based, not v0 top-to-bottom).
- [ ] Workflow name and notes describe purpose + data flow.

`n8n_autofix_workflow` can resolve many validation issues automatically.
Run it after `validate_workflow` reports issues, then re-validate.

## Common Gotchas

### 1. Webhook data structure

**Problem**: cannot access webhook payload data.

**Cause**: payload is nested under `$json.body`.

```javascript
// WRONG
{{$json.email}}

// RIGHT
{{$json.body.email}}
```

See: `n8n-expression-syntax` skill.

### 2. Multiple input items

**Problem**: node processes all input items, but you only want one.

**Solution**: use Execute Once mode, or index the first item:

```javascript
{{$json[0].field}}  // first item only
```

### 3. Authentication issues

**Problem**: API calls failing with 401/403.

**Solution**:

- Configure credentials in the node's Credentials section, not in parameters.
- Test credentials before workflow activation.
- For OAuth, use n8n's built-in OAuth credential types.

### 4. Node execution order

**Problem**: nodes executing in unexpected order.

**Solution**: check Workflow settings → Execution Order.

- v0: top-to-bottom (legacy).
- v1: connection-based (recommended).

Always use v1 unless you have a documented reason for v0.

### 5. Expression errors

**Problem**: expressions render as literal text.

**Solution**: use `{{ }}` around expressions. See `n8n-expression-syntax`.

### 6. Silent branch loss after IF/Switch

**Problem**: downstream node only sees one branch's data after an IF.

**Solution**: merge branches via the Merge node, or ensure each branch
terminates independently.

### 7. Webhook timeout under load

**Problem**: webhook returns 5xx during slow downstream work.

**Solution**: split into two workflows:

1. Webhook responds with `202 Accepted` immediately.
2. A follow-on workflow handles the heavy work; reports back asynchronously.

## Best Practices

### Do

- Start with the simplest pattern that solves the problem.
- Plan workflow structure before building.
- Use error handling on every production workflow.
- Test with sample data before activation.
- Follow the workflow creation checklist.
- Use descriptive node names — they survive renames better than IDs.
- Document complex workflows in the notes field.
- Monitor the first executions after deployment.

### Don't

- Build workflows in one shot — iterate (industry average ~56s between edits).
- Skip validation before activation.
- Ignore error scenarios.
- Use complex patterns when simple ones suffice.
- Hardcode credentials in parameters.
- Forget to handle empty data cases.
- Mix multiple patterns without clear boundaries.
- Deploy without testing.

## Anti-Patterns

| Anti-pattern | Symptom | Fix |
|--------------|---------|-----|
| Webhook with long-running body | 5xx during sync work | Split into 202-accept + follow-on workflow |
| Continue On Fail everywhere | Silent data loss | Use only where downstream tolerates failure |
| Unmerged IF / Switch branches | Downstream node missing data | Add Merge or terminate each branch explicitly |
| Credentials in node parameters | Secrets in source / exports | Move to n8n credential storage |
| One mega-workflow for everything | Hard to debug, single failure point | Split by pattern; communicate via webhook or queue |
| Schedule frequency > API rate limit | Throttling, partial data | Align schedule to rate limit or paginate |
| No Error Trigger in production | Failures go unnoticed | Add Error Trigger → alert (Slack / email / PagerDuty) |
| Hardcoded environment values | Workflow breaks on import | Use n8n environment variables or credentials |
| Skipped validation before activation | Production-time failures | `validate_workflow` + sample-data run, every time |

## QA Playbook

| Symptom | First check | Likely cause |
|---------|-------------|--------------|
| Workflow fires but does nothing | Execution view | Trigger condition not met; check trigger config |
| Webhook returns 5xx | Response strategy | Long body work blocking; split workflow |
| Step processes 0 items | Upstream output | Earlier filter eliminated everything; check IF |
| API call 401/403 | Credential section | Credentials in parameters instead of Credentials |
| Downstream sees stale data | Execution order | v0 vs v1 mismatch |
| Branches don't rejoin | Merge node | Missing Merge after IF / Switch |
| Schedule misses runs | Cron expression | Time zone or DST drift |
| AI agent can't call a tool | Connections | Tool not wired to the agent node |
| Error Trigger never fires | Trigger placement | Error Trigger requires no upstream connection |

## Real Template Examples

From the n8n template library — use `search_templates` and `get_template` to
discover more.

- **Template #2947 — Weather to Slack**: Schedule → HTTP Request → Set → Slack
  (4 nodes, Scheduled Task).
- **Webhook Processing** — most common pattern; covers form submissions,
  payment webhooks, chat integrations.
- **HTTP API** — data fetching and third-party integrations.
- **Database Operations** — ETL, data sync, backup workflows.
- **AI Agents** — chatbots, content generation, data analysis.

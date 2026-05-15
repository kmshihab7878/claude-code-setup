# n8n Administration Examples

This reference contains public-safe examples for common n8n administration tasks. Replace placeholders with approved local values at execution time.

## Data Table Row Delete Preview

Use dry-run before deleting rows.

```bash
curl -s -X DELETE "<n8n-url>/api/v1/data-tables/<table-id>/rows/delete?dryRun=true&returnData=true&filter=<url-encoded-filter>" \
  -H "X-N8N-API-KEY: <api-key>"
```

After review and explicit approval, run without `dryRun=true`.

## Data Table Upsert

```bash
curl -s -X POST "<n8n-url>/api/v1/data-tables/<table-id>/rows/upsert" \
  -H "X-N8N-API-KEY: <api-key>" \
  -H "Content-Type: application/json" \
  -d '{
    "filter": {
      "type": "and",
      "filters": [
        { "columnName": "external_id", "condition": "eq", "value": "example-123" }
      ]
    },
    "data": { "status": "active" },
    "returnData": true,
    "dryRun": true
  }'
```

## Folder Move

Internal API with session-cookie auth:

```bash
curl -s -X PATCH "<n8n-url>/rest/projects/<project-id>/folders/<folder-id>" \
  -H "Cookie: <session-cookie>" \
  -H "Content-Type: application/json" \
  -d '{ "parentFolderId": "<target-folder-id>" }'
```

Use `PROJECT_ROOT` or null to move to the project root.

## Community Package Install

```bash
curl -s -X POST "<n8n-url>/community-packages" \
  -H "Cookie: <session-cookie>" \
  -H "Content-Type: application/json" \
  -d '{ "name": "<package-name>" }'
```

Validate by listing installed packages.

## Workflow Backup

```bash
docker exec <container> n8n export:workflow --all --output=/home/node/.n8n/backups/workflows.json
docker cp <container>:/home/node/.n8n/backups/workflows.json <backup-dir>/workflows.json
```

## Full Restore

Full restore is destructive and requires explicit approval.

```bash
docker exec <container> n8n import:entities --inputDir=<backup-dir> --truncateTables
```

Validate with health check, workflow list, and representative workflow execution or activation state.

## Final Report Pattern

```text
Operation: [what changed]
Risk tier: [T1/T2/T3]
Surface used: [MCP/Public API/Internal API/CLI/Docker]
Approval: [not required/received/deferred]
Validation: [health check, API response, row count, package list, logs]
Rollback: [backup path or revert plan]
Remaining risk: [none or specific follow-up]
```

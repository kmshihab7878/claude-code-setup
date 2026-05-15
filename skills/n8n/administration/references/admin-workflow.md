# n8n Administration Workflow Reference

This reference contains routing detail, endpoint catalogs, and administration procedures for operations not fully covered by MCP. Load it only when the task needs deeper n8n administration detail.

## Contents

- [Use What](#use-what)
- [Data Tables](#data-tables)
- [Folder Management](#folder-management)
- [Community Packages](#community-packages)

## Use What

| You want to... | Use | Why |
|---|---|---|
| Build, edit, or validate workflows | MCP | Partial updates, validation, auto-fix |
| Search nodes or get node schema | MCP | Indexed node database with properties |
| Deploy templates | MCP | Auto-fix and version upgrades |
| Test or trigger workflows | MCP | Auto-detects trigger type |
| Manage executions | MCP | List, get, delete with filtering |
| Health check | MCP | `n8n_health_check` |
| CRUD credentials or test credentials | [credentials skill](../../credentials/SKILL.md) | Full credential management |
| CRUD data table rows | Public REST API | API-key-supported row operations |
| CRUD data table columns or CSV import | Internal API | Not exposed in public API |
| Manage folders or move workflows | Internal API | Enterprise-only folders |
| Install community packages | Internal API | Package admin endpoint |
| Export decrypted credentials | CLI | Requires explicit approval and secret handling |
| Full database backup or restore | CLI | `n8n export:entities` / `import:entities` |
| Roll back database migration | CLI | `n8n db:revert` |
| Set encryption key or DB config | Environment variables | Not exposed via API |
| Upgrade n8n version | Docker/infra | Pull image and redeploy |

Priority: MCP -> Public API -> Internal API -> CLI -> Docker/infra.

## Data Tables

n8n's built-in structured storage. Each table belongs to a project.

Source files: `data-table.controller.ts`, `data-table-aggregate.controller.ts`, `data-table-uploads.controller.ts`.

### Data Model

- Table: id, name, projectId, columns, createdAt, updatedAt.
- Name: 1-128 chars, unique per project.
- Column: id, name, type, index.
- Column name: 1-63 chars, regex `^[a-zA-Z][a-zA-Z0-9_]*$`, unique per table.
- Column types: `string`, `number`, `boolean`, `date`.
- Row system columns: id, createdAt, updatedAt.

### Filter Schema

Used by get rows, update rows, delete rows, and upsert.

```json
{
  "type": "and",
  "filters": [
    { "columnName": "status", "condition": "eq", "value": "active" },
    { "columnName": "score", "condition": "gte", "value": 80 }
  ]
}
```

Conditions: `eq`, `neq`, `like`, `ilike`, `gt`, `gte`, `lt`, `lte`.
`like` and `ilike` auto-wrap with `%` if no wildcard exists.

### Public API

API-key auth.

| Method | Path | What |
|---|---|---|
| `GET` | `/api/v1/data-tables` | List tables. Query: `limit`, `cursor`, `filter`, `sortBy` |
| `POST` | `/api/v1/data-tables` | Create table. Body: `{ name, columns: [{ name, type }] }` |
| `GET` | `/api/v1/data-tables/:id` | Get table with columns |
| `PATCH` | `/api/v1/data-tables/:id` | Rename. Body: `{ name }` |
| `DELETE` | `/api/v1/data-tables/:id` | Delete table |
| `GET` | `/api/v1/data-tables/:id/rows` | Get rows. Query: `limit`, `cursor`, `filter`, `sortBy`, `search` |
| `POST` | `/api/v1/data-tables/:id/rows` | Insert rows. Body: `{ data: [...], returnType?: "count"|"id"|"all" }` |
| `PATCH` | `/api/v1/data-tables/:id/rows/update` | Update by filter. Body: `{ filter, data, returnData?, dryRun? }` |
| `POST` | `/api/v1/data-tables/:id/rows/upsert` | Upsert. Body: `{ filter, data, returnData?, dryRun? }` |
| `DELETE` | `/api/v1/data-tables/:id/rows/delete` | Delete by filter. Query: `filter`, `returnData`, `dryRun` |

### Internal API Additions

Session-cookie auth. Base: `/rest/projects/:projectId/data-tables`.

| Method | Path | What |
|---|---|---|
| `POST` | `/:id/columns` | Add column. Body: `{ name, type, index? }` |
| `DELETE` | `/:id/columns/:colId` | Delete column |
| `PATCH` | `/:id/columns/:colId/move` | Reorder. Body: `{ targetIndex }` |
| `PATCH` | `/:id/columns/:colId/rename` | Rename. Body: `{ name }` |
| `GET` | `/:id/download-csv` | Download CSV. Query: `includeSystemColumns` |
| `POST` | `/:id/import-csv` | Import CSV. Body: `{ fileId }` |

CSV upload: `POST /rest/data-tables/uploads` with multipart field `file` and `hasHeaders` set to `"true"` or `"false"`. Use returned `id` as `fileId`.

Global listing: `GET /rest/data-tables-global/`.
Storage limits: `GET /rest/data-tables-global/limits`.

### Data Table Gotchas

1. Filter is mandatory for delete.
2. `dryRun: true` is available on update, upsert, and delete.
3. Column names must match `^[a-zA-Z][a-zA-Z0-9_]*$`, max 63 chars.
4. Table names are unique per project.
5. Column CRUD is internal API only.
6. CSV import is upload file -> use `fileId`.
7. Public API creates tables in the API key owner's personal project.
8. Source-control protected instances block writes.
9. Dates are stored as UTC ISO 8601.

## Folder Management

Folders organize workflows into nested folders within projects.

Source files: `folder.controller.ts`, `workflows.controller.ts`, `folder.schema.ts`.

Folders are enterprise-only and require `feat:folders`. They use internal API session-cookie auth; public API endpoints are not available.

### Folder Endpoints

Base: `/rest/projects/:projectId/folders`.

| Method | Path | What |
|---|---|---|
| `POST` | `/` | Create. Body: `{ name, parentFolderId? }` |
| `GET` | `/` | List. Query: `skip`, `take`, `sortBy`, `filter` |
| `GET` | `/:id/tree` | Ancestor chain from root to this folder |
| `GET` | `/:id/content` | Recursive counts: `{ totalSubFolders, totalWorkflows }` |
| `GET` | `/:id/credentials` | Credentials used by workflows in this folder |
| `PATCH` | `/:id` | Update. Body: `{ name?, tagIds?, parentFolderId? }` |
| `DELETE` | `/:id` | Delete. Query: `transferToFolderId` optional |
| `PUT` | `/:id/transfer` | Transfer to project. Body: `{ destinationProjectId, destinationParentFolderId, shareCredentials }` |

### Folder Name Validation

- Cannot be empty.
- Cannot contain `[ ] ^ \ / : * ? " < > |`.
- Cannot consist only of dots or start with a dot.
- Max 128 characters.

### Moving Folders

Set `parentFolderId` in the PATCH body.

- Cannot set a folder as its own parent.
- Cannot move into own descendants.
- New parent must be in the same project.
- Use `PROJECT_ROOT` to move to top level.

### Deleting Folders

Two modes:

1. Without `transferToFolderId`: flatten and archive. Workflows move to project root, are archived and deactivated, then folder is deleted.
2. With `transferToFolderId`: transfer. Children move to target folder or `PROJECT_ROOT`, workflow state is preserved, then folder is deleted.

Both modes require explicit approval when used against shared or production data.

### Moving Workflows Between Folders

These operations live on the workflows controller:

| Operation | How |
|---|---|
| Create in folder | `POST /rest/workflows/` with `parentFolderId` |
| Move to folder | `PATCH /rest/workflows/:id` with `parentFolderId` |
| Move to root | Set `parentFolderId` to `PROJECT_ROOT` or null |
| List in folder | `GET /rest/workflows/?filter={"parentFolderId":"..."}&includeFolders=true` |
| Transfer and place | `PUT /rest/workflows/:id/transfer` with `destinationParentFolderId` |

## Community Packages

Source: `community-packages.controller.ts`.

Internal API only, session-cookie auth.

| Method | Path | What |
|---|---|---|
| `POST` | `/community-packages` | Install. Body: `{ "name": "n8n-nodes-package-name" }` |
| `GET` | `/community-packages` | List installed |
| `PATCH` | `/community-packages` | Update. Body: `{ "name": "n8n-nodes-package-name" }` |
| `DELETE` | `/community-packages` | Uninstall. Body: `{ "name": "n8n-nodes-package-name" }` |

Packages persist in the n8n volume at `/home/node/.n8n/nodes/`. If that volume is lost, reinstall packages.

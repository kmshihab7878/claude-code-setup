# n8n Administration Security and Validation Reference

This reference holds detailed safety rules, approval gates, validation checks, and completion review guidance for n8n administration.

## Destructive and Approval-Gated Operations

Ask for explicit approval before:

- Deleting tables, rows, folders, workflows, credentials, or community packages.
- Running `n8n export:credentials --all --decrypted`.
- Running `n8n import:entities --inputDir=... --truncateTables`.
- Running `n8n db:revert`.
- Running `n8n user-management:reset`.
- Running `n8n license:clear`.
- Clearing LDAP configuration.
- Disabling MFA for a real user.
- Redeploying production or shared infrastructure.
- Changing `N8N_ENCRYPTION_KEY`, database config, or queue mode settings.

## Secret Handling

- Never print credential values, decrypted exports, API keys, session cookies, database passwords, encryption keys, or tokens.
- Treat decrypted credential exports as secret material.
- Do not place real secrets in Markdown, TOML, JSON examples, shell output summaries, commits, or chat.
- Use env-var names and placeholders such as `${N8N_ENCRYPTION_KEY}`, `${DB_PASSWORD}`, `<api-key>`, and `<session-cookie>`.
- If a token or credential appears in output, stop and recommend rotation and cleanup.

## Preflight Checklist

Before writes:

- Confirm target instance and environment.
- Identify auth surface: MCP, API key, session cookie, CLI, or Docker.
- Confirm target IDs: project, table, folder, workflow, package, or version.
- Inspect current state.
- Confirm backup and rollback path for destructive or infrastructure work.
- Prefer preview or dry-run modes where available.
- Check for source-control protected instances.
- Confirm enterprise-only folder feature availability when folder management is requested.

## Data Table Safety

- Use `dryRun: true` for update, upsert, and delete where available.
- Require a filter for row deletes.
- Avoid broad filters unless explicitly requested and approved.
- Validate row counts before and after bulk changes.
- Confirm column name and type constraints before column changes.
- Treat CSV imports as two-step operations: upload, then import by `fileId`.

## Folder Safety

- Confirm folder deletion mode before deleting:
  - No `transferToFolderId`: workflows move to root, are archived and deactivated.
  - With `transferToFolderId`: children move to target folder or root and state is preserved.
- Check circular-move constraints.
- Confirm same-project parent constraints.
- Verify workflow locations after move or transfer.

## Backup and Restore Safety

- Back up workflows before imports, upgrades, and destructive changes.
- Back up the database before restore, migration rollback, or version upgrade.
- Keep `N8N_ENCRYPTION_KEY` unchanged across restore.
- Validate backup files exist before restore.
- Treat full restore as destructive when `--truncateTables` is used.

## Validation Checklist

Use the smallest evidence that proves success:

- API status code and returned IDs.
- Row count, updated count, or dry-run count.
- Folder tree or workflow location query.
- Package list after install, update, or uninstall.
- CLI exit code and concise output summary.
- Docker container status.
- Health check through MCP or `/healthz`.
- Logs with secrets redacted.
- Representative workflow activation or execution state.

## Completion Review

Final reports should include:

- What changed.
- Which surface was used.
- What was not changed.
- Approval gates satisfied or deferred.
- Validation evidence.
- Rollback path.
- Remaining risks.

## Public-Safe Documentation Rules

- Use placeholders only.
- Do not include local absolute paths, private hostnames, real account IDs, private project names, or personal identifiers.
- Keep examples generic and portable.
- Do not copy private instance logs into tracked files.

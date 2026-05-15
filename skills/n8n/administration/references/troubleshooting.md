# n8n Administration Troubleshooting Reference

This reference contains troubleshooting detail and operational gotchas for n8n administration.

## Troubleshooting Matrix

| Symptom | Likely Cause | Fix |
|---|---|---|
| Webhooks not receiving | Wrong `WEBHOOK_URL` | Set full public URL with trailing `/` |
| Credentials invalid after move | Different encryption key | Use original `N8N_ENCRYPTION_KEY` |
| Schedules not triggering | Wrong timezone | Set `GENERIC_TIMEZONE` |
| Community nodes missing | Volume not persisted | Check the n8n volume mount |
| Workflow could not be activated | Missing credentials | Relink credentials |
| Folder endpoints return unavailable | Enterprise feature missing | Confirm `feat:folders` license |
| Internal API returns unauthorized | API key used instead of session cookie | Use the correct session-cookie auth surface |
| Data table delete blocked | Missing filter | Provide a filter and use dry-run first |
| CSV import fails | Upload/import sequence incomplete | Upload CSV first, then import with returned `fileId` |
| Source-control protected write fails | Instance blocks writes | Do not bypass; report protected mode |

## Health and Logs

Health:

```bash
curl -s "<n8n-url>/healthz"
```

Debug logs:

```bash
N8N_LOG_LEVEL=debug
docker logs <container> -f --tail 100
```

Do not paste logs that contain secrets, cookies, tokens, credential values, or private data.

## Operational Gotchas

1. `N8N_ENCRYPTION_KEY` is irreplaceable for credential decryption.
2. `WEBHOOK_URL` must end with `/`.
3. External systems use `/webhook/`, not `/webhook-test/`.
4. Credential IDs are instance-specific; relink after import.
5. Webhook paths must be unique across all workflows.
6. Internal API requires session cookie, not API key.
7. Folders are enterprise-only and require `feat:folders`.
8. Data table column CRUD is internal API only.
9. Source-control protected instances block writes.
10. Public API data table creation may target the API key owner's personal project.

## Diagnosis Flow

1. Identify whether the issue is workflow, auth, API, CLI, Docker, database, or deployment.
2. Run a health check.
3. Inspect the narrowest relevant state: workflow, folder, package list, data table, container, or logs.
4. Verify environment variables without printing secret values.
5. Confirm whether the instance is source-control protected or license-gated.
6. Apply the smallest fix.
7. Re-run the same check that exposed the issue.

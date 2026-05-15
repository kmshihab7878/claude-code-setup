# n8n Administration Commands and Recipes

This reference contains CLI commands, Docker recipes, environment variables, backup/restore steps, worker mode, and upgrade procedures.

## Contents

- [CLI Commands](#cli-commands)
- [Docker Deployment](#docker-deployment)
- [Environment Variables](#environment-variables)
- [Backup and Restore](#backup-and-restore)
- [Upgrades](#upgrades)

## CLI Commands

Run inside the container:

```bash
docker exec -it <container> n8n <command>
```

### Backup and Export

| Command | What |
|---|---|
| `n8n export:workflow --all --output=file.json` | Export all workflows |
| `n8n export:workflow --id=ID --output=file.json` | Export one workflow |
| `n8n export:credentials --all --decrypted --output=file.json` | Export credentials in plaintext; approval-gated |
| `n8n export:entities --outputDir=dir/` | Full database export |

### Restore and Import

| Command | What |
|---|---|
| `n8n import:workflow --input=file.json` | Import workflows |
| `n8n import:credentials --input=file.json` | Import credentials |
| `n8n import:entities --inputDir=dir/ --truncateTables` | Full destructive restore |

### Instance Management

| Command | What |
|---|---|
| `n8n execute --id=ID` | Run workflow without webhook |
| `n8n update:workflow --id=ID --active=true` | Activate |
| `n8n update:workflow --all --active=false` | Deactivate all |
| `n8n list:workflow` | List all |
| `n8n delete:workflow --id=ID` | Delete |
| `n8n audit` | Security audit |
| `n8n db:revert` | Roll back last DB migration |

### User and Auth

| Command | What |
|---|---|
| `n8n user-management:reset` | Reset user management to initial setup; approval-gated |
| `n8n mfa:disable --email=user@example.com` | Disable MFA for a user |
| `n8n ldap:reset` | Clear LDAP config |
| `n8n license:info` | License info |
| `n8n license:clear` | Remove license; approval-gated |

### Worker Mode

| Command | What |
|---|---|
| `n8n start` | Main process: editor and triggers |
| `n8n worker --concurrency=5` | Worker process in queue mode |
| `n8n webhook` | Dedicated webhook process |

## Docker Deployment

Use placeholders for hostnames, keys, and passwords. Do not commit real env values.

### PostgreSQL Production Example

```yaml
version: "3.8"
services:
  n8n:
    image: docker.n8n.io/n8nio/n8n:latest
    restart: unless-stopped
    ports:
      - "5678:5678"
    environment:
      - N8N_HOST=${N8N_HOST}
      - N8N_PROTOCOL=https
      - WEBHOOK_URL=https://${N8N_HOST}/
      - N8N_ENCRYPTION_KEY=${N8N_ENCRYPTION_KEY}
      - DB_TYPE=postgresdb
      - DB_POSTGRESDB_HOST=postgres
      - DB_POSTGRESDB_PORT=5432
      - DB_POSTGRESDB_DATABASE=n8n
      - DB_POSTGRESDB_USER=n8n
      - DB_POSTGRESDB_PASSWORD=${DB_PASSWORD}
      - EXECUTIONS_DATA_PRUNE=true
      - EXECUTIONS_DATA_MAX_AGE=168
      - GENERIC_TIMEZONE=${TIMEZONE}
    volumes:
      - n8n_data:/home/node/.n8n
    depends_on:
      - postgres

  postgres:
    image: postgres:16
    restart: unless-stopped
    environment:
      - POSTGRES_DB=n8n
      - POSTGRES_USER=n8n
      - POSTGRES_PASSWORD=${DB_PASSWORD}
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  n8n_data:
  postgres_data:
```

### SQLite Simple Example

```yaml
services:
  n8n:
    image: docker.n8n.io/n8nio/n8n:latest
    restart: unless-stopped
    ports:
      - "5678:5678"
    environment:
      - N8N_HOST=${N8N_HOST}
      - WEBHOOK_URL=https://${N8N_HOST}/
      - N8N_ENCRYPTION_KEY=${N8N_ENCRYPTION_KEY}
      - DB_TYPE=sqlite
    volumes:
      - n8n_data:/home/node/.n8n
```

## Environment Variables

### Critical

| Variable | Purpose |
|---|---|
| `N8N_ENCRYPTION_KEY` | Encrypts credentials; irreplaceable |
| `WEBHOOK_URL` | Full public URL; must end with `/` |
| `DB_TYPE` | `sqlite` or `postgresdb` |
| `GENERIC_TIMEZONE` | Default for cron triggers |

### Execution

| Variable | Default |
|---|---|
| `EXECUTIONS_DATA_PRUNE` | `false` |
| `EXECUTIONS_DATA_MAX_AGE` | `336` hours |
| `N8N_CONCURRENCY_PRODUCTION_LIMIT` | `-1` unlimited |
| `N8N_EXECUTIONS_MODE` | `regular`, or `queue` for Redis workers |

### Miscellaneous

| Variable | Default |
|---|---|
| `N8N_LOG_LEVEL` | `info` |
| `N8N_COMMUNITY_PACKAGES_ENABLED` | `true` |
| `N8N_RUNNERS_ENABLED` | `false` |

## Backup and Restore

### Quick Backup

```bash
docker exec <container> n8n export:workflow --all --output=/home/node/.n8n/backups/workflows.json
docker exec <container> n8n export:credentials --all --decrypted --output=/home/node/.n8n/backups/credentials.json
docker cp <container>:/home/node/.n8n/backups/ ./n8n-backup-$(date +%Y%m%d)/
```

Decrypted credential export requires explicit approval and secret handling.

### Database Backup

```bash
# PostgreSQL
docker exec <postgres-container> pg_dump -U n8n n8n > n8n-db-$(date +%Y%m%d).sql

# SQLite
docker cp <container>:/home/node/.n8n/database.sqlite ./n8n-db-$(date +%Y%m%d).sqlite
```

### Restore

```bash
docker exec <container> n8n import:workflow --input=/home/node/.n8n/backups/workflows.json
docker exec <container> n8n import:credentials --input=/home/node/.n8n/backups/credentials.json

# Full restore is destructive and requires explicit approval.
docker exec <container> n8n import:entities --inputDir=<backup-dir> --truncateTables
```

## Upgrades

```bash
docker pull docker.n8n.io/n8nio/n8n:latest
docker compose down
docker compose up -d
```

Pin a version:

```yaml
image: docker.n8n.io/n8nio/n8n:1.70.3
```

Rollback last database migration:

```bash
docker exec <container> n8n db:revert
```

Upgrade workflow:

1. Verify current version and target version.
2. Confirm backup exists and restore path is known.
3. Pull or pin the image.
4. Redeploy during an approved maintenance window.
5. Run health check and inspect logs.
6. Validate representative workflows and webhooks.
7. Keep rollback path available until validation completes.

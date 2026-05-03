# Connections Registry

_Single source of truth for every tool, account, and data source the AI OS can reach._

> **Privacy guard:** Never paste real credentials, tokens, or API keys into this file. Use `.env` (gitignored) for secrets. Use a dedicated **AI OS service account** for sensitive systems.

See `docs/CONNECTIONS_ROADMAP.md` for the seven-domain build order and decision criteria.

---

## Schema

| Field | Meaning |
|-------|---------|
| Domain | Revenue · Customer · Calendar · Comms · Tasks · Meetings · Knowledge |
| Tool | Name |
| Account | Logical label (e.g. `aios-service`) — never the email |
| Data Needed | What the OS reads/writes |
| Access Method | Manual export · Direct API · MCP · CLI · Webhook · Workflow tool · Not connected |
| Auth Location | `.env` var name OR `manual` OR `none` |
| Sensitivity | low · medium · high |
| Status | not connected · planned · connected (read-only) · connected (write) · paused · revoked |
| Notes | Rate limits, kill switch, related runbook |

---

## Tier 1 — connected

| Domain | Tool | Account | Data | Access | Auth | Sensitivity | Status | Notes |
|--------|------|---------|------|--------|------|-------------|--------|-------|
| _(populate as you connect tools)_ | | | | | | | | |

## Tier 4 — manual / planned

| Domain | Tool | Reason | Planned access |
|--------|------|--------|----------------|
| Revenue | _e.g. Stripe_ | Need to set up restricted key | Direct API, read-only |
| Customer | | | |
| Calendar | | | |
| Comms | | | |
| Tasks | | | |
| Meetings | | | |
| Knowledge | | | |

# Security

## Reporting a vulnerability

Open a private security advisory via GitHub:
**Security → Advisories → Report a vulnerability** on the repository page.

Do not file public issues for sensitive findings. Maintainers will acknowledge within a reasonable window and coordinate a fix.

## Scope

In scope:

- Hook scripts under `hooks/`
- The MCP security gate (`hooks/mcp-security-gate.sh`) and whitelist (`recipes/lib/mcp-whitelist.json`)
- Pre-commit / safety checks under `scripts/`
- Anything that could cause secret leakage, credential exposure, or arbitrary code execution when this configuration is loaded into Claude Code

Out of scope:

- Issues in upstream tools (Claude Code, Warp, MCP servers themselves) — file those with the respective project
- Local misconfiguration that isn't a flaw in this repository's defaults

## Defence model

Full architecture: [`docs/SECURITY.md`](docs/SECURITY.md). Quick map:

| Layer | What it stops | Where |
|---|---|---|
| `.gitignore` | Secret files entering the index | repo root |
| Pre-commit secret hook | Direct `.env`/`*.key` writes | `hooks/no-secret-commit.sh` |
| MCP security gate | Unknown / write-capable MCP calls | `hooks/mcp-security-gate.sh` |
| Public-safety check | Personal-identifier regression | `scripts/check-public-safety.sh` |
| Destructive-command gate | `rm -rf /`, force-push to main, etc. | `hooks/destructive-command-gate.sh` |
| Validation suite | Drift in counts / refs | `scripts/validate.sh` |

## Pre-publication checklist

See [`docs/PUBLICATION_CHECKLIST.md`](docs/PUBLICATION_CHECKLIST.md).

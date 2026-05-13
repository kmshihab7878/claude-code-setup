# AGENTS.md

This file is a public-safe pointer for agent-compatible tools.

## Canonical Policy

The canonical operating contract is [`CLAUDE.md`](./CLAUDE.md). If this file conflicts with `CLAUDE.md`, follow `CLAUDE.md`.

## Repository Safety

- Do not commit secrets, credentials, tokens, session records, memory exports, local paths, or private context.
- Use placeholders such as `<your-org>/<your-repo>`, `<workspace>`, `<project-root>`, and `<your-api-key>`.
- Keep local overrides in ignored local files.
- Run validation before committing.

## Validation

Run:

```bash
bash scripts/check-public-safety.sh
bash scripts/audit-public-readiness.sh --quick
gitleaks detect --no-banner --redact
trivy fs --scanners secret .
bash scripts/validate.sh
```

## Related Docs

- [`CLAUDE.md`](./CLAUDE.md)
- [`README.md`](./README.md)
- [`docs/SETUP.md`](./docs/SETUP.md)
- [`docs/SECURITY.md`](./docs/SECURITY.md)
- [`docs/CONTEXT_BUDGET.md`](./docs/CONTEXT_BUDGET.md)
- [`docs/PUBLICATION_CHECKLIST.md`](./docs/PUBLICATION_CHECKLIST.md)
- [`docs/TROUBLESHOOTING.md`](./docs/TROUBLESHOOTING.md)
- [`CONTRIBUTING.md`](./CONTRIBUTING.md)

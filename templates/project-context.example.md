# Project context — template

A skeleton for filling out per-project context that Claude Code can use to make better decisions. Lives at `context/<topic>.md` in your project. Populated by `/onboard` or by hand. **Never commit real personal details to the public repo.**

---

## `context/about.md`

```markdown
# About this project

- **Type:** <web-app | api | library | data-pipeline | trading-strategy | other>
- **Primary language(s):** <e.g. Python, TypeScript>
- **Risk tier:** <T0 internal | T1 prod-shadow | T2 user-facing | T3 financial/safety-critical>
- **Owner role:** <maintainer | operator | contributor>

## Why this project exists
<one paragraph: the problem it solves, in plain language>

## Constraints that matter
- <e.g. must support offline mode>
- <e.g. cannot add new dependencies without ADR>
```

---

## `context/stack.md`

```markdown
# Stack

| Layer | Choice | Why |
|---|---|---|
| Runtime | <e.g. Python 3.12> | <constraint or preference> |
| Framework | <e.g. FastAPI> | <constraint or preference> |
| Storage | <e.g. Postgres 16 on RDS> | <constraint or preference> |
| Deploy | <e.g. Fargate via Terraform> | <constraint or preference> |
| Tests | <e.g. pytest + hypothesis> | <constraint or preference> |

## Versions and pins
- <runtime/version manager file paths>

## Off-limits
- <e.g. no GPL dependencies>
- <e.g. no telemetry libraries>
```

---

## `context/conventions.md`

```markdown
# Conventions

## Naming
- Modules: <kebab-case | snake_case>
- Tests: <test_*.py | *.test.ts>
- Branches: <feat/x | fix/x | chore/x>

## Commit format
<conventional-commits | other>

## Style
- Formatter: <black | ruff | prettier>
- Linter: <ruff | eslint>
- Type checker: <pyright | mypy | tsc>

## PR rules
- <e.g. squash-merge only>
- <e.g. CI must be green>
```

---

## `context/non-negotiables.md`

```markdown
# Non-negotiables

Things that must always be true. Violations block merge.

- <e.g. no production code without a failing test first>
- <e.g. no schema change without a migration>
- <e.g. no new MCP server without an entry in the whitelist>
- <e.g. no commit with a real token; gitleaks pre-commit hook required>
```

---

## `context/goals.md`

```markdown
# Goals

## Now (this week)
- <bullet>
- <bullet>

## Next (this month)
- <bullet>

## Later (someday)
- <bullet>

Update weekly via `/level-up`.
```

---

## Privacy rules

- Names: use roles (`maintainer`, `operator`), never real names.
- Emails: use `<your-email>` or omit entirely.
- Repos: use `<your-org>/<your-repo>` in examples.
- Paths: use `<workspace>` or `~/projects/<repo>`.
- Service URLs: use `<your-domain>` or product names without subdomains.

If your fork lives behind a private remote, you can fill these in normally and add `context/` to your local `.gitignore`. Never push your filled-in context to a public mirror.

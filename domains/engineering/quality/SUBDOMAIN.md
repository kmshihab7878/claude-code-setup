# Engineering — Quality

Testing strategy, code review, property-based testing, accessibility, performance validation.

## Canonical skills

- `test-driven-development` — RED-GREEN-REFACTOR
- `testing-methodology` — Test pyramid, AAA, edge-case checklists
- `property-based-testing` — Hypothesis strategies
- `api-testing-suite` — Bruno + Schemathesis + OpenAPI validation + Spectral
- `webapp-testing` — Playwright toolkit
- `expect-testing` — Adversarial browser tests (diff-aware)
- `test-gap-analyzer` — Coverage gap detection + targeted generation
- `agent-evaluation` — Eval harness for agents

## Agents

- **L2:** `quality-engineer`
- **L3:** `compliance-officer`
- **L6:** `tester`, `debugger`, `refactorer`, `code-reviewer`, `api-tester`, `test-results-analyzer`

Wave 1 `agents/quality/**` (15 stage agents): EXPERIMENTAL.

## Commands

`/test-gen`, `/review`, `/debug`, `/fix-root`

## Recipes

`recipes/engineering/test-suite.yaml`, `recipes/engineering/code-review.yaml`

## Path rules

`rules/testing.md`

## Canonical pick rule

- Bare "review" → `/review`
- Pressure-test before ship → `/council-review`
- Root-cause diagnosis → `/fix-root`
- Test generation for new feature → `/test-gen`
- Adversarial browser pass → `expect-testing` skill (via `/sc:test` or direct invocation)

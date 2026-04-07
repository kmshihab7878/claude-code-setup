---
paths:
  - "**/tests/**"
  - "**/test_*"
  - "**/*_test.*"
  - "**/*.test.*"
  - "**/*.spec.*"
---

# Testing Rules

- Tests must be deterministic — no random data without fixed seeds
- One assertion per logical concept (multiple `assert` for the same thing is fine)
- Test names describe: what is tested, under what condition, expected result
- No test interdependencies — each test must pass in isolation
- Use fixtures/factories for test data — no inline object literals repeated across tests
- Integration tests hit real services (DB, API) — no mocks for boundaries we own
- Mock only external services we don't control
- Arrange-Act-Assert pattern in every test
- Clean up test data/state after tests (use teardown/fixtures)
- Coverage is a guide, not a target — 80% is better than 100% with meaningless tests

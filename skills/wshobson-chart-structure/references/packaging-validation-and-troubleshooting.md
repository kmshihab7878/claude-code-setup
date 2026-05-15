# Packaging, Validation, And Troubleshooting

Purpose: detailed packaging, `.helmignore`, validation, best-practice, anti-pattern, and troubleshooting reference.

## .helmignore

Exclude files that should not enter chart packages:

```text
# Development files
.git/
.gitignore
*.md
docs/

# Build artifacts
*.swp
*.bak
*.tmp
*.orig

# CI/CD
.travis.yml
.gitlab-ci.yml
Jenkinsfile

# Testing
test/
*.test

# IDE
.vscode/
.idea/
*.iml
```

## Validation Checklist

- `helm lint <chart-dir>` passes.
- `helm template <release-name> <chart-dir>` renders expected manifests.
- `helm dependency build <chart-dir>` succeeds when dependencies exist.
- `helm dependency list <chart-dir>` shows pinned, expected dependency versions.
- `values.schema.json` rejects invalid values.
- Tests exist for critical connectivity or readiness paths.
- Secret values are referenced, not committed.
- CRD behavior is documented if CRDs are included.
- Hooks have lifecycle annotations and cleanup policies.

## Best Practices

1. Use helpers for repeated template logic.
2. Quote strings in templates.
3. Validate values with `values.schema.json`.
4. Document all user-facing values in `values.yaml`.
5. Use semantic versioning for chart versions.
6. Pin dependency versions exactly.
7. Include `NOTES.txt` with usage instructions.
8. Add tests for critical functionality.
9. Use hooks carefully for migrations and lifecycle tasks.
10. Keep charts focused: one application per chart unless the repository pattern says otherwise.

## Common Anti-Patterns

- Committing real secrets in `values.yaml`.
- Encoding environment-specific production values in the base chart.
- Changing labels or selectors without planning upgrade impact.
- Templating CRDs as ordinary manifests.
- Leaving dependency versions floating.
- Adding hooks without cleanup policies.
- Claiming validation passed without inspecting command output.
- Bundling unrelated applications into one chart.

## Troubleshooting

If `helm lint` fails:

- Check `Chart.yaml` required fields and SemVer.
- Check YAML indentation and template delimiters.
- Check `values.schema.json` for schema syntax errors.

If `helm template` fails:

- Render with the same values file used by the caller.
- Inspect missing values and helper template names.
- Confirm `_helpers.tpl` definitions match `include` names.

If dependencies fail:

- Run `helm dependency list`.
- Confirm repository URLs, versions, aliases, tags, and conditions.
- Rebuild dependencies only when lockfile changes are expected.

If tests fail:

- Confirm the release exists and the target namespace is correct.
- Inspect test pod logs.
- Verify the service name, port, and selectors.

If upgrades fail:

- Look for immutable field changes.
- Review selector changes, CRD behavior, hooks, and migration jobs.
- Do not retry cluster-mutating commands without explicit approval and a rollback plan.

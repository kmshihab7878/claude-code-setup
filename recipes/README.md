# Recipe Catalog

Parameterized YAML workflow recipes for Claude Code.
Run with `/recipe run <name>` or `/recipe list` to browse.

## Security
| Recipe | Description | Parameters |
|--------|-------------|------------|
| [security-audit](security/security-audit.yaml) | Full security audit pipeline | target_path, scan_depth, fix_issues |
| [secrets-scan](security/secrets-scan.yaml) | Detect leaked secrets in repo | target_path, scan_history |

## Engineering
| Recipe | Description | Parameters |
|--------|-------------|------------|
| [code-review](engineering/code-review.yaml) | Structured code review | target, focus_areas, severity_threshold |
| [test-suite](engineering/test-suite.yaml) | Generate comprehensive test suite | target_path, framework, coverage_target |
| [api-endpoint](engineering/api-endpoint.yaml) | Create new API endpoint | name, method, path, auth_required |
| [refactor](engineering/refactor.yaml) | Systematic code refactoring | target_path, strategy, preserve_tests |
| [debug-investigation](engineering/debug-investigation.yaml) | Root cause analysis | symptom, error_message, affected_files |

## Trading
| Recipe | Description | Parameters |
|--------|-------------|------------|
| [market-scan](trading/market-scan.yaml) | Scan market data across symbols | symbols, interval, indicators |
| [position-review](trading/position-review.yaml) | Review open positions and risk | account_id, risk_threshold |

## DevOps
| Recipe | Description | Parameters |
|--------|-------------|------------|
| [deploy-check](devops/deploy-check.yaml) | Pre-deployment verification | environment, run_tests, check_deps |

## Sub-Recipes (Reusable Components)
| Sub-Recipe | Description |
|------------|-------------|
| [sub/lint-check.yaml](sub/lint-check.yaml) | Run linters on target |
| [sub/test-run.yaml](sub/test-run.yaml) | Execute test suite |
| [sub/dep-audit.yaml](sub/dep-audit.yaml) | Audit dependencies |

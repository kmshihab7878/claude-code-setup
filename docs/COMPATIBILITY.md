# Compatibility

This matrix describes what a fresh adopter needs locally and what CI expects.
Use `scripts/doctor.sh` for a quick local check.

| Surface | Status | Expected usage | Notes | Verify locally |
|---|---|---|---|---|
| Claude Code | Required for full adoption | Runs the setup, commands, hooks, skills, and agents. | Minimal adoption can read docs without it. | `claude --version` |
| git | Required | Clone, branch, diff, status, and tracked-file checks. | Required by validation and diagnostics. | `git --version` |
| gh | Optional | Create PRs and inspect GitHub state. | Not required for local validation. | `gh --version` |
| gitleaks | Required before publishing | Secret scan for working tree and history. | CI should run it; local install is strongly recommended. | `gitleaks version` |
| trivy | Required before publishing | Secret scan for filesystem contents. | CI should run it; local install is strongly recommended. | `trivy --version` |
| bash | Required | Runs hooks and scripts. | Scripts are written for `/usr/bin/env bash`. | `bash --version` |
| python3 | Required | Supports validation helpers and JSON parsing in hooks. | Keep available on local machines and CI. | `python3 --version` |
| macOS | Supported | Primary local development platform. | Use Homebrew or equivalent package management for optional tools. | `sw_vers` |
| Linux / Ubuntu CI | Supported | CI validation, scanners, and shell checks. | Keep CI images current and install scanner tools explicitly. | `uname -a` |
| Windows / WSL | Supported via WSL | Run the repo from a Linux shell inside WSL. | Native Windows shells are not the target for hook scripts. | `wsl --status` |

## Tool Roles

- Required tools are needed for the setup to operate or validate correctly.
- Optional tools improve contributor workflow but should not block local docs
  review.
- Publishing tools are mandatory before sharing a public fork or release, even
  if they are not needed for every local edit.
- CI-only usage means the local machine can warn while CI remains the final gate.

## Local Readiness

Run:

```bash
bash scripts/doctor.sh
```

Warnings for optional tools are acceptable during early evaluation. Missing core
repo files, tracked `.env` files, or broken required scripts are not acceptable.

## CI Expectations

CI should preserve the same safety posture as local validation:

- Run public-safety checks.
- Run secret scanning.
- Run validation.
- Keep branch-protection guidance intact.
- Avoid adding CI shortcuts that skip safety gates.

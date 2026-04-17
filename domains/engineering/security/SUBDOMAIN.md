# Engineering — Security

Appsec, infra-sec, offensive testing, compliance, and incident response.

## Canonical skills

- `security-review` — OWASP checklist, secrets scanning, auth patterns, input validation
- `container-security` — Image hardening, K8s security contexts, network policies
- `infrastructure-scanning` — Trivy, Checkov, Semgrep on AWS
- `offensive-security` — Pentesting methodology, vulnerability assessment
- `osint-recon` — Username enumeration, domain intel, social analysis
- `threat-intelligence-feed` — CVE aggregation + patch tracking
- `gdpr-dsgvo-expert` — Privacy automation, DPIA generation
- `jarvis-sec` — Autonomous security ecosystem (14 agents / 48 tools / 9 attack chains)

## Agents

- **L2:** `security-engineer`
- **L3:** `security-auditor`, `secrets-manager`, `compliance-officer`, `legal-compliance-checker`

Wave 1 `agents/security/**` (13 stage agents): EXPERIMENTAL.

## Commands

`/security-audit`, `/jarvis-sec`

## Recipes

`recipes/security/security-audit.yaml`, `recipes/security/secrets-scan.yaml`

## Path rules

`rules/security.md`

## Risk tier note

Anything modifying auth, secrets, request-path code, or cryptography defaults to T2 (escalate for user approval). Infrastructure changes touching shared resources default to T2.

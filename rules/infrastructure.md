---
paths:
  - "**/terraform/**"
  - "**/*.tf"
  - "**/docker-compose*"
  - "**/Dockerfile*"
  - "**/.github/workflows/**"
  - "**/k8s/**"
  - "**/helm/**"
---

# Infrastructure Rules

- Terraform: use modules for reusable components, lock provider versions
- Docker: multi-stage builds, non-root user, specific base image tags (no `:latest`)
- Docker Compose: pin versions, use healthchecks, explicit networks
- GitHub Actions: pin action versions to SHA, use OIDC for cloud auth
- Kubernetes: resource limits on all containers, readiness + liveness probes
- Secrets: never in code/configs — use secret manager references
- IaC: no inline scripts in Terraform — use user_data files or provisioners
- CI/CD: fail fast on lint/type errors before running expensive tests
- Monitoring: every deployed service must have health endpoint + alerting
- Cost: tag all cloud resources, use spot/preemptible where possible

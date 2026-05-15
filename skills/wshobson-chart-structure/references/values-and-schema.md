# Values And Schema Examples

Purpose: detailed examples for `values.yaml` organization and `values.schema.json` validation.

## values.yaml Defaults

```yaml
# Global values shared with subcharts.
global:
  imageRegistry: docker.io
  imagePullSecrets: []

# Image configuration.
image:
  registry: docker.io
  repository: myapp/web
  tag: "" # Defaults to .Chart.AppVersion
  pullPolicy: IfNotPresent

# Deployment settings.
replicaCount: 1
revisionHistoryLimit: 10

# Pod configuration.
podAnnotations: {}
podSecurityContext:
  runAsNonRoot: true
  runAsUser: 1000
  fsGroup: 1000

# Container security.
securityContext:
  allowPrivilegeEscalation: false
  readOnlyRootFilesystem: true
  capabilities:
    drop:
      - ALL

# Service.
service:
  type: ClusterIP
  port: 80
  targetPort: http
  annotations: {}

# Resources.
resources:
  limits:
    cpu: 100m
    memory: 128Mi
  requests:
    cpu: 100m
    memory: 128Mi

# Autoscaling.
autoscaling:
  enabled: false
  minReplicas: 1
  maxReplicas: 100
  targetCPUUtilizationPercentage: 80

# Node selection.
nodeSelector: {}
tolerations: []
affinity: {}

# Monitoring.
serviceMonitor:
  enabled: false
  interval: 30s
```

## values.schema.json

```json
{
  "$schema": "https://json-schema.org/draft-07/schema#",
  "type": "object",
  "properties": {
    "replicaCount": {
      "type": "integer",
      "minimum": 1
    },
    "image": {
      "type": "object",
      "required": ["repository"],
      "properties": {
        "repository": {
          "type": "string"
        },
        "tag": {
          "type": "string"
        },
        "pullPolicy": {
          "type": "string",
          "enum": ["Always", "IfNotPresent", "Never"]
        }
      }
    }
  },
  "required": ["image"]
}
```

## Values Organization Rules

- Keep safe defaults in `values.yaml`.
- Use `values.schema.json` to reject invalid user input early.
- Document expected values near their defaults.
- Avoid embedding environment-specific values in the base chart.
- Never commit real credentials. Use placeholders, Kubernetes Secret references, or external secret integrations.
- Keep names and selectors stable across releases.

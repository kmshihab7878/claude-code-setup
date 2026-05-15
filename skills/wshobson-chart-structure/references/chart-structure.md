# Chart Structure And Metadata

Purpose: detailed Helm chart layout and metadata reference for `Chart.yaml`, chart types, and repository packaging.

## Standard Chart Directory Structure

```text
my-app/
├── Chart.yaml              # Chart metadata (required)
├── Chart.lock              # Dependency lock file (generated)
├── values.yaml             # Default configuration values (required)
├── values.schema.json      # JSON schema for values validation
├── .helmignore             # Patterns to ignore when packaging
├── README.md               # Chart documentation
├── LICENSE                 # Chart license
├── charts/                 # Chart dependencies (bundled)
│   └── postgresql-12.0.0.tgz
├── crds/                   # Custom Resource Definitions
│   └── my-crd.yaml
├── templates/              # Kubernetes manifest templates (required)
│   ├── NOTES.txt           # Post-install instructions
│   ├── _helpers.tpl        # Template helper functions
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── ingress.yaml
│   ├── configmap.yaml
│   ├── secret.yaml
│   ├── serviceaccount.yaml
│   ├── hpa.yaml
│   ├── pdb.yaml
│   ├── networkpolicy.yaml
│   └── tests/
│       └── test-connection.yaml
└── files/                  # Additional files to include
    └── config/
        └── app.conf
```

## Chart.yaml Specification

Use `apiVersion: v2` for Helm 3 charts.

```yaml
apiVersion: v2
name: my-application
version: 1.2.3
appVersion: "2.5.0"
description: A Helm chart for my application
type: application
keywords:
  - web
  - api
  - backend
home: <project-home-url>
sources:
  - <source-repository-url>
maintainers:
  - name: <maintainer-name>
    email: <maintainer-email>
    url: <maintainer-profile-url>
icon: <icon-url>
kubeVersion: ">=1.24.0"
deprecated: false
annotations:
  example.com/release-notes: <release-notes-url>
dependencies:
  - name: postgresql
    version: "12.0.0"
    repository: "https://charts.bitnami.com/bitnami"
    condition: postgresql.enabled
    tags:
      - database
    import-values:
      - child: database
        parent: database
    alias: db
```

Required fields are `apiVersion`, `name`, `version`, and `description`. Use SemVer for the chart version.

## Chart Types

Application chart:

```yaml
type: application
```

- Standard Kubernetes applications.
- Can be installed and managed.
- Contains templates for Kubernetes resources.

Library chart:

```yaml
type: library
```

- Shared template helpers.
- Cannot be installed directly.
- Used as a dependency by other charts.
- Does not contain normal installable manifests.

## Chart Versioning

- Chart version changes when the chart changes.
- `MAJOR` for breaking changes.
- `MINOR` for backward-compatible additions.
- `PATCH` for compatible fixes.
- `appVersion` records the application version and does not need to follow SemVer.

```yaml
version: 2.3.1
appVersion: "1.5.0"
```

## Chart Repository Structure

```text
helm-charts/
├── index.yaml
├── my-app-1.0.0.tgz
├── my-app-1.1.0.tgz
├── my-app-1.2.0.tgz
└── another-chart-2.0.0.tgz
```

Create or refresh a repository index:

```bash
helm repo index . --url <chart-repository-url>
```

## Related Resources

- Helm documentation: <https://helm.sh/docs/>
- Chart template guide: <https://helm.sh/docs/chart_template_guide/>
- Chart best practices: <https://helm.sh/docs/chart_best_practices/>

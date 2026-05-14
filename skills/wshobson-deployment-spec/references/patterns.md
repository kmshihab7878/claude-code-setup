# Common Deployment patterns

Reusable Deployment patterns (high-availability, sidecar, init container). SKILL.md summarizes when to reach for each; this file holds the full YAML examples.

## Common Patterns

### High Availability Deployment

```yaml
spec:
  replicas: 3
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
  template:
    spec:
      affinity:
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            - labelSelector:
                matchLabels:
                  app: my-app
              topologyKey: kubernetes.io/hostname
      topologySpreadConstraints:
        - maxSkew: 1
          topologyKey: topology.kubernetes.io/zone
          whenUnsatisfiable: DoNotSchedule
          labelSelector:
            matchLabels:
              app: my-app
```

### Sidecar Container Pattern

```yaml
spec:
  template:
    spec:
      containers:
        - name: app
          image: myapp:1.0.0
          volumeMounts:
            - name: shared-logs
              mountPath: /var/log
        - name: log-forwarder
          image: fluent-bit:2.0
          volumeMounts:
            - name: shared-logs
              mountPath: /var/log
              readOnly: true
      volumes:
        - name: shared-logs
          emptyDir: {}
```

### Init Container for Dependencies

```yaml
spec:
  template:
    spec:
      initContainers:
        - name: wait-for-db
          image: busybox:1.36
          command:
            - sh
            - -c
            - |
              until nc -z database-service 5432; do
                echo "Waiting for database..."
                sleep 2
              done
        - name: run-migrations
          image: myapp:1.0.0
          command: ["./migrate", "up"]
          env:
            - name: DATABASE_URL
              valueFrom:
                secretKeyRef:
                  name: db-credentials
                  key: url
      containers:
        - name: app
          image: myapp:1.0.0
```


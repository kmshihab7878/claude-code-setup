# Complete Deployment specification (full reference example)

A reference Deployment manifest with every commonly-used field annotated. SKILL.md links here when an invocation needs to see the full picture; otherwise the per-field reference in [`field-reference.md`](field-reference.md) is usually enough.

## Complete Deployment Specification

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
  namespace: production
  labels:
    app.kubernetes.io/name: my-app
    app.kubernetes.io/version: "1.0.0"
    app.kubernetes.io/component: backend
    app.kubernetes.io/part-of: my-system
  annotations:
    description: "Main application deployment"
    contact: "backend-team@example.com"
spec:
  # Replica management
  replicas: 3
  revisionHistoryLimit: 10

  # Pod selection
  selector:
    matchLabels:
      app: my-app
      version: v1

  # Update strategy
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0

  # Minimum time for pod to be ready
  minReadySeconds: 10

  # Deployment will fail if it doesn't progress in this time
  progressDeadlineSeconds: 600

  # Pod template
  template:
    metadata:
      labels:
        app: my-app
        version: v1
      annotations:
        prometheus.io/scrape: "true"
        prometheus.io/port: "9090"
    spec:
      # Service account for RBAC
      serviceAccountName: my-app

      # Security context for the pod
      securityContext:
        runAsNonRoot: true
        runAsUser: 1000
        fsGroup: 1000
        seccompProfile:
          type: RuntimeDefault

      # Init containers run before main containers
      initContainers:
        - name: init-db
          image: busybox:1.36
          command: ["sh", "-c", "until nc -z db-service 5432; do sleep 1; done"]
          securityContext:
            allowPrivilegeEscalation: false
            runAsNonRoot: true
            runAsUser: 1000

      # Main containers
      containers:
        - name: app
          image: myapp:1.0.0
          imagePullPolicy: IfNotPresent

          # Container ports
          ports:
            - name: http
              containerPort: 8080
              protocol: TCP
            - name: metrics
              containerPort: 9090
              protocol: TCP

          # Environment variables
          env:
            - name: POD_NAME
              valueFrom:
                fieldRef:
                  fieldPath: metadata.name
            - name: POD_NAMESPACE
              valueFrom:
                fieldRef:
                  fieldPath: metadata.namespace
            - name: DATABASE_URL
              valueFrom:
                secretKeyRef:
                  name: db-credentials
                  key: url

          # ConfigMap and Secret references
          envFrom:
            - configMapRef:
                name: app-config
            - secretRef:
                name: app-secrets

          # Resource requests and limits
          resources:
            requests:
              memory: "256Mi"
              cpu: "250m"
            limits:
              memory: "512Mi"
              cpu: "500m"

          # Liveness probe
          livenessProbe:
            httpGet:
              path: /health/live
              port: http
              httpHeaders:
                - name: Custom-Header
                  value: Awesome
            initialDelaySeconds: 30
            periodSeconds: 10
            timeoutSeconds: 5
            successThreshold: 1
            failureThreshold: 3

          # Readiness probe
          readinessProbe:
            httpGet:
              path: /health/ready
              port: http
            initialDelaySeconds: 5
            periodSeconds: 5
            timeoutSeconds: 3
            successThreshold: 1
            failureThreshold: 3

          # Startup probe (for slow-starting containers)
          startupProbe:
            httpGet:
              path: /health/startup
              port: http
            initialDelaySeconds: 0
            periodSeconds: 10
            timeoutSeconds: 3
            successThreshold: 1
            failureThreshold: 30

          # Volume mounts
          volumeMounts:
            - name: data
              mountPath: /var/lib/app
            - name: config
              mountPath: /etc/app
              readOnly: true
            - name: tmp
              mountPath: /tmp

          # Security context for container
          securityContext:
            allowPrivilegeEscalation: false
            readOnlyRootFilesystem: true
            runAsNonRoot: true
            runAsUser: 1000
            capabilities:
              drop:
                - ALL

          # Lifecycle hooks
          lifecycle:
            postStart:
              exec:
                command:
                  ["/bin/sh", "-c", "echo Container started > /tmp/started"]
            preStop:
              exec:
                command: ["/bin/sh", "-c", "sleep 15"]

      # Volumes
      volumes:
        - name: data
          persistentVolumeClaim:
            claimName: app-data
        - name: config
          configMap:
            name: app-config
        - name: tmp
          emptyDir: {}

      # DNS configuration
      dnsPolicy: ClusterFirst
      dnsConfig:
        options:
          - name: ndots
            value: "2"

      # Scheduling
      nodeSelector:
        disktype: ssd

      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
            - weight: 100
              podAffinityTerm:
                labelSelector:
                  matchExpressions:
                    - key: app
                      operator: In
                      values:
                        - my-app
                topologyKey: kubernetes.io/hostname

      tolerations:
        - key: "app"
          operator: "Equal"
          value: "my-app"
          effect: "NoSchedule"

      # Termination
      terminationGracePeriodSeconds: 30

      # Image pull secrets
      imagePullSecrets:
        - name: regcred
```


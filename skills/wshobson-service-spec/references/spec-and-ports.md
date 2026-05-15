# Kubernetes Service Spec and Ports

Purpose: Full Service specification reference, port mapping examples, session affinity, and traffic policy details.

## Complete Service Specification

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
  namespace: production
  labels:
    app: my-app
    tier: backend
  annotations:
    description: "Main application service"
    prometheus.io/scrape: "true"
spec:
  type: ClusterIP
  selector:
    app: my-app
    version: v1
  ports:
    - name: http
      port: 80
      targetPort: 8080
      protocol: TCP
  sessionAffinity: ClientIP
  sessionAffinityConfig:
    clientIP:
      timeoutSeconds: 10800
  clusterIP: 10.0.0.10
  clusterIPs:
    - 10.0.0.10
  ipFamilies:
    - IPv4
  ipFamilyPolicy: SingleStack
  externalTrafficPolicy: Local
  internalTrafficPolicy: Local
  healthCheckNodePort: 30000
  loadBalancerIP: 203.0.113.100
  loadBalancerSourceRanges:
    - 203.0.113.0/24
  externalIPs:
    - 80.11.12.10
  publishNotReadyAddresses: false
```

## Named Ports

Use named ports in Pods for flexibility.

Deployment:

```yaml
spec:
  template:
    spec:
      containers:
        - name: app
          ports:
            - name: http
              containerPort: 8080
            - name: metrics
              containerPort: 9090
```

Service:

```yaml
spec:
  ports:
    - name: http
      port: 80
      targetPort: http
    - name: metrics
      port: 9090
      targetPort: metrics
```

## Multiple Ports

```yaml
spec:
  ports:
    - name: http
      port: 80
      targetPort: 8080
      protocol: TCP
    - name: https
      port: 443
      targetPort: 8443
      protocol: TCP
    - name: grpc
      port: 9090
      targetPort: 9090
      protocol: TCP
```

## Session Affinity

Default:

```yaml
spec:
  sessionAffinity: None
```

Client IP affinity:

```yaml
spec:
  sessionAffinity: ClientIP
  sessionAffinityConfig:
    clientIP:
      timeoutSeconds: 10800 # 3 hours
```

Use cases:

- Stateful applications.
- Session-based applications.
- WebSocket connections.

## External Traffic Policy

Cluster:

```yaml
spec:
  externalTrafficPolicy: Cluster
```

- Load balances across all nodes.
- May add an extra network hop.
- Source IP is masked.

Local:

```yaml
spec:
  externalTrafficPolicy: Local
```

- Routes traffic only to pods on the receiving node.
- Preserves client source IP.
- Can improve performance by avoiding an extra hop.
- May cause imbalanced load.

## Internal Traffic Policy

```yaml
spec:
  internalTrafficPolicy: Local # or Cluster
```

Controls routing for cluster-internal clients.

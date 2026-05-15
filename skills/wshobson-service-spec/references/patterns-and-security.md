# Kubernetes Service Patterns and Security

Purpose: Common Service patterns, network policy examples, best practices, production checklist, and performance tuning snippets.

## Internal Microservice

```yaml
apiVersion: v1
kind: Service
metadata:
  name: user-service
  namespace: backend
  labels:
    app: user-service
    tier: backend
spec:
  type: ClusterIP
  selector:
    app: user-service
  ports:
    - name: http
      port: 8080
      targetPort: http
      protocol: TCP
    - name: grpc
      port: 9090
      targetPort: grpc
      protocol: TCP
```

## Public API with Load Balancer

```yaml
apiVersion: v1
kind: Service
metadata:
  name: api-gateway
  annotations:
    service.beta.kubernetes.io/aws-load-balancer-type: "nlb"
    service.beta.kubernetes.io/aws-load-balancer-ssl-cert: "arn:aws:acm:..."
spec:
  type: LoadBalancer
  externalTrafficPolicy: Local
  selector:
    app: api-gateway
  ports:
    - name: https
      port: 443
      targetPort: 8443
      protocol: TCP
  loadBalancerSourceRanges:
    - 0.0.0.0/0
```

Treat broad source ranges as a deliberate public exposure decision and call it out in review.

## StatefulSet with Headless Service

```yaml
apiVersion: v1
kind: Service
metadata:
  name: cassandra
spec:
  clusterIP: None
  selector:
    app: cassandra
  ports:
    - port: 9042
      targetPort: 9042
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: cassandra
spec:
  serviceName: cassandra
  replicas: 3
  selector:
    matchLabels:
      app: cassandra
  template:
    metadata:
      labels:
        app: cassandra
    spec:
      containers:
        - name: cassandra
          image: cassandra:4.0
```

## External Service Mapping

```yaml
apiVersion: v1
kind: Service
metadata:
  name: external-database
spec:
  type: ExternalName
  externalName: prod-db.example.com
---
apiVersion: v1
kind: Service
metadata:
  name: external-api
spec:
  ports:
    - port: 443
      targetPort: 443
      protocol: TCP
---
apiVersion: v1
kind: Endpoints
metadata:
  name: external-api
subsets:
  - addresses:
      - ip: 203.0.113.100
    ports:
      - port: 443
```

## Multi-Port Service with Metrics

```yaml
apiVersion: v1
kind: Service
metadata:
  name: web-app
  annotations:
    prometheus.io/scrape: "true"
    prometheus.io/port: "9090"
    prometheus.io/path: "/metrics"
spec:
  type: ClusterIP
  selector:
    app: web-app
  ports:
    - name: http
      port: 80
      targetPort: 8080
    - name: metrics
      port: 9090
      targetPort: 9090
```

## Network Policies

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-frontend-to-backend
spec:
  podSelector:
    matchLabels:
      app: backend
  policyTypes:
    - Ingress
  ingress:
    - from:
        - podSelector:
            matchLabels:
              app: frontend
      ports:
        - protocol: TCP
          port: 8080
```

## Best Practices

1. Use named ports for flexibility.
2. Set the Service type based on exposure needs.
3. Keep Deployment and Service labels/selectors consistent.
4. Configure session affinity only when needed.
5. Set `externalTrafficPolicy: Local` when source IP preservation matters.
6. Use headless Services for StatefulSets.
7. Add network policies for sensitive paths.
8. Add monitoring annotations for observability.

## Production Checklist

- [ ] Service type appropriate for use case.
- [ ] Selector matches pod labels.
- [ ] Named ports used for clarity.
- [ ] Session affinity configured if needed.
- [ ] Traffic policy set appropriately.
- [ ] Load balancer annotations configured if applicable.
- [ ] Source IP ranges restricted for public Services.
- [ ] Health check configuration validated.
- [ ] Monitoring annotations added.
- [ ] Network policies defined.

## Performance Tuning

High traffic:

```yaml
spec:
  externalTrafficPolicy: Local
  sessionAffinity: ClientIP
  sessionAffinityConfig:
    clientIP:
      timeoutSeconds: 3600
```

WebSocket or long connections:

```yaml
spec:
  sessionAffinity: ClientIP
  sessionAffinityConfig:
    clientIP:
      timeoutSeconds: 86400 # 24 hours
```

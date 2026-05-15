# Discovery, Traffic, and Mesh Reference

Purpose: Detailed examples for headless Services, DNS, environment variables, load balancing, connection limits, and service mesh integration.

## Headless Services

Service without a cluster IP for direct pod access.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: database
spec:
  clusterIP: None
  selector:
    app: database
  ports:
    - port: 5432
      targetPort: 5432
```

Use cases:

- StatefulSet pod discovery.
- Direct pod-to-pod communication.
- Custom load balancing.
- Database clusters.

DNS returns individual pod IPs instead of a service IP. Format:

```text
<pod-name>.<service-name>.<namespace>.svc.cluster.local
```

## Service Discovery DNS

ClusterIP Service:

```text
<service-name>.<namespace>.svc.cluster.local
```

Example:

```bash
curl http://backend-service.production.svc.cluster.local
```

Within the same namespace:

```bash
curl http://backend-service
```

Headless Service:

```text
<pod-name>.<service-name>.<namespace>.svc.cluster.local
```

## Environment Variables

Kubernetes injects Service info into pods created after the Service exists.

```bash
BACKEND_SERVICE_SERVICE_HOST=10.0.0.100
BACKEND_SERVICE_SERVICE_PORT=80
BACKEND_SERVICE_SERVICE_PORT_HTTP=80
```

## Load Balancing

Kubernetes uses random selection by default. For advanced load balancing, use a service mesh or provider-specific facilities.

Istio `DestinationRule` example:

```yaml
apiVersion: networking.istio.io/v1beta1
kind: DestinationRule
metadata:
  name: my-destination-rule
spec:
  host: my-service
  trafficPolicy:
    loadBalancer:
      simple: LEAST_REQUEST # or ROUND_ROBIN, RANDOM, PASSTHROUGH
    connectionPool:
      tcp:
        maxConnections: 100
```

## Connection Limits

Use pod disruption budgets and resource limits for workload-level resilience.

```yaml
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: my-app-pdb
spec:
  minAvailable: 2
  selector:
    matchLabels:
      app: my-app
```

## Istio Virtual Service

```yaml
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: my-service
spec:
  hosts:
    - my-service
  http:
    - match:
        - headers:
            version:
              exact: v2
      route:
        - destination:
            host: my-service
            subset: v2
    - route:
        - destination:
            host: my-service
            subset: v1
          weight: 90
        - destination:
            host: my-service
            subset: v2
          weight: 10
```

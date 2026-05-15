# Kubernetes Service Types

Purpose: Detailed Service type examples, use cases, limitations, and cloud load balancer annotations.

## ClusterIP

Exposes the service on an internal cluster IP. Only reachable from within the cluster.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: backend-service
  namespace: production
spec:
  type: ClusterIP
  selector:
    app: backend
  ports:
    - name: http
      port: 80
      targetPort: 8080
      protocol: TCP
  sessionAffinity: None
```

Use cases:

- Internal microservice communication.
- Database services.
- Internal APIs.
- Message queues.

## NodePort

Exposes the service on each Node's IP at a static port in the 30000-32767 range.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: frontend-service
spec:
  type: NodePort
  selector:
    app: frontend
  ports:
    - name: http
      port: 80
      targetPort: 8080
      nodePort: 30080 # Optional, auto-assigned if omitted
      protocol: TCP
```

Use cases:

- Development/testing external access.
- Small deployments without load balancer.
- Direct node access requirements.

Limitations:

- Limited port range.
- Node failures must be handled.
- No built-in load balancing across nodes.

## LoadBalancer

Exposes the service through a cloud provider load balancer.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: public-api
  annotations:
    service.beta.kubernetes.io/aws-load-balancer-type: "nlb"
    service.beta.kubernetes.io/aws-load-balancer-scheme: "internet-facing"
spec:
  type: LoadBalancer
  selector:
    app: api
  ports:
    - name: https
      port: 443
      targetPort: 8443
      protocol: TCP
  loadBalancerSourceRanges:
    - 203.0.113.0/24
```

## Cloud-Specific Annotations

AWS:

```yaml
annotations:
  service.beta.kubernetes.io/aws-load-balancer-type: "nlb" # or "external"
  service.beta.kubernetes.io/aws-load-balancer-scheme: "internet-facing"
  service.beta.kubernetes.io/aws-load-balancer-cross-zone-load-balancing-enabled: "true"
  service.beta.kubernetes.io/aws-load-balancer-ssl-cert: "arn:aws:acm:..."
  service.beta.kubernetes.io/aws-load-balancer-backend-protocol: "http"
```

Azure:

```yaml
annotations:
  service.beta.kubernetes.io/azure-load-balancer-internal: "true"
  service.beta.kubernetes.io/azure-pip-name: "my-public-ip"
```

GCP:

```yaml
annotations:
  cloud.google.com/load-balancer-type: "Internal"
  cloud.google.com/backend-config: '{"default": "my-backend-config"}'
```

## ExternalName

Maps a Service to an external DNS name through a CNAME record.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: external-db
spec:
  type: ExternalName
  externalName: db.external.example.com
  ports:
    - port: 5432
```

Use cases:

- Accessing external services.
- Service migration scenarios.
- Multi-cluster service references.

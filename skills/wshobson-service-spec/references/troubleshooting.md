# Kubernetes Service Troubleshooting

Purpose: Ordered troubleshooting commands and related Kubernetes references for Service issues.

## Service Not Accessible

```bash
kubectl get service <service-name>
kubectl get endpoints <service-name>
kubectl describe service <service-name>
kubectl get pods -l app=<app-name>
```

Common issues:

- Selector does not match pod labels.
- No pods are running, so endpoints are empty.
- Ports are misconfigured.
- Network policy blocks traffic.

## DNS Resolution Failing

```bash
kubectl run debug --rm -it --image=busybox -- nslookup <service-name>
kubectl get pods -n kube-system -l k8s-app=kube-dns
kubectl logs -n kube-system -l k8s-app=kube-dns
```

Check whether the querying pod is in the expected namespace and whether the Service existed before pod creation if relying on environment variables.

## Load Balancer Issues

```bash
kubectl describe service <service-name>
kubectl get events --sort-by='.lastTimestamp'
kubectl describe node
```

Verify provider-specific annotations, subnet tagging, source ranges, node health, and cloud-controller-manager events.

## Related Resources

- Kubernetes Service API Reference: `https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.28/#service-v1-core`
- Service Networking: `https://kubernetes.io/docs/concepts/services-networking/service/`
- DNS for Services and Pods: `https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/`

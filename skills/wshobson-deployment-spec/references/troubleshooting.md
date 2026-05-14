# Troubleshooting catalog

Common Deployment failures with diagnosis commands and fixes.

## Troubleshooting

### Common Issues

**Pods not starting:**

```bash
kubectl describe deployment <name>
kubectl get pods -l app=<app-name>
kubectl describe pod <pod-name>
kubectl logs <pod-name>
```

**ImagePullBackOff:**

- Check image name and tag
- Verify imagePullSecrets
- Check registry credentials

**CrashLoopBackOff:**

- Check container logs
- Verify liveness probe is not too aggressive
- Check resource limits
- Verify application dependencies

**Deployment stuck in progress:**

- Check progressDeadlineSeconds
- Verify readiness probes
- Check resource availability


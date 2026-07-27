# Kubernetes Dashboard

## Generate Admin token

```bash
kubectl create token admin-user -n kubernetes-dashboard --duration=1h
```

## Decode Long Lived Token (Read Only User)

```bash
kubectl get secret readonly-user-token -n kubernetes-dashboard -o jsonpath='{.data.token}' | base64 -d
```

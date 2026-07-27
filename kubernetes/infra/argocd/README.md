
# ArgoCD

- [Official Docs](https://argo-cd.readthedocs.io/en/stable/getting_started/)

## Setup

Apply Kustomize
```bash
kubectl apply -k .
```

## Login

1. Find Password
    ```bash
    kubectl get secret -n argocd argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
    ```
   Login with the username `admin` and password from the previous command. \
   Update current password from UI.

2. Delete Old Password Secret
    ```bash
    kubectl delete secret argocd-initial-admin-secret -n argocd
    ```
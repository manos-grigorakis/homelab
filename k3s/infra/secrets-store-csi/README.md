# CSI Driver

> This driver is being used by HashiCorp Vault

- [Official Docs](https://secrets-store-csi-driver.sigs.k8s.io/getting-started/installation.html#installation)

## Setup

1. Add Helm repo

   ```bash
   helm repo add secrets-store-csi-driver https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts
   ```

2. Update Helm repos

   ```bash
   helm repo update
   ```

3. Install CSI Driver

   ```bash
   helm install csi-secrets-store secrets-store-csi-driver/secrets-store-csi-driver --namespace kube-system
   ```

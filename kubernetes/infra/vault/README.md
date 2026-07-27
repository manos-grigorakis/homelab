# HashiCorp Vault

Deploys HashiCorp Vault on Kubernetes using the official Helm chart. Includes the basic installation steps and Kubernetes authentication configuration.

## Commands

### Helm (Manual)

1. Add Helm repository

   ```bash
   helm repo add hashicorp https://helm.releases.hashicorp.com
   ```

2. Update Helm repositories

   ```bash
   helm repo update
   ```

3. Install Vault using custom values

   ```bash
   helm install vault hashicorp/vault -n vault --values values.yaml --create-namespace
   ```

---

### Upgrade Manual Helm Installation

```bash
helm upgrade vault hashicorp/vault -n vault --values values.yaml --force-conflicts
```

---

### Enable Kubernetes Authentication

> Note: Vault must run on the same Kubernetes cluster

1. Enter `vault-0` pod

   ```bash
   kubectl exec -it vault-0 -- /bin/sh
   ```

2. Enable Kubernetes authentication method

   ```bash
   vault auth enable kubernetes
   ```

3. Configure the Kubernetes authentication method

   ```bash
   vault write auth/kubernetes/config \
   kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443"
   ```

   > `$KUBERNETES_PORT_443_TCP_ADDR` is automatically injected by the Kubernetes cluster into every pod's environment

## Notes

- [Official Docs](https://developer.hashicorp.com/vault/tutorials/kubernetes/kubernetes-raft-deployment-guide)

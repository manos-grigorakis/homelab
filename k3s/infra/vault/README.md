# HashiCorp Vault

> Note: Secrets Store CSI Driver is required (see `secrets-store-csi` directory)

## Commands

- Upgrade command (manual installation)
  ```bash
  helm upgrade vault hashicorp/vault -n vault --values values.yaml --force-conflicts
  ```

## Notes

- [Official Docs](https://developer.hashicorp.com/vault/tutorials/kubernetes/kubernetes-raft-deployment-guide)
- [CSI Driver & K8s Secrets Tutorial](https://developer.hashicorp.com/vault/tutorials/kubernetes-introduction/kubernetes-secret-store-driver)

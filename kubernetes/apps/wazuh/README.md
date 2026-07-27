# Wazuh on Kubernetes

## Resources

- [Official Repo](https://github.com/wazuh/wazuh-kubernetes)

## Set up

> Certs are being handled with Cert-Mananger

1. Configure storage class \
   Modify `/base/storage-class.yaml` with your provisioner.

   Find your provisioner

   ```bash
   kubectl get sc
   ```

2. Configure Kubernetes Secrets \
   Copy all `.yaml.example` files to `.yaml` extension.

   ```bash
   cp secrets/dashboard-cred-secret.yaml.example secrets/dashboard-cred-secret.yaml && \
   cp secrets/indexer-cred-secret.yaml.example secrets/indexer-cred-secret.yaml && \
   cp secrets/wazuh-api-cred-secret.yaml.example secrets/wazuh-api-cred-secret.yaml && \
   cp secrets/wazuh-authd-pass-secret.yaml.example secrets/wazuh-authd-pass-secret.yaml && \
   cp secrets/wazuh-cluster-key-secret.yaml.example secrets/wazuh-cluster-key-secret.yaml && \
   cp secrets/internal-users-secret.yaml.example secrets/internal-users-secret.yaml
   ```

   > Don't modify passwords yet!

3. IP of Wazuh Manager \
   Modify the IP of Wazuh Manager Services in both:
   - `/wazuh_managers/master-svc.yaml`
   - `/wazuh_managers/wazuh-workers-svc.yaml`

4. Apply all manifests using Kustomize
   ```bash
   kubectl apply -k .
   ```

## Default Credentials

| **User**      | **Username** | **Password**                     |
| ------------- | ------------ | -------------------------------- |
| Indexer       | admin        | SecretPassword                   |
| Kibana server | kibanaserver | kibanaserver                     |
| User          | user         | kibanaserver                     |
| Wazuh API     | wazuh-wui    | MyS3cr37P450r.\*-                |
| Wazuh auth    | N/A          | password                         |
| Cluster key   | N/A          | 123a45bc67def891gh23i45jk67l8mn9 |

> [Instructions to change default credentials](CHANGE_PASSWORDS.md)

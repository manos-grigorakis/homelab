# Homarr with Helm

## Resources

- [Official Docs](https://homarr.dev/docs/getting-started/installation/helm/)
- [Values Sample](https://github.com/homarr-labs/charts/blob/dev/charts/homarr/values.yaml)

## Requirements

- Kubernetes: `>=1.24.0-0`
- Helm

## Setup

1.  Copy and configure secret

    ```bash
    cp secret.yaml.example secret.yaml
    ```

2.  Create Namespace

    ```bash
    kubectl create namespace homarr
    ```

3.  Apply Secret

    ```bash
    kubectl apply -f secret.yaml
    ```

4.  Install Homarr with Helm

    ```bash
    helm install homarr oci://ghcr.io/homarr-labs/charts/homarr -f values.yaml -n homarr
    ```

5.  (Optional) Apply Traefik IngressRoute

    ```bash
    kubectl apply -f ingress-route.yaml
    ```

## Useful Commands

### Upgrade Homarr

```bash
helm upgrade homarr oci://ghcr.io/homarr-labs/charts/homarr -f values.yaml -n homarr
```

### Uninstall Homarr

```bash
helm uninstall homarr -n homarr
```

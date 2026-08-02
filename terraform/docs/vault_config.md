# HashiCorp Vault

## Configuration

1. Enter `vault-0` pod (Kubernetes)

   ```bash
   kubectl exec -it -n vault vault-0 -- sh
   ```

2. Authenticate in Vault

   ```bash
   vault login
   ```

3. Create Vault policy

   ```bash
   vault policy write terraform-provisioning - <<EOF
   path "secret/data/terraform/*" {
   capabilities = ["read"]
   }
   path "secret/data/shared/*" {
   capabilities = ["read"]
   }
   EOF
   ```

4. Create Vault AppRole
   The `secret_id` has a retention for 90 days. After that re-generation is required

   ```bash
   vault write auth/approle/role/terraform \
       token_policies="terraform-provisioning" \
       token_ttl=15m \
       token_max_ttl=1h \
       secret_id_ttl=90d \
       secret_id_num_uses=0 \
       bind_secret_id=true
   ```

5. Write secrets
   1. CLI
      ```bash
      vault kv put secret/terraform/pve/nexus api_token="<token>"
      vault kv put secret/shared/linux_user hashed_password="<hash>"
      ```
   2. UI <br>
      `Vault -> Secrets engines -> secret -> Create secret`, using same path / key naming show above

6. Retrieve Credentials
   1. Role ID
      ```bash
      vault read auth/approle/role/terraform/role-id
      ```
   2. Secret ID

      ```bash
      vault write -f auth/approle/role/terraform/secret-id
      ```

7. Export Vault variables in Shell
   ```bash
   export TF_VAR_vault_role_id="<role_id>"
   export TF_VAR_vault_secret_id="<secret_id>"
   ```

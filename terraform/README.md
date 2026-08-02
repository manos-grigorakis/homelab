# Terraform

**Guides:**

- [HashiCorp Vault Config](/terraform/docs/vault_config.md)

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install)
- AWS credentials configured locally
- HashiCorp Vault access

## Useful Commands

- Init Terraform Backend <br>

  > Requires AWS credentials configured

  ```bash
  terraform init
  ```

- Terraform Plan <br>
  Show changes that will be applied on `apply` command

  ```bash
  terraform plan
  ```

- Terraform Apply <br>
  Applies changes after confirmation

  ```bash
  terraform apply
  ```

- Force Unlock State (if `plan` / `apply` was interrupted) <br>

  ```bash
  terraform force-unlock <LOCK_ID>
  ```

- Export HashiCorp Vault in Shell

  ```bash
  export TF_VAR_vault_role_id="<role_id>"
  export TF_VAR_vault_secret_id="<secret_id>"
  ```

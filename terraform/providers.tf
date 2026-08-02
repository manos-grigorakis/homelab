data "vault_kv_secret_v2" "pve_token" {
  mount = "secret"
  name  = "terraform/pve/nexus"
}

provider "vault" {
  address          = "https://vault.k3s.poolnode.net"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"
    parameters = {
      role_id   = var.vault_role_id
      secret_id = var.vault_secret_id
    }
  }
}

provider "proxmox" {
  endpoint  = var.pve_endpoint
  api_token = "${var.pve_token_id}=${data.vault_kv_secret_v2.pve_token.data["API_TOKEN"]}"

  # Because self-signed TLS certificate is in use
  insecure = true

  ssh {
    agent       = true
    username    = var.pve_user
    private_key = file("~/.ssh/id_ed25519_terraform_homelab")
  }
}
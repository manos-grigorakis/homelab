# ====================
# **IMPORTANT**
# Only non-sensitive data, everything else to HashiCorp Vault
# ====================

# Proxmox Provider
pve_endpoint = "https://192.168.10.20:8006"
pve_token_id = "terraform@pve!terraform"

# Proxmox SSH
pve_user            = "terraform"
pve_ssh_key_private = "~/.ssh/id_ed25519_terraform_homelab"

# Common
pve_node_name = "nexus"

# VM
gateway = "192.168.10.1"

# Cloud init
timezone = "Europe/Athens"
vm_user  = "manos"
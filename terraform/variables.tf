# ====================
# HashiCorp Vault
# ====================

variable "vault_role_id" {
  description = "Vault role ID for authentication"
  type        = string
  sensitive   = true
}

variable "vault_secret_id" {
  description = "Vault secret ID for authentication"
  type        = string
  sensitive   = true
}

# ====================
# Proxmox Provider
# ====================
variable "pve_endpoint" {
  type        = string
  description = "Proxmox Endpoint."
  nullable    = false
}

variable "pve_token_id" {
  type        = string
  description = "Proxmox API Token Id."
  nullable    = false
}

# Proxmox SSH
variable "pve_user" {
  type        = string
  description = "Name of the Proxmox Linux User which is being used to SSH."
  sensitive   = true
  nullable    = false
}

variable "pve_ssh_key_private" {
  type        = string
  description = "Path to Private SSH Key from Machine Terraform is being executed. (e.g. your Desktop)"
}

# ====================
# Common
# ====================

variable "pve_node_name" {
  type        = string
  description = "Name of Proxmox Node."
  nullable    = false
}

# ====================
# Virtual Machines
# ====================

# Network
variable "gateway" {
  type        = string
  description = "The IPv4 Gateway"
  nullable    = false
}

variable "dns_servers" {
  type        = list(string)
  description = "The List of DNS Servers."
  default     = ["1.1.1.1", "9.9.9.9"]
  nullable    = false
}

# Cloud-Init
variable "timezone" {
  type        = string
  description = "Timezone for VM"
  default     = "Europe/Athens"
  nullable    = false
}

variable "vm_user" {
  type        = string
  description = "User for VM"
  default     = "manos"
  nullable    = false
}
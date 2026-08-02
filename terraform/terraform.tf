terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.9.0"
    }

    vault = {
      source  = "hashicorp/vault"
      version = "5.10.1"
    }

    proxmox = {
      source  = "bpg/proxmox"
      version = "0.111.1"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "6.55.0"
    }
  }

  required_version = ">= 1.13"
}
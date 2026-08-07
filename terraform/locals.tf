locals {
  k3s_servers = {

  }

  k3s_agents = {

  }

  ubuntu_containers = {
    "uptime-kuma" = {
      id            = 103
      hostname      = "uptime-kuma"
      tags          = ["terraform", "monitoring"]
      cpu_cores     = 1
      memory        = 1024
      ipv4          = "192.168.10.43/24"
      storage_size  = 20
      startup_order = null
    }

    "cloudflare-tunnel" = {
      id            = 104
      hostname      = "cloudflare-tunnel"
      tags          = ["terraform"]
      cpu_cores     = 1
      memory        = 512
      ipv4          = "192.168.10.44/24"
      storage_size  = 10
      startup_order = 1
    }

    "netbox" = {
      id            = 105
      hostname      = "netbox"
      tags          = ["terraform"]
      cpu_cores     = 2
      memory        = 4096
      ipv4          = "192.168.10.48/24"
      storage_size  = 20
      startup_order = null
    }

    "qbittorent" = {
      id            = 106
      hostname      = "qbittorent"
      tags          = ["terraform"]
      cpu_cores     = 1
      memory        = 1024
      ipv4          = "192.168.10.50/24"
      storage_size  = 20
      startup_order = 4
    }

    "coolify" = {
      id            = 120
      hostname      = "coolify"
      tags          = ["terraform"]
      cpu_cores     = 4
      memory        = 8192
      ipv4          = "192.168.10.56/24"
      storage_size  = 100
      startup_order = null
    }

  }

  other_vm = {
    hardening-ubuntu = {
      id        = 210
      cpu_cores = 2
      memory    = 4096
      size      = 40
      ipv4      = "192.168.10.141/24"
      hostname  = "hardening-ubuntu"
      tags      = ["terraform"]
      started   = false
    }
  }
}
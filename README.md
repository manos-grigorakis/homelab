# Homelab

![Status](https://img.shields.io/badge/status-active-brightgreen)
![Last Commit](https://img.shields.io/github/last-commit/manos-grigorakis/homelab)
![Commits/month](https://img.shields.io/github/commit-activity/m/manos-grigorakis/homelab)
![Commits (total)](https://img.shields.io/github/commit-activity/t/manos-grigorakis/homelab)
![Issues](https://img.shields.io/github/issues/manos-grigorakis/homelab)
![Open PRs](https://img.shields.io/github/issues-pr/manos-grigorakis/homelab)
![Created At](https://img.shields.io/github/created-at/manos-grigorakis/homelab?color=007ec6)
![License](https://img.shields.io/github/license/manos-grigorakis/homelab?color=007ec6)

## Setup

<img src="docs/screenshots/rack.png" width="250" alt="Homelab Rack">

[Photo Gallery](https://photos.app.goo.gl/yr2DCLmaNbhbLmsD6)

## Hardware

<details>
<summary><b>Servers</b></summary>

### Site A

| **Name** | **Device**     | **CPU**        | **RAM** | **Storage**                                      | **GPU** | **Notes**                                                                      |
| -------- | -------------- | -------------- | ------- | ------------------------------------------------ | ------- | ------------------------------------------------------------------------------ |
| Nexus    | Custom         | Intel i5-13500 | 128GB   | 1x1TB NVMe, 1x2TB NVMe, <br>2x8TB HDD, 1x6TB HDD | iGPU    | Main Node                                                                      |
| Pi       | Raspberry Pi 5 |                | 8GB     | 240GB NVMe                                       | N/A     | Home Assistant                                                                 |
| NAS      | Custom         | Intel i5-12400 | 32GB    | 1x250GB NVMe, 2x8TB HDD, 1x6TB HDD               | iGPU    | Planned (will replace TrueNAS Scale VM from server Nexus, along with its HDDs) |

</details>

<details>
<summary><b>Networking</b></summary>

### Site A

| **Role** | **Device**                  |
| -------- | --------------------------- |
| Modem    | ZTE ZXHN F8648P             |
| Router   | GL.iNet Flint 2 (GL-MT6000) |
| Switch   | TP-LINK TL-SG3428X-M2       |

### Site B

| **Role**       | **Device** |
| -------------- | ---------- |
| Modem / Router | Cudy P2 5G |
| Mesh           | Cudy M3000 |

</details>

## Project Directory Structure

```bash
homelab
├── .github                        # GitHub related
├── ansible                        # Host configuration (WIP)
├── Dockerfiles                    # Custom Docker images
├── kubernetes
│   ├── apps                       # Cluster core applications grouped by domain
│   └── infra                      # Cluster infrastructure
├── LICENSE
├── lxc                            # Proxmox LXC configs
├── vm                             # Proxmox VM configs
├── haos                           # Home Assistant OS & ESPHome configs
├── README.md
├── scripts                        # Helper scripts
└── terraform                      # Infrastructure provisioning (Proxmox VMs & LXCs)
```

## Services

<details>
<summary><b>Services</b></summary>

### Cluster Infrastructure

| **Service**                                                     | **Category**            | **Runtime** | **Site** |
| --------------------------------------------------------------- | ----------------------- | ----------- | -------- |
| [Argo CD](https://argo-cd.readthedocs.io/en/stable/)            | GitOps                  | Cluster     | Site A   |
| [cert-manager](https://cert-manager.io/)                        | Certificates            | Cluster     | Site A   |
| [Longhorn](https://longhorn.io/)                                | Storage                 | Cluster     | Site A   |
| [Velero](https://velero.io/)                                    | Cluster Backups         | Cluster     | Site A   |
| [MetalLB](https://metallb.io/)                                  | IP Pool                 | Cluster     | Site A   |
| [Traefik](https://traefik.io/)                                  | Ingress / Load Balancer | Cluster     | Site A   |
| [Kubernetes Dashboard](https://github.com/kubernetes/dashboard) | Cluster Dashboard       | Cluster     | Site A   |
| [HashiCorp Vault](https://www.hashicorp.com/en/products/vault)  | Secrets Management      | Cluster     | Site A   |

### Monitoring & Security

| **Service**                                                              | **Category**       | **Runtime** | **Site** |
| ------------------------------------------------------------------------ | ------------------ | ----------- | -------- |
| [Grafana](https://grafana.com/)                                          | Data Visualization | Cluster     | Site A   |
| [Grafana Alloy](https://grafana.com/docs/alloy/latest/)                  | Log Collector      | Cluster     | Site A   |
| [Loki](https://grafana.com/oss/loki/)                                    | Log Aggregator     | Cluster     | Site A   |
| [Prometheus](https://prometheus.io/)                                     | Monitoring         | Cluster     | Site A   |
| [Alertmanager](https://prometheus.io/docs/alerting/latest/alertmanager/) | Alerts             | Cluster     | Site A   |
| [Wazuh](https://wazuh.com/)                                              | SIEM               | Cluster     | Site A   |
| [Suricata](https://suricata.io/)                                         | IDS                | VM          | Site A   |
| [Uptime Kuma](https://uptimekuma.org/)                                   | Monitoring         | LXC         | Site A   |
| [Speedtest Tracker](https://docs.speedtest-tracker.dev/)                 | Network Monitoring | LXC         | Site A   |
| [Authentik](https://goauthentik.io/)                                     | Identity Provider  | Cluster     | Site A   |

### Networking

| **Service**                                             | **Category**             | **Runtime** | **Notes**                                          | **Site** |
| ------------------------------------------------------- | ------------------------ | ----------- | -------------------------------------------------- | -------- |
| [Pi-hole](https://pi-hole.net/)                         | AdBlocker                | Cluster     |                                                    | Site A   |
| [Unbound](https://nlnetlabs.nl/projects/unbound/about/) | Recursive DNS            | Cluster     |                                                    | Site A   |
| [AdGuard](https://adguard.com)                          | AdBlocker & Fallback DNS | Flint 2     | AdBlocker and fallback DNS in case Pi-hole is down | Site A   |
| [nginx](https://nginx.org/)                             | Load Balancer            | LXC         | K3s External Load Balancer                         | Site A   |
| [Nginx Proxy Manager](https://nginxproxymanager.com/)   | Reverse Proxy            | LXC         |                                                    | Site A   |
| [NetBox](https://netboxlabs.com)                        | IPAM / DCIM              | LXC         |                                                    | Site A   |

### Databases & Storage

| **Service**                                                   | **Category** | **Runtime** | **Notes**                    | **Site** |
| ------------------------------------------------------------- | ------------ | ----------- | ---------------------------- | -------- |
| [MariaDB](https://mariadb.org/)                               | Database     | Cluster     |                              | Site A   |
| [MySQL](https://www.mysql.com/)                               | Database     | Cluster     |                              | Site A   |
| [PostgreSQL](https://www.postgresql.org/)                     | Database     | Cluster     |                              | Site A   |
| [MySQL](https://www.mysql.com/)                               | Database     | LXC         | K3s External Database        | Site A   |
| [Redis](https://redis.io/)                                    | Cache        | Cluster     |                              | Site A   |
| [TrueNas](https://www.truenas.com/truenas-community-edition/) | NAS          | VM          | RAIDZ1 (2x8TB and 1x6TB HDD) | Site A   |

### Applications

| **Service**                                               | **Category**          | **Runtime**                 | **Site** |
| --------------------------------------------------------- | --------------------- | --------------------------- | -------- |
| [Homarr](https://homarr.dev/)                             | Dashboard             | Cluster                     | Site A   |
| [Mealie](https://mealie.io/)                              | Recipes               | Cluster                     | Site A   |
| [CloudBeaver](https://github.com/dbeaver/cloudbeaver)     | Database Management   | Cluster                     | Site A   |
| [Immich](https://immich.app/)                             | Images                | Cluster                     | Site A   |
| [Plex](https://www.plex.tv/)                              | Movies                | Cluster                     | Site A   |
| [Paperless-ngx](https://docs.paperless-ngx.com/)          | Document Management   | Cluster                     | Site A   |
| [Home Assistant](https://www.home-assistant.io/)          | Smart Home            | Raspberry Pi 5 (Bare Metal) | Site A   |
| [Vaultwarden](https://github.com/dani-garcia/vaultwarden) | Passwords Manager     | LXC                         | Site A   |
| [n8n](https://n8n.io/)                                    | Workflows Automations | Cluster                     | Site A   |
| [Coolify](https://coolify.io/)                            | Deployment Platform   | LXC                         | Site A   |
| [Nextcloud](https://nextcloud.com/)                       | Cloud                 | Cluster                     | Site A   |

</details>

## Screenshots

### Homarr Dashboard

![Homarr](/docs/screenshots/homarr_dashboard.png)

### Grafana Kubernetes Dashboard

![Grafana](/docs/screenshots/grafana_kubernetes.png)

### ArgoCD

**Apps**

![ArgoCD](/docs/screenshots/argocd_apps.png)

**DNS**

![ArgoCD](/docs/gifs/argocd_dns.gif)

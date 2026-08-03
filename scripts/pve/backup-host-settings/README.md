# Proxmox Host Configuration Backup

This script backs up Proxmox VE host configuration files that are not included in standard `vzdump` VM/LXC backups. It will be executed automatically with a scheduled backup job, and it will store the data using the NFS protocol to a NAS.

## PVE Backup Script

1. SSH to the PVE server

   ```bash
   ssh <user>@<server-ip>
   ```

2. Create a directory for the script

   ```bash
   sudo mkdir -p /usr/local/sbin
   ```

3. Copy `proxmox-hostconfig-backup.sh` to `/usr/local/sbin`

4. Make the file executable

   ```bash
   sudo chmod +x /usr/local/sbin/proxmox-hostconfig-backup.sh
   ```

## Connect Script to Backup Job through Hooks

1. Configure an NFS storage in PVE

   | Field   | Value                                                                                  |
   | ------- | -------------------------------------------------------------------------------------- |
   | ID      | Storage identifier. Must match the `STORAGE` variable in `vzdump-hostconfig-custom.sh` |
   | Server  | NAS IP address                                                                         |
   | Export  | NFS export path                                                                        |
   | Content | `Backup`                                                                               |
   | Enable  | `true`                                                                                 |

   **UI** <br>
   Datacenter -> Storage -> Add -> NFS

   **CLI**

   ```bash
   pvesm add nfs <id> \
   --server <server> \
   --export <export> \
   --content backup
   ```

2. Create a directory for hooks in PVE

   ```bash
   sudo mkdir -p /root/hooks
   ```

3. Copy `vzdump-hostconfig-custom.sh` to `/root/hooks` <br>
   Modify the `STORAGE` variable so it matches the storage ID configured in PVE

4. Make the script executable

   ```bash
   sudo chmod +x /root/hooks/vzdump-hostconfig-custom.sh
   ```

5. Register the hook script

   ```bash
   echo 'script: /root/hooks/vzdump-hostconfig-custom.sh' | sudo tee -a /etc/vzdump.conf
   ```

## Verification

- Execute PVE Backup Settings Manually

  ```bash
  cd /root && /usr/local/sbin/proxmox-hostconfig-backup.sh
  ```

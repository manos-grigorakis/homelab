# Flint 2

This script backs up the OpenWrt configuration (`sysupgrade` backup) from the Flint 2 router to NAS over SSH key (dropbear), keeps the last 7 backups and logs / notifies via Proxmox.

## Prerequisites

- Dedicated NAS user for Flint 2 with permissions on dataset
- (Optional) Proxmox VE Mail configured

## Setup

1.  SSH to Flint 2

    ```bash
    ssh root@<flint-ip>
    ```

2.  Generate the SSH Key

    ```bash
    mkdir -p /root/.ssh
    dropbearkey -t ed25519 -f /root/.ssh/id_dropbear_ed25519
    dropbearkey -y -f /root/.ssh/id_dropbear_ed25519 | grep "^ssh-ed25519"
    ```

    Copy the public key output to `authorized_keys` on both the NAS user and the Proxmox `root` user.

3.  Create a directory for the script

    ```bash
    mkdir -p /root/scripts
    ```

4.  Copy `flint-backup.sh` to `/root/scripts`

5.  Configure script variables

    | Name           | Required | Notes                                  |
    | -------------- | -------- | -------------------------------------- |
    | `NAS_HOST`     | yes      | IP of NAS                              |
    | `NAS_USER`     | yes      | Dedicated user in NAS with permissions |
    | `DEST_DIR`     | yes      | NAS path mounted in Flint 2            |
    | `SSH_KEY`      | yes      | Path to dropbear SSH key               |
    | `KEEP`         | no       | Retention of backups (default 7)       |
    | `PROXMOX_HOST` | no       | Proxmox VE IP address                  |
    | `MAIL_TO`      | no       | Email Address to be notified           |

6.  Make the script executable

    ```bash
    chmod +x /root/scripts/flint-backup.sh
    ```

7.  Schedule the script via cron

    ```bash
    echo "0 4 * * * /root/scripts/flint-backup.sh >> /var/log/flint-backup.log 2>&1" >> /etc/crontabs/root
    /etc/init.d/cron restart
    ```

8.  Execute the script manually
    Trust once both SSH hosts (NAS & PVE) and confirm that the backup works

    ```bash
    /root/scripts/flint-backup.sh
    ```

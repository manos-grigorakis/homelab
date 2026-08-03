#!/bin/sh

set -e

NAS_HOST="192.168.10.100"
NAS_USER="router"
DEST_DIR="/mnt/tank/backups/other/router"
SSH_KEY="/root/.ssh/id_dropbear_ed25519"
KEEP=7
DATE="$(date +%Y%m%d-%H%M)"
TMP="/tmp/flint-backup-$DATE.tar.gz"
DEST_FILE="$DEST_DIR/flint-backup-$DATE.tar.gz"

# (Optional) Proxmox notification settings
PROXMOX_HOST=""
MAIL_TO=""

sysupgrade -b "$TMP"

cat "$TMP" | dbclient -i "$SSH_KEY" $NAS_USER@$NAS_HOST "cat > '$DEST_FILE'"

dbclient -i "$SSH_KEY" "$NAS_USER@$NAS_HOST" "
  cd '$DEST_DIR' && \
  ls -1t flint-backup-*.tar.gz 2>/dev/null | tail -n +$((KEEP+1)) | xargs -r rm -f
"

rm -f "$TMP"
echo "Backup completed."

# (Optional) Notify Proxmox

if [ -n "$PROXMOX_HOST" ] && [ -n "$MAIL_TO" ]; then
    MSG="Flint backup completed at $(date)"

    # Write logs to Proxmox
    echo "$MSG" | dbclient -y -i "$SSH_KEY" root@$PROXMOX_HOST "cat >> /var/log/flint-backup.log"

    # Send email from Proxmox
    echo "$MSG" | dbclient -y -i "$SSH_KEY" root@$PROXMOX_HOST "mail -s 'Flint Backup OK' $MAIL_TO"

    echo "Email sent from Proxmox"
else
    echo "Proxmox notification skipped (PROXMOX_HOST or MAIL_TO not set)"
fi
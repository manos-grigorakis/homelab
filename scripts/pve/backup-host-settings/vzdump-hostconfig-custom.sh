#!/bin/bash
# vzdump hook to always save host-config backup to a fixed NAS path
set -euo pipefail

STORAGE="nas_backups"
DEST_SUBDIR="proxmox-settings"
KEEP=30

DEST_BASE="/mnt/pve/${STORAGE}/${DEST_SUBDIR}"
PHASE="${1:-}"

case "$PHASE" in
  job-end)
    echo "[hostconfig] Creating host settings archive..."
    ARCHIVE_NAME="$(/usr/local/sbin/proxmox-hostconfig-backup.sh)"

    if ! mountpoint -q "/mnt/pve/${STORAGE}"; then
      echo "[hostconfig] ERROR: storage /mnt/pve/${STORAGE} is not mounted." >&2
      exit 1
    fi

    mkdir -p "${DEST_BASE}"
    echo "[hostconfig] Moving ${ARCHIVE_NAME} -> ${DEST_BASE}"
    mv "${ARCHIVE_NAME}" "${DEST_BASE}/"

    ls -1t "${DEST_BASE}"/proxmox-hostconfig-*.tar.gz 2>/dev/null | tail -n +$((KEEP+1)) | xargs -r rm -f
    echo "[hostconfig] Done -> ${DEST_BASE}"
    ;;
  *)
    :
    ;;
esac

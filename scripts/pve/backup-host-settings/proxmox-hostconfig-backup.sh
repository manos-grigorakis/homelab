#!/bin/bash
set -euo pipefail

STAMP="$(date -u +%Y%m%d-%H%M%S)"
TMPDIR="$(mktemp -d)"
ARCHIVE_NAME="proxmox-hostconfig-${STAMP}.tar.gz"

# Gather important configs
cp -a /etc/pve                      "${TMPDIR}/pve"
cp -a /etc/hosts                    "${TMPDIR}/hosts"
cp -a /etc/resolv.conf              "${TMPDIR}/resolv.conf"
cp -a /etc/fstab                    "${TMPDIR}/fstab"
cp -a /etc/apt/sources.list*        "${TMPDIR}/" || true
cp -a /etc/modules*                 "${TMPDIR}/" || true

# Optional configs
[[ -f /etc/network/interfaces ]] && cp -a /etc/network/interfaces "${TMPDIR}/interfaces"
[[ -f /etc/vzdump.conf ]] && cp -a /etc/vzdump.conf "${TMPDIR}/vzdump.conf"
[[ -d /root/.ssh ]] && cp -a /root/.ssh "${TMPDIR}/root_ssh"
[[ -d /etc/modprobe.d ]] && cp -a /etc/modprobe.d "${TMPDIR}/modprobe.d"
[[ -f /etc/sysctl.conf ]] && cp -a /etc/sysctl.conf "${TMPDIR}/sysctl.conf"
[[ -d /etc/sysctl.d ]] && cp -a /etc/sysctl.d "${TMPDIR}/sysctl.d"

# Optional: pmxcfs DB dump
if command -v sqlite3 >/dev/null 2>&1 && [ -f /var/lib/pve-cluster/config.db ]; then
  sqlite3 /var/lib/pve-cluster/config.db '.dump' > "${TMPDIR}/config-db-dump-${STAMP}.sql" || true
fi

tar -czf "${ARCHIVE_NAME}" -C "${TMPDIR}" .
echo "${ARCHIVE_NAME}"

rm -rf "${TMPDIR}"
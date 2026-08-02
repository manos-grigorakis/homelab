# Suricata

- Mode: IDS-only (sniffing only no packet blocking)
- Interface: enp6s16 (dedicated for Suricata)
- Logs: `/mnt/suricata-logs/eve.json` (external mount in NAS with rotation)
- [Logs Rotation](/vm/suricata/logrotate-suricata)
- Rule sources: `et/open` only, defined in `update.yaml`
- `threshold.config`: Suppresses logs to reduce noisy rules

## Notes

- [Ubuntu Installation](https://docs.suricata.io/en/suricata-8.0.6/install/ubuntu.html)

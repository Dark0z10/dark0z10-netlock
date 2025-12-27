#!/bin/bash
# dark0z10-netlock disable — stops the watchdog service (keeps firewall rules)

# Require root
if [ "$EUID" -ne 0 ]; then
    echo "Run as root"
    exit 1
fi

echo "[*] Stopping dark0z10-netlock watchdog..."

sudo systemctl stop dark0z10-netlock

echo "[✓] Watchdog stopped"
echo "    Firewall rules remain active — protection still enabled"
echo "    Watchdog is NOT monitoring — rules won't auto-repair"
echo

# Show status
netlock-status

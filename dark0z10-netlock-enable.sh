#!/bin/bash
# dark0z10-netlock enable — starts and enables the watchdog service

# Require root
if [ "$EUID" -ne 0 ]; then
    echo "Run as root"
    exit 1
fi

echo "[*] Enabling and starting dark0z10-netlock..."

sudo systemctl enable --now dark0z10-netlock

echo "[✓] dark0z10-netlock is now enabled and running"
echo "    Firewall rules are active — VPN-only protection enabled"
echo

# Show status
netlock-status

#!/bin/bash
# dark0z10-netlock disable persistence — removes auto-start but keeps watchdog running

# Require root
if [ "$EUID" -ne 0 ]; then
    echo "Run as root"
    exit 1
fi

echo "[*] Disabling dark0z10-netlock auto-start..."

sudo systemctl disable dark0z10-netlock

echo "[✓] Auto-start disabled"
echo "    Watchdog continues running until you stop it"
echo "    Service will NOT start on next boot"
echo

# Show status
netlock-status

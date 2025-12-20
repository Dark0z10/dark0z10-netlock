#!/bin/bash
set -e

echo "[*] Installing dark0z10-netlock..."

# Install runtime script
sudo cp dark0z10-netlock.sh /usr/local/bin/dark0z10-netlock.sh
sudo chmod +x /usr/local/bin/dark0z10-netlock.sh

# Install systemd service
sudo cp dark0z10-netlock.service /etc/systemd/system/dark0z10-netlock.service

# Reload systemd
sudo systemctl daemon-reload

echo "[✓] Installed successfully."
echo "    Service is NOT started or enabled."
echo "    Use: sudo systemctl enable --now dark0z10-netlock"

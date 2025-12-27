#!/bin/bash
set -e

echo "[*] Installing dark0z10-netlock..."

# Install runtime script
sudo cp dark0z10-netlock.sh /usr/local/bin/dark0z10-netlock.sh
sudo chmod +x /usr/local/bin/dark0z10-netlock.sh

# Install status command
sudo cp dark0z10-netlock-status.sh /usr/local/bin/netlock-status
sudo chmod +x /usr/local/bin/netlock-status

# Install enable command
sudo cp dark0z10-netlock-enable.sh /usr/local/bin/netlock-enable
sudo chmod +x /usr/local/bin/netlock-enable

# Install disable command
sudo cp dark0z10-netlock-disable.sh /usr/local/bin/netlock-disable
sudo chmod +x /usr/local/bin/netlock-disable

# Install disable persistence command
sudo cp dark0z10-netlock-disable-persistence.sh /usr/local/bin/netlock-disable-persistence
sudo chmod +x /usr/local/bin/netlock-disable-persistence

# Install uninstall command
sudo cp dark0z10-netlock-uninstall.sh /usr/local/bin/netlock-uninstall
sudo chmod +x /usr/local/bin/netlock-uninstall

# Install reset command
sudo cp dark0z10-netlock-reset.sh /usr/local/bin/netlock-reset
sudo chmod +x /usr/local/bin/netlock-reset

# Install systemd service
sudo cp dark0z10-netlock.service /etc/systemd/system/dark0z10-netlock.service

# Reload systemd
sudo systemctl daemon-reload

echo "[✓] Installed successfully."
echo "    Enabling and starting dark0z10-netlock..."
echo

# Enable and start the service
sudo systemctl enable --now dark0z10-netlock

# Show status
netlock-status

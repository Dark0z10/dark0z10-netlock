#!/bin/bash
# dark0z10-netlock installer

BIN="/usr/local/bin/dark0z10-netlock"
SERVICE="/etc/systemd/system/dark0z10-netlock.service"

[ "$EUID" -ne 0 ] || {
    echo "Run as root"
    exit 1
}

cp dark0z10-netlock.sh "$BIN" || exit 1
chmod +x "$BIN"

cp dark0z10-netlock.service "$SERVICE" || exit 1

systemctl daemon-reload

echo "dark0z10-netlock installed"
echo "Enable with:"
echo "  sudo systemctl enable --now dark0z10-netlock"

#!/bin/bash
# dark0z10-netlock uninstall

SERVICE="dark0z10-netlock"
BIN="/usr/local/bin/dark0z10-netlock"
UNIT="/etc/systemd/system/dark0z10-netlock.service"

[ "$EUID" -ne 0 ] || {
    echo "Run as root"
    exit 1
}

systemctl stop "$SERVICE" 2>/dev/null
systemctl disable "$SERVICE" 2>/dev/null

rm -f "$BIN" "$UNIT"
systemctl daemon-reload

# Restore open networking
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -F
iptables -X

ip6tables -P INPUT ACCEPT
ip6tables -P OUTPUT ACCEPT
ip6tables -P FORWARD ACCEPT
ip6tables -F
ip6tables -X

echo "dark0z10-netlock removed"

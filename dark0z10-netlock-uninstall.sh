#!/bin/bash
# dark0z10-netlock uninstall

SERVICE="dark0z10-netlock"
BIN="/usr/local/bin/dark0z10-netlock.sh"
STATUS_CMD="/usr/local/bin/netlock-status"
ENABLE_CMD="/usr/local/bin/netlock-enable"
DISABLE_CMD="/usr/local/bin/netlock-disable"
DISABLE_PERSISTENCE_CMD="/usr/local/bin/netlock-disable-persistence"
RESET_CMD="/usr/local/bin/netlock-reset"
UNINSTALL_CMD="/usr/local/bin/netlock-uninstall"
UNIT="/etc/systemd/system/dark0z10-netlock.service"

# Require root
if [ "$EUID" -ne 0 ]; then
    echo "Run as root"
    exit 1
fi

# Stop and disable service (ignore errors if not present)
systemctl stop "$SERVICE" 2>/dev/null
systemctl disable "$SERVICE" 2>/dev/null

# Remove installed files
rm -f "$BIN" "$STATUS_CMD" "$ENABLE_CMD" "$DISABLE_CMD" "$DISABLE_PERSISTENCE_CMD" "$RESET_CMD" "$UNINSTALL_CMD" "$UNIT"
systemctl daemon-reload

# Restore open networking (IPv4)
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -F
iptables -X

# Restore open networking (IPv6)
ip6tables -P INPUT ACCEPT
ip6tables -P OUTPUT ACCEPT
ip6tables -P FORWARD ACCEPT
ip6tables -F
ip6tables -X

echo "dark0z10-netlock removed"
echo "Normal networking restored"

#!/bin/bash
# dark0z10-netlock reset — clears firewall rules but keeps watchdog running

# Require root
if [ "$EUID" -ne 0 ]; then
    echo "Run as root"
    exit 1
fi

echo "[*] Resetting dark0z10-netlock firewall rules..."
echo "    Watchdog will detect changes and reapply rules in ~30 seconds"

# Reset IPv4 to normal (ACCEPT all)
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -F
iptables -X

# Reset IPv6 to normal (ACCEPT all)
ip6tables -P INPUT ACCEPT
ip6tables -P OUTPUT ACCEPT
ip6tables -P FORWARD ACCEPT
ip6tables -F
ip6tables -X

echo "[✓] Firewall reset to normal"
echo "    Service will reapply rules automatically"
echo

# Show status
/usr/local/bin/netlock-status

#!/bin/bash
# dark0z10-netlock status checker

echo
tput bold; tput setaf 3; echo " ==== 🔒 dark0z10-netlock ===="; tput sgr0; echo

# Service status (checks if firewall rules are active, not if systemd service is running)
tput setaf 6; printf "Service:        "; tput sgr0
if sudo iptables -S OUTPUT | grep -q "^-P OUTPUT DROP"; then
    tput bold; tput setaf 2; echo "● RUNNING"; tput sgr0
else
    tput bold; tput setaf 1; echo "● STOPPED"; tput sgr0
fi

# IPv4 killswitch
tput setaf 6; printf "IPv4 killswitch: "; tput sgr0
if sudo iptables -S OUTPUT | grep -q "^-P OUTPUT DROP"; then
    tput setaf 2; echo "✓ ACTIVE"; tput sgr0
else
    tput setaf 1; echo "✗ INACTIVE"; tput sgr0
fi

# VPN route
tput setaf 6; printf "VPN route:       "; tput sgr0
if sudo iptables -S OUTPUT | grep -q "tun0.*ACCEPT"; then
    tput setaf 2; echo "✓ tun0 allowed"; tput sgr0
else
    tput setaf 1; echo "✗ NO VPN route"; tput sgr0
fi

# IPv6 block
tput setaf 6; printf "IPv6 block:      "; tput sgr0
if sudo ip6tables -S OUTPUT | grep -q "^-P OUTPUT DROP"; then
    tput setaf 2; echo "✓ BLOCKED"; tput sgr0
else
    tput setaf 1; echo "✗ OPEN"; tput sgr0
fi

# Last log with "active" highlighted based on service status
tput setaf 6; printf "Watchdog Service: "; tput sgr0
if systemctl is-active --quiet dark0z10-netlock; then
    sudo journalctl -u  dark0z10-netlock -n 1 --no-pager -o cat | sed "s/active/$(tput bold; tput setaf 2)active$(tput sgr0)/g"
else
    tput setaf 1; echo "[dark0z10-netlock] inactive — watchdog not running"; tput sgr0
fi

echo
#!/bin/bash
# dark0z10-netlock status checker

printf "\e[1m👁️  dark0z10-netlock  Status\e[0m\n"
echo

# Service status
tput setaf 6; printf "Service:        "; tput sgr0
if systemctl is-active --quiet dark0z10-netlock; then
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

# Last log
tput setaf 6; printf "Last log:        "; tput sgr0
sudo journalctl -u dark0z10-netlock -n 1 --no-pager -o cat

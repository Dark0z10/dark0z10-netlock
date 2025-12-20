#!/bin/bash
# dark0z10-netlock — runtime

VPN_IFACE="tun0"
CHECK_INTERVAL=30

die() {
    echo "[dark0z10-netlock] ERROR: $1"
    exit 1
}

apply_rules() {
    # IPv4
    iptables -F || die "iptables flush failed"
    iptables -X

    iptables -P INPUT DROP
    iptables -P OUTPUT DROP
    iptables -P FORWARD DROP

    iptables -A INPUT  -i lo -j ACCEPT
    iptables -A OUTPUT -o lo -j ACCEPT

    iptables -A INPUT  -i "$VPN_IFACE" -j ACCEPT
    iptables -A OUTPUT -o "$VPN_IFACE" -j ACCEPT

    iptables -A INPUT  -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
    iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

    iptables -A INPUT  -p udp --sport 67:68 --dport 67:68 -j ACCEPT
    iptables -A OUTPUT -p udp --sport 67:68 --dport 67:68 -j ACCEPT

    # IPv6 (block completely)
    ip6tables -F
    ip6tables -X
    ip6tables -P INPUT DROP
    ip6tables -P OUTPUT DROP
    ip6tables -P FORWARD DROP
}

check_rules() {
    iptables -S OUTPUT | grep -q "^-P OUTPUT DROP" || return 1
    iptables -S OUTPUT | grep -q "\-o $VPN_IFACE .*ACCEPT" || return 1
    ip6tables -S OUTPUT | grep -q "^-P OUTPUT DROP" || return 1
    return 0
}

[ "$EUID" -ne 0 ] && die "Run as root"

apply_rules
check_rules || die "Firewall verification failed"

echo "[dark0z10-netlock] active — watchdog running"

while true; do
    sleep "$CHECK_INTERVAL"
    check_rules || apply_rules
done

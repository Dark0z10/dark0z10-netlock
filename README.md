# dark0z10-netlock 🔒

Kernel-level VPN kill switch for Linux using `iptables`.

All network traffic is **blocked by default** unless it exits through the VPN interface.  
If firewall rules are modified or flushed, they are **automatically restored** by a watchdog.

---

## 🧠 Overview

`dark0z10-netlock` enforces a **strict VPN-only networking policy** at the kernel firewall level.

Once enabled:

- No traffic leaves the system outside the VPN tunnel
- VPN drops result in **zero connectivity** (no leaks)
- Firewall resets are automatically corrected
- Rules persist across reboots using `systemd`

Designed to work alongside VPN clients (e.g. ExpressVPN).

---

## ✨ Features

- Default **DROP** policy (INPUT / OUTPUT / FORWARD)
- VPN-only traffic (`tun0`)
- Loopback traffic allowed
- Established connections allowed
- IPv6 fully blocked (leak prevention)
- Self-healing watchdog
- systemd-native persistence
- Minimal Bash, no external dependencies

---

## 📋 Requirements

- Linux
- `iptables` / `ip6tables`
- `systemd`
- VPN interface named `tun0`  
  *(changeable in the script if needed)*

---

## 📦 Installation

Clone and Install the required files
(this does not enable or start the kill switch):
```bash
git clone https://github.com/Dark0z10/dark0z10-netlock.git
cd dark0z10-netlock
chmod +x dark0z10-netlock-install.sh
sudo ./dark0z10-netlock-install.sh
```
---

## 🚀 Usage

**Enable and start the kill switch:**
```bash
sudo systemctl enable --now dark0z10-netlock
```
🔒 From this point on, all traffic is blocked by default.   Only traffic through the VPN interface (`tun0`) is allowed.

##

**Stop temporarily (without uninstalling):**
```bash
sudo systemctl stop dark0z10-netlock
```
##

**Disable persistence (do not start on boot):**
```bash
sudo systemctl disable dark0z10-netlock
```
---

## 🧹 Uninstall

**Fully remove the kill switch and restore normal networking:**
```bash
sudo ./dark0z10-netlock-uninstall.sh
```

This will:
 - stop and disable the service
 - Remove installed files
 - Restore ACCEPT policies for IPv4 and IPv6


---

## Verification

**Check the OUTPUT policy:**
```bash
sudo iptables -S OUTPUT
```

Expected output includes:
```bash
-P OUTPUT DROP
-A OUTPUT -o tun0 -j ACCEPT
```

**Behavior Test(Very important to test on first install):**
+ Disconnect VPN → no internet access  
+ Reconnect VPN → internet restored
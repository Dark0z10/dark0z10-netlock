<p align="center">
  <img style="margin:-50px;" src="assets/netlock-logo.png" width="450" alt="dark0z10-netlock logo">
</p>

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

**Designed to work alongside VPN clients and their kill switches (e.g. ExpressVPN), effectively giving you two layers of protection**

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

## 👁️ Watchdog  Service

- Runs continuously via systemd and repeatedly checks that:

  - OUTPUT policy is DROP

  - VPN-only rule (-o tun0) exists

  - Loopback traffic is allowed

  - Established connections are allowed

  - IPv6 is still fully blocked

  **If any of these are missing or changed,**
  **the watchdog re-applies the full firewall ruleset**

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

**Check if dark0z10-netlock service is running:**
```bash
systemctl status dark0z10-netlock
```

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
+ **Disconnect VPN → no internet access**
+ **Reconnect VPN → internet restored**

## 

**Key Owner:** Dark0z10  
**Fingerprint:** `ABCD 1234 EFGH 5678 IJKL 9ABC DEF0 1234 5678 90AB`

- GitHub: https://github.com/Dark0z10.gpg
- keys.openpgp.org: https://keys.openpgp.org/search?q=ABCD1234EFGH5678

<p align="center" style="margin-bottom:1px; margin-top:30px; border: 0px solid grey"">
<img style="width: 120px" src="assets/avatar-circle.png">

</p> 
<p align="center" style="margin-bottom:1px">
Dark0z10@proton.me
</p>
<p align="center"> 
dark0z10@atomicmail.io
</p>

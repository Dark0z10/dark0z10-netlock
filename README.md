<p align="center">
  <img src="assets/netlock-logo.png" width="400" alt="dark0z10-netlock logo">
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

**Enable and start watchdog:**
```bash
sudo netlock-enable
```
🔒 From this point on, all traffic is blocked by default.   Only traffic through the VPN interface (`tun0`) is allowed.

##

**Stop watchdog temporarily:**
```bash
sudo netlock-disable
```
##

**Disable watchdog (do not start on boot):**
```bash
sudo netlock-disable-persistence
```
##

**Clears all firewall rules to normal:**
```bash
sudo netlock-reset
```

### ✅ Verification


**Check if dark0z10-netlock service is running:**
```bash
netlock-status
```
**Expected output:**
  <div>
    <pre>
<span style="color:#f1c40f;font-weight:700"> ==== 🔒 dark0z10-netlock ====</span>

<span color="green">Service:</span>        <span style="color:#2ecc71;font-weight:700"> ● RUNNING</span>
<span style="color:#00bcd4">IPv4 killswitch:</span> <span style="color:#2ecc71">✓ ACTIVE</span>
<span style="color:#00bcd4">VPN route:</span>       <span style="color:#2ecc71">✓ tun0 allowed</span>
<span style="color:#00bcd4">IPv6 block:</span>      <span style="color:#2ecc71">✓ BLOCKED</span>
<span style="color:#00bcd4">Watchdog:</span> <span style="color:#95a5a6">[dark0z10-netlock] <span style="color:#2ecc71;font-weight:700" color=red>active</span> — watchdog running</span>
    </pre>
  </div>


**Behavior Test:**
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

# Phone Monitor Web · Infinix X6886

A lightweight, real-time hardware telemetry dashboard for **Infinix GT / Note (X6886 · MediaTek MT6789)** and modern Android devices running Android 12 - 17+ (AOSP / GSI / Stock).

Runs as a Magisk / KernelSU / APatch module utilizing busybox `httpd` with near-zero overhead (<0.1% CPU). Access the live web dashboard from any PC, tablet, or phone on your local network at `http://<phone-ip>:8088`.

---

## ⚡ Direct Download (Flashable Magisk Module)

👉 [**Download PhoneMonitor-X6886-v2.5.zip**](https://github.com/lemonrsh/phone-monitoring-web/raw/main/PhoneMonitor-X6886-v2.5.zip)

> ⚠️ **IMPORTANT**: Do **NOT** use GitHub's green *"Code -> Download ZIP"* button or GitHub's *"Source code (zip)"* link!
> GitHub packages repository code inside a subfolder (`phone-monitoring-web-main/`), which causes Magisk to report:
> ```
> ! This zip is not a Magisk module!
> ! Installation failed
> ```
> **Always use the direct link above (`PhoneMonitor-X6886-v2.5.zip`)**, which has `module.prop` and `META-INF` structured correctly at the zip root.

---

## Features & Diagnostics

- **Display & SurfaceFlinger FPS**:
  - Hardware display refresh rate calculation (120 Hz on Infinix X6886).
  - Real-time frame presentation FPS and SurfaceFlinger compositor CPU load.
- **CPU Octa-Core Cluster**:
  - Live per-core load tracking across all 8 cores (Cortex-A76 Big + Cortex-A55 Little).
  - Cluster scaling governors (`schedutil` / `performance`), active frequency bounds, and 1m/5m/15m load averages.
  - CPU Pressure Stall Information (PSI).
- **GPU (MediaTek Mali-G57 MC2)**:
  - Real-time GPU core clock frequency via `gpufreqv2` and GED HAL.
  - GPU utilization percentage and active render pipeline.
  - Mali graphics memory usage and core operating voltage.
  - Devfreq DRAM memory bus frequency (`mtk-dvfsrc-devfreq` @ 4266 MHz LPDDR5).
- **Battery & Power HUD**:
  - Real-time power draw in Watts ($W = V \times I$), terminal voltage ($V$), and charging/discharging current ($mA$).
  - Battery capacity percentage, temperature, battery health status, charge cycles (e.g. 241 cycles), and estimated time to full countdown.
- **RAM & zRAM Memory Deep Dive**:
  - Physical RAM breakdown: Total (8 GB), Used, Available, Free, Cached, and Buffers.
  - zRAM swap utilization and memory pressure stall information.
- **Storage & Disk I/O**:
  - Userdata partition (`/data`) and system root (`/`) capacity and utilization.
  - Active disk throughput (Read/Write MB/s) on primary UFS internal storage (`sdc`) and data mapper (`dm-62`).
- **Comprehensive Thermal Matrix**:
  - Heat sensor matrix mapping all device thermal zones (CPU, GPU, battery, PMIC, charger, board skin).
  - Color-coded temperature tags with peak thermal zone indicator and rolling 30-minute peak history.
- **Live Task Manager**:
  - Top active processes with PID, command name, CPU%, and memory% allocation.
- **Modern Cyber Aesthetic**:
  - Self-contained, responsive glassmorphism dark UI with embedded vector SVG icons.
  - Zero external internet or CDN dependencies.

---

## Installation

### Method 1: Magisk / KernelSU / APatch App
1. Download [**PhoneMonitor-X6886-v2.5.zip**](https://github.com/lemonrsh/phone-monitoring-web/raw/main/PhoneMonitor-X6886-v2.5.zip).
2. Open **Magisk**, **KernelSU**, or **APatch**.
3. Go to the **Modules** tab, tap **Install from storage**, and select `PhoneMonitor-X6886-v2.5.zip`.
4. Reboot your phone.
5. In your web browser on any device connected to the same Wi-Fi, navigate to:
   ```
   http://<phone-ip>:8088
   ```
   *(Tip: In Magisk / KernelSU, tap the module's **Action** button to view your phone's active IP address)*.

### Method 2: Terminal / ADB (Root)
```bash
# Push zip to phone
adb push PhoneMonitor-X6886-v2.5.zip /sdcard/

# Flash module using magisk CLI
adb shell su -c "magisk --install-module /sdcard/PhoneMonitor-X6886-v2.5.zip"

# Reboot
adb reboot
```

---

## File Structure

```
PhoneMonitor-X6886-v2.5.zip
├── META-INF/                     # Standard Magisk installer binary and script
│   └── com/google/android/
│       ├── update-binary
│       └── updater-script
├── module.prop                   # Module metadata
├── customize.sh                  # Installation script with permissions setup
├── service.sh                    # Boot service: launches thermal logger & httpd
├── action.sh                     # Action button script: shows network IP
├── uninstall.sh                  # Cleanup on module removal
├── www/                          # Web server root
│   ├── index.html                # Modern responsive dashboard
│   └── cgi-bin/
│       └── stats                 # Shell CGI script collecting kernel stats
└── README.md
```

---

## License

MIT License

# ⌨️ Royal Kludge R75 - Custom QMK Firmware

<p>
  <a href="https://github.com/snakkarike/Royal-Kludge-R75/stargazers"><img src="https://img.shields.io/github/stars/snakkarike/Royal-Kludge-R75?style=for-the-badge&color=yellow" alt="Stars" /></a>
  <a href="https://github.com/snakkarike/Royal-Kludge-R75/network/members"><img src="https://img.shields.io/github/forks/snakkarike/Royal-Kludge-R75?style=for-the-badge&color=orange" alt="Forks" /></a>
  <a href="https://github.com/snakkarike/Royal-Kludge-R75/issues"><img src="https://img.shields.io/github/issues/snakkarike/Royal-Kludge-R75?style=for-the-badge&color=red" alt="Issues" /></a>
  <a href="https://github.com/snakkarike/Royal-Kludge-R75"><img src="https://img.shields.io/github/repo-size/snakkarike/Royal-Kludge-R75?style=for-the-badge&color=purple" alt="Repo Size" /></a>
  <a href="https://github.com/snakkarike/Royal-Kludge-R75"><img src="https://img.shields.io/github/languages/top/snakkarike/Royal-Kludge-R75?style=for-the-badge&color=teal" alt="Language" /></a>
</p>

A high-performance, feature-rich custom QMK firmware for the **Royal Kludge R75 (Wired ANSI/ISO)**. This project aims to unlock the full potential of the R75, providing advanced features like SOCD cleaning, OpenRGB/SignalRGB integration, and highly customizable layers.

---

## 🚀 Key Features

- **QMK & VIA Support**: Full customization through the powerful QMK firmware and easy-to-use VIA interface.
- **⚡ SOCD Cleaner**: Simultaneous Opposing Cardinal Directions cleaning (Last Win) - essential for competitive gaming (e.g., CS2, Valorant).
- **🕹️ NKRO (N-Key Rollover)**: Never miss a keystroke with full N-key rollover support.
- **🌈 Advanced RGB Integration**:
  - **OpenRGB**: Direct control via OpenRGB for synchronized lighting across all your devices.
  - **SignalRGB**: Native support for SignalRGB with a dedicated plugin.
  - Smooth transitions and reactive effects.
- **🛡️ Safety First**: Triple-tap protection for critical functions like Bootloader reset and EEPROM clearing.
- **📁 Multi-Layer Support**: Optimized layers for Windows, macOS, and dedicated Numpad functionality.

---

## 📦 Firmware Variants

| Firmware Image | Features | USB IDs (VID:PID) | Status |
| :--- | :--- | :--- | :--- |
| **[VIA + OpenRGB + SignalRGB v1.0.2](firmware/VIA%20Plus%20SignalRGB%20%26%20OpenRGB%20Firmware-v1.0.2.hex)** | All Features | `342d:e484` | ✔️ Maintained |
| **[VIA + OpenRGB + SignalRGB v1.0.2 (ISO)](firmware/VIA%20Plus%20SignalRGB%20%26%20OpenRGB%20Firmware-ISO-v1.0.2.hex)** | All Features for ISO Layout | `342d:e483` | ✔️ Maintained |

---

## 🛠️ Usage Guide

### 📂 Layer System Overview

The firmware uses a 6-layer system for maximum flexibility:

1.  **Layer 0 (Base)**: Default Windows layout.
2.  **Layer 1 (Fn)**: Multimedia, lighting controls, and navigation.
3.  **Layer 2 (Options)**: System configurations (Reset, NKRO, SOCD, Mode Toggle).
4.  **Layer 3 (Mac)**: Optimized layout for macOS users.
5.  **Layer 4 (Numpad)**: Integrated Numpad layout on the alpha keys.

### ⌨️ Key Combinations

#### ⚙️ System Controls (Layer 2)
*Access by holding `Fn` + `Right Shift`*

| Action | Shortcut | Notes |
| :--- | :--- | :--- |
| **Enter Bootloader** | `Triple Tap Q` | Highlighted Yellow in Layer 2 |
| **Clear EEPROM** | `Triple Tap Z` | Highlighted Purple in Layer 2 |
| **Toggle NKRO** | `N` | Highlighted Red in Layer 2 |
| **Toggle SOCD / SnapTap** | `T` | Highlighted Orange in Layer 2 |
| **Toggle OpenRGB** | `O` | Cyan when active; Red when disabled in Layer 2 |
| **Toggle SignalRGB** | `S` | Green when active; Red when disabled in Layer 2 |
| **Switch to Layer 0 (Windows)** | `F1` | Switches to Base Windows layout for the session (Mac LED turns OFF) |
| **Switch to Layer 3 (Mac)** | `F2` | Switches to Mac layout (Default on boot; Mac LED turns ON) |
| **Switch to Layer 4 (Numpad)** | `F3` | Numpad on right-hand keys (Press `F1` to exit) |

> [!NOTE]
> **Fn Row in Mac mode:** Mac mode only swaps the Alt and Cmd keys; it does not change the top-row function keys. For example, pressing `F12` by itself sends `F12`. Hold `Fn` and press `F12` to send **Volume Up** (the volume controls are on the Fn layer).

> [!IMPORTANT]
> **Triple-Tap Timing & Execution (`Q` / `Z`)**:
> - **Hold Order**: Press and hold **`Fn` first**, then press and hold **`Right Shift`**. Keep **both keys held down** continuously throughout the sequence.
> - **Rapid Cadence**: Tap `Q` (or `Z`) 3 times quickly in rapid succession (each tap must be within **200ms** of the previous tap).
> - **Hold Until Triggered**: Keep holding `Fn` + `Right Shift` for a split second after the 3rd tap until the reset executes. Releasing either modifier immediately after the 3rd tap drops the active layer before QMK's tap-dance timeout finishes, canceling the action.

> [!NOTE]
> In the firmware, the layer switching keys are mapped to **`F1`**, **`F2`**, and **`F3`** on the top row of Layer 2. If you prefer using number keys `1`, `3`, and `4`, you can easily remap them using [VIA](https://usevia.app/).

> [!NOTE]
> **Default Layer on Power Off / Restart**:
> The wired keyboard defaults to **Layer 0 (Windows)** every time it is unplugged, powered off, or restarted. The layer switching shortcuts (`F1`/`F2`/`F3`) use QMK's transient `TO(n)` action (in RAM) rather than persistent EEPROM/Flash default layer writes (`DF(n)`).
> For a detailed guide on how batteryless persistence works and how to make Mac mode permanent across reboots, see [Layer Persistence & Power-off Behavior](docs/kb/layer-persistence-and-power-cycles.md).

---

#### 💡 RGB Lighting Controls (Layer 1)
*Access by holding `Fn` + Key*

| Action | Shortcut | Description |
| :--- | :--- | :--- |
| **Toggle Backlight On / Off** | `Fn` + `\` | Toggles RGB matrix on/off (blinks Space & Alts dark red when off) |
| **Next RGB Effect** | `Fn` + `]` | Cycle forward through animations |
| **Previous RGB Effect** | `Fn` + `[` | Cycle backward through animations |
| **Reset to Solid Color** | `Fn` + `P` | Sets static solid color mode and flashes Space white |
| **Brightness Up** | `Fn` + `.` or `Fn` + `↑` | Increase brightness (flashes white; dark red at max) |
| **Brightness Down** | `Fn` + `,` or `Fn` + `↓` | Decrease brightness (flashes white; dark red at min) |
| **Hue Up** | `Fn` + `O` | Increase hue (flashes white; dark red at max) |
| **Hue Down** | `Fn` + `I` | Decrease hue (flashes white; dark red at min) |
| **Saturation Up** | `Fn` + `L` | Increase saturation (flashes white; dark red at max) |
| **Saturation Down** | `Fn` + `K` | Decrease saturation (flashes white; dark red at min) |
| **Effect Speed Up** | `Fn` + `→` | Speed up animation (flashes white; dark red at max) |
| **Effect Speed Down** | `Fn` + `;` or `Fn` + `←` | Slow down animation (flashes white; dark red at min) |

---

#### 🚨 Mode & LED Indicators

* **Mac Mode vs. Windows Mode (Hardware LED)**:
  * **Mac Mode (Layer 3)**: The dedicated hardware **Mac Indicator LED** (`M` LED, pin `B8`) is **illuminated (ON)**.
  * **Windows Mode (Layer 0)**: The **Mac Indicator LED** is **OFF**.
  * *(The Mac LED also lights up temporarily while holding `Fn` + `Right Shift` because Layer 2 is active).*
* **Win Lock / Layer Indicator LED** (pin `B9`):
  * Illuminates whenever **Layer 1 (`Fn`)** or **Layer 4 (Numpad)** is active.
* **Layer 2 (Options) Visual Preview**:
  * Holding `Fn` + `Right Shift` turns off general background lighting and illuminates functional keys:
    * **`O` (Cyan when active, Red when disabled)**: OpenRGB mode
    * **`S` (Green when active, Red when disabled)**: SignalRGB mode
    * **`N` (Red)**: NKRO toggle
    * **`T` (Orange)**: SOCD cleaner toggle
    * **`Q` (Yellow)**: Bootloader reset
    * **`Z` (Purple)**: EEPROM reset
* **OpenRGB & SignalRGB Status**:
  * **OpenRGB ON (`Fn` + `Right Shift` + `O`)**: Firmware halts internal QMK effects and waits for raw HID frame streams from the OpenRGB desktop software.
  * **OpenRGB OFF**: Immediately snaps back to the built-in solid color effect (`RGB_MATRIX_SOLID_COLOR`).

---

## 📥 Installation

### 1️⃣ Flashing the Firmware
Use your preferred tool (e.g., QMK Toolbox or `wb32-dfu-updater_cli`) to flash the `.hex` file corresponding to your desired configuration.

### 2️⃣ VIA Configuration
To use VIA, you may need to manually load the JSON layout file:
1.  Open [VIA](https://usevia.app/).
2.  Enable the **"Design"** tab in Settings.
3.  Upload `VIA Layout.json` (or `VIA Layout ISO.json`) from the `layouts/` folder.

#### Verify the installed custom firmware on macOS

The v1.0.2 ANSI and ISO HEX files use USB device version **1.0.2**. The unversioned HEX files are preserved at **0.0.1**. On macOS, check `bcdDevice` alongside the keyboard name:

```shell
ioreg -p IOUSB -l -w 0 | grep -E 'Royal Kludge R75|bcdDevice|idVendor|idProduct'
```

The USB product ID remains `0xe484` for ANSI or `0xe483` for ISO. macOS reports `bcdDevice = 258` for version `1.0.2` (`bcdDevice = 257` for `1.0.1` and `bcdDevice = 1` for the older `0.0.1`). The device version is separate from the product ID.

### 3️⃣ SignalRGB Setup
1.  Copy [`SignalRGB Plugin for RK R75.js`](plugins/SignalRGB%20Plugin%20for%20RK%20R75.js) to:
    `%userprofile%/Documents/WhirlwindFX/Plugins`
2.  Restart SignalRGB.

### 4️⃣ OpenRGB Setup
1.  Open **OpenRGB**.
2.  Ensure your keyboard is detected.
3.  Configure the settings as shown below:
    
![OpenRGB Settings](assets/OpenRGB%20Setting.png)

---

## 🏗️ Compiling from Source

To build the firmware yourself, you will need to clone the appropriate QMK firmware repository:

- **For OpenRGB & SignalRGB Support**: Use the [OpenSignalRGB-131026 Branch](https://github.com/snakkarike/qmk_firmware/tree/OpenSignalRGB-131026).
- **For Traditional QMK**: Use the [Official QMK Firmware](https://github.com/qmk/qmk_firmware).

On macOS, prepare the isolated QMK checkout and toolchain, then build both layouts:

```shell
make setup-build-env
make build
```

`make build` compiles ANSI (`rk/r75/custom`) and ISO (`rk/r75/customiso`) HEX files in the QMK checkout. To copy them into this repository's `firmware/` directory with version suffixes taken from each keyboard's `device_version`, run:

```shell
make copy-hex
```

The setup target clones the `OpenSignalRGB-131026` QMK branch into `/tmp/r75-qmk-build`, installs the QMK CLI and compiler toolchain under `/tmp`, and stages this repository's ANSI and ISO keyboard sources in that checkout. Use `make clean-build-staging` to remove the copied keyboard sources and generated QMK build outputs while keeping the environment. Use `make clean-build-env` to remove the temporary checkout, CLI, toolchain, and build-installed Homebrew formulas. Homebrew protects formulas required by other installed packages. `make clean-build` and `make clean-all` are aliases for `make clean-build-env`.

---

## ⚠️ Disclaimer
> [!CAUTION]
> This is a custom firmware. While extensively tested, there is always a risk of bricking your device. Use at your own risk.

---

## 🤝 Credits & Thanks
Huge thanks to the original contributors whose work paved the way for this project:
- [@irfanjmdn](https://github.com/irfanjmdn/)
- [@sdk66](https://github.com/sdk66/)
- [@iamdanielv](https://github.com/iamdanielv)

---


<div>
  <i>*Maintained with ❤️ for the mechanical keyboard community.*</i>
  <br/><br/>
  <a href="https://buymeacoffee.com/snakkarike" target="_blank">
    <img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 40px !important;width: 145px !important;" >
  </a>
</div>

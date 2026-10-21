# 🧠 Knowledge Base: Layer Persistence & Power-off Behavior

## Overview

This article explains how the Royal Kludge R75 wired keyboard (and batteryless QMK keyboards in general) handles layer state across power cycles, reboots, and USB reconnections.

---

## 1. Default Layer After Power Off / Restart

On the **Royal Kludge R75 wired keyboard**, whenever the keyboard is disconnected, powered off, or restarted:
* The active layer **always reverts to Layer 0 (Base Windows layout)**.
* Even if you switched to **Layer 3 (Mac mode)** or **Layer 4 (Numpad mode)** prior to unplugging or restarting, the keyboard will boot back into Layer 0.

### Why Does This Happen?

In QMK firmware:
* The layer switching shortcuts on Layer 2 (`F1`, `F2`, `F3`) use QMK's **`TO(n)`** action:
  * `F1` $\rightarrow$ `TO(0)` (Windows Base)
  * `F2` $\rightarrow$ `TO(3)` (Mac mode)
  * `F3` $\rightarrow$ `TO(4)` (Numpad)
* `TO(n)` modifies only the active `layer_state` stored in volatile MCU RAM. It does **not** modify `default_layer_state` in non-volatile memory.
* When the keyboard loses power, the volatile RAM is wiped. On the next startup, QMK initializes `layer_state` from `default_layer_state`, which points to Layer 0.

---

## 2. Can Batteryless QMK Keyboards Have Persistent Layers?

**Yes.** A battery is **not** required for a QMK keyboard to remember settings or layer states across power cycles.

QMK uses non-volatile hardware storage:
* **Microcontrollers with built-in EEPROM** (e.g. ATmega32U4): Write persistent state directly to EEPROM.
* **Modern ARM microcontrollers** (e.g. WB32FQ95 on the R75, RP2040, STM32): Emulate EEPROM using **Wear-Leveling on external or internal SPI Flash memory**.

Data written to EEPROM or Wear-Leveling Flash survives complete disconnection and zero power indefinitely.

---

## 3. Transient vs. Persistent Layer Switching in QMK

| Concept | Keycode / Function | Storage Medium | Survives Power-Off / Unplug? |
| :--- | :--- | :--- | :--- |
| **Transient Layer Activation** | `MO()`, `TO()`, `TG()`, `TT()`, `LT()` | MCU RAM (volatile) | ❌ **No** (Resets to default layer on power off) |
| **Persistent Default Layer** | `DF(layer)` or `set_single_persistent_default_layer()` | EEPROM / SPI Flash (non-volatile) | ✔️ **Yes** (Saved across reboots and unplugs) |

### Why QMK Defaults to Transient Switching for Normal Layers

Writing to non-volatile EEPROM/Flash has finite write endurance cycles (typically 10,000 to 100,000+ writes). To protect the flash memory from premature wear, standard layer commands (`MO`, `TO`, `TG`) operate purely in RAM.

---

## 4. How to Make Mac (or Any Layer) Persistent Across Reboots

If you want the R75 wired keyboard to remember your Mac layout across restarts without resetting to Windows:

### Method A: Modify Firmware Keymap
In `source/keyboards/rk/r75/custom/keymaps/via/keymap.c`, replace `TO(3)` and `TO(0)` with `DF(3)` and `DF(0)` on Layer 2:
```c
    [2] = LAYOUT( /* Options Layer */
        _______,  DF(0),    DF(3),    TO(4),   _______,  _______, ...
    ),
```
* `DF(0)` sets Layer 0 as the persistent default layer in EEPROM/Flash.
* `DF(3)` sets Layer 3 (Mac) as the persistent default layer in EEPROM/Flash.

### Method B: In QMK C Logic
Alternatively, bind a custom keycode or tap dance that calls:
```c
set_single_persistent_default_layer(3); // Writes Layer 3 as default to EEPROM
```

### Method C: Using VIA / Remapping
Using [VIA](https://usevia.app/) or [VIAL](https://get.vial.today/), you can bind the QMK keycode `DF(3)` to any key combination to switch and persist the default layer.

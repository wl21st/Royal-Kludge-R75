# Proposal: Default to Layer 3 Mac on Power-On (v1.0.2)

## Why

Currently, whenever the Royal Kludge R75 is unplugged, powered off, or rebooted, QMK resets volatile runtime layer state to Layer 0 (Windows base layout). macOS users must manually press `Fn` + `Right Shift` + `F2` every time the keyboard reconnects to activate Layer 3 (Mac modifier swap) and turn on the hardware Mac LED indicator. Defaulting to Layer 3 on startup provides an out-of-the-box native macOS experience without requiring repeated manual switching after power cycles.

## What Changes

- Implement startup post-initialization (`keyboard_post_init_user`) in both ANSI (`rk/r75/custom`) and ISO (`rk/r75/customiso`) custom keymaps to activate Layer 3 (`layer_on(3)`) upon boot.
- Leverage the existing `housekeeping_task_user` check (`IS_LAYER_ON(3)`) to automatically light the dedicated Mac LED on startup.
- Maintain existing session-switching behavior:
  - `Fn` + `Right Shift` + `F1` (`TO(0)`) switches to Layer 0 (Windows) and turns off the Mac LED for that session.
  - `Fn` + `Right Shift` + `F2` (`TO(3)`) switches back to Layer 3 (Mac) and turns on the Mac LED.
- Bump firmware USB device version from `1.0.1` to `1.0.2` in `source/keyboards/rk/r75/custom/keyboard.json` and `source/keyboards/rk/r75/customiso/keyboard.json`.
- Compile and build v1.0.2 firmware binaries into `firmware/VIA Plus SignalRGB & OpenRGB Firmware-v1.0.2.hex` and `firmware/VIA Plus SignalRGB & OpenRGB Firmware-ISO-v1.0.2.hex`.
- Document changes in `CHANGELOG.md` under version `[1.0.2]` following Keep a Changelog standards.

## Capabilities

### New Capabilities
- `layout/default-mac-layer`: Automatic activation of Layer 3 (Mac layout overlay) and Mac LED hardware indicator on keyboard boot while preserving runtime layer-switching shortcuts.

### Modified Capabilities
*(None - no previous specs exist for layer defaults)*

## Impact

- **Firmware Source**: `source/keyboards/rk/r75/custom/keymaps/via/keymap.c` and `source/keyboards/rk/r75/customiso/keymaps/via/keymap.c`.
- **Keyboard Metadata**: `source/keyboards/rk/r75/custom/keyboard.json` and `source/keyboards/rk/r75/customiso/keyboard.json` (`usb.device_version`).
- **Release Binaries**: Generates new `firmware/*-v1.0.2.hex` files.
- **Documentation**: Updates `CHANGELOG.md` and `README.md` firmware variant tables.
- **Breaking Changes**: None. Windows users who prefer Layer 0 across reboots can switch with `Fn + Right Shift + F1`.

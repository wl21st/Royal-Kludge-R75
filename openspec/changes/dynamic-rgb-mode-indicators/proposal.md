# Proposal: Dynamic OpenRGB and SignalRGB Mode Indicators

## Why

Currently on Layer 2 (accessed via `Fn` + `Right Shift`), the hotkeys for OpenRGB (`O`) and SignalRGB (`S`) are permanently illuminated in static colors (Cyan and Green) regardless of whether either mode is active or disabled. This leaves users with no visual feedback about which lighting control mode is currently active or whether the keyboard is in built-in hardware mode.

## What Changes

- Update Layer 2 indicator lighting for OpenRGB (`O` key, LED 40) and SignalRGB (`S` key, LED 52).
- When a mode is turned OFF / inactive, the corresponding key glows **Red** (`0xFF, 0x00, 0x00`).
- When a mode is turned ON / active, the corresponding key glows its designated mode color:
  - **OpenRGB ON**: Cyan (`0x00, 0xFF, 0xFF`)
  - **SignalRGB ON**: Green (`0x00, 0xFF, 0x00`)
- If both modes are disabled, both `O` and `S` illuminate in **Red**.

## Capabilities

### New Capabilities
- `lighting/mode-indicators`: Dynamic status indicators for lighting integration modes (OpenRGB and SignalRGB) when inspecting system options on Layer 2.

### Modified Capabilities
*(None - no existing specs present)*

## Impact

- Firmware indicator code in `source/keyboards/rk/r75/custom/keymaps/via/features/indicators.c` and `source/keyboards/rk/r75/customiso/keymaps/via/features/indicators.c`.
- References extern runtime state variables `is_orgb_mode` and `is_srgb_mode`.
- No breaking changes or changes to keymaps/layouts.

# Design: Default Mac Layer on Startup (v1.0.2)

## Context

The Royal Kludge R75 custom QMK firmware uses a 6-layer system. Layer 0 is the base Windows layout, and Layer 3 is an overlay Mac layout where modifiers (Alt and GUI) are swapped, but all alphanumeric and navigation keys are transparent (`KC_TRNS` / `_______`).

Currently, Layer 3 is only activated at runtime by pressing `Fn` + `Right Shift` + `F2` (`TO(3)`). Because `TO(3)` modifies volatile `layer_state` in RAM, any power interruption causes QMK to reset to Layer 0.

## Goals / Non-Goals

**Goals:**
- Automatically activate Layer 3 upon keyboard power-on or USB reconnect.
- Illuminate the physical Mac LED indicator (`LED_MAC_PIN`) at startup.
- Preserve full key fall-through to Layer 0 for all transparent keys.
- Preserve existing runtime session switching (`Fn + Right Shift + F1` for Windows, `F2` for Mac).
- Implement identically across both ANSI (`rk/r75/custom`) and ISO (`rk/r75/customiso`) targets.
- Bump firmware version to `1.0.2` in `keyboard.json`, build updated HEX files, and update documentation / `CHANGELOG.md`.

**Non-Goals:**
- Writing layer switch states to SPI flash/EEPROM during runtime toggle (avoids unnecessary flash wear cycles).
- Altering VIA layer configurations, dynamic keymap bindings, or existing lighting features.

## Decisions

### Decision 1: Use `keyboard_post_init_user()` with `layer_on(3)`
- **Rationale**: QMK provides `keyboard_post_init_user()` as the designated hook called after hardware and USB initialization complete. Calling `layer_on(3)` turns on Layer 3 in `layer_state` over Layer 0. Because Layer 0 remains the active default base layer, all `_______` keys on Layer 3 fall through to Layer 0 transparently.
- **Alternative considered**: `set_single_persistent_default_layer(3)`. Rejected because Layer 3 is an overlay rather than a full base layer; setting Layer 3 as the sole default layer causes transparent keys to emit nothing.

### Decision 2: Automatic Mac LED indicator via existing `housekeeping_task_user()`
- **Rationale**: `housekeeping_task_user()` already checks `if (IS_LAYER_ON(2) || IS_LAYER_ON(3))` and drives `LED_MAC_PIN` low (ON). Because `layer_on(3)` sets `IS_LAYER_ON(3)` to true at startup, the LED illuminates immediately without requiring additional GPIO logic.
- **Alternative considered**: Manually asserting GPIO in startup hook. Rejected as redundant and potentially conflicting with the housekeeping task.

### Decision 3: Zero-wear volatile layer switching
- **Rationale**: Keeping layer changes in RAM eliminates flash write wear on the SPI flash chip. Since the user's primary workstation is macOS, booting unconditionally into Mac mode satisfies the primary workflow while retaining instant `TO(0)` switching for temporary Windows sessions.

## Risks / Trade-offs

- **[Risk] User temporarily switches to Windows layout with `Fn + Right Shift + F1` and re-plugs expecting Windows mode.**
  → *Mitigation*: Documented in README and CHANGELOG that the firmware default power-on layout is Mac (Layer 3), and switching to Layer 0 is a session override.

## Migration Plan

1. Compile firmware HEX files using `make copy-hex` (producing `VIA Plus SignalRGB & OpenRGB Firmware-v1.0.2.hex` and `-ISO-v1.0.2.hex`).
2. Flash keyboard using existing flashing procedures (`make build` / DFU updater).
3. Rollback: Users can reflash `v1.0.1` or `v1.0.0` HEX binaries from `firmware/` if they prefer the original Windows-default behavior.

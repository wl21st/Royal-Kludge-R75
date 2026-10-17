# Design: Dynamic OpenRGB and SignalRGB Mode Indicators

## Context

See `proposal.md` for background and motivation.

In the custom R75 QMK codebase (`source/keyboards/rk/r75/custom/` and `source/keyboards/rk/r75/customiso/`), mode variables `is_orgb_mode` and `is_srgb_mode` track the active integration state. In `indicators.c`, `rgb_matrix_indicators_advanced_user` executes on every frame to render key highlights when layers are active.

Currently, on Layer 2 (`IS_LAYER_ON(2)`), LED 40 (`O`) and LED 52 (`S`) are colored with static cyan and green values.

## Goals / Non-Goals

**Goals:**
- Dynamically reflect runtime values of `is_orgb_mode` and `is_srgb_mode` on key LEDs 40 and 52 during Layer 2 inspection.
- Maintain preprocessor guards (`OPENRGB_ENABLE`, `SIGNALRGB_SUPPORT_ENABLE`) to preserve portability across build configurations.
- Ensure zero latency updates when toggling modes via `SWITCH_MODE` or `SIGNAL_MODE`.

**Non-Goals:**
- Modifying standard matrix animations or effect logic when outside Layer 2.
- Changing keycode bindings or layer switching mechanics.

## Decisions

### Decision 1: Use Option A (Feature accent color for ON, Red for OFF)
- **Rationale**: Keeps key colors aligned with existing layer indicator conventions (O = Cyan, S = Green) while providing a distinct contrast (Red) when inactive.
- **Alternatives Considered**: 
  - Dynamic HSV match (Option B): Sample live matrix HSV for ON state. Rejected because Layer 2 clears matrix LEDs to black, making sample context inconsistent.

### Decision 2: Reference extern flags directly in `indicators.c`
- **Rationale**: `is_orgb_mode` and `is_srgb_mode` are already global uint8_t variables defined in the firmware. Declaring `extern uint8_t is_orgb_mode;` and `extern uint8_t is_srgb_mode;` in `indicators.c` avoids changing header dependencies or adding boilerplate getter functions.
- **Alternatives Considered**: Creating accessor functions in `keymap.c`. Rejected as unnecessary overhead in embedded C codebase.

## Risks / Trade-offs

- **[Risk] Unused variable compiler warning if flags are enabled but not referenced**:
  - *Mitigation*: Wrap extern declarations or logic with `#ifdef OPENRGB_ENABLE` and `#ifdef SIGNALRGB_SUPPORT_ENABLE`.
- **[Risk] Syncing ANSI and ISO custom variants**:
  - *Mitigation*: Apply the exact same logic to both `custom/keymaps/via/features/indicators.c` and `customiso/keymaps/via/features/indicators.c`.

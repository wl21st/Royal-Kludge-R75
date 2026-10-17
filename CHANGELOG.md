# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.1] - 2026-10-17

### Fixed
- Corrected LED indicator indexes in `rgb_keys.c` for both ANSI and ISO custom keymaps:
  - `RGB_HUD`: Changed target LED from 40 (`O`) to 41 (`I`).
  - `RGB_SAD`: Changed target LED from 59 (`L`) to 58 (`K`).
  - `RGB_VAD`: Changed target LED from 66 (`.`) to 67 (`,`).
- Realigned step indicator blink triggers in `rgb_keys.c` (`RGB_SAI`, `RGB_SAD`, `RGB_VAI`, `RGB_VAD`) so white indicator flashes occur on key press when within valid range, rather than on key release.

## [1.0.0] - 2026-10-17

### Added
- Dynamic external lighting indicators on Layer 2 (`Fn` + `Right Shift`):
  - Key `O` (LED 40) illuminates Cyan when OpenRGB mode is active, Red when disabled.
  - Key `S` (LED 52) illuminates Green when SignalRGB mode is active, Red when disabled.
- Versioned custom firmware images (`1.0.0` device version / `bcdDevice = 256`).

### Changed
- Modernized QMK keycode aliases in `defines.h` mapping legacy `RGB_*` codes to current `RM_*` symbols.
- Removed legacy `quantum_keycodes_legacy.h` include in favor of `defines.h`.

### Fixed
- Resolved `RGB_MATRIX_LED_COUNT` redefinition warning on ISO builds by undefining before definition.

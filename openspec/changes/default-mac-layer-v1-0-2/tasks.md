# Tasks

## 1. Firmware Startup Layer Hook

- [ ] 1.1 Add `keyboard_post_init_user(void)` calling `layer_on(3)` to `source/keyboards/rk/r75/custom/keymaps/via/keymap.c` (ANSI) and verify syntax.
- [ ] 1.2 Add `keyboard_post_init_user(void)` calling `layer_on(3)` to `source/keyboards/rk/r75/customiso/keymaps/via/keymap.c` (ISO) and verify syntax.

## 2. Version Bump & Firmware Build

- [ ] 2.1 Bump `usb.device_version` to `1.0.2` in `source/keyboards/rk/r75/custom/keyboard.json` and `source/keyboards/rk/r75/customiso/keyboard.json`.
- [ ] 2.2 Run `make copy-hex` to compile firmware and verify both `firmware/VIA Plus SignalRGB & OpenRGB Firmware-v1.0.2.hex` and `firmware/VIA Plus SignalRGB & OpenRGB Firmware-ISO-v1.0.2.hex` are generated.

## 3. Documentation & Changelog

- [ ] 3.1 Add release notes for `[1.0.2]` to `CHANGELOG.md` following Keep a Changelog formatting.
- [ ] 3.2 Update `README.md` firmware variants table and usage notes to reflect v1.0.2 and default Mac layer behavior.

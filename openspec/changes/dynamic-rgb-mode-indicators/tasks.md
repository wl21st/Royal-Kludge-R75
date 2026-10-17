# Tasks

## 1. Implement Dynamic Indicators in ANSI Custom Firmware

- [ ] 1.1 In `source/keyboards/rk/r75/custom/keymaps/via/features/indicators.c`, declare extern references for `is_orgb_mode` and `is_srgb_mode` and verify syntax
- [ ] 1.2 In `source/keyboards/rk/r75/custom/keymaps/via/features/indicators.c`, update the Layer 2 rendering logic so key O (LED 40) illuminates Cyan when `is_orgb_mode` is true and Red when false
- [ ] 1.3 In `source/keyboards/rk/r75/custom/keymaps/via/features/indicators.c`, update the Layer 2 rendering logic so key S (LED 52) illuminates Green when `is_srgb_mode` is true and Red when false

## 2. Implement Dynamic Indicators in ISO Custom Firmware

- [ ] 2.1 In `source/keyboards/rk/r75/customiso/keymaps/via/features/indicators.c`, declare extern references for `is_orgb_mode` and `is_srgb_mode` and verify syntax
- [ ] 2.2 In `source/keyboards/rk/r75/customiso/keymaps/via/features/indicators.c`, update the Layer 2 rendering logic for key O (LED 40) to Cyan when active and Red when disabled
- [ ] 2.3 In `source/keyboards/rk/r75/customiso/keymaps/via/features/indicators.c`, update the Layer 2 rendering logic for key S (LED 52) to Green when active and Red when disabled

## 3. Documentation

- [ ] 3.1 Update `README.md` to document the dynamic red/active color behavior on Layer 2 for keys O and S

.DEFAULT_GOAL := help

QMK_REPO_URL := https://github.com/snakkarike/qmk_firmware.git
QMK_REPO_BRANCH := OpenSignalRGB-2026
QMK_BUILD_DIR := /tmp/r75-qmk-build
QMK_UV_INSTALL_DIR := /tmp/r75-qmk-uv
QMK_UV_TOOL_DIR := /tmp/r75-qmk-uv-tools
QMK_DISTRIB_DIR := /tmp/r75-qmk-distrib
QMK_BREW_BASELINE := /tmp/r75-qmk-brew-before.txt
QMK_BREW_AFTER := /tmp/r75-qmk-brew-after.txt
QMK_BREW_ADDED := /tmp/r75-qmk-brew-added.txt
QMK_TOOLCHAIN := $(QMK_DISTRIB_DIR)/bin/arm-none-eabi-gcc
QMK_CLI := $(QMK_UV_TOOL_DIR)/qmk/bin/qmk
ANSI_FIRMWARE_VERSION := $(shell python3 -c 'import json; print(json.load(open("source/keyboards/rk/r75/custom/keyboard.json"))["usb"]["device_version"])')
ISO_FIRMWARE_VERSION := $(shell python3 -c 'import json; print(json.load(open("source/keyboards/rk/r75/customiso/keyboard.json"))["usb"]["device_version"])')
QMK_BUILD_PATH := $(QMK_DISTRIB_DIR)/bin:$(QMK_UV_TOOL_DIR)/qmk/bin:/opt/homebrew/opt/make/libexec/gnubin:$(PATH)

QMK_BUILD_TEMP_PATHS := \
	$(QMK_BUILD_DIR) \
	$(QMK_UV_INSTALL_DIR) \
	$(QMK_UV_TOOL_DIR) \
	$(QMK_DISTRIB_DIR) \
	$(QMK_BREW_BASELINE) \
	$(QMK_BREW_AFTER) \
	$(QMK_BREW_ADDED)

QMK_LEGACY_BREW_FORMULAE := \
	arm-none-eabi-gcc \
	arm-none-eabi-binutils \
	isl \
	mpfr \
	libmpc \
	make

.PHONY: help setup-build-env build copy-hex clean-build-env clean-build-staging clean-build-tools clean-build-temp clean-build clean-all

help:
	@printf '%s\n' \
		'Available targets:' \
		'  help                Show this help message (default).' \
		'  setup-build-env     Prepare the isolated QMK checkout and toolchain.' \
		'  build               Compile ANSI and ISO firmware HEX files.' \
		'  copy-hex            Build and copy versioned HEX files into firmware/.' \
		'  clean-build-staging Remove staged keyboard sources and generated build outputs.' \
		'  clean-build-tools   Remove build formulas installed by setup-build-env.' \
		'  clean-build-temp    Remove temporary QMK build environment files.' \
		'  clean-build-env     Remove staged files, temporary environment, and build tools.' \
		'  clean-build         Alias for clean-build-env.' \
		'  clean-all           Alias for clean-build-env.'

setup-build-env:
	@command -v git >/dev/null 2>&1 || { echo "git is required" >&2; exit 1; }
	@command -v brew >/dev/null 2>&1 || { echo "Homebrew is required on macOS" >&2; exit 1; }
	@if [ -e "$(QMK_BUILD_DIR)" ]; then \
		if [ ! -d "$(QMK_BUILD_DIR)/.git" ] || \
		   [ "$$(git -C "$(QMK_BUILD_DIR)" remote get-url origin)" != "$(QMK_REPO_URL)" ]; then \
			echo "Refusing to reuse $(QMK_BUILD_DIR): it is not the expected QMK checkout" >&2; exit 1; \
		fi; \
		if [ "$$(git -C "$(QMK_BUILD_DIR)" branch --show-current)" != "$(QMK_REPO_BRANCH)" ]; then \
			echo "Refusing to switch the existing QMK checkout; clean it or restore branch $(QMK_REPO_BRANCH)" >&2; exit 1; \
		fi; \
	else \
		git clone --recurse-submodules --depth 1 --branch "$(QMK_REPO_BRANCH)" "$(QMK_REPO_URL)" "$(QMK_BUILD_DIR)"; \
	fi
	@git -C "$(QMK_BUILD_DIR)" submodule update --init --recursive
	$(MAKE) clean-build-staging
	@if [ ! -f "$(QMK_BREW_BASELINE)" ]; then brew list --formula --full-name | sort > "$(QMK_BREW_BASELINE)"; fi
	@HOMEBREW_NO_AUTO_UPDATE=1 brew install make zstd
	@brew list --formula --full-name | sort > "$(QMK_BREW_AFTER)"
	@comm -13 "$(QMK_BREW_BASELINE)" "$(QMK_BREW_AFTER)" > "$(QMK_BREW_ADDED)"
	@if [ ! -x "$(QMK_CLI)" ] || [ ! -x "$(QMK_TOOLCHAIN)" ]; then \
		CONFIRM=1 \
		UV_INSTALL_DIR="$(QMK_UV_INSTALL_DIR)" \
		UV_TOOL_DIR="$(QMK_UV_TOOL_DIR)" \
		QMK_DISTRIB_DIR="$(QMK_DISTRIB_DIR)" \
		sh "$(QMK_BUILD_DIR)/util/env-bootstrap.sh" --confirm --skip-package-manager; \
	fi
	@for variant in custom customiso; do \
		destination="$(QMK_BUILD_DIR)/keyboards/rk/r75/$$variant"; \
		rm -rf "$$destination"; \
		mkdir -p "$(QMK_BUILD_DIR)/keyboards/rk/r75"; \
		cp -R "source/keyboards/rk/r75/$$variant" "$$destination"; \
		done
	@printf 'Build environment is ready at %s\n' "$(QMK_BUILD_DIR)"
	@printf 'QMK CLI: %s\n' "$(QMK_CLI)"
	@printf 'Run make build to compile both firmware layouts.\n'

build: setup-build-env
	cd "$(QMK_BUILD_DIR)" && PATH="$(QMK_BUILD_PATH)" "$(QMK_CLI)" compile -j 4 -kb rk/r75/custom -km via
	cd "$(QMK_BUILD_DIR)" && PATH="$(QMK_BUILD_PATH)" "$(QMK_CLI)" compile -j 4 -kb rk/r75/customiso -km via

copy-hex: build
	mkdir -p firmware
	cp "$(QMK_BUILD_DIR)/.build/rk_r75_custom_via.hex" "firmware/VIA Plus SignalRGB & OpenRGB Firmware-v$(ANSI_FIRMWARE_VERSION).hex"
	cp "$(QMK_BUILD_DIR)/.build/rk_r75_customiso_via.hex" "firmware/VIA Plus SignalRGB & OpenRGB Firmware-ISO-v$(ISO_FIRMWARE_VERSION).hex"

clean-build-env:
	$(MAKE) clean-build-staging
	@tools_status=0; temp_status=0; \
	$(MAKE) clean-build-tools || tools_status=$$?; \
	if [ -e "$(QMK_BUILD_DIR)" ] && \
	   { [ ! -d "$(QMK_BUILD_DIR)/.git" ] || \
	     [ "$$(git -C "$(QMK_BUILD_DIR)" remote get-url origin)" != "$(QMK_REPO_URL)" ]; }; then \
		echo "Refusing to remove unexpected directory: $(QMK_BUILD_DIR)" >&2; temp_status=1; \
	else \
		for path in $(QMK_BUILD_TEMP_PATHS); do \
			if [ -e "$$path" ]; then \
				printf 'Removing %s\n' "$$path"; \
				rm -rf "$$path" || temp_status=1; \
			fi; \
		done; \
	fi; \
	if [ "$$tools_status" -ne 0 ] || [ "$$temp_status" -ne 0 ]; then \
		echo "Build cleanup finished with errors; see the messages above" >&2; exit 1; \
	fi

clean-build-staging:
	@if [ -e "$(QMK_BUILD_DIR)" ]; then \
		if [ ! -d "$(QMK_BUILD_DIR)/.git" ] || \
		   [ "$$(git -C "$(QMK_BUILD_DIR)" remote get-url origin)" != "$(QMK_REPO_URL)" ]; then \
			echo "Refusing to remove staging files from an unexpected directory: $(QMK_BUILD_DIR)" >&2; exit 1; \
		fi; \
		printf 'Removing QMK build outputs and staged keyboard sources from %s\n' "$(QMK_BUILD_DIR)"; \
		rm -rf "$(QMK_BUILD_DIR)/.build" \
			"$(QMK_BUILD_DIR)/keyboards/rk/r75/custom" \
			"$(QMK_BUILD_DIR)/keyboards/rk/r75/customiso"; \
		rm -f "$(QMK_BUILD_DIR)/rk_r75_custom_via.bin" \
			"$(QMK_BUILD_DIR)/rk_r75_customiso_via.bin"; \
	fi

clean-build-tools:
	@command -v brew >/dev/null 2>&1 || { echo "Homebrew is required to remove build formulas" >&2; exit 1; }
	@set -u; failed=0; \
	if [ -s "$(QMK_BREW_ADDED)" ]; then \
		printf 'Uninstalling Homebrew formulas installed by setup-build-env\n'; \
		xargs brew uninstall < "$(QMK_BREW_ADDED)" || failed=1; \
	fi; \
	for formula in $(QMK_LEGACY_BREW_FORMULAE); do \
		if brew list --versions "$$formula" >/dev/null 2>&1; then \
			brew uninstall "$$formula" || failed=1; \
		fi; \
	done; \
	exit $$failed

clean-build-temp:
	@set -eu; \
	if [ -e "$(QMK_BUILD_DIR)" ] && \
	   { [ ! -d "$(QMK_BUILD_DIR)/.git" ] || \
	     [ "$$(git -C "$(QMK_BUILD_DIR)" remote get-url origin)" != "$(QMK_REPO_URL)" ]; }; then \
		echo "Refusing to remove unexpected directory: $(QMK_BUILD_DIR)" >&2; exit 1; \
	fi; \
	for path in $(QMK_BUILD_TEMP_PATHS); do \
		if [ -e "$$path" ]; then \
			printf 'Removing %s\n' "$$path"; \
			rm -rf "$$path"; \
		fi; \
	done

# Backward-compatible alias for the original cleanup target.
clean-build: clean-build-env

# Convenient alias for removing the full build environment.
clean-all: clean-build-env

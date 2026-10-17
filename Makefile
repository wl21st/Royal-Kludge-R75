QMK_BUILD_TEMP_DIRS := \
	/tmp/r75-qmk-build \
	/tmp/r75-qmk-uv \
	/tmp/r75-qmk-uv-tools \
	/tmp/r75-qmk-distrib

QMK_BUILD_BREW_FORMULAE := \
	arm-none-eabi-gcc \
	arm-none-eabi-binutils \
	isl \
	mpfr \
	libmpc \
	make

.PHONY: clean-build clean-build-temp clean-build-tools

clean-build: clean-build-temp clean-build-tools

clean-build-temp:
	@set -eu; \
	for path in $(QMK_BUILD_TEMP_DIRS); do \
		if [ -e "$$path" ]; then \
			printf 'Removing %s\n' "$$path"; \
			rm -rf "$$path"; \
		fi; \
	done

clean-build-tools:
	@command -v brew >/dev/null 2>&1 || { echo "Homebrew is required to remove the build tool formulas" >&2; exit 1; }
	@set -eu; \
	installed=""; \
	for formula in $(QMK_BUILD_BREW_FORMULAE); do \
		if brew list --versions "$$formula" >/dev/null 2>&1; then \
			installed="$$installed $$formula"; \
		fi; \
	done; \
	if [ -n "$$installed" ]; then \
		brew uninstall $$installed; \
	else \
		printf 'No build-specific Homebrew formulas are installed.\n'; \
	fi

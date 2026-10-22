# Spec Delta: Default Mac Layer

## Purpose

Enables the keyboard to start up in Mac mode (Layer 3) with the hardware Mac LED indicator active by default upon power-on, while retaining runtime layer switching shortcuts.

## ADDED Requirements

### Requirement: Startup layer defaults to Mac mode
The keyboard firmware SHALL automatically activate Layer 3 (Mac layout overlay) upon completion of hardware startup and USB initialization.

#### Scenario: Keyboard powered on or reconnected
- **WHEN** the keyboard is plugged into a USB port or power is restored
- **THEN** Layer 3 is active immediately without requiring manual keypresses
- **AND** Left Alt and Left Command (GUI) keys operate swapped for macOS compatibility
- **AND** keys transparent on Layer 3 fall through to Layer 0

### Requirement: Hardware Mac LED indicator aligns with startup mode
The firmware SHALL illuminate the physical Mac LED indicator whenever Layer 3 is active, including immediately following power-on initialization.

#### Scenario: Hardware Mac LED status at startup
- **WHEN** the keyboard boots up and enters Layer 3
- **THEN** the physical Mac LED indicator is turned ON

### Requirement: Runtime session switching remains functional
The firmware SHALL continue to support runtime switching between Windows mode (Layer 0) and Mac mode (Layer 3) using standard options shortcuts during the active session.

#### Scenario: Switching to Windows mode during a session
- **WHEN** the user holds `Fn` and `Right Shift` to enter Layer 2 and presses `F1`
- **THEN** the firmware clears active higher layers and switches to Layer 0
- **AND** the physical Mac LED indicator turns OFF

#### Scenario: Switching back to Mac mode during a session
- **WHEN** the user holds `Fn` and `Right Shift` to enter Layer 2 and presses `F2`
- **THEN** the firmware activates Layer 3
- **AND** the physical Mac LED indicator turns ON

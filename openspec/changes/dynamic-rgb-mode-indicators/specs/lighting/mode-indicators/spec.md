# Spec Delta: lighting/mode-indicators

## Purpose

Provides dynamic visual lighting indicators on Layer 2 for external lighting control modes (OpenRGB and SignalRGB).

## ADDED Requirements

### Requirement: OpenRGB Mode Key Indicator State
When Layer 2 is active, the keyboard firmware SHALL illuminate key O (LED index 40) according to the runtime state of OpenRGB mode.

#### Scenario: OpenRGB is active
- **WHEN** the user holds Fn + Right Shift to enter Layer 2 AND OpenRGB mode is enabled
- **THEN** key O illuminates in Cyan (#00FFFF)

#### Scenario: OpenRGB is disabled
- **WHEN** the user holds Fn + Right Shift to enter Layer 2 AND OpenRGB mode is disabled
- **THEN** key O illuminates in Red (#FF0000)

### Requirement: SignalRGB Mode Key Indicator State
When Layer 2 is active, the keyboard firmware SHALL illuminate key S (LED index 52) according to the runtime state of SignalRGB mode.

#### Scenario: SignalRGB is active
- **WHEN** the user holds Fn + Right Shift to enter Layer 2 AND SignalRGB mode is enabled
- **THEN** key S illuminates in Green (#00FF00)

#### Scenario: SignalRGB is disabled
- **WHEN** the user holds Fn + Right Shift to enter Layer 2 AND SignalRGB mode is disabled
- **THEN** key S illuminates in Red (#FF0000)

### Requirement: Real-time Indicator Feedback on Toggle
When on Layer 2 and the user presses O or S to toggle lighting modes, the indicator colors SHALL update on the very next render frame.

#### Scenario: Toggling OpenRGB ON
- **WHEN** OpenRGB is toggled ON via key O while holding Layer 2
- **THEN** key O immediately updates from Red to Cyan, and key S immediately updates to Red

#### Scenario: Toggling SignalRGB ON
- **WHEN** SignalRGB is toggled ON via key S while holding Layer 2
- **THEN** key S immediately updates from Red to Green, and key O immediately updates to Red

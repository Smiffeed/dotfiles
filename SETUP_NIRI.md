# Niri Setup Guide

This guide details all the specific configurations and fixes applied to this Niri-based Linux installation to achieve the exact experience mapped out in these dotfiles.

## 1. Kanata Keyboard Configuration
- **Native Device Detection**: Kanata ignores mouse buttons by default. To make it listen to the side buttons of the mouse (for macros), the configuration specifically targets the mouse devices using `linux-dev-names-include` in `config.kbd`.
  - **Identified Devices**: "Logitech USB Receiver" and "E9".
- **Stardew Valley Animation Cancel Macro**: 
  - Bound to `mbck` (Mouse Backward side button).
  - Uses native Kanata layer-switching to prevent macro overlaps when the button is spammed. It instantly switches to a `stardew-cd` (cooldown) layer where the trigger button is disabled until the macro finishes executing.
  - No external bloat (`ydotool`, `wtype`, `xdotool`) is required since Wayland/Stardew ignore virtual keyboards. Kanata injects directly at the kernel `evdev` level.
- **Nav Layer (Capslock)**:
  - Capslock acts as Backspace when tapped, and `nav` layer when held.
  - In `nav` layer:
    - `s` = `Shift`
    - `d` = `Ctrl`
    - `f` = `Escape`
    - `h`, `j`, `k`, `l` = Left, Down, Up, Right
    - `c` = `Capslock Toggle` (Since the physical Capslock key is overridden, holding Capslock + `c` toggles the hardware Capslock state on/off).

## 2. Display and Brightness
- **Backlight Control**: Niri's `XF86MonBrightnessUp` and `Down` keys are mapped to `brightnessctl`.
  - **Required Package**: `brightnessctl` (`sudo dnf install brightnessctl`).
- **AMD Vari-Bright (Adaptive Brightness)**: 
  - AMD's power-saving feature randomly adjusts brightness on battery based on screen content. 
  - Disabled by appending `amdgpu.abmlevel=0` to the kernel boot parameters using GRUB.
  - **Command**: `sudo grubby --update-kernel=ALL --args="amdgpu.abmlevel=0"`

## 3. Emoji Picker (Bemoji & Niri)
- `bemoji` is mapped to `Mod + .` in Niri.
- Instead of using a clunky clipboard `Ctrl+V` paste script, `bemoji` uses the native `-t` (type) flag to inject emojis directly into the active text field.
- **Required Package**: `wtype` (`sudo dnf install wtype`) is strictly required for `bemoji -t` to function on Wayland.

## 4. Theming (Atomic Deep Dark)
- **Mako (Notifications)**: 
  - Standardized the text color to match the Deep Dark palette (`#abb2bf` / `#ffffff`).
  - Specifically removed the `urgency=critical` text color override (`#e06c75` red), as many applications abuse the critical urgency level and annoyingly turn normal notifications red.
- **Yazi (File Manager)**:
  - Default pastel colors (Catppuccin-like) were too bright.
  - Created a custom Yazi flavor named `atomic` in `~/.config/yazi/flavors/atomic.yazi/flavor.toml`.
  - Configured `yazi.toml` to load the flavor using `[flavor] dark = "atomic"` and `light = "atomic"`.
  - The colors match the One Dark/Atomic palette defined globally in `foot` and `mako` (Background: `#121317`, Foreground: `#abb2bf`, Accent Blue: `#61afef`, etc.).

## 5. Oh My Tmux Customization
To replicate the perfectly integrated Atomic Deep Dark terminal experience with Powerline arrows and transparent backgrounds:
- **Theme Adjustments**: The `tmux.conf.local` uses the standard Atomic palette (Blue `#4d8cbf`, Purple `#9e60b0`, Green `#799c60`, Yellow `#b79962`, Red `#b3565d`), with brightness mathematically dimmed by ~20% for a softer aesthetic.
- **Powerline Transparent Bug**: When using `default` for transparent backgrounds, Powerline arrows will glitch out and inherit wrong colors. To fix this, you must explicitly assign the terminal's native background color (`#121317`) to `tmux_conf_theme_status_bg`, `tmux_conf_theme_window_status_bg` and the far-right section (`tmux_conf_theme_colour_15`).
- **Clean UI**: The mouse indicator `↗` is intentionally cleared from `tmux_conf_theme_mouse` to keep the right status bar minimal.

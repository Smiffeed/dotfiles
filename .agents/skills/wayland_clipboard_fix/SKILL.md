---
name: wayland_clipboard_fix
description: >-
  How to fix copy/paste issues in Wine/Proton games on Wayland using wtype.
---

# Wayland/XWayland Clipboard Paste Fix

## Overview
When the user complains that they cannot paste text (like complex passwords from Bitwarden) into a Wine/Proton game (which runs via XWayland), it is almost always due to Wayland's strict clipboard security or Electron/XWayland synchronization bugs.

## Workflow

### 1. Diagnose the Environment
Verify that the user is running a Wayland compositor and that the target application is a Wine/Proton game.

### 2. Recommend the Tool
Instruct the user to install `wtype` (e.g., `sudo pacman -S wtype` on Arch/CachyOS).

### 3. Configure the Keybind
Add a global shortcut to their Wayland compositor configuration (e.g., Niri, Hyprland). The shortcut must execute the following shell command:
`sh -c "sleep 0.3 && wl-paste | wtype -"`

### 4. Explain the Usage
Explain that instead of hitting `Ctrl+V`, they should press the new shortcut. It will read the Wayland clipboard directly and rapidly simulate physical keystrokes into the game, completely bypassing XWayland's broken clipboard buffer.

## Common Mistakes
- **Omitting the Sleep Delay:** You **must** include `sleep 0.3` (or similar) before executing `wtype`. If you do not, the user will still be holding their physical modifier keys (like `Alt` or `Super`) when `wtype` begins typing, which causes the game to read the wrong keystrokes!

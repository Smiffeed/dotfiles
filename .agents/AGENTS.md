# Antigravity Agents for Dotfiles

This directory contains definitions and skills for AI agents to help manage this dotfiles repository.

## Subsystem Directory Map

- **Compositor (Niri)**:
  - Top-level config: `niri/.config/niri/config.kdl`
  - Modular includes: `niri/.config/niri/cfg/` (`autostart.kdl`, `keybinds.kdl`, `input.kdl`, `display.kdl`, `layout.kdl`, `rules.kdl`, `misc.kdl`)
- **Shells, Bars & Panels**:
  - Noctalia (CachyOS desktop): `noctalia/.config/noctalia/`
  - Waybar (laptop): `waybar/.config/waybar/`
  - Multi-machine bar switcher: `niri/.local/bin/bar-autostart`
  - Universal volume/launcher helper: `niri/.local/bin/desktop-helper`
- **Application Launchers & Search**:
  - Fuzzel config: `fuzzel/.config/fuzzel/fuzzel.ini`
  - File search tool (`Mod+S`): `niri/.local/bin/fuzzel-find`
  - Window switcher (`Mod+U`): `niri/.config/niri/scripts/fuzzel-window-switch.sh`
  - Emoji picker (`Mod+.`): `bemoji/.local/bin/bemoji`
- **Terminal & Shell**:
  - Foot terminal: `foot/.config/foot/foot.ini`
  - ZSH shell: `zsh/.zshrc` (smart jump with `zoxide`)
  - Multiplexer: `tmux/.tmux.conf`
- **File Manager & Chooser Portal**:
  - Yazi file manager: `yazi/.config/yazi/` (`yazi.toml`, `keymap.toml`, `package.toml`)
  - Desktop portal file chooser wrapper: `yazi/.config/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh`
- **System Roots & Paths**:
  - Workspaces root: `~/Workspaces` (symlinked via `~/Workspace -> ~/Workspaces`)
  - Validation script: `./check.sh`

## Available Skills

- **deploy_dotfiles**: Instructions for agents to safely deploy configurations to the user's home directory using GNU Stow.
- **add_dotfile**: Guidelines for extracting an existing configuration from the home directory and setting it up as a new package here.
- **sync_dotfiles**: Instructions on how to commit and push changes using the provided `push.sh` script.

## Coding Standards

Review [CODING_STANDARDS.md](../CODING_STANDARDS.md) for architectural guidelines, Wayland dmenu best practices, and script standards.

## Interaction Rules

- **Configuration Safety & Conflict Warning**: Before executing any user prompt that modifies keybinds, layouts, or system configurations, always analyze the current configuration to identify potential conflicts (e.g., remapping a key that is already used for an essential function). If a conflict or potential user error is detected in the prompt, DO NOT blindly execute the change. STOP and explicitly warn the user about the consequences, and propose a safer alternative.
- **Validation Before Hand-off**: Always run `./check.sh` after modifying dotfiles or scripts. Any changes to interactive launcher scripts (Fuzzel, Wayland helpers) must be smoke-tested with a non-blocking timeout test to confirm the process launches cleanly without crashing or exiting with errors.
- **Delayed Git Push Protocol**: When modifying dotfile configurations, DO NOT automatically commit and push the changes. You must wait for the user to explicitly confirm that the configuration works on their machine. If the user asks you to start a new, unrelated task and you have unpushed configuration changes from the previous task, you MUST warn the user that they forgot to instruct you to push the changes, and ask if they want to push before proceeding.
- **Atomic Commits Discipline**: When syncing dotfiles, split independent tool changes into separate, focused Conventional Commits (`type(scope): description`) rather than bundling everything into one commit.
- **Niri and Noctalia Shell Restarts**: If you reload Niri (`niri msg action load-config-file`), it may disrupt the Noctalia shell layer (which draws the wallpaper and top bar). If you ever need to restart Noctalia, you MUST do so through Niri's spawn command (`niri msg action spawn -- noctalia -d`) rather than a raw background bash command, to ensure it inherits the correct Wayland environment.
- **Obsidian Notes Location**: Whenever the user instructs you to "note in obsidian" or save a note for them, always write the markdown file to the `~/Workspaces/Obsidian-Notes` directory.

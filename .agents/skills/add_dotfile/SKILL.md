---
name: add_dotfile
description: How to add a new dotfile package
---

# Add a New Dotfile Package

To add a new application configuration to this repository and manage it with GNU Stow:

1. Determine the path of the original configuration (e.g., `~/.config/foot`).
2. Create a mirrored directory structure inside the dotfiles repository: 
   `mkdir -p ~/Workspace/dotfiles/<package_name>/.config/`
3. Move the real configuration into the dotfiles directory: 
   `mv ~/.config/<package_name> ~/Workspace/dotfiles/<package_name>/.config/`
4. Stow it back to create symlinks: 
   `cd ~/Workspace/dotfiles && stow -v -t ~ <package_name>`

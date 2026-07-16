---
name: deploy_dotfiles
description: How to deploy dotfiles using GNU Stow
---

# Deploy Dotfiles

This repository manages configuration files using GNU Stow.

## Instructions
To deploy or update configurations for a specific package (e.g. `niri`, `waybar`):
1. Navigate to the dotfiles workspace: `cd ~/Workspace/dotfiles`
2. If the package has not been stowed yet, ensure existing config directories are backed up or removed first (e.g., `rm -rf ~/.config/niri`).
3. Run stow: `stow -v -t ~ <package_name>`
4. If updating existing links or adding new loose files inside an already tracked package, use Restow: `stow -R -v -t ~ <package_name>`

Never overwrite physical directories that Stow complains about; delete them or move them aside first.

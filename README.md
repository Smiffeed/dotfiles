# My Minimal Wayland Dotfiles

## 📌 About This Repository

This is a personal configuration space tailored specifically to my workflow, taste, and hardware setup. While it is built for my own daily use, I've made it public—if you are curious, you are more than welcome to look around and borrow anything you find useful!

This setup is a curated blend of various community configurations that I have combined, heavily tweaked, and customized. I have adjusted color themes, optimized application layouts, and hooked up my favorite minimalist tools to build my perfect desktop environment. 

**Note for myself and others:** This is an ongoing work in progress. These instructions serve as both an installation guideline and a personal reference for the future.

---

## 🧰 Tools & Software

This setup heavily relies on modern Wayland-native and terminal-centric tools for speed and minimalism:

| Category | Tool / Software | Notes |
| :--- | :--- | :--- |
| **Compositor** | [Niri](https://github.com/YaLTeR/niri) | Scrollable-tiling Wayland compositor |
| **Terminal** | [Foot](https://codeberg.org/dnkl/foot) | Fast, lightweight, Wayland-native terminal emulator |
| **App Launcher** | [Fuzzel](https://codeberg.org/dnkl/fuzzel) | Application launcher for Wayland |
| **File Manager** | [Yazi](https://github.com/sxyazi/yazi) | Blazing fast terminal file manager |
| **Emoji Picker** | [Bemoji](https://github.com/marty-oehme/bemoji) | Configured with auto-paste bypass for Wayland |
| **Lock / Power** | [wlogout](https://github.com/ArtsyMacaw/wlogout) | Wayland logout menu |
| **Keyboard Mod** | [Kanata](https://github.com/jtroo/kanata) | Advanced software keyboard remapping |
| **Browser** | [Brave](https://brave.com/) | Primary web browser |
| **Notes** | [Obsidian](https://obsidian.md/) | PKM tool (uses custom CSS for emoji rendering) |

---

## 🛠️ How it Works (GNU Stow)

This repository manages configuration files using **GNU Stow**. 

Instead of copying files directly into your system, Stow creates **symbolic links (shortcuts)** from this repository folder straight into your home (`~`) directory. Any edits you make within this repository automatically apply to your system instantly.

The folder structure is organized into modular app "packages". Notice how `.config` files and root home files (like `.zshrc`) are handled differently:

```text
~/Workspace/dotfiles/
├── niri/              <-- Package Wrapper Name
│   └── .config/
│       └── niri/      <-- Links to ~/.config/niri/
├── waybar/
│   └── .config/
│       └── waybar/    <-- Links to ~/.config/waybar/
├── zsh/
│   └── .zshrc         <-- Links directly to ~/.zshrc
└── vim/
    └── .vimrc         <-- Links directly to ~/.vimrc
```

I prefer GNU Stow because it makes tracking and versioning configurations with Git incredibly easy.

---

## 🚀 Installation & Deployment

If you are setting this up on a fresh system or restoring a backup, follow these steps:

### 1. Install GNU Stow
Ensure Stow is installed on your Linux system:
```bash
# Fedora
sudo dnf install stow

# Arch Linux
sudo pacman -S stow

# Ubuntu/Debian
sudo apt install stow
```

### 2. Clone the Repository
Clone the dotfiles into your workspace folder:
```bash
mkdir -p ~/Workspace
cd ~/Workspace
git clone https://github.com/Smiffeed/dotfiles.git
cd dotfiles
```

### 3. Remove Existing Default Configurations
Stow **cannot** overwrite existing physical folders or files. You must back up or delete your current default configurations before linking:
```bash
rm -rf ~/.config/niri
rm -rf ~/.config/waybar
rm -f ~/.zshrc ~/.vimrc
```

### 4. Symlink with Stow
Run the following command from inside the `~/Workspace/dotfiles` directory to safely generate symlinks:
```bash
stow -v -t ~ niri waybar zsh vim tmux mako foot fuzzel
```
*   `-v` (Verbose): Prints a confirmation checklist of every link created.
*   `-t ~` (Target): Explicitly targets your User Home folder.

---

## 🔄 Managing Configurations

### Adding a New Application Package
To track a new configuration folder (e.g., `foot`), mimic the home directory layout inside the repo:
```bash
# 1. Create the mirrored directory path inside dotfiles
mkdir -p ~/Workspace/dotfiles/foot/.config/

# 2. Move your real local configuration inside it
mv ~/.config/foot ~/Workspace/dotfiles/foot/.config/

# 3. Use Stow to link it back to your system
cd ~/Workspace/dotfiles
stow -v -t ~ foot
```

*Tip: If the file belongs directly in `~` (like `.bashrc`), skip the `.config` folder and put it straight in the package root (e.g. `bash/.bashrc`).*

### Restowing / Updating Links
If you add new loose script files inside an existing configuration folder, force Stow to refresh and recalculate the symlinks using **Restow (`-R`)**:
```bash
cd ~/Workspace/dotfiles
stow -R -v -t ~ waybar
```

### Unstowing / Removing Links
To cleanly remove configurations and delete the symlinks without deleting your repository files, run **Delete (`-D`)**:
```bash
cd ~/Workspace/dotfiles
stow -D -t ~ niri waybar
```

---

## 🤖 AI Agent Integration & Commits

This repository includes custom AI Agent Skills (in `.agents/skills/`) designed for AI assistants to easily manage this repository. When working with an agent, it automatically knows how to deploy, add, and push configurations using Stow.

### Syncing Changes
When pushing updates, we strictly use **Conventional Commits** (e.g., `feat(niri): update keybinds`). A script is provided to enforce this workflow:
```bash
cd ~/Workspace/dotfiles
./push.sh "feat(scope): your commit message here"
```

---

## References
- [cachyos-niri-settings](https://github.com/CachyOS/cachyos-niri-settings/tree/master)
- [Hobbyist-dotfiles](https://github.com/BlackSparkz/hobbyist-dotfiles/tree/main)
- [New-Niri-minimal-dots](https://github.com/youngcoder45/New-Niri-minimal-dots/tree/main)

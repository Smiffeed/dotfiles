# Minimal Niri Dotfile
## 📌 About This Repository

This is a personal configuration space tailored specifically to my own workflow, taste, and hardware setup. It isn’t built to be a one-size-fits-all setup for everyone, but if you are curious, you are more than welcome to look around!

I did not build all of these configurations completely from scratch. Instead, this setup is a curated blend of various community repositories that I have combined, heavily tweaked, and customized to match my personal preferences. I have adjusted the color themes, optimized application layouts, and hooked up my favorite minimalist tools to build my perfect desktop environment. 

You can find the original configurations that inspired this setup listed in the **References** section below.

This is work in progress. It contains bad script. You can use it without any error, but the text is not clean looking. The instruction below is not only a guideline installation, but also note for myself to read in the future.

---

## 🛠️ How it Works (GNU Stow)

This repository manages configuration files using **GNU Stow**. 

Instead of copying files directly into your system, Stow creates **symbolic links (shortcuts)** from this repository folder straight into your `~/.config/` directory. Any edits you make within this repository automatically apply to your system instantly.

The folder structure is organized into modular app "packages":
```text
~/Workspace/dotfiles/
├── niri/              <-- Package Wrapper Name
│   └── .config/
│       └── niri/      <-- Target Directory Structure
│           └── config.kdl
└── waybar/
    └── .config/
        └── waybar/
            ├── config.jsonc
            ├── style.css
            └── cfg
```

I like GNU Stow because it is easy to edit and commit git.

---


## 🚀 Installation & Deployment

If you are setting this up on a fresh system or restoring your backup, follow these steps:

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
Clone your dotfiles into your workspace folder:
```bash
mkdir -p ~/Workspace
cd ~/Workspace
git clone https://github.com dotfiles
cd dotfiles
```

### 3. Remove Existing Default Configurations
Stow **cannot** overwrite existing physical folders. You must back up or delete your current default configurations before linking:
```bash
rm -rf ~/.config/niri
rm -rf ~/.config/waybar
```

### 4. Symlink with Stow
Run the following command from inside your `~/Workspace/dotfiles` directory to generate the symlinks safely targeting your home (`~`) directory:
```bash
stow -v -t ~ niri waybar
```
*   `-v` (Verbose): Prints a confirmation checklist of every link created.
*   `-t ~` (Target): Explicitly targets your User Home folder.

---

## 🔄 Managing Configurations

### Adding a New Application Package
To track a new configuration folder (e.g., `foot` terminal), mimic the home directory layout:
```bash
# 1. Create the mirrored directory path inside dotfiles
mkdir -p ~/Workspace/dotfiles/foot/.config/

# 2. Move your real local configuration inside it
mv ~/.config/foot ~/Workspace/dotfiles/foot/.config/

# 3. Use Stow to link it back to your system
cd ~/Workspace/dotfiles
stow -v -t ~ foot
```

### Restowing / Updating Links
If you add new loose script files inside an existing configuration folder, force Stow to refresh and recalculate the symlinks using **Restow (`-R`)**:
```bash
cd ~/Workspace/dotfiles
stow -R -v -t ~ waybar
```

### Unstowing / Removing Links
To cleanly remove your configurations and delete the symlinks without deleting your repository files, run **Delete (`-D`)**:

```bash
cd ~/Workspace/dotfiles
stow -D -t ~ niri waybar foot
```

## References
- [cachyos-niri-settings](https://github.com/CachyOS/cachyos-niri-settings/tree/master)
- [Hobbyist-dotfiles](https://github.com/BlackSparkz/hobbyist-dotfiles/tree/main)
- [New-Niri-minimal-dots](https://github.com/youngcoder45/New-Niri-minimal-dots/tree/main)

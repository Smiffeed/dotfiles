---
name: sync_dotfiles
description: Sync and push dotfile changes
---

# Sync Dotfiles

To commit and push the latest dotfile changes:
1. Ensure all modifications are correct and tested.
2. Navigate to the dotfiles directory: `cd ~/Workspace/dotfiles`
3. Check the status of changes: `git status`
4. Stage the changes: `git add .`
5. **CRITICAL**: Use Conventional Commits for your commit message. Do NOT just use "Sync configs" or the date/time. 
   Format: `type(scope): description`
   Examples: 
   - `feat(tmux): add custom theme configuration`
   - `fix(zsh): resolve syntax error in aliases`
   - `chore: update stow symlinks`
6. Commit the changes: `git commit -m "your conventional commit message"`
7. Push to the repository: `git push origin main`

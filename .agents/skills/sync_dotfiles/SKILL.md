---
name: sync_dotfiles
description: Sync and push dotfile changes
---

# Sync Dotfiles

To commit and push dotfile changes:

1. **Validate**: Run `./check.sh` from the repository root and verify that all configuration and script checks pass.
2. **Review status**: Check modified and untracked files with `git status`.
3. **Atomic commits**: If changes touch multiple distinct tools or packages (e.g. `yazi`, `niri`, `fuzzel`), do NOT stage everything together. Stage and commit each logical unit separately.
4. **Conventional Commits**: Format each commit message strictly as `type(scope): description`.
   - Examples:
     - `feat(yazi): add drag plugin and termfilechooser wrapper`
     - `fix(fuzzel): prevent dmenu heap crash by simplifying column format`
     - `chore(check): add repo validation script`
5. **Delayed Push Protocol**: Do NOT push automatically after modifying configurations. Wait for explicit user confirmation that the change works on their machine.
6. **Push**: Once confirmed, push to the remote repository:
   ```bash
   git push origin master
   ```

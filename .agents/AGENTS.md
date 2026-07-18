# Antigravity Agents for Dotfiles

This directory contains definitions and skills for AI agents to help manage this dotfiles repository.

## Available Skills

- **deploy_dotfiles**: Instructions for agents to safely deploy configurations to the user's home directory using GNU Stow.
- **add_dotfile**: Guidelines for extracting an existing configuration from the home directory and setting it up as a new package here.
- **sync_dotfiles**: Instructions on how to commit and push changes using the provided `push.sh` script.

## Interaction Rules

- **Configuration Safety & Conflict Warning**: Before executing any user prompt that modifies keybinds, layouts, or system configurations, always analyze the current configuration to identify potential conflicts (e.g., remapping a key that is already used for an essential function). If a conflict or potential user error is detected in the prompt, DO NOT blindly execute the change. STOP and explicitly warn the user about the consequences, and propose a safer alternative.

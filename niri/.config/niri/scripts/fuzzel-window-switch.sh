#!/bin/bash
# Fetch windows from niri, format them with jq, and pass to fuzzel
# The selected output is parsed to get the window ID and then focused via niri msg

WINDOWS=$(niri msg -j windows)

# Format: "Workspace 1: AppName - Window Title" (ID is hidden at the start for awk to grab)
SELECTION=$(echo "$WINDOWS" | jq -r '.[] | "\(.id) | W\(.workspace_id) | \(.app_id) | \(.title)"' | fuzzel -d -p "Window: ")

if [ -n "$SELECTION" ]; then
    WINDOW_ID=$(echo "$SELECTION" | awk -F'|' '{print $1}' | tr -d ' ')
    niri msg action focus-window --id "$WINDOW_ID"
fi

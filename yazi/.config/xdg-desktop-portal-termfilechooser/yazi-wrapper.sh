#!/usr/bin/env sh
set -e

multiple="$1"
directory="$2"
save="$3"
path="$4"
out="$5"

# If path is empty, default to $HOME
if [ -z "$path" ]; then
    path="$HOME"
fi

cwd_file=$(mktemp)
trap 'rm -f "$cwd_file"' EXIT

if [ "$save" = "1" ]; then
    filename=$(basename "$path")
    created_file=0

    # If suggested target doesn't exist yet, touch it so Yazi displays it
    if [ ! -e "$path" ]; then
        dir=$(dirname "$path")
        mkdir -p "$dir"
        touch "$path"
        created_file=1
    fi

    foot --app-id="file_chooser" --title="Save File: [Enter] Overwrite file | [q] Save into folder | [a] New name" yazi --chooser-file="$out" --cwd-file="$cwd_file" "$path"

    # If user pressed Enter on a file, $out already has the chosen file path.
    # If $out is empty, but user navigated into a folder and pressed 'q',
    # save the file into that folder with the suggested filename.
    if [ ! -s "$out" ] && [ -s "$cwd_file" ]; then
        chosen_dir=$(cat "$cwd_file")
        if [ -d "$chosen_dir" ]; then
            echo "$chosen_dir/$filename" > "$out"
        fi
    fi

    # Clean up the placeholder if it was saved elsewhere or cancelled
    if [ "$created_file" = "1" ]; then
        if [ ! -s "$out" ] || [ "$(cat "$out" 2>/dev/null)" != "$path" ]; then
            rm -f "$path"
        fi
    fi
elif [ "$directory" = "1" ]; then
    # Selecting a directory:
    # Navigating into a folder and pressing 'q' chooses that directory via --cwd-file
    foot --app-id="file_chooser" --title="Choose Directory - Yazi" yazi --cwd-file="$out" "$path"
else
    # Opening / selecting file(s):
    # Pressing Enter on file(s) chooses them via --chooser-file
    foot --app-id="file_chooser" --title="Open File - Yazi" yazi --chooser-file="$out" "$path"
fi

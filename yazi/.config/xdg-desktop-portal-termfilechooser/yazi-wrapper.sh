#!/usr/bin/env sh
set -e

multiple="$1"
directory="$2"
save="$3"
path="$4"
out="$5"

cwd_file=$(mktemp)
trap 'rm -f "$cwd_file"' EXIT

if [ "$save" = "1" ]; then
    if [ -n "$path" ] && [ ! -d "$path" ]; then
        dir=$(dirname "$path")
        filename=$(basename "$path")
    else
        if [ -d "$path" ]; then
            dir="$path"
        elif [ -d "$HOME/Downloads" ]; then
            dir="$HOME/Downloads"
        else
            dir="$HOME"
        fi
        filename=""
    fi

    if [ ! -d "$dir" ]; then
        mkdir -p "$dir" 2>/dev/null || dir="$HOME"
    fi

    created_file=0
    target_entry="$dir"

    # If suggested target doesn't exist yet, touch it so Yazi displays it
    if [ -n "$filename" ]; then
        target="$dir/$filename"
        if [ ! -e "$target" ]; then
            touch "$target"
            created_file=1
        fi
        target_entry="$target"
    fi

    foot --app-id="file_chooser" --title="Save File: [Enter] Confirm | [q] Save into folder | [a] New name | [Q] Cancel" yazi --chooser-file="$out" --cwd-file="$cwd_file" "$target_entry" || true

    # If user pressed Enter on a file, $out already has the chosen file path.
    # If $out is empty, but user navigated into a folder and pressed 'q',
    # save the file into that folder with the suggested filename (if available).
    if [ ! -s "$out" ] && [ -s "$cwd_file" ]; then
        chosen_dir=$(cat "$cwd_file")
        if [ -d "$chosen_dir" ] && [ -n "$filename" ]; then
            echo "$chosen_dir/$filename" > "$out"
        fi
    fi

    # Clean up the placeholder if it was saved elsewhere or cancelled
    if [ "$created_file" = "1" ]; then
        if [ ! -s "$out" ] || [ "$(cat "$out" 2>/dev/null)" != "$target" ]; then
            rm -f "$target"
        fi
    fi

    if [ ! -s "$out" ]; then
        rm -f "$out"
    fi
else
    # If path is empty or does not exist, default to Downloads if available, else $HOME
    if [ -z "$path" ] || [ ! -e "$path" ]; then
        if [ -d "$HOME/Downloads" ]; then
            path="$HOME/Downloads"
        else
            path="$HOME"
        fi
    fi

    # Opening / selecting file(s) or directory
    if [ "$multiple" = "1" ]; then
        title="Select Multiple: [Space] Select | [v] Range | [Ctrl+a] All | [Enter] Confirm"
    elif [ "$directory" = "1" ]; then
        title="Choose Directory: [Space] Select Folder | [Enter] Confirm | [q] Cancel"
    else
        title="Choose File: [l/→] Open folder | [Enter] Choose | [q] Cancel"
    fi

    foot --app-id="file_chooser" --title="$title" yazi --chooser-file="$out" --cwd-file="$cwd_file" "$path" || true

    # Fallback for directory mode: if user navigated into a folder and exited with 'q'
    if [ ! -s "$out" ] && [ -s "$cwd_file" ]; then
        if [ "$directory" = "1" ]; then
            cp "$cwd_file" "$out"
        fi
    fi

    # Sanitize output list: keep only valid existing items
    if [ -s "$out" ]; then
        out_filtered=$(mktemp)
        while IFS= read -r item || [ -n "$item" ]; do
            if [ -n "$item" ] && [ -e "$item" ]; then
                printf '%s\n' "$item"
            fi
        done < "$out" > "$out_filtered"

        if [ -s "$out_filtered" ]; then
            mv "$out_filtered" "$out"
        else
            rm -f "$out_filtered" "$out"
        fi
    else
        rm -f "$out"
    fi
fi

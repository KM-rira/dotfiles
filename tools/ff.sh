#!/bin/bash

ff() {
    while true;
    do
        # Find directories in the current directory
        directories=$(find . -maxdepth 1 -type d ! -name '.*' | cut -c 3-)

        # Check if there are any directories
        if [ -n "$directories" ]; then
            # If directories exist, let the user choose one with fzf
            dir=$(echo "$directories" | fzf --height 40%)
            if [ -z "$dir" ]; then
                echo "===== EXIT PROCESS ====="
                return
            else
                cd "$dir" && echo "Now in $dir" || echo "Failed to enter $dir"
            fi
        else
            # Message if no directories exist
            echo "===== NO DIRECTORIES EXIST ====="
            return
        fi
    done
}

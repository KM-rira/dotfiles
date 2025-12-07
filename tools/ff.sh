#!/bin/bash

ff() {
    # reset OPTIND for repeated calls
    OPTIND=1
    show_hidden=false

    # parse options
    while getopts "a" opt; do
        case ${opt} in
            a )
                show_hidden=true
                ;;
            \? )
                echo "Usage: ff [-a]"
                return
                ;;
        esac
    done

    while true; do
        # directories search
        if [ "$show_hidden" = true ]; then
            # include hidden directories
            directories=$(find . -maxdepth 1 -type d | cut -c 3-)
        else
            # exclude hidden directories
            directories=$(find . -maxdepth 1 -type d ! -name '.*' | cut -c 3-)
        fi

        # remove empty line for root "."
        directories=$(echo "$directories" | sed '/^$/d')

        if [ -n "$directories" ]; then
            dir=$(echo "$directories" | fzf --height 40%)

            if [ -z "$dir" ]; then
                echo "===== EXIT PROCESS ====="
                return
            else
                cd "$dir" && echo "Now in $dir" || echo "Failed to enter $dir"
            fi
        else
            echo "===== NO DIRECTORIES EXIST ====="
            return
        fi
    done
}


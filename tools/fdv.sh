#!/bin/bash
fdv() {
    if [ "$#" -eq 0 ]; then
        echo "===== NEED PARAMETER ====="
        return
    fi

    select_file=$(fdfind $@ | fzf --tac --no-sort --reverse --prompt='Select FILE: ' --no-multi)
    if [ -z "$select_file" ] ; then
        echo "===== EXIT PROCESS ====="
        return
    fi

    nvim $select_file
}


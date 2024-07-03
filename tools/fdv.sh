#!/bin/bash
fdv() {
    if [ "$#" -eq 0 ]; then
        echo "===== NEED PARAMETER ====="
        return
    fi


    file_count=$(fd $@ | wc -l)
    if [ $file_count -eq 0 ] ; then
        echo "===== NOT FOUND FILE ====="
        return
    fi

    select_file=$(fd $@ | fzf --tac --no-sort --reverse --prompt='SELECT FILE: ' --no-multi)
    if [ -z "$select_file" ] ; then
        echo "===== EXIT PROCESS ====="
        return
    fi

    nvim $select_file
}


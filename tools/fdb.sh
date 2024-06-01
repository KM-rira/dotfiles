#!/bin/bash
fdb() {
    if [ "$#" -eq 0 ]; then
        ECHO "===== NEED PARAMETER ====="
        return
    fi

    file_count=$(fdfind $@ | wc -l)
    if [ $file_count -eq 0 ] ; then
        echo "===== NOT FOUND FILE ====="
        return
    fi

    select_file=$(fdfind $@ | fzf --tac --no-sort --reverse --prompt='Select FILE: ' --no-multi)

    if [ -z "$select_file" ] ; then
        echo "===== EXIT PROCESS ====="
        return
    fi

    batcat $select_file
}


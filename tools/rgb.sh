#!/bin/bash

rgv() {
    if [ "$#" -eq 0 ]; then
        echo "===== NEED PARAMETER ====="
        return
    fi

    file_count=$(rg -l "$*" | wc -l)
    if [ $file_count -eq 0 ] ; then
        echo "===== NOT FOUND FILE ====="
        exit
    fi

    select_file=$(rg -l "$*" | fzf --tac --no-sort --reverse --prompt='SELECT FILE: ' --no-multi)

    if [ -z "$select_file" ] ; then
        echo "===== EXIT PROCESS ====="
        exit
    fi

    # 選択されたコマンドを実行
    echo $select_file
    bat -n $select_file
}

#!/bin/bash

vf() {
    file_count=$(find . -maxdepth 1 -type f | wc -l)
    if [ "$file_count" -eq 0 ] ; then
        echo "===== NOT EXIST FILE ====="
        return
    fi

    select_file=$(find . -maxdepth 1 -type f | fzf --tac --no-sort --reverse --prompt='Select FILE: ' --no-multi)

    if [ -z "$select_file" ] ; then
        echo "===== EXIT PROCESS ====="
        return
    fi

    # 選択されたコマンドを実行
    nvim $select_file
}


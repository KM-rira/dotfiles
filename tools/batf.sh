#!/bin/bash
batf() {
    select_file=$(find . -maxdepth 1 -type f | fzf --tac --no-sort --reverse --prompt='Select FILE: ' --no-multi)

    if [ -z "$select_file" ] ; then
        echo "===== EXIT PROCESS ====="
        return
    fi

    # 選択されたコマンドを実行
    batcat $select_file
}


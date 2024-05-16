#!/bin/bash
bf() {
    select_file=$(ls -F | grep -v / | fzf --tac --no-sort --reverse --prompt='Select FILE: ' --no-multi)

    if [ -z "$select_file" ] ; then
        echo "===== EXIT PROCESS ====="
        return
    fi

    # 選択されたコマンドを実行
    bat $select_file
}


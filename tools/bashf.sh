#!/bin/bash

bashf() {
    select_file=$(find . -maxdepth 1 -type f | grep "\.sh"| fzf --tac --no-sort --reverse --prompt='SELECT FILE: ' --no-multi)

    # リポジトリ名の抽出失敗した場合
    if [ -z "$select_file" ] ; then
        echo "===== EXIT PROCESS ====="
        return
    fi

    # 選択されたコマンドを実行
    bash $select_file "$*"
}


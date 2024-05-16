#!/bin/bash

bashf() {
    select_file=$(ls -F | grep -v / | grep "\.sh"| fzf --tac --no-sort --reverse --prompt='SELECT FILE: ' --no-multi)

    # リポジトリ名の抽出失敗した場合
    if [ -z "$select_file" ] ; then
        echo "===== exit process ====="
        return
    fi

    # 選択されたコマンドを実行
    bash $select_file "$*"
}


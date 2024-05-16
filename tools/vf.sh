#!/bin/bash

vf() {
    # コマンド履歴を取得してfzfでフィルタリング
    select_file=$(ls -F | grep -v / | fzf --tac --no-sort --reverse --prompt='Select FILE: ' --no-multi)

    # リポジトリ名の抽出失敗した場合
    if [ -z "$select_file" ] ; then
        echo "===== EXIT PROCESS ====="
        return
    fi

    # 選択されたコマンドを実行
    nvim $select_file
}


#!/bin/bash

# コマンド履歴を取得してfzfでフィルタリング
select_file=$(find . -maxdepth 1 -type f | fzf --tac --no-sort --reverse --prompt='Select FILE: ' --no-multi)

# リポジトリ名の抽出失敗した場合
if [ -z "$select_file" ] ; then
    echo "===== EXIT PROCESS ====="
    exit
fi

# 選択されたコマンドを実行
cat $select_file


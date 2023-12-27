#!/bin/bash

# コマンド履歴を取得してfzfでフィルタリング
select_file=$(fzf --no-sort --reverse --prompt='Select FILE: ' --no-multi)

# リポジトリ名の抽出失敗した場合
if [ -z "$select_file" ] ; then
    echo "===== exit process ====="
    exit
fi

# 選択されたコマンドを実行
cat $select_file


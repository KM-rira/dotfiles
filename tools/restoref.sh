#!/bin/bash

# コマンド履歴を取得してfzfでフィルタリング
cd $(git rev-parse --show-toplevel)
select_file=$( git diff --name-only --cached | fzf --no-sort --prompt='SELECT RESTORE FILE: ' --no-multi)
cd -

# リポジトリ名の抽出失敗した場合
if [ -z "$select_file" ] ; then
    echo "===== exit process ====="
    exit
fi

# 選択されたコマンドを実行
git add $select_file

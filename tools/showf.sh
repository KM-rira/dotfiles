#!/bin/bash

select=$( git log --oneline -n 50 | fzf --no-sort --reverse --prompt='select COMMIT_ID: ' --no-multi )
c_id=$(echo $select | awk '{print $1}')
c_mes=$(echo $select | cut -d ' ' -f 2-)

# selectの抽出失敗した場合
if [ -z "$select" ] ; then
    echo "===== exit process ====="
    exit 1
fi

# 選択されたコマンドを実行
git show $c_id


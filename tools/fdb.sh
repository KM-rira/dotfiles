#!/bin/bash

# fdするワードを指定
word=$1
if [ -z "$word" ] ; then
    echo "===== need parameter ====="
    exit
fi

select_file=$(fdfind $word | fzf --tac --no-sort --reverse --prompt='Select FILE: ' --no-multi)

# リポジトリ名の抽出失敗した場合
if [ -z "$select_file" ] ; then
    echo "===== exit process ====="
    exit
fi

batcat $select_file


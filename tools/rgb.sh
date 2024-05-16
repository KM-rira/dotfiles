#!/bin/bash

# grepするワードを指定
grep_word=$1
if [ -z "$grep_word" ] ; then
    echo "===== need parameter ====="
    exit
fi

select_file=$(rg -l $grep_word | fzf --tac --no-sort --reverse --prompt='Select FILE: ' --no-multi)

if [ -z "$select_file" ] ; then
    echo "===== EXIT PROCESS ====="
    exit
fi

# 選択されたコマンドを実行
echo $select_file
batcat -n $select_file

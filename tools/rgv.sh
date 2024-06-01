#!/bin/bash

if [ "$#" -eq 0 ] ; then
    echo "===== NEED PARAMETER ====="
    exit
fi

file_count=$(rg -l "$*" | wc -l)
if [ $file_count -eq 0 ] ; then
    echo "===== NOT FOUND FILE ====="
    exit
fi

select_file=$(rg -l "$*" | fzf --tac --no-sort --reverse --prompt='Select FILE: ' --no-multi)

# リポジトリ名の抽出失敗した場合
if [ -z "$select_file" ] ; then
    echo "===== EXIT PROCESS ====="
    exit
fi

row_num=$(rg -n $grep_word $select_file | fzf --tac --no-sort --reverse --prompt='Select ROW: ' --no-multi | cut -d ':' -f 1)

# 選択されたコマンドを実行
echo $select_file
nvim $select_file +$row_num

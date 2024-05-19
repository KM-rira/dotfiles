#!/bin/bash

if [ "$#" -eq 0 ]; then
        echo "===== need parameter ====="
        return
fi

select_file=$(rg -l "$*" | fzf --tac --no-sort --reverse --prompt='Select FILE: ' --no-multi)

if [ -z "$select_file" ] ; then
    echo "===== EXIT PROCESS ====="
    exit
fi

# 選択されたコマンドを実行
echo $select_file
batcat -n $select_file

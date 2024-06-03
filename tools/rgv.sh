#!/bin/bash

rgv() {
    if [ "$#" -eq 0 ] ; then
        echo "===== NEED PARAMETER ====="
        return
    fi

    echo rg -l "$*"

    file_count=$(rg -l "$*" | wc -l)
    if [ $file_count -eq 0 ] ; then
        echo "===== NOT FOUND FILE ====="
        return
    fi

    select_file=$(rg -l "$*" | fzf --tac --no-sort --reverse --prompt='SELECT FILE: ' --no-multi)

    # リポジトリ名の抽出失敗した場合
    if [ -z "$select_file" ] ; then
        echo "===== EXIT PROCESS ====="
        return
    fi

    row_num=$(rg -n $grep_word $select_file | fzf --tac --no-sort --reverse --prompt='SELECT ROW: ' --no-multi | cut -d ':' -f 1)

    # 選択されたコマンドを実行
    echo $select_file
    nvim $select_file +$row_num
}


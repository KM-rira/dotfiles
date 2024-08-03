#!/bin/bash

titlev() {
    grep_word='TITLE:'
    ext='md'
    dir="$HOME/note"
    file_count=$(rg -t $ext -l $grep_word $dir | wc -l)
    if [ $file_count -eq 0 ] ; then
        echo "===== NOT FOUND FILE ====="
        return
    fi

    select_row=$(find $dir -maxdepth 1 -type f -name "*.md" -print0 | xargs -0 grep -h "TITLE:.*" | fzf --tac --no-sort --reverse --prompt='SELECT ROW: ' --no-multi)
    select_file=$(rg -t $ext -l $select_row $dir | fzf --tac --no-sort --reverse --prompt='SELECT FILE: ' --no-multi)

    # リポジトリ名の抽出失敗した場合
    if [ -z "$select_file" ] ; then
        echo "===== EXIT PROCESS ====="
        return
    fi

    # 選択されたコマンドを実行
    echo $select_file
    v $select_file
}


#!/bin/bash

addf() {
    cd $(git rev-parse --show-toplevel)
    select_file=$( git diff --name-only | fzf --no-sort --prompt='SELECT ADD FILE: ' --multi)

    if [ -z "$select_file" ] ; then
        echo "===== exit process ====="
        return
    fi

    # 選択されたコマンドを実行
    git add $select_file

    cd -

    echo "===== done ====="
}

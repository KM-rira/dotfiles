#!/bin/bash

f() {
    # 現在のディレクトリにあるディレクトリのリストを取得
    directories=$(ls -d */ 2>/dev/null)

    # ディレクトリが存在するか確認
    if [ -n "$directories" ]; then
        # ディレクトリが存在する場合、fzfで選択させる
        dir=$(echo "$directories" | fzf --height 40%)
        if [ -z "$dir" ] ; then
            echo "===== exit process ====="
        else
            echo "===== cd $dir ====="
            cd $dir
        fi
    else
        # ディレクトリが存在しない場合のメッセージ
        echo "===== not exists dir ====="
    fi
}


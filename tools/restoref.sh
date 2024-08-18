#!/bin/bash

restoref() {
    # コマンド履歴を取得してfzfでフィルタリング
    cd $(git rev-parse --show-toplevel)
    select_file=$( git diff --name-only | gfzf --no-sort --prompt='SELECT RESTORE FILE: ' --multi)

    # ファイル名の抽出失敗した場合
    if [ -z "$select_file" ] ; then
        cd -
        echo "===== EXIT PROCESS ====="
        return 1
    fi

    # ユーザーに質問をして y/n の回答を待つ
    echo -n "restore all ok? (y/n) "
    read  answer

    # 回答を小文字に変換
    answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')

    # 回答によって処理を分岐
    case "$answer" in
        y|yes)
            ;;
        n|no)
            cd -
            echo "exit process"
            return 1
            ;;
        *)
            cd -
            echo "unknown answer"
            return 1
            ;;
    esac


    # 選択されたコマンドを実行
    git restore $select_file
    cd -
    echo "===== DONE ====="
}

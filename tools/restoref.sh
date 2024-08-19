#!/bin/bash

restoref() {
    local DIFF_OPTION=''
    local QUESTION_FLAG=true
    local RESTORE_OPTION=''

    while getopts "s" opt; do
        case ${opt} in
            s )
            DIFF_OPTION=' --cached'
            QUESTION_FLAG=false
            RESTORE_OPTION='--staged'
            ;;
        \? )
            echo "Usage: $0 [-s]"
            return 1
            ;;
        esac
    done

    # コマンド履歴を取得してfzfでフィルタリング
    cd $(git rev-parse --show-toplevel)
    local select_file=$(eval "git diff --name-only $DIFF_OPTION" | gfzf --no-sort --prompt='SELECT RESTORE FILE: ' --multi)

    # ファイル名の抽出失敗した場合
    if [ -z "$select_file" ] ; then
        cd - > /dev/null 2>&1
        echo "===== EXIT PROCESS ====="
        return 1
    fi

    if [ "$QUESTION_FLAG" = true ]; then
        # ユーザーに質問をして y/n の回答を待つ
        echo -n "restore all ok? (y/n) "
        read  answer

        # 回答を小文字に変換
        local answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')

        # 回答によって処理を分岐
        case "$answer" in
            y|yes)
                ;;
            n|no)
                cd - > /dev/null 2>&1
                echo "===== EXIT PROCESS ====="
                return 1
                ;;
            *)
                cd - > /dev/null 2>&1
                echo "===== UNKNOWN ANSWER ====="
                return 1
                ;;
        esac
    fi


    # 選択されたコマンドを実行
    echo $select_file | xargs git restore $RESTORE_OPTION
    cd - > /dev/null 2>&1
    echo "===== DONE ====="
}

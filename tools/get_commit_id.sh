#!/bin/bash

select=$( git log --oneline -n 50 | fzf --no-sort --reverse --prompt='select COMMIT_ID: ' --no-multi )
c_id=$(echo $select | awk '{print $1}')
c_mes=$(echo $select | cut -d ' ' -f 2-)

# selectの抽出失敗した場合
if [ -z "$select" ] ; then
    echo "===== exit process ====="
    exit 1
else
    # ユーザーに質問をして y/n の回答を待つ
    read -p "${c_id} ${c_mes} ←check (y/n) " answer

    # 回答を小文字に変換
    answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')

    # 回答によって処理を分岐
    case "$answer" in
        y|yes)
            ;;
        n|no)
            echo "exit process"
            exit 1
            ;;
        *)
            echo "unknown answer"
            exit 1
            ;;
    esac
fi

# 選択されたコマンドを実行
echo $c_id


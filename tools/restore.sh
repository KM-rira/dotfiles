#!/bin/bash

file=$1

# selectの抽出失敗した場合
if [ -z "$file" ] ; then
    echo "===== NOT SETTING PATH ====="
    exit 1
else
    # ユーザーに質問をして y/n の回答を待つ
    read -p "${file} ← restore ok? (y/n) " answer

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
git restore $file


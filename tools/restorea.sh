#!/bin/bash

# ユーザーに質問をして y/n の回答を待つ
read -p "restore all ok? (y/n) " answer

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

# コマンドを実行
git restore .


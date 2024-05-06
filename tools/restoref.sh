#!/bin/bash

# コマンド履歴を取得してfzfでフィルタリング
cd $(git rev-parse --show-toplevel)
select_file=$( git diff --name-only | fzf --no-sort --prompt='SELECT RESTORE FILE: ' --multi)

# ファイル名の抽出失敗した場合
if [ -z "$select_file" ] ; then
    echo "===== exit process ====="
    exit
fi

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


# 選択されたコマンドを実行
git restore $select_file

echo "===== done ====="

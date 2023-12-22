#!/bin/bash

# Bookmarkフォルダ内のファイルをfzfで検索
selected_file=$(ls ~/bookmark | fzf --no-sort --reverse --prompt='select BOOKMARK: ' --no-multi)

# ファイルが選択されなかった場合の処理
if [ -z "$selected_file" ]; then
    echo "ファイルが選択されませんでした。"
    exit 1
fi

# 選択されたファイルからURLを取得
url=$(cat ~/bookmark/"$selected_file")

# URLをブラウザで開く
start "$url"

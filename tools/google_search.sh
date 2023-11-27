#!/bin/bash

# 引数がない場合はスクリプトを終了
if [ $# -eq 0 ]; then
    echo "少なくとも一つの単語を引数として提供してください。"
    exit 1
fi

# 引数をスペースで結合
search_word=" "
for arg in "$@"; do
    search_word="${search_word}${arg} "
done
search_word=$(echo $search_word | sed 's/ $//')  # 末尾のスペースを削除

# URLエンコード
encoded_word=$(echo $search_word | jq -sRr @uri)

url="https://www.google.com/search?q=$encoded_word"

# 結果を表示
echo "===== Google search: '${search_word}' ====="

start "$url"

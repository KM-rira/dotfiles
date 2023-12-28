#!/bin/bash

# 引数の数をチェック
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <number>"
    exit 1
fi

# 引数が数字かどうかをチェック
if ! [[ "$1" =~ ^[0-9]+$ ]]; then
    echo "Error: Argument must be a number"
    exit 1
fi

# git rebase -i コマンドを実行
git rebase -i "HEAD~$1" --autosqush

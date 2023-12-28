#!/bin/bash

# 引数の数を確認
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 file1 file2"
    exit 1
fi

# diffコマンドを実行
diff -u "$1" "$2" | colordiff

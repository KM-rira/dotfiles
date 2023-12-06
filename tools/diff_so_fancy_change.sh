#!/bin/bash

# このスクリプトは2つのファイルパスを引数として受け取ります
# 引数が2つでなければエラーメッセージを表示し、終了します
if [ "$#" -ne 2 ]; then
    echo "使用法: $0 <ファイル1> <ファイル2>"
    exit 1
fi

# diff コマンドを実行し、出力を diff-so-fancy にパイプします
diff -u "$1" "$2" | diff-so-fancy


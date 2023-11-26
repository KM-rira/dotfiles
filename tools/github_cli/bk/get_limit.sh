#!/bin/bash

# 初期値の設定
limit=20

# case文を使用して引数に応じた処理を行う
# オプションと引数の解析
while getopts ":l:" opt; do
    case $opt in
    l)
        limit=$OPTARG
        ;;
  esac
done

echo "$limit"

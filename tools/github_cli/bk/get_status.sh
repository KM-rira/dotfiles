#!/bin/bash

# 初期値の設定
type=""

# case文を使用して引数に応じた処理を行う
while getopts ":l:" opt; do
    case $opt in
    a)
        type='--state all'
        ;;
    o)
        type='--state open'
        ;;
    c)
        type='--state closed'
        ;;
    d)
        type='--draft'
        ;;
    esac
done

echo "$type"

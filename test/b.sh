#!/bin/bash

# すべての引数に対してループ
for num in "$@"
do
    # 数値を2倍にして出力
    echo $((num))
    sum=$((sum + num))
done



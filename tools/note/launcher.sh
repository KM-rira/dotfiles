#!/bin/bash

TARGET_DIR="$HOME/vimConf/tools/note"
files=$(ls $TARGET_DIR | grep -v "launcher.sh")

# 各ファイルをsourceで実行
for file in $files; do
    source "$TARGET_DIR/$file"
done

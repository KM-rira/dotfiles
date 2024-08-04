#!/bin/bash

TARGET_DIR="$HOME/vimConf/tools/note/*.sh"

# 各スクリプトを source コマンドで読み込む
for script in $TARGET_DIR; do
    if [ -r "$script" ]; then
        source "$script"
    else
        echo "$script は読み込み権限がありません。"
    fi
done

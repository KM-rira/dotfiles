#!/bin/bash

# コマンド履歴を取得してfzfでフィルタリング
select_file=$( ls -d */ | fzf --no-sort --prompt='CHANGE DIR: ')

# リポジトリ名の抽出失敗した場合
if [ -z "$select_file" ] ; then
    echo "===== EXIT PROCESS ====="
    exit
fi

# 選択されたコマンドを実行
cd $select_file

echo "===== DONE ====="


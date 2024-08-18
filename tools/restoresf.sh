#!/bin/bash

restoresf() {
    # コマンド履歴を取得してfzfでフィルタリング
    cd $(git rev-parse --show-toplevel)
    select_file=$( git diff --name-only --cached | gfzf --no-sort --prompt='SELECT STAGING RESTORE FILE: ' --multi)

    # リポジトリ名の抽出失敗した場合
    if [ -z "$select_file" ] ; then
        echo "===== EXIT PROCESS ====="
        return 1
    fi

    # 選択されたコマンドを実行
    echo "$select_file" | xargs git restore --staged

    echo "===== DONE ====="
}

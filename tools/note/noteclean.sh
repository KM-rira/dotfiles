#!/bin/bash

noteclean() {
    # 対象ディレクトリ
    target_dir="$HOME/note"

    # 対象ディレクトリ内のすべての.mdファイルをチェック
    for file in "$target_dir"/*.md; do
        if [ -f "$file" ]; then
            # ファイルの内容をチェックし、指定の形式に一致する場合は削除
            if grep -q "^# TITLE: *$" "$file" && [ $(wc -l < "$file") -eq 3 ]; then
                echo "Deleting $file as it matches the specified content"
                rm "$file"
            fi
        fi
    done
}

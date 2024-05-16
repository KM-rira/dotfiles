#!/bin/bash

# ステージングされているファイルの数をチェック
staged_files=$(git diff --cached --name-only)

# ステージングされているファイルがない場合
if [ -z "$staged_files" ]; then
    echo "===== not staged file ====="
    exit 1
fi

select=$( git log --oneline -n 50 | fzf --no-sort --reverse --prompt='select COMMIT_ID: ' --no-multi )
c_id=$(echo $select | awk '{print $1}')
c_mes=$(echo $select | cut -d ' ' -f 2-)

# selectの抽出失敗した場合
if [ -z "$select" ] ; then
    echo "===== EXIT PROCESS ====="
    exit 1
else
    # ユーザーに質問をして y/n の回答を待つ
    read -p "${c_id} ${c_mes} ←check (y/n) " answer

    # 回答を小文字に変換
    answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')

    # 回答によって処理を分岐
    case "$answer" in
        y|yes)
            ;;
        n|no)
            echo "exit process"
            exit 1
            ;;
        *)
            echo "unknown answer"
            exit 1
            ;;
    esac
fi

# 選択されたコマンドを実行
git commit --fixup $c_id


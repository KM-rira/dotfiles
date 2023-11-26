#!/bin/bash

# GitHubのリポジトリ一覧を取得し、fzfで選択させる
selected_repo=$(gh repo list ${gh_user} | fzf)

# 選択されたリポジトリからリポジトリ名を抜き取る
repo_name=$(echo "$selected_repo" | awk '{print $1}')

option=""
# 引数の有無をチェック
if [ $# -gt 0 ]; then
    # 第一引数を変数に格納
    arg="$1"

    # optionを設定する
    option=$(~/vimConf/tools/get_status.sh "$arg")
fi

cmd="gh pr list $option --json title,url --repo $repo_name"
eval $cmd

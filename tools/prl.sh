#!/bin/bash

# GitHubのリポジトリ一覧を取得し、fzfで選択させる
selected_repo=$(gh repo list ${gh_user} | fzf)

# 選択されたリポジトリからリポジトリ名を抜き取る
repo_name=$(echo "$selected_repo" | awk '{print $1}')

# 第一引数を変数に格納
option="$1"

# case文を使用して引数に応じた処理を行う
case $option in
    a)
        gh pr list --state all --repo "$repo_name"
        ;;
    o)
        gh pr list --state open --repo "$repo_name"
        ;;
    c)
        gh pr list --state closed --repo "$repo_name"
        ;;
    d)
        gh pr list --draft --repo "$repo_name"
        ;;
    *)
        gh pr list --repo "$repo_name"
        ;;
esac


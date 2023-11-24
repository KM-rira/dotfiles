#!/bin/bash

# GitHubのリポジトリ一覧を取得し、fzfで選択させる
selected_repo=$(gh repo list ${gh_user} | fzf)

# 選択されたリポジトリからリポジトリ名を抜き取る
repo_name=$(echo "$selected_repo" | awk '{print $1}')

# pr/issue 番号取得
num=$(gh pr list --repo "$repo_name" | fzf | awk '{gsub("#", "", $1); print $1}')

# コメントリスト出力
gh pr view "$num" --repo "$repo_name" --comments


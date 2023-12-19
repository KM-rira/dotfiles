#!/bin/bash

source ~/vimConf/tools/github_cli/bash/config.sh

# GitHubのリポジトリ一覧を取得し、fzfで選択させる
selected_repo=$(gh repo list ${gh_user} --limit ${Limit1} | fzf)

# 選択されたリポジトリからリポジトリ名を抜き取る
repo_name=$(echo "$selected_repo" | awk '{print $1}')

gh pr status --repo "$repo_name"

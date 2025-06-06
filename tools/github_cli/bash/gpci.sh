#!/bin/bash

source ~/dotfiles/tools/github_cli/bash/config.sh
source ~/dotfiles/tools/github_cli/bash/option.sh

# Gitリポジトリのorigin URLを取得
repo_url=$(git config --get remote.origin.url)

# URLからリポジトリ名を抽出
selected_repo=$(echo $repo_url | sed -e 's/.*://' -e 's/\.git$//')

# リポジトリ名の抽出失敗した場合
if [ -z "$selected_repo" ] || [ "$select_repo_flg" = true ]; then
    # GitHubのリポジトリ一覧を取得し、fzfで選択させる
    selected_repo=$(gh repo list ${gh_user} --limit ${Limit1} |
    fzf --no-sort --reverse --prompt='select REPOSITORY: ' --no-multi)
fi

# 選択されたリポジトリからリポジトリ名を抜き取る
repo_name=$(echo "$selected_repo" | awk '{print $1}')

cmd="gh pr list $Type --repo $repo_name --limit $Limit2"

# pr/issue 番号取得
# num=$(eval $cmd | fzf | awk '{gsub("#", "", $1); print $1}')
num=$(gh pr view --json number -q .number)

# CIステータス出力
gh pr checks "$num" --repo "$repo_name"

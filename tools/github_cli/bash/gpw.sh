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

cmd="gh pr list $Type --json title,url --repo $repo_name --limit $Limit2"

# GitHub CLIでリストをJSON形式で取得
json_data=$(eval $cmd)

titles=$(echo $json_data | jq -r '.[].title')

selected_title=$(echo "$titles" | fzf --no-sort --reverse --prompt='select PR: ' --no-multi)

# 選択されたtitleに対応するurlを取得
selected_url=$(echo "$json_data" | jq -r --arg title "$selected_title" '.[] | select(.title == $title) | .url')

# 結果を表示
start "$selected_url"

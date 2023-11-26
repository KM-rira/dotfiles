#!/bin/bash

# GitHubのリポジトリ一覧を取得し、fzfで選択させる
selected_repo=$(gh repo list ${gh_user} | fzf)

# 選択されたリポジトリからリポジトリ名を抜き取る
repo_name=$(echo "$selected_repo" | awk '{print $1}')

source ~/vimConf/tools/github_cli/bash/config.sh
# 引数の数をチェック
case "$#" in
    *)
        for arg in "$@"; do
            case "$arg" in
                a)
                    Type='--state all'
                    ;;
                o)
                    Type='--state open'
                    ;;
                c)
                    Type='--state closed'
                    ;;
                d)
                    Type='--draft'
                    ;;
                [1-9]*)
                    Limit=$arg
                    ;;
            esac
        done
        ;;
esac

cmd="gh pr list $Type --json title,url --repo $repo_name --limit $Limit"

# GitHub CLIでリストをJSON形式で取得
json_data=$(eval $cmd)

titles=$(echo $json_data | jq -r '.[].title')

selected_title=$(echo "$titles" | fzf)

# 選択されたtitleに対応するurlを取得
selected_url=$(echo "$json_data" | jq -r --arg title "$selected_title" '.[] | select(.title == $title) | .url')

# 結果を表示
start "$selected_url"

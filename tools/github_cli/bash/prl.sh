#!/bin/bash

source ~/vimConf/tools/github_cli/bash/config.sh

# GitHubのリポジトリ一覧を取得し、fzfで選択させる
selected_repo=$(gh repo list ${gh_user} --limit ${Limit1} | fzf)

# 選択されたリポジトリからリポジトリ名を抜き取る
repo_name=$(echo "$selected_repo" | awk '{print $1}')

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

cmd="gh pr list $Type --repo $repo_name --limit $Limit2"
eval $cmd

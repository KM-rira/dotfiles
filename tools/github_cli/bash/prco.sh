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

cmd="gh pr list $Type --repo $repo_name --limit $Limit"

# pr/issue 番号取得
num=$(eval $cmd | fzf | awk '{gsub("#", "", $1); print $1}')

# コメントリスト出力
gh pr view "$num" --repo "$repo_name" --json commits


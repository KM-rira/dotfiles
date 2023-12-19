#!/bin/bash

source ~/vimConf/tools/github_cli/bash/config.sh

# Gitリポジトリのorigin URLを取得
repo_url=$(git config --get remote.origin.url)

# URLからリポジトリ名を抽出
selected_repo=$(echo $repo_url | sed -e 's/.*://' -e 's/\.git$//')

# リポジトリ名の抽出失敗した場合
if [ -z "$selected_repo" ]; then
    # GitHubのリポジトリ一覧を取得し、fzfで選択させる
    selected_repo=$(gh repo list ${gh_user} --limit ${Limit1} |
    fzf --no-sort --reverse --prompt='select REPOSITORY: ' --no-multi)
fi

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
                    Limit2=$arg
                    ;;
            esac
        done
        ;;
esac

cmd="gh issue list $Type --repo $repo_name --limit $Limit2"

# pr/issue 番号取得
num=$(eval $cmd | fzf --no-sort --reverse --prompt='select ISSUE: ' --no-multi | awk '{gsub("#", "", $1); print $1}')

# コメントリスト出力
gh issue view "$num" --repo "$repo_name" --comments


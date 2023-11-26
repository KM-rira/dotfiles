#!/bin/bash

# GitHubのリポジトリ一覧を取得し、fzfで選択させる
selected_repo=$(gh repo list ${gh_user} | fzf)

# 選択されたリポジトリからリポジトリ名を抜き取る
repo_name=$(echo "$selected_repo" | awk '{print $1}')

type=""
limit=""
echo "'#'$#"
echo "'@'$@"
# 引数の有無をチェック
if [ $# -gt 0 ]; then
    # typeを設定する
    type=$(~/vimConf/tools/get_type.exe "$@")
    # limitを設定する
    limit=$(~/vimConf/tools/get_limit.exe "$@")
fi

cmd="gh pr list $type --repo $repo_name --limit $limit"
echo $cmd
eval $cmd

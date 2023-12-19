#!/bin/bash

Selected_repo=""

# Gitリポジトリのorigin URLを取得
repo_url=$(git config --get remote.origin.url)

# リポジトリURLが取得できたかどうかを確認
if [ -z "$repo_url" ]; then
    Selected_repo=""
    exit 1
fi

# URLからリポジトリ名を抽出
Selected_repo=$(echo $repo_url | sed -e 's/\.git$//' -e 's/^https:\/\/github\.com\///' -e 's/^git@github\.com://' -e 's/:/\//')

# リポジトリ名が取得できたかどうかを確認
if [ -z "$Selected_repo" ]; then
    $Selected_repo=""
    exit 1
fi

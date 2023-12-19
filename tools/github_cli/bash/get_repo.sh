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
Selected_repo=$(basename -s .git "$repo_url")

# リポジトリ名が取得できたかどうかを確認
if [ -z "$Selected_repo" ]; then
    $Selected_repo=""
    exit 1
fi

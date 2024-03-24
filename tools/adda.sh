#!/bin/bash

# コマンド履歴を取得してfzfでフィルタリング
cd $(git rev-parse --show-toplevel)

git add .

echo "===== done ====="

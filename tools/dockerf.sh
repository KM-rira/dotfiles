#!/bin/bash

# 起動中の Docker コンテナの名前を fzf で選択し、選択されたコンテナの ID を表示するスクリプト

# 'docker ps' を使用して起動中のコンテナの名前を取得し、それらを fzf でユーザーが選択できるようにする
selected_container_name=$(docker ps --format "{{.Names}}" | fzf --prompt="Select Docker container: ")

# 選択がキャンセルされた場合、スクリプトを終了
if [ -z "$selected_container_name" ]; then
    echo "No container selected."
    exit 1
fi

# 選択されたコンテナの名前から Docker コンテナ ID を取得
selected_container_id=$(docker ps -qf "name=$selected_container_name")

# 選択されたコンテナの ID を表示
echo "$selected_container_id"

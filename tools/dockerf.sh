#!/bin/bash

# 起動中の Docker コンテナのイメージ名を fzf で選択し、選択されたコンテナの ID を表示するスクリプト

# 'docker ps' を使用して起動中のコンテナのイメージ名を取得し、それらを fzf でユーザーが選択できるようにする
selected_image_name=$(docker ps --format "{{.Image}}" | sort | uniq | fzf --prompt="Select Docker image: ")

# 選択がキャンセルされた場合、スクリプトを終了
if [ -z "$selected_image_name" ]; then
    echo "No image selected."
    exit 1
fi

# 選択されたイメージ名を使用して該当するコンテナのIDを取得
selected_container_ids=$(docker ps -qf "ancestor=$selected_image_name")

# 選択されたコンテナのIDを表示
# 該当するコンテナが複数ある場合は、それぞれのIDを改行で区切って表示
if [ -z "$selected_container_ids" ]; then
    echo "No containers found for selected image."
else
    echo "$selected_container_ids"
fi

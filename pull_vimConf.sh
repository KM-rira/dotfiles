#!/bin/bash

# .bashrcに下記を追記
# nohup bash ~/dotfiles/pull.sh > /dev/null 2>&1 &
# その後実行
# chmod +x ~/dotfiles/pull.sh

# dotfiles移動
cd ~/dotfiles

# リモートリポジトリから最新の変更を取得
git pull

# init.vimを最新化する
#bash ~/dotfiles/cp_local.sh

# wezterm copy
#bash ~/dotfiles/cp_wezterm.sh


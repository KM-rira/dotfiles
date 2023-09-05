#!/bin/bash

# .bashrcに下記を追記
# nohup bash ~/vimConf/pull.sh &
# その後実行
# chmod +x ~/vimConf/pull.sh

# vimConf移動
cd ~/vimConf

# リモートリポジトリから最新の変更を取得
git pull

# init.vimを最新化する
bash ~/vimConf/cpLocal.sh

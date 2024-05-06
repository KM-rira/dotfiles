#!/bin/bash

# コマンド履歴を取得してfzfでフィルタリング
selected_command=$(cat $HOME/.bash_history | grep -v '^#' | tail | fzf --tac --no-sort --reverse --prompt='Select Command: ' --no-multi)

# 選択されたコマンドを実行
# eval "!$selected_command"
eval $selected_command

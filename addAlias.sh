#!/bin/bash

# 複数のエイリアスを効率的に`.bashrc`に追加するためには、スクリプトを一般化して、追加したいエイリアスを簡単にリストに追加できるようにすると便利です。
# 以下のスクリプトは、追加したいエイリアスを配列として列挙し、それらのエイリアスが`.bashrc`に存在しない場合にだけ追加します：

# bashrcに下記を追加。（非同期で）
# ~/vimConf/addAlias.sh

# .bashrcのパス
BASHRC="$HOME/.bashrc"

# 追加したいエイリアスをこの配列に列挙
declare -A aliases
aliases["historyg"]="history | grep"
aliases["open"]="nvim ~/.bashrc"
aliases[".."]="cd .."
aliases["..."]="cd ../.."
aliases["ll"]="ls -lt"
aliases["re"]="source ~/.bashrc"
aliases["bashrc"]="nv ~/.bashrc"
aliases["rc"]="nvim ~/AppData/Local/nvim/init.vim"
aliases["nv"]="nvim"
aliases["l"]="ls -l --color=auto"
aliases["historygrep"]="history | grep"
aliases["got"]="go test -v -cover -run "
aliases["status"]="git status"
aliases["push"]="git push"
aliases["checkout"]="git checkout"
aliases["branch"]="git branch"
aliases["fetch"]="git fetch"
aliases["log"]="git log --oneline"
aliases["fixup"]="git commit --fixup "
aliases["vimConf"]="cd ~/vimConf"
aliases["pull"]="git pull"
aliases["findall"]="sudo find / -name"

# 各エイリアスをチェック
for key in "${!aliases[@]}"; do
    # aliasが存在するかチェック
    grep -q "alias $key='${aliases[$key]}'" $BASHRC
    if [ $? -ne 0 ]; then
        echo "alias $key='${aliases[$key]}'" >> $BASHRC
        echo "add Alias > alias $key='${aliases[$key]}'"
    fi
done

echo "Done updating alias"

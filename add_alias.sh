#!/bin/bash

# 複数のエイリアスを効率的に`.bashrc`に追加するためには、スクリプトを一般化して、追加したいエイリアスを簡単にリストに追加できるようにすると便利です。
# 以下のスクリプトは、追加したいエイリアスを配列として列挙し、それらのエイリアスが`.bashrc`に存在しない場合にだけ追加します。

# bashrcに下記を追加。（非同期で）
# nohup bash ~/vimConf/addAlias.s > /dev/null 2>&1 &h

# bashrcに下記を追記すること。
# unalias -a
# source ~/vimConf/addAlias.sh

# .bashrcのパス
BASHRC="$HOME/.bashrc"

# user定義
#user=""
#while IFS= read -r line; do
#    user="${user}${line}"
#done < ~/user.txt
#echo -e "$user" | cat -v

# 追加したいエイリアスをこの配列に列挙
alias historyg='history | grep'
alias open='nvim ~/.bashrc'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ll='ls -lt'
alias re='source ~/.bashrc'
alias bashrc='nv ~/.bashrc'
# alias rc='nvim ~/AppData/Local/nvim/init.vim'
alias nv='nvim'
alias l='ls -l --color=auto'
alias historygrep='history | grep'
alias got='go test -v -cover -run '
alias status='git status'
alias push='git push'
alias checkout='git checkout'
alias branch='git branch'
alias fetch='git fetch'
alias log='git log --oneline'
alias fixup='git commit --fixup '
alias vimConf='cd ~/vimConf'
alias pull='git pull'
alias findall='sudo find / -name'
alias e='exa -l'
alias batf='fzf | xargs bat'
alias catf='fzf | xargs cat'
alias nvf='fzf | xargs nvim'
alias continue='git rebase --continue'
alias abort='git rebase --abort'
alias amend='git commit --amend -m'
alias rebasei='bash ~/vimConf/tools/rebase_helper.sh'
alias commit='git commit -m'
alias bmformat='nohup ~/vimConf/tools/book_mark_format.exe > /dev/null 2>&1 &'
alias bmf='~/vimConf/tools/book_mark_fzf.sh'
alias log='git log --oneline | nl | head -n 30'
alias oneline='git log --oneline'

# ghコマンド
alias prl="~/vimConf/tools/prl.sh"
alias isl="~/vimConf/tools/isl.sh"
alias prs="~/vimConf/tools/prs.sh"
alias iss="~/vimConf/tools/iss.sh"
alias prc="~/vimConf/tools/prc.sh"
alias isc="~/vimConf/tools/isc.sh"

alias prci="~/vimConf/tools/prci.sh"
alias prch="~/vimConf/tools/prch.sh"
alias prurl="~/vimConf/tools/prurl.sh"

echo "===== Done updating alias ====="

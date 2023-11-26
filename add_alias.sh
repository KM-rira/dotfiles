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
alias -='cd -'
alias ll='ls -lt'
alias re='source ~/.bashrc'
alias bashrc='nv ~/.bashrc'
# alias rc='nvim ~/AppData/Local/nvim/init.vim'
alias nv='nvim'
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
alias batf='bat $(fzf)'
alias catf='cat $(fzf)'
alias nvf='nvim $(fzf)'
alias bashf='bash $(fzf)'
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
alias prl="python ~/vimConf/tools/github_cli/prl.sh"
alias isl="python ~/vimConf/tools/github_cli/isl.sh"
alias prs="python ~/vimConf/tools/github_cli/prs.sh"
alias iss="python ~/vimConf/tools/github_cli/iss.sh"
alias prc="python ~/vimConf/tools/github_cli/prc.sh"
alias isc="python ~/vimConf/tools/github_cli/isc.sh"

alias prci="python ~/vimConf/tools/github_cli/prci.sh"
alias prch="python ~/vimConf/tools/github_cli/prch.sh"
alias prurl="python ~/vimConf/tools/github_cli/prurl.sh"
alias isurl="python ~/vimConf/tools/github_cli/isurl.sh"

# OS分岐
OS=$(uname)
case $OS in
    'Linux')
        alias l='exa -l'
        ;;
    'Darwin')
        echo "Mac"
        alias l='exa -l'
        ;;
    'WindowsNT' | 'CYGWIN'* | 'MINGW'*)
        alias l='ls -l --color=auto'
        ;;
    *)
        echo "Unknown OS: $OS"
        ;;
esac

echo "===== Done updating alias ====="

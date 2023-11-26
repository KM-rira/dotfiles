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
alias _='cd -'
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


# OS分岐
OS=$(uname)
case $OS in
    'Linux')
        # ls
        alias l='exa -l'
        # ghコマンド
        alias prl="python ~/vimConf/tools/github_cli/prl.py"
        alias isl="python ~/vimConf/tools/github_cli/isl.py"
        alias prs="python ~/vimConf/tools/github_cli/prs.py"
        alias iss="python ~/vimConf/tools/github_cli/iss.py"
        alias prc="python ~/vimConf/tools/github_cli/prc.py"
        alias isc="python ~/vimConf/tools/github_cli/isc.py"
        alias prci="python ~/vimConf/tools/github_cli/prci.py"
        alias prch="python ~/vimConf/tools/github_cli/prch.py"
        alias prurl="python ~/vimConf/tools/github_cli/prurl.py"
        alias isurl="python ~/vimConf/tools/github_cli/isurl.py"
        ;;
    'Darwin')
        echo "Mac"
        # ls
        alias l='exa -l'
        ;;
    'WindowsNT' | 'CYGWIN'* | 'MINGW'*)
        # ls
        alias l='ls -l --color=auto'
        # gh
        alias prl="python3 ~/vimConf/tools/github_cli/prl.py"
        alias isl="python3 ~/vimConf/tools/github_cli/isl.py"
        alias prs="python3 ~/vimConf/tools/github_cli/prs.py"
        alias iss="python3 ~/vimConf/tools/github_cli/iss.py"
        alias prc="python3 ~/vimConf/tools/github_cli/prc.py"
        alias isc="python3 ~/vimConf/tools/github_cli/isc.py"
        alias prci="python3 ~/vimConf/tools/github_cli/prci.py"
        alias prch="python3 ~/vimConf/tools/github_cli/prch.py"
        alias prurl="python3 ~/vimConf/tools/github_cli/prurl.py"
        alias isurl="python3 ~/vimConf/tools/github_cli/isurl.py"
        ;;
    *)
        echo "Unknown OS: $OS"
        ;;
esac

echo "===== Done updating alias ====="

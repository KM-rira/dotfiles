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

# export variable
export BAT_STYLE="header,grid"

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
alias bashf='bash $(find . -name "*.sh"| fzf)'
alias continue='git rebase --continue'
alias abort='git rebase --abort'
alias amend='git commit --amend -m'
alias rebasei='bash ~/vimConf/tools/rebase_helper.sh'
alias commit='git commit -m'
alias bmf='~/vimConf/tools/book_mark_format/book_mark_format.exe;~/vimConf/tools/book_mark_format/book_mark_fzf.sh'
alias log='git log --oneline | nl | head -n 30'
alias oneline='git log --oneline'
alias gs='bash ~/vimConf/tools/google_search.sh'
alias gh='bash ~/vimConf/tools/history_search.sh'
alias un='uname'

# gh
alias prl="bash ~/vimConf/tools/github_cli/bash/prl.sh"
alias isl="bash ~/vimConf/tools/github_cli/bash/isl.sh"
alias prs="bash ~/vimConf/tools/github_cli/bash/prs.sh"
alias iss="bash ~/vimConf/tools/github_cli/bash/iss.sh"
alias prc="bash ~/vimConf/tools/github_cli/bash/prc.sh"
alias isc="bash ~/vimConf/tools/github_cli/bash/isc.sh"
alias prci="bash ~/vimConf/tools/github_cli/bash/prci.sh"
alias prch="bash ~/vimConf/tools/github_cli/bash/prch.sh"
alias pru="bash ~/vimConf/tools/github_cli/bash/pru.sh"
alias isu="bash ~/vimConf/tools/github_cli/bash/isu.sh"
alias prw="bash ~/vimConf/tools/github_cli/bash/prw.sh"
alias isw="bash ~/vimConf/tools/github_cli/bash/isw.sh"

# OS分岐
OS=$(uname)
case $OS in
    'Linux')
        # ls
        alias l='exa -l'
        ;;
    'Darwin')
        echo "Mac"
        # ls
        alias l='exa -l'
        ;;
    'WindowsNT' | 'CYGWIN'* | 'MINGW'*)
        # ls
        alias l='ls -l --color=auto'
        ;;
    *)
        echo "Unknown OS: $OS"
        ;;
esac

echo "===== Done updating alias ====="

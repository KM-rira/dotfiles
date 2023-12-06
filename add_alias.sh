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
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
shopt -s histappend

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
alias gr='bash ~/vimConf/tools/google_research.sh'
alias hs='bash ~/vimConf/tools/history_search.sh'
alias un='uname'
alias diffsofancy="bash ~/vimConf/tools/diff_so_fancy_change.sh"
alias diffs="git diff --staged"

# gh
alias gpl="bash ~/vimConf/tools/github_cli/bash/prl.sh"
alias gil="bash ~/vimConf/tools/github_cli/bash/isl.sh"
alias gps="bash ~/vimConf/tools/github_cli/bash/prs.sh"
alias gis="bash ~/vimConf/tools/github_cli/bash/iss.sh"
alias gpc="bash ~/vimConf/tools/github_cli/bash/prc.sh"
alias gic="bash ~/vimConf/tools/github_cli/bash/isc.sh"
alias gpci="bash ~/vimConf/tools/github_cli/bash/prci.sh"
alias gpch="bash ~/vimConf/tools/github_cli/bash/prch.sh"
alias gpu="bash ~/vimConf/tools/github_cli/bash/pru.sh"
alias giu="bash ~/vimConf/tools/github_cli/bash/isu.sh"
alias gpw="bash ~/vimConf/tools/github_cli/bash/prw.sh"
alias giw="bash ~/vimConf/tools/github_cli/bash/isw.sh"
alias gpco="bash ~/vimConf/tools/github_cli/bash/prco.sh"

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

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
alias hg='history | grep'
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
alias diff="git diff"
alias restore="git restore --staged"
alias restorea="git restore --staged ."
alias add="git add"
alias adda="git add ."
alias reseth="git fetch;git reset --hard"
alias findf="find * -name"
alias findd="find * -type d -name"
alias cdf='cd $(find * -type d | fzf)'

# gh
alias gpl="bash ~/vimConf/tools/github_cli/bash/gpl.sh"
alias gil="bash ~/vimConf/tools/github_cli/bash/gil.sh"
alias gps="bash ~/vimConf/tools/github_cli/bash/gps.sh"
alias gis="bash ~/vimConf/tools/github_cli/bash/gis.sh"
alias gpc="bash ~/vimConf/tools/github_cli/bash/gpc.sh"
alias gic="bash ~/vimConf/tools/github_cli/bash/gic.sh"
alias gpci="bash ~/vimConf/tools/github_cli/bash/gpci.sh"
alias gpch="bash ~/vimConf/tools/github_cli/bash/gpch.sh"
alias gpu="bash ~/vimConf/tools/github_cli/bash/gpu.sh"
alias giu="bash ~/vimConf/tools/github_cli/bash/giu.sh"
alias gpw="bash ~/vimConf/tools/github_cli/bash/gpw.sh"
alias giw="bash ~/vimConf/tools/github_cli/bash/giw.sh"
alias gpco="bash ~/vimConf/tools/github_cli/bash/gpco.sh"

# OS分岐
OS=$(uname)
case $OS in
    'Linux')
        alias l='exa -l'
        alias rc='nvim ~/.config/nvim/init.vim'
        alias wez='echo "not windows"'
        ;;
    'Darwin')
        echo "Mac"
        alias l='exa -l'
        alias rc='nvim ~/.config/nvim/init.vim'
        alias wez='echo "not windows"'
        ;;
    'WindowsNT' | 'CYGWIN'* | 'MINGW'*)
        alias l='ls -l --color=auto'
        alias rc='nvim ~/AppData/Local/nvim/init.vim'
        alias wez='nvim ~/vimConf/wezterm.lua'
        ;;
    *)
        echo "Unknown OS: $OS"
        ;;
esac

echo "===== Done updating alias ====="

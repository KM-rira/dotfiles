#!/bin/bash

# 複数のエイリアスを効率的に`.bashrc`に追加するためには、スクリプトを一般化して、追加したいエイリアスを簡単にリストに追加できるようにすると便利です。
# 以下のスクリプトは、追加したいエイリアスを配列として列挙し、それらのエイリアスが`.bashrc`に存在しない場合にだけ追加します。

# bashrcに下記を追加。（非同期で）
# nohup bash ~/vimConf/addAlias.s > /dev/null 2>&1 &h

# bashrcに下記を追記すること。
# unalias -a
# source ~/vimConf/addAlias.sh

bashrc="$HOME/.bashrc"
vimConf="$HOME/vimConf"

# user定義
#user=""
#while IFS= read -r line; do
#    user="${user}${line}"
#done < ~/user.txt
#echo -e "$user" | cat -v
eval "$(zoxide init bash)"
# export variable
export BAT_STYLE="header,grid"
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
shopt -s histappend
# デフォルトのエディタ設定
export EDITOR=nvim
export GIT_EDITOR=nvim

# 追加したいエイリアスをこの配列に列挙
alias open='nvim ~/.bashrc'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias _='cd -'
alias ll='ls -lt'
alias re='source ~/.bashrc'
alias bashrc='nv ~/.bashrc'
# alias rc='nvim ~/AppData/Local/nvim/init.vim'
alias nv='nvim'
alias hg='history | grep'
alias got='go test -v -cover -run '
alias status='git status'
alias statuss='git status -s'
alias push='git push'
alias checkout='git checkout'
alias branch='git branch'
alias fetch='git fetch'
alias log='git log --oneline'
alias fixup='git commit --fixup '
alias vimConf='cd ~/vimConf'
alias pull='git pull'
alias show='git show'
alias findall='sudo find / -name'
alias findalld='sudo find / -type d -name'
alias batf='bash ~/vimConf/tools/batf.sh'
alias catf='bash ~/vimConf/tools/catf.sh'
alias nvf='bash ~/vimConf/tools/nvf.sh'
alias vf='bash ~/vimConf/tools/nvf.sh'
alias bashf='bash ~/vimConf/tools/bashf.sh'
alias fixupf='bash ~/vimConf/tools/fixupf.sh'
alias showf='bash ~/vimConf/tools/showf.sh'
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
alias diff="bash ~/vimConf/tools/diff_so_fancy_change.sh"
alias gdiffs="git diff --staged"
alias gdiff="git diff"
alias restore="bash ~/vimConf/tools/restore.sh"
alias restoref="bash ~/vimConf/tools/restoref.sh"
alias restorea="bash ~/vimConf/tools/restorea.sh"
alias restores="git restore --staged"
alias restoresf="bash ~/vimConf/tools/restoresf.sh"
alias restoresa="bash ~/vimConf/tools/restoresa.sh"
alias add="git add"
alias addf="bash ~/vimConf/tools/addf.sh"
alias adda="bash ~/vimConf/tools/adda.sh"
alias reseth="git fetch;git reset --hard"
alias findf="find * -name"
alias findd="find * -type d -name"
alias cdf='cd "$(find * -type d | fzf --no-sort --reverse --prompt="Select FOLDER: " --no-multi)" || cd "$(pwd)"'
alias changefile='git diff --name-only'
alias stagefile='git diff --name-only --staged'
alias v='nvim'
alias c='cd'
alias commitid='bash ~/vimConf/tools/get_commit_id.sh'
alias t='tig'
alias resetsoft='git reset --soft HEAD~1'
alias stash='git stash'
alias stashl='git stash list'
alias stasha='git stash apply'
alias stashs='git stash show'
alias stashp='git stash push'
alias stagestash='git stash push --keep-index --include-untracked'
alias wez='nvim ~/vimConf/wezterm.lua'
alias wt="nvim ~/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
alias g="grep"
alias c="cd"
alias addalias='nvim ~/vimConf/add_alias.sh'
alias func='nvim ~/vimConf/nvim/func.lua'
alias keymap='nvim ~/vimConf/nvim/keymap.lua'
alias command='nvim ~/vimConf/nvim/command.lua'
alias auto='nvim ~/vimConf/nvim/auto.lua'
alias plug='nvim ~/vimConf/nvim/plug.lua'
alias setting='nvim ~/vimConf/nvim/setting.lua'
alias view='nvim ~/vimConf/nvim/view.lua'
alias rc='nvim ~/vimConf/nvim/init.lua'
alias rco='nvim ~/vimConf/nvim/bk/init.vim'
alias dockerf="bash ~/vimConf/tools/dockerf.sh"
alias switch='git switch'
alias dcu='docker compose up --build -d'
alias dlogsf='docker logs -f $(dockerf)'
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
        alias l='exa -l --icons'
        alias wezl='echo "not windows"'
        alias nvimf='cd ~/.config/nvim'
        alias setting='echo "not windows"'
        alias fd=fdfind
        ;;
    'Darwin')
        echo "Mac"
        alias l='exa -l --icons'
        alias wezl='echo "not windows"'
        alias nvimf='cd ~/.config/nvim'
        alias setting='echo "not windows"'
        alias fd=fdfind
        ;;
    'WindowsNT' | 'CYGWIN'* | 'MINGW'*)
        alias l='ls -l --color=auto'
        alias wezl='nvim ~/.config/wezterm/wezterm.lua'
        alias nvimf='cd ~/AppData/Local/nvim'
        alias setting="nvim ~/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
        ;;
    *)
        echo "Unknown OS: $OS"
        ;;
esac

echo "===== Done updating alias ====="

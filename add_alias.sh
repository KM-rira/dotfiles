#!/bin/bash


# bashrcに下記を追加。（非同期で）
# nohup bash ~/vimConf/addAlias.s > /dev/null 2>&1 &h

# bashrcに下記を追記すること。
# unalias -a
# source ~/vimConf/addAlias.sh

# 開始時間を記録（ミリ秒単位のタイムスタンプ）
START_TIME=$(date +%s%3N)

bashrc="$HOME/.bashrc"
vc="$HOME/vimConf"

# user定義
#user=""
#while IFS= read -r line; do
#    user="${user}${line}"
#done < ~/user.txt
#echo -e "$user" | cat -v
eval "$(zoxide init bash)"
# export variable
export BAT_STYLE="header,grid"
export BAT_THEME="TwoDark"

export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
# デフォルトのエディタ設定
export EDITOR=nvim
export GIT_EDITOR=nvim

mkdir -p $HOME/.tmp
chmod +x $vc/tools/rgv_preview.sh

##alias fzf="fzf --height 70% --layout reverse --info inline --border     --preview 'batcat --color=always {}' --preview-window '~3'      --bind 'ctrl-/:change-preview-window(50%|hidden|)'     --color 'fg:#bbccdd,fg+:#ddeeff,bg:#334455,preview-bg:#223344,border:#778899'"

# 追加したいエイリアスをこの配列に列挙
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias _='cd -'
alias ld='lazydocker'
alias ll='ls -lt'
alias bashrc='nv ~/.bashrc'
alias zshrc='nv ~/.zshrc'
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
alias vc='cd ~/vimConf'
alias pull='git pull'
alias show='git show'
alias findall='sudo find / -name'
alias findalld='sudo find / -type d -name'
. ~/vimConf/tools/batf.sh
. ~/vimConf/tools/bf.sh
alias catf='bash ~/vimConf/tools/catf.sh'
. ~/vimConf/tools/vf.sh
. ~/vimConf/tools/vff.sh
. ~/vimConf/tools/bashf.sh
alias fixupf='bash ~/vimConf/tools/fixupf.sh'
alias showf='bash ~/vimConf/tools/showf.sh'
alias continue='git rebase --continue'
alias abort='git rebase --abort'
alias amend='git commit --amend -m'
alias rebasei='bash ~/vimConf/tools/rebase_helper.sh'
. ~/vimConf/tools/commit.sh
alias bmf="go run $vc/bookmark/book_mark_format.go;~/vimConf/tools/book_mark_format/book_mark_fzf.sh"
alias log='git log --oneline | nl | head -n 30'
alias oneline='git log --oneline'
alias gs='bash ~/vimConf/tools/google_search.sh'
alias gr='bash ~/vimConf/tools/google_research.sh'
alias hs='bash ~/vimConf/tools/history_search.sh'
alias un='uname'
alias dif="bash ~/vimConf/tools/diff_so_fancy_change.sh"
alias gdiffs="git diff --staged"
alias gdiff="git diff"
alias restore="bash ~/vimConf/tools/restore.sh"
source "$HOME/vimConf/tools/restoref.sh"
alias restorea="bash ~/vimConf/tools/restorea.sh"
alias restores="git restore --staged"
source "$vc/tools/restoresf.sh"
alias restoresa="bash ~/vimConf/tools/restoresa.sh"
alias add="git add"
. ~/vimConf/tools/addf.sh
. ~/vimConf/tools/adda.sh
. ~/vimConf/tools/addc.sh
alias reseth="git fetch;git reset --hard"
alias findf="find * -name"
alias findd="find * -type d -name"
alias cdf='cd "$(find * -type d | fzf --no-sort --reverse --prompt="Select FOLDER: " --no-multi)" || cd "$(pwd)"'
#alias cf="bash ~/vimConf/tools/cf.sh"
#alias f='cd "$(ls -d */ | fzf --no-sort --prompt="CHANGE DIR: ")"'
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
alias aliases='nvim ~/vimConf/add_alias.sh'
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
alias commitid='bash ~/vimConf/tools/get_commit_id.sh'
alias d='bash ~/vimConf/tools/do.sh'
# alias ff="ls -F | grep -v / | sed 's/\*//g' | fzf --height 70% --layout reverse --info inline --border     --preview 'batcat --color=always {}' --preview-window '~3'      --bind 'ctrl-/:change-preview-window(50%|hidden|)'     --color 'fg:#bbccdd,fg+:#ddeeff,bg:#334455,preview-bg:#223344,border:#778899'"
. ~/vimConf/tools/rgv.sh
alias rgb='bash ~/vimConf/tools/rgb.sh'
. ~/vimConf/tools/fdv.sh
. ~/vimConf/tools/fdb.sh
. ~/vimConf/tools/f.sh
. ~/vimConf/tools/ff.sh
alias h='history'
alias m='make'
alias packer='cd ~/.local/share/nvim/site/pack/packer/start/'
source $HOME/vimConf/tools/wezcp.sh

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

# note
note="$HOME/vimConf/tools/note"
go run $vc/tools/launcher/launcher.go "$HOME/vimConf/tools/note" && source $HOME/.tmp/file_list.sh || echo "fail lancher.go"
#source $HOME/vimConf/tools/launcher/note_launcher.sh

# OS分岐
OS=$(uname)
case $OS in
    'Linux')
        alias l='lsd -l'
        alias wezl='echo "not windows"'
        alias nvimf='cd ~/.config/nvim'
        alias setting='echo "not windows"'
        alias fd=fdfind
        alias fzf="fzf --height 70% --layout reverse --info inline --border     --preview 'batcat --color=always {}' --preview-window '~3'      --bind 'ctrl-/:change-preview-window(50%|hidden|)'"
        alias gfzf="fzf --height 70% --layout reverse --info inline --border     --preview 'git diff --color=always HEAD -- {}' --preview-window '~3'      --bind 'ctrl-/:change-preview-window(50%|hidden|)'"
        alias lfzf="fzf --height 70% --layout reverse --info inline --border \
            --preview 'lsd -l {}' --preview-window '~3' \
            --bind 'ctrl-/:change-preview-window(50%|hidden|)'"
        #. ~/vimConf/tools/prompt/ps1.sh
        . ~/vimConf/tools/prompt/prompt.sh
        alias b='batcat'
        alias bat='batcat'
        #shopt -s histappend
        alias re='source ~/.zshrc'
        alias ports='ss -tuln'
        ;;
    'Darwin')
        echo "Mac"
        alias l='lsd -l'
        alias wezl='echo "not windows"'
        alias nvimf='cd ~/.config/nvim'
        alias setting='echo "not windows"'
        alias fzf="fzf --height 70% --layout reverse --info inline --border     --preview 'bat --color=always {}' --preview-window '~3'      --bind 'ctrl-/:change-preview-window(50%|hidden|)'"
        alias gfzf="fzf --height 70% --layout reverse --info inline --border     --preview 'git diff --color=always HEAD -- {}' --preview-window '~3'      --bind 'ctrl-/:change-preview-window(50%|hidden|)'"
        alias lfzf="fzf --height 70% --layout reverse --info inline --border \
            --preview 'lsd -l {}' --preview-window '~3' \
            --bind 'ctrl-/:change-preview-window(50%|hidden|)'"
        . ~/vimConf/tools/prompt/prompt.sh
        alias re='source ~/.zshrc'
        alias ports='lsof -i -P | grep -i "listen"'
        ;;
    'WindowsNT' | 'CYGWIN'* | 'MINGW'*)
        alias l='lsd -l'
        alias wezl='nvim ~/.config/wezterm/wezterm.lua'
        alias nvimf='cd ~/AppData/Local/nvim'
        alias settings="nvim ~/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
        alias fzf="fzf --height 70% --layout reverse --info inline --border"
        . ~/vimConf/tools/prompt/win_ps1.sh
        alias b='batcat'
        alias bat='batcat'
        alias gfzf="fzf --height 70% --layout reverse --info inline --border"
        alias lfzf="fzf --height 70% --layout reverse --info inline --border"
        shopt -s histappend
        alias re='source ~/.bashrc'
        ;;
    *)
        echo "Unknown OS: $OS"
        ;;
esac

if [ "$SHELL" = "/bin/zsh" ] || [ "$SHELL" = "$(which zsh)" ]; then
    alias zshplug="v $vc/zsh_plug.sh"
    source "$vc/zsh_plug.sh"
fi

source $vc/tools/time_caliculator.sh


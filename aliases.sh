#!/bin/zsh


# .zshrcに下記を追加
# source ~/dotfiles/aliases.sh

# bashrcに下記を追記すること。
# unalias -a
# source ~/dotfiles/addAlias.sh

# 開始時間を記録（ミリ秒単位のタイムスタンプ）
START_TIME=$(date +%s.%N)

bashrc="$HOME/.bashrc"
dot="$HOME/dotfiles"

alias nv='neovide'
export EZA_ICONS_AUTO=1
local eza_options=' -la --git --icons --group-directories-first'

eval "$(starship init zsh)"

export CHEAT_PATH=~/dotfiles/cheat
bindkey -e
# user定義
#user=""
#while IFS= read -r line; do
#    user="${user}${line}"
#done < ~/user.txt
#echo -e "$user" | cat -v
eval "$(zoxide init zsh)"
##eval "$(mcfly init zsh)"
# export variable
export BAT_STYLE="header"
export BAT_THEME="TwoDark"
export BAT_OPTS="--color=always --paging=never"
# OSに応じたコピーコマンドの設定
if [[ "$OSTYPE" == "darwin"* ]]; then
    export FZF_COPY_CMD="pbcopy"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # xselの場合は標準入力から受け取る
    export FZF_COPY_CMD="xclip -selection clipboard"
fi

# FZF_DEFAULT_OPTS の --bind 部分を修正
export FZF_DEFAULT_OPTS='
  --height=~60%
  --layout=reverse
  --border
  --cycle
  --multi
  --info=inline-right
  --scroll-off=3
  --color="pointer:#ff0000:bold,fg+:#00ff00:bold:underline,bg+:#333333,hl+:#00BFFF:bold"
  --pointer="▶"
  --marker="●"
  --preview "bat --color=always --style=numbers --line-range :500 {}"
  --preview-window "right,50%,border-left,follow"
  --header "Keys: [C-t]Top [C-l]Last [C-/]Preview [C-u/d]Scroll [C-y]Copy [Tab]Select"
  --bind "ctrl-u:preview-page-up,ctrl-d:preview-page-down"
  --bind "ctrl-t:top,ctrl-l:last,ctrl-/:toggle-preview"
  --bind "ctrl-a:select-all,ctrl-x:deselect-all"
'
#  --bind "ctrl-y:execute-silent(printf '%s' {+} | xclip -selection clipboard)"
export FZF_DEFAULT_OPTS="
    ${FZF_DEFAULT_OPTS}
    --bind 'ctrl-y:execute-silent(printf '%s' {+} | ${FZF_COPY_CMD})'
"

eval "$(fzf --zsh)"
# # 2. 各機能のコマンド指定
export FZF_CTRL_T_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git --exclude node_modules --exclude .cache'
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'

# 3. Ctrl+R 専用設定（履歴検索を軽くする）
export FZF_CTRL_R_OPTS='
  --preview ""
  --header "History Search [C-y]Copy"
  --bind "ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort"
'

# 4. シェル連携のロードとキー奪還
# fzf を使って配下のディレクトリを選択し、移動する関数
function fzf-cd-subdirs() {
    # fd を使用してディレクトリのみを抽出
    # --max-depth 1: 現在の直下のみ
    # --type d: ディレクトリのみ
    # --hidden: 隠しディレクトリも含める（不要なら消してください）
    # --exclude: 除外したいディレクトリがあれば追加
    local dir=$(fd --max-depth 1 --type d --hidden --exclude .git . 2> /dev/null | fzf --height 40% --reverse --border)

    if [ -n "$dir" ]; then
        BUFFER="cd ${(q)dir}"
        zle accept-line
    fi
    zle reset-prompt
}
zle -N fzf-cd-subdirs

# Ctrl + G にバインド
bindkey '^g' fzf-cd-subdirs

fzf-open-file() {
  local file
  file=$(fd --type f --hidden --follow --exclude .git | fzf --height=60%)
  [ -n "$file" ] && ${EDITOR:-nvim} "$file"
}
zle -N fzf-open-file
fzf-open-nvim() {
  local file
  file=$(fd --type f --hidden --follow --exclude .git | fzf --height=60%)
  [ -n "$file" ] && nvim "$file"
}
zle -N fzf-open-nvim
# bindkey '^E' fzf-open-nvim
bindkey '^O' fzf-open-file
# export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
# デフォルトのエディタ設定
export EDITOR=nvim
export GIT_EDITOR=nvim
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

setopt APPEND_HISTORY        # 既存ファイルに追記
setopt INC_APPEND_HISTORY    # コマンド実行ごとに履歴ファイルへ追記（重要）
setopt SHARE_HISTORY         # 複数端末で履歴共有（必要なら）

mkdir -p $HOME/.tmp
chmod +x $dot/tools/rgv_preview.sh

##alias fzf="fzf --height 70% --layout reverse --info inline --border     --preview 'batcat --color=always {}' --preview-window '~3'      --bind 'ctrl-/:change-preview-window(50%|hidden|)'     --color 'fg:#bbccdd,fg+:#ddeeff,bg:#334455,preview-bg:#223344,border:#778899'"

alias e='emacs'
alias el='emacs .'
# alias ree='doom sync && emacs'
# export PATH="$HOME/.emacs.d/bin:$PATH"
# export DOOMDIR="$HOME/dotfiles/emacs/doom"

cd ~/dotfiles/tools/gocli
make build &
cd -
. "$dot/tools/gocli/generate/output/alias.sh"
alias gocli='cd ~/dotfiles/tools/gocli'

# 追加したいエイリアスをこの配列に列挙
alias clip='clip.exe'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias _='cd -'
alias ld='lazydocker'
alias dps='docker ps'
alias dl='docker logs'
alias dcdn='docker compose down'
alias dcup='docker compose up -d'
alias restart='docker compose down;docker compose up -d'
alias ll='ls -lt'
alias bashrc='v ~/.bashrc'
alias zshrc='v ~/.zshrc'
alias y='yazi'
alias help='tldr'
# alias rc='nvim ~/AppData/Local/nvim/init.vim'
alias hg='history | grep'
alias got='go test -v -cover -run '
alias status='git status'
alias statuss='git status -s'
alias push='git push'
alias checkout='git checkout'
alias branch='git branch'
alias fetch='git fetch'
alias fixup='git commit --fixup '
alias dot='cd ~/dotfiles'
alias pull='git pull'
alias show='git show'
alias findall='sudo find / -name'
alias findalld='sudo find / -type d -name'
alias geminiq='go run ~/dotfiles/tools/gemini/main.go'
alias catf='bash ~/dotfiles/tools/catf.sh'
. ~/dotfiles/tools/vff.sh
. ~/dotfiles/tools/bashf.sh
alias fixupf='bash ~/dotfiles/tools/fixupf.sh'
alias continue='git rebase --continue'
alias abort='git rebase --abort'
alias amend='git commit --amend -m'
alias rebasei='bash ~/dotfiles/tools/rebase_helper.sh'
. ~/dotfiles/tools/commit.sh
alias bmf="go run $dot/bookmark/book_mark_format.go;~/dotfiles/tools/book_mark_format/book_mark_fzf.sh"
alias log='git log --oneline | nl | head -n 30'
alias oneline='git log --oneline --decorate --graph'
alias alllog='git log --stat --patch --decorate --graph --all --full-history --pretty=fuller --date=iso'
alias gs='bash ~/dotfiles/tools/google_search.sh'
alias gr='bash ~/dotfiles/tools/google_research.sh'
alias hs='bash ~/dotfiles/tools/history_search.sh'
alias un='uname'
alias dif="bash ~/dotfiles/tools/diff_so_fancy_change.sh"
alias gdiff="bash $dot/tools/gdiff.sh"
alias restore="bash ~/dotfiles/tools/restore.sh"
source "$HOME/dotfiles/tools/restoref.sh"
alias restorea="bash ~/dotfiles/tools/restorea.sh"
alias restores="git restore --staged"
source "$dot/tools/restoresf.sh"
source "$dot/tools/replaceall.sh"
alias restoresa="bash ~/dotfiles/tools/restoresa.sh"
alias add="git add"
. ~/dotfiles/tools/addf.sh
. ~/dotfiles/tools/adda.sh
. ~/dotfiles/tools/addc.sh
#. ~/dotfiles/tools/create_branch.sh
alias createbranch='lua ~/dotfiles/tools/create_branch.lua'
alias reseth="git fetch;git reset --hard"
alias findf="find * -name"
alias findd="find * -type d -name"
alias cdf='cd "$(find * -type d | fzf --no-sort --reverse --prompt="Select FOLDER: " --no-multi)" || cd "$(pwd)"'
#alias cf="bash ~/dotfiles/tools/cf.sh"
#alias f='cd "$(ls -d */ | fzf --no-sort --prompt="CHANGE DIR: ")"'
alias changefile='git diff --name-only'
alias stagefile='git diff --name-only --staged'
alias v='nvim'
alias c='cd'
alias commitid='bash ~/dotfiles/tools/get_commit_id.sh'
alias t='tig'
alias lg='lazygit'
alias resetsoft='git reset --soft HEAD~1'
alias stash='git stash'
alias stashl='git stash list'
alias stasha='git stash apply'
alias stashs='git stash show'
alias stashp='git stash push'
alias stagestash='git stash push --keep-index --include-untracked'
alias wt="nvim ~/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
alias g="grep"
alias c="cd"
alias aliases='nvim ~/dotfiles/aliases.sh'
alias func='nvim ~/dotfiles/nvim/func.lua'
alias keymap='nvim ~/dotfiles/nvim/keymap.lua'
alias command='nvim ~/dotfiles/nvim/command.lua'
alias auto='nvim ~/dotfiles/nvim/auto.lua'
alias plug='nvim ~/dotfiles/nvim/plug.lua'
alias coc-setting='nvim ~/dotfiles/nvim/coc-settings.json'
alias setting='nvim ~/dotfiles/nvim/setting.lua'
alias view='nvim ~/dotfiles/nvim/view.lua'
alias rc='nvim ~/dotfiles/nvim/init.lua'
alias rco='nvim ~/dotfiles/nvim/bk/init.vim'
alias dockerf="bash ~/dotfiles/tools/dockerf.sh"
alias switch='git switch'
alias dcu='docker compose up --build -d'
alias dlogsf='docker logs -f $(dockerf)'
alias commitid='bash ~/dotfiles/tools/get_commit_id.sh'
alias ours='git checkout --ours .'
alias theirs='git checkout --theirs .'
alias d='bash ~/dotfiles/tools/do.sh'
# alias ff="ls -F | grep -v / | sed 's/\*//g' | fzf --height 70% --layout reverse --info inline --border     --preview 'batcat --color=always {}' --preview-window '~3'      --bind 'ctrl-/:change-preview-window(50%|hidden|)'     --color 'fg:#bbccdd,fg+:#ddeeff,bg:#334455,preview-bg:#223344,border:#778899'"
. ~/dotfiles/tools/rgv.sh
alias rgb='bash ~/dotfiles/tools/rgb.sh'
. ~/dotfiles/tools/f.sh
. ~/dotfiles/tools/ff.sh
. ~/dotfiles/tools/apply.sh
. ~/dotfiles/tools/curlfmt.sh
. ~/dotfiles/tools/maketarget.sh
. ~/dotfiles/tools/targetdate.sh
alias h='history'
alias m='make'
alias packer='cd ~/.local/share/nvim/site/pack/packer/start/'
source $HOME/dotfiles/tools/wezcp.sh
alias ccze='ccze -A'
alias conflicts='git diff --name-only --diff-filter=U'

. ~/dotfiles/tools/difff.sh

# gh
alias gpl="bash ~/dotfiles/tools/github_cli/bash/gpl.sh"
alias gil="bash ~/dotfiles/tools/github_cli/bash/gil.sh"
alias gps="bash ~/dotfiles/tools/github_cli/bash/gps.sh"
alias gis="bash ~/dotfiles/tools/github_cli/bash/gis.sh"
alias gpc="bash ~/dotfiles/tools/github_cli/bash/gpc.sh"
alias gic="bash ~/dotfiles/tools/github_cli/bash/gic.sh"
alias gpci="bash ~/dotfiles/tools/github_cli/bash/gpci.sh"
alias gpch="bash ~/dotfiles/tools/github_cli/bash/gpch.sh"
alias gpu="bash ~/dotfiles/tools/github_cli/bash/gpu.sh"
alias giu="bash ~/dotfiles/tools/github_cli/bash/giu.sh"
alias gpw="bash ~/dotfiles/tools/github_cli/bash/gpw.sh"
alias giw="bash ~/dotfiles/tools/github_cli/bash/giw.sh"
alias gpco="bash ~/dotfiles/tools/github_cli/bash/gpco.sh"

# note
mkdir -p "$HOME/note"
note="$HOME/note"
go run $dot/tools/launcher/launcher.go "$HOME/dotfiles/tools/note" && source $HOME/.tmp/file_list.sh || echo "fail lancher.go"
#source $HOME/dotfiles/tools/launcher/note_launcher.sh

### macOS ###
if [[ "$OS" == "Darwin" ]]; then
    alias copy="pbcopy"
    alias paste="pbpaste"
    alias open="open"

### Linux ###
elif [[ "$OS" == "Linux" ]]; then
    # copy: xclip または xsel が必要
    if command -v xclip >/dev/null 2>&1; then
        alias copy="xclip -selection clipboard"
        alias paste="xclip -selection clipboard -o"
    elif command -v xsel >/dev/null 2>&1; then
        alias copy="xsel --clipboard --input"
        alias paste="xsel --clipboard --output"
    else
        echo "Install xclip or xsel for copy/paste"
    fi

    alias open="xdg-open"

### Windows(Git Bash / MSYS / WSL) ###
elif echo "$OS" | grep -qi "mingw\|msys\|cygwin"; then
    alias copy='powershell.exe -NoLogo -NoProfile -Command "Set-Clipboard"'
    alias paste='powershell.exe -NoLogo -NoProfile -Command "Get-Clipboard"'
    alias open='powershell.exe /c start'
fi

# OS分岐
OS=$(uname)
case $OS in
    'Linux')
        alias l="eza $eza_options"
        alias tree='eza --tree'
        alias wez='echo "not windows"'
        alias nvimf='cd ~/.config/nvim'
        alias setting='echo "not windows"'
        alias fzf="fzf --height 70% --layout reverse --info inline --border     --preview 'bat --color=always {}' --preview-window '~3'      --bind 'ctrl-/:change-preview-window(50%|hidden|)'"
        alias gfzf="fzf --height 70% --layout reverse --info inline --border     --preview 'git diff --color=always HEAD -- {}' --preview-window '~3'      --bind 'ctrl-/:change-preview-window(50%|hidden|)'"
        alias lfzf="fzf --height 70% --layout reverse --info inline --border \
            --preview 'eza -1 --icons=never --no-git --color=never {}' --preview-window '~3' \
            --bind 'ctrl-/:change-preview-window(50%|hidden|)'"
        # . ~/dotfiles/tools/prompt/prompt.sh
        alias b='bat'
        alias batcat='bat'
        #shopt -s histappend
        alias re='source ~/.zshrc'
        alias ports='ss -tuln'
        autoload -Uz bracketed-paste-magic
        zle -N bracketed-paste bracketed-paste-magic
        ;;
    'Darwin')
        alias l="eza $eza_options"
        alias tree='eza --tree'
        alias wez='nvim ~/.config/wezterm/wezterm.lua'
        alias nvimf='cd ~/.config/nvim'
        alias setting='echo "not windows"'
        alias fzf="fzf --height 70% --layout reverse --info inline --border     --preview 'bat --color=always {}' --preview-window '~3'      --bind 'ctrl-/:change-preview-window(50%|hidden|)'"gg
        alias gfzf="fzf --height 70% --layout reverse --info inline --border     --preview 'git diff --color=always HEAD -- {}' --preview-window '~3'      --bind 'ctrl-/:change-preview-window(50%|hidden|)'"
        alias lfzf="fzf --height 70% --layout reverse --info inline --border \
            --preview 'eza -1 --no-icons --no-git --color=never {}' --preview-window '~3' \
            --bind 'ctrl-/:change-preview-window(50%|hidden|)'"
        # . ~/dotfiles/tools/prompt/prompt.sh
        alias re='source ~/.zshrc'
        alias ports='lsof -i -P | grep -i "listen"'
        alias b='bat'
        alias batcat='bat'
        autoload -Uz bracketed-paste-magic
        zle -N bracketed-paste bracketed-paste-magic
        ;;
    'WindowsNT' | 'CYGWIN'* | 'MINGW'*)
        alias l="eza $eza_options"
        alias tree='eza --tree'
        alias wez='nvim ~/.config/wezterm/wezterm.lua'
        alias nvimf='cd ~/AppData/Local/nvim'
        alias settings="nvim ~/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
        alias fzf="fzf --height 70% --layout reverse --info inline --border"
        . ~/dotfiles/tools/prompt/win_ps1.sh
        alias b='bat'
        alias batcat='bat'
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
    alias zshplug="v $dot/zsh_plug.sh"
    source "$dot/zsh_plug.sh"
fi

# 終了時間を記録
END_TIME=$(date +%s.%N)

# 開始時間と終了時間の差を計算
ELAPSED_TIME=$(echo "$END_TIME - $START_TIME" | bc)


# 結果を表示
echo "================================"
printf "UpdateTime: %.3f 秒\n" "$ELAPSED_TIME"
echo "================================"

# The best way
# curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

# Using Homebrew (OS X)
# brew install zplug

export ZPLUG_HOME=$HOME/.zplug
source $ZPLUG_HOME/init.zsh

# autoload -Uz compinit && compinit

# NOTE zstyle
zstyle ':completion:*' menu select
zstyle ':completion:*' auto-list true
zstyle ':completion:*' file-sort time
autoload -Uz colors; colors
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' list-colors \
  'di=34:fi=0:ln=36:pi=33:so=35:do=32:bd=33;40:cd=33;40:or=31;47:mi=00;41'
zstyle ':completion:*:*files' ignored-patterns '*?.o'

# NOTE setopt list
setopt autocd
setopt no_beep
setopt nobeep
setopt nolistbeep
setopt share_history
setopt correct
setopt extended_glob
setopt noautoremoveslash
setopt EXTENDED_GLOB
# 末尾から自動的に/を除かない

setopt auto_param_slash
# 末尾に自動的に/を追加

setopt auto_param_keys
# カッコを自動補完

setopt magic_equal_subst
# --prefix=以降でも補完

setopt list_packed
# 詰めて表示

setopt numeric_glob_sort
# 辞書順ではなく数値順でソート

# 設定ファイル ~/.zshrc に追加
setopt HIST_IGNORE_SPACE  # スペースで始まるコマンドを履歴に記録しない
setopt HIST_IGNORE_DUPS   # 重複する履歴エントリを記録しない
setopt HIST_FIND_NO_DUPS  # 履歴からの補完時に重複しない
setopt HIST_REDUCE_BLANKS # 履歴からの補完時に空白を削除する

# bindkey
# Ctrl + p で履歴から補完する設定
bindkey '^P' history-beginning-search-backward
# Ctrl + n で履歴から補完する設定
bindkey '^N' history-beginning-search-forward

# NOTE zplug list
# zplug の初期化
source ~/.zplug/init.zsh
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "akarzim/zsh-docker-aliases"
#zplug "jeffreytse/zsh-vi-mode"
# zplug "zsh-users/zsh-async"

# プラグインの読み込み
if ! zplug check; then
  zplug install
fi

zplug load

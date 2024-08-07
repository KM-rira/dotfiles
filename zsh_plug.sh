# The best way
# curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

# Using Homebrew (OS X)
# brew install zplug

autoload -Uz compinit && compinit

# NOTE zstyle
zstyle ':completion:*:setopt:*' menu true select
zstyle ':completion:*' auto-list true
zstyle ':completion:*' file-sort time
autoload -Uz colors; colors
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' list-colors \
  'di=34:fi=0:ln=36:pi=33:so=35:do=32:bd=33;40:cd=33;40:or=31;47:mi=00;41'
zstyle ':completion:*:*files' ignored-patterns '*?.o'

# NOTE setopt list
setopt autocd
setopt hist_ignore_dups
setopt no_beep
setopt nobeep
setopt nolistbeep
setopt share_history
setopt correct
setopt extended_glob
setopt noautoremoveslash
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

setopt hist_ignore_space


# NOTE zplug list
# zplug の初期化
source ~/.zplug/init.zsh
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "MichaelAquilina/zsh-auto-notify"
zplug "akarzim/zsh-docker-aliases"
#zplug "jeffreytse/zsh-vi-mode"
# zplug "zsh-users/zsh-async"

# プラグインの読み込み
if ! zplug check; then
  zplug install
fi

zplug load

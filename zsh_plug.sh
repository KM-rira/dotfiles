# The best way
# curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

# Using Homebrew (OS X)
# brew install zplug

# NOTE zstyle
zstyle ':completion:*:setopt:*' menu true select
zstyle ':completion:*' auto-list true

# NOTE setopt list
setopt autocd
setopt hist_ignore_dups
setopt no_beep
setopt share_history
setopt correct
setopt extended_glob

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

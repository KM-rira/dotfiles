# Antigen install
#curl -L git.io/antigen > ~/.antigen.zsh

export ANTIGEN_LOG_FILE="$HOME/.antigen.log"
# Antigenの設定
source ~/.antigen.zsh

# プラグインの設定
# Oh My Zshのプラグインを含む
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle MichaelAquilina/zsh-auto-notify

# その他のプラグインをここに追加できます
# 例: antigen bundle zsh-users/zsh-completions

# Antigenの設定を適用
antigen apply

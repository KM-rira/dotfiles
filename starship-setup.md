# Homebrewでフォントをインストール

## mac
brew install --cask font-jetbrains-mono-nerd-font

brew install starship

echo 'eval "$(starship init zsh)"' >> ~/.zshrc

source ~/.zshrc

## linux
sudo mkdir -p /usr/share/fonts/jetbrains-mono
sudo unzip JetBrainsMono.zip -d /usr/share/fonts/jetbrains-mono
sudo fc-cache -fv

curl -sS https://starship.rs/install.sh | sh

# 既存の PROMPT 設定などがあればコメントアウトし、最後にこれを書く
echo 'eval "$(starship init zsh)"' >> ~/.zshrc


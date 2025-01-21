## cloneする
```bash
git clone https://github.com/KM-rira/vimConf.git
Username for 'https://github.com': KM-rira
Password for 'https://KM-rira@github.com': <ここにパーソナルアクセストークンを入力>
```

## cp_local.shで、init.vimを配置する

## 有効なツール
Windowsで、PowerToys。画面分割が容易になる。

## Go
### linux
```bash
# 最新バージョン確認
https://go.dev/dl/

curl -O https://dl.google.com/go/go1.x.x.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.x.x.linux-amd64.tar.gz

# bashrcに追加
export PATH=$PATH:/usr/local/go/bin
source ~/.bashrc
go version
```

## Neovim
### linux
#### install
```bash
sudo apt update
sudo apt install neovim
nvim --version
```

## Neovim update
### linux
```bash
sudo snap install nvim --classic
```

## coc.nvim
```bash
:CocInstall coc-go
```

#### update
```bash
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install neovim
nvim --version
```

```bash
### vim-plugのインストール
```bash
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

## coc.vim のセットアップ
```bash
https://vimawesome.com/plugin/coc-nvim
```

## bat install
### linux
```bash
sudo apt-get update
sudo apt-get install bat
```

### windows
#### choco install by powershell
```bash
# 管理者権限で
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco -v
powershell reboot
```
#### bat
```bash
# 管理者権限で
choco install bat
```

## exa
```bash
sudo apt update
sudo apt install exa
```

## fzf
### linux
```bash
sudo apt-get update
sudo apt-get install fzf
```

### windows
```bash
https://github.com/junegunn/fzf-bin/releases
```

## add github cli
### linux
```bash
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null && sudo apt update && sudo apt install gh -y
gh auth login
```

### windows
```bash
https://cli.github.com/
gh auth login
```

## jq
```bash
sudo apt update
```

### windows
```bash
# 管理者権限で
choco install jq
```

## diff-so-fancy
### linux
```bash
sudo apt update
# install npm
sudo apt install nodejs npm

# proxyの設定が必要かも
# npm config set proxy http://proxy.xxx:8080
# npm config set https-proxy http://proxy.xxx:8080

# install diff-so-fancy by npm
sudo npm install -g diff-so-fancy

# color
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --global color.ui true
git config --global color.diff-highlight.oldNormal "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"
git config --global color.diff.meta "11"
git config --global color.diff.frag "magenta bold"
git config --global color.diff.commit "yellow bold"
git config --global color.diff.old "red bold"
git config --global color.diff.new "green bold"
git config --global color.diff.whitespace "red reverse"
```

### windows
```bash
# nodejs install

# install diff-so-fancy by npm
npm install -g diff-so-fancy

# color
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --global color.ui true
git config --global color.diff-highlight.oldNormal "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"
git config --global color.diff.meta "11"
git config --global color.diff.frag "magenta bold"
git config --global color.diff.commit "yellow bold"
git config --global color.diff.old "red bold"
git config --global color.diff.new "green bold"
git config --global color.diff.whitespace "red reverse"
```

## node.js
### linux
```bash
# update
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
re
nvm install node
node -v
```

## Go install
### gopls
```
go install golang.org/x/tools/gopls@latest
go install golang.org/x/tools/cmd/goimports@latest
```

## glow install
### windows
```bash
# windows 管理者権限で
choco install glow

# linux
sudo snap install glow
```

## ソフトリンク作成
```bash
# neovim
ln -s ~/vimConf/nvim/init.vim ./init.vim

# wezterm
ln ~/vimConf/wezterm.lua ~/.config/wezterm/wezterm.lua
```

## ripgrep
```bash
# windows
choco install ripgrep

#linux
sudo apt-get install ripgrep
```

## zoxide
```bash
# Linux
sudo apt install zoxide
# windows
choco install zoxide
```

## colordiff
```bash
sudo apt install colordiff
```

## wasavi
```bash
# オプションに下記追加
set noerrorbells
set nolaunchbell
```

## Ubuntu日本語設定
```bash
sudo apt update

# ログを日本語化
sudo apt install language-pack-ja
sudo update-locale LANG=ja_JP.UTF-8

# manコマンド日本語化
sudo apt install manpages-ja manpages-ja-dev
# LANGがja_JP.UTF-8になっていることを確認してください。
locale
# なっていなければ
sudo update-locale LANG=ja_JP.UTF-8
# 確認
man ls
```

## Rust
```bash
# 1(defaultを選択)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
rustc --version
cargo --version
cargo install code-minimap
code-minimap --version
```

## win32yank.exe
```
hmod +x win32yank.exe
```

# python support
```bash
npm install -g pyright

:CocInstall coc-pyright
```

# packer
```bash
# windows
git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"

# linux
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

# fd
```bash
# windows
choco install fd

# linux
sudo apt install fd-find
```

# lua lsp
```bash
sudo apt update
sudo apt install ninja-build cmake

git clone https://github.com/sumneko/lua-language-server
cd lua-language-server
git submodule update --init --recursive

https://github.com/LuaLS/lua-language-server/wiki/Getting-Started
./make.sh

# install パスによって下記を変更する
      "command": "/home/koji/repo/lua-language-server/bin/lua-language-server",
      "args": ["-E", "/home/koji/repo/lua-language-server/bin/main.lua"],

# nvimで
:CocInstall coc-sumneko-lua
```

# lsd
```bash
# linux
sudo snap install lsd

# windows
choco install lsd
```

# lazydocker

```bash
go install github.com/jesseduffield/lazydocker@latest
```

# procs

```bash
cargo install procs
```

# kindle shortcut path
```bash
rm /mnt/c/Users/ユーザー名/AppData/Roaming/Microsoft/Windows/Start\ Menu/Programs/Amazon/Amazon\ Kindle/Kindle.lnk > /dev/null 2>&1 &
```
# linux mint
```bash
sudo apt install copyq -y
sudo apt install xclip
```

# startup

## homebrew install
```
sudo apt update
sudo apt install build-essential curl file git
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>~/.bashrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>~/.zshrc
source ~/.zshrc
brew --version
```


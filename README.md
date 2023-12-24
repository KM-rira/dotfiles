## cloneする
```bash
git clone https://github.com/KM-rira/vimConf.git
Username for 'https://github.com': KM-rira
Password for 'https://KM-rira@github.com': <ここにパーソナルアクセストークンを入力>
```

## cp_local.shで、init.vimを配置する

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
# 管理者権限で
choco install glow
```

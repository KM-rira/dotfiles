## cloneする
git clone https://github.com/KM-rira/vimConf.git
Username for 'https://github.com': KM-rira
Password for 'https://KM-rira@github.com': <ここにパーソナルアクセストークンを入力>

## cp_local.shで、init.vimをコピーする

## Neovim
```bash
sudo apt update
sudo apt install neovim
```

### vim-plugのインストール
```bash
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

## coc.vim のセットアップ
```bash
https://vimawesome.com/plugin/coc-nvim
```

## bat install
```bash
sudo apt-get update
sudo apt-get install bat
```

## exa instal (Ubuntu 20.04以降であれば、exaは公式のリポジトリに含まれているので、次のコマンドでインストールできます。)
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
```bash
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null && sudo apt update && sudo apt install gh -y
```
###
```bash
gh auth login
```


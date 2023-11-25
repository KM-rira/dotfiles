## cloneする
```bash
git clone https://github.com/KM-rira/vimConf.git
Username for 'https://github.com': KM-rira
Password for 'https://KM-rira@github.com': <ここにパーソナルアクセストークンを入力>
```

## cp_local.shで、init.vimを配置する

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
### linux
```bash
sudo apt-get update
sudo apt-get install bat
```

### windows
#### choco install by powershell
```bash
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco -v
powershell reboot
```
#### bat install
```bash
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


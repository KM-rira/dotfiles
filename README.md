## cloneする
git clone https://github.com/KM-rira/vimConf.git
Username for 'https://github.com': KM-rira
Password for 'https://KM-rira@github.com': <ここにパーソナルアクセストークンを入力>

## mvHome.shで、vimrcとbashrcをホームディレクトリ上にコピーする

## pureline for bashrc
source ~/vimConf/pureline/pureline ~/.pureline.conf

## vim-plugのインストール
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

## coc.vim のセットアップ
https://vimawesome.com/plugin/coc-nvim

## bat install
wget https://github.com/sharkdp/bat/releases/download/v0.18.3/bat_0.18.3_amd64.deb
sudo dpkg -i bat_0.18.3_amd64.deb

## exa instal (Ubuntu 20.04以降であれば、exaは公式のリポジトリに含まれているので、次のコマンドでインストールできます。)
sudo apt update
sudo apt install exa

## fzf
sudo apt-get update
sudo apt-get install fzf

#!/bin/sh

#cp ~/AppData/Local/nvim/init.vim ~/vimConf/init.vim
#cp ~/.bashrc ~/vimConf/.bashrc

# 環境によって適宜変更
# cp ~/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json ~/settings.json

OS=$(uname)

case $OS in
    'Linux')
        echo "Linux"
        cp ~/.config/nvim/init.vim ~/vimConf/init.vim
        ;;
    'Darwin')
        echo "Mac"
        ;;
    'WindowsNT' | 'CYGWIN'* | 'MINGW'*)
        echo "Windows"
        cp ~/AppData/Local/nvim/init.vim ~/vimConf/init.vim
        ;;
    *)
        echo "Unknown OS: $OS"
        ;;
esac

#!/bin/sh

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

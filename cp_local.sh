#!/bin/sh

OS=$(uname)

case $OS in
    'Linux')
        echo "Linux"
        mkdir -p ~/.config/nvim
        cp -R ~/vimConf/nvim/* ~/.config/nvim
        ;;
    'Darwin')
        echo "Mac"
        ;;
    'WindowsNT' | 'CYGWIN'* | 'MINGW'*)
        echo "Windows"
        mkdir -p ~/AppData/Local/nvim
        cp -R ~/vimConf/nvim/* ~/AppData/Local/nvim
        ;;
    *)
        echo "Unknown OS: $OS"
        ;;
esac


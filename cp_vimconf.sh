#!/bin/sh

OS=$(uname)

case $OS in
    'Linux')
        echo "Linux"
        cp -R ~/.config/nvim/* ~/vimConf/nvim
        ;;
    'Darwin')
        echo "Mac"
        ;;
    'WindowsNT' | 'CYGWIN'* | 'MINGW'*)
        echo "Windows"
        cp ~/AppData/Local/nvim/* ~/vimConf/nvim
        ;;
    *)
        echo "Unknown OS: $OS"
        ;;
esac

#!/bin/sh

OS=$(uname)

case $OS in
    'Linux')
        echo "Linux"
        cp -R ~/.config/nvim/* ~/dotfiles/nvim
        ;;
    'Darwin')
        echo "Mac"
        ;;
    'WindowsNT' | 'CYGWIN'* | 'MINGW'*)
        echo "Windows"
        cp ~/AppData/Local/nvim/* ~/dotfiles/nvim
        ;;
    *)
        echo "Unknown OS: $OS"
        ;;
esac

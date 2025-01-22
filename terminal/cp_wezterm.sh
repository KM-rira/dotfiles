#!/bin/sh

OS=$(uname)

case $OS in
    'Linux')
        echo "Linux"
        ;;
    'Darwin')
        echo "Mac"
        ;;
    'WindowsNT' | 'CYGWIN'* | 'MINGW'*)
        echo "Windows"
        mkdir -p ~/AppData/Local/nvim
        cp -R ~/dotfiles/wezterm.lua ~/.config/wezterm/wezterm.lua
        ;;
    *)
        echo "Unknown OS: $OS"
        ;;
esac


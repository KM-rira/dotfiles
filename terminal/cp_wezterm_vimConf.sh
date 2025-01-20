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
        cp -R ~/.config/wezterm/wezterm.lua ~/vimConf/wezterm.lua
        ;;
    *)
        echo "Unknown OS: $OS"
        ;;
esac


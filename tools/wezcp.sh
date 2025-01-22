#!/bin/bash

wezcp() {
    OS=$(uname)

    case $OS in
        'Linux')
            echo "Linux"
            ;;
        'Darwin')
            # Mac
            cp -R ~/dotfiles/wezterm.lua ~/.config/wezterm/wezterm.lua
            ;;
        'WindowsNT' | 'CYGWIN'* | 'MINGW'*)
            cp -R ~/dotfiles/wezterm.lua ~/.config/wezterm/wezterm.lua
            ;;
        *)
            echo "Unknown OS: $OS"
            ;;
    esac
}


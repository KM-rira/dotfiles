#!/bin/sh

# VScodeのキーボード設定をvimConfのvscodeKeybord.jsonに反映させるためのコード

OS=$(uname)

case $OS in
    'Linux')
        echo "can't update keybord.json: Linux"
        ;;
    'Darwin')
        echo "can't update keybord.json: Mac"
        ;;
    'WindowsNT' | 'CYGWIN'* | 'MINGW'*)
        cat ~/vimConf/vscode_keybord.json > ~/AppData/Roaming/Code/User/keybindings.json 
        echo "update done keybord.json: Windows"
        ;;
    *)
        echo "can't update keybord.json: Unknown OS: $OS"
        ;;
esac

#!/bin/sh

# VScodeのキーボード設定をvimConfのvscodeKeybord.jsonに反映させるためのコード
# 環境によって適宜変更

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
        cat ~/AppData/Roaming/Code/User/keybindings.json > ~/vimConf/vscodeKeybord.json
        ;;
    *)
        echo "Unknown OS: $OS"
        ;;
esac

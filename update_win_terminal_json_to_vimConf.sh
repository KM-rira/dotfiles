#!/bin/sh

# windows terminalの設定をvimConfのterminal_setting.jsonに反映させるためのコード

OS=$(uname)

case $OS in
    'Linux')
        echo "can't update json: Linux"
        ;;
    'Darwin')
        echo "can't update json: Mac"
        ;;
    'WindowsNT' | 'CYGWIN'* | 'MINGW'*)
        cp ${wt_path} "$HOME/vimConf/terminal_settings.json"
        echo "update done json: Windows"
        ;;
    *)
        echo "can't update json: Unknown OS: $OS"
        ;;
esac

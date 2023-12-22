#!/bin/bash

# 機能説明
# .bashrcに${add_line}のコードがない場合にソースコードを追加する機能

# .bashrcファイルのパスを設定
BASHRC="$HOME/.bashrc"

# 指定された行が.bashrcに存在するかどうかを確認し、存在しない場合にその行を追加する関数
add_line() {
    local line=$1
    grep -qF -- "$line" "$BASHRC"
    if [ $? -ne 0 ]; then
        # .bashrcファイルに指定された行がない場合、その行を追加
        echo "$line" >> "$BASHRC"
        echo "add code > $line"
    fi
}

# 必要な行を.bashrcに追加
add_line "source ~/vimConf/pureline/pureline ~/.pureline.conf"
add_line "# unalias -a"
add_line "source ~/vimConf/add_alias.sh"
add_line "HISTSIZE=100000"
add_line "HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S '"
add_line "bash ~/vimConf/pull_vimConf.sh"
add_line "source ~/vimConf/add_alias.sh"
add_line 'export BAT_STYLE="header,grid"'

echo "=== Updated $BASHRC if necessary. ==="

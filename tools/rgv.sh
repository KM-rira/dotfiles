#!/bin/bash

rgv() {
    if [ "$#" -eq 0 ] ; then
        echo "===== NEED PARAMETER ====="
        return
    fi

    FILE_COUNT=$(rg -l "$*" | wc -l)
    if [ $FILE_COUNT -eq 0 ] ; then
        echo "===== NOT FOUND FILE ====="
        return
    fi

    SELECT_FILE=$(rg -l "$*" | fzf --tac --no-sort --reverse --prompt='SELECT FILE: ' --no-multi)
    EXT="${SELECT_FILE##*.}"
    # リポジトリ名の抽出失敗した場合
    if [ -z "$SELECT_FILE" ] ; then
        echo "===== EXIT PROCESS ====="
        return
    fi

    ROW_NUM=$(rg -n $1 $SELECT_FILE | fzf --tac --no-sort --reverse --prompt='SELECT ROW: ' --no-multi --preview "$HOME/dotfiles/tools/rgv_preview.sh {} ${SELECT_FILE} ; bat --color=always $HOME/.tmp/tmp.${EXT}" | cut -d ':' -f 1)

    # 選択されたコマンドを実行
    echo $SELECT_FILE
    nvim $SELECT_FILE +$ROW_NUM
}


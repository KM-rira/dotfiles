#!/bin/bash

f() {
    # オプションを解析
    while getopts "a" opt; do
      case ${opt} in
        a )
          COMMAND='ls -da .*/ */'
           ;;
        \? )
          echo "Usage: cmd [-a]"
          return
          ;;
      esac
    done

    echo "1 $COMMAND"

    # デフォルトのコマンドオプションを設定（オプションが指定されていない場合）
    COMMAND="${COMMAND:-"ls -d */"}"

    echo "2 $COMMAND"
    # 現在のディレクトリにあるディレクトリのリストを取得
    directories=$(eval $COMMAND)
    echo "directories $directories"

    # ディレクトリが存在するか確認
    if [ -n "$directories" ]; then
        # ディレクトリが存在する場合、fzfで選択させる
        dir=$(echo "$directories" | lfzf --height 40%)
        if [ -z "$dir" ] ; then
            echo "===== EXIT PROCESS ====="
        else
            echo "===== cd $dir ====="
            cd $dir
        fi
    else
        # ディレクトリが存在しない場合のメッセージ
        echo "===== NOT EXISTS DIR ====="
    fi
}


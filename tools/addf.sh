#!/bin/bash


addf() {
    current_dir=$PWD
    echo $current_dir

    # フラグの初期値を設定
    flag=false

    # オプションを解析
    while getopts "u" opt; do
      case ${opt} in
        u )
          flag=true
          ;;
        \? )
          echo "Usage: cmd [-u]"
          return
          ;;
      esac
    done

    cd $(git rev-parse --show-toplevel)

    # コマンド実行部分
    if [ "$flag" = true ]; then
      # -u オプションが指定された場合
      select_file=$( git diff --name-only | fzf --no-sort --prompt='SELECT ADD FILE: ' --multi)
    else
      # -u オプションが指定されなかった場合
      select_file=$(git status --short | cut -c4- | fzf --no-sort --prompt='SELECT ADD FILE: ' --multi)
    fi

    if [ -z "$select_file" ] ; then
        echo "===== EXIT PROCESS ====="
        cd $current_dir
        return
    fi

    # 選択されたコマンドを実行
    git add $select_file

    cd $current_dir

    echo "===== DONE ====="
}

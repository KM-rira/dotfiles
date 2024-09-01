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
        select_file=$( git diff --name-only | gfzf --no-sort --prompt='SELECT ADD FILE: ' --multi)
    else
        # -u オプションが指定されなかった場合
        # ステージングされていない変更のあるファイル
        unstaged_files=$(git diff --name-only)

        # 追跡されていないファイル
        untracked_files=$(git ls-files --others --exclude-standard)

        # 結合して表示
        all_files=$(echo "$unstaged_files"$'\n'"$untracked_files")
        select_file=$( echo "$all_files" | gfzf --no-sort --prompt='SELECT ADD FILE: ' --multi)
    fi

    if [ -z "$select_file" ] ; then
        echo "===== EXIT PROCESS ====="
        cd $current_dir
        return
    fi

    # 選択されたコマンドを実行
    echo "$select_file" | xargs git add

    cd $current_dir
    echo "===== DONE ====="
}

#!/bin/bash

replaceall() {
    # 引数が2未満の場合はエラーメッセージを表示して終了
    if [ "$#" -lt 2 ]; then
        echo "===== NEED PARAMETERS ====="
        echo "Usage: replaceall \"<BEFORE>\" \"<AFTER>\""
        return 1
    fi

    local BEFORE="$1"
    local AFTER="$2"

    # sed用の特殊文字をエスケープ
    local escaped_BEFORE
    local escaped_AFTER

    escaped_BEFORE=$(printf '%s\n' "$BEFORE" | sed 's/[\/&]/\\&/g')
    escaped_AFTER=$(printf '%s\n' "$AFTER" | sed 's/[\/&]/\\&/g')

    # sedの区切り文字を | に変更
    local sed_expr="s|${escaped_BEFORE}|${escaped_AFTER}|g"

    # 必要なコマンドが存在するかチェック
    for cmd in rg sed; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            echo "Error: '$cmd' コマンドが見つかりません。インストールしてください。"
            return 1
        fi
    done

    local OS
    OS=$(uname)

    case $OS in
        'Linux')
            if rg -l --null "$BEFORE" | xargs -0 sed -i "$sed_expr"; then
                echo "Replaced '$BEFORE' with '$AFTER' in files."
            else
                echo "Error: 置換処理中にエラーが発生しました。"
                return 1
            fi
            ;;
        'Darwin')
            # Mac
            if rg -l --null "$BEFORE" | xargs -0 sed -i "" "$sed_expr"; then
                echo "Replaced '$BEFORE' with '$AFTER' in files."
            else
                echo "Error: 置換処理中にエラーが発生しました。"
                return 1
            fi
            ;;
        'WindowsNT' | CYGWIN* | MINGW*)
            if rg -l --null "$BEFORE" | xargs -0 sed -i "$sed_expr"; then
                echo "Replaced '$BEFORE' with '$AFTER' in files."
            else
                echo "Error: 置換処理中にエラーが発生しました。"
                return 1
            fi
            ;;
        *)
            echo "Unknown OS: $OS"
            return 1
            ;;
    esac

    echo "==== DONE ===="
}


#!/bin/bash

# 引数からファイル名を取得
filename="$1"

# ファイルの拡張子を取得
extension="${filename##*.}"

# 拡張子に応じて条件分岐
case $extension in
  py)
    # Pythonファイルの場合
    python "$filename"
    ;;
  go)
    # Goファイルの場合
    go run "$filename"
    ;;
  sh)
    # Shellスクリプトの場合
    bash "$filename"
    ;;
  *)
    # それ以外のファイルの場合
    source "$filename"
    ;;
esac


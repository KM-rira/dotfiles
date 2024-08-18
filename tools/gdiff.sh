#!/bin/bash

# デフォルトのコマンドオプションを設定
COMMAND="git diff"

# オプションを解析
while getopts "s" opt; do
  case ${opt} in
    s )
      COMMAND='git diff --staged'
      ;;
    \? )
      echo "Usage: $0 [-s]"
      exit 1
      ;;
  esac
done

# コマンドを実行
$COMMAND

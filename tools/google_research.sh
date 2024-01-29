#!/bin/bash

# Chrome履歴ファイルのパス
CHROME_HISTORY_DB="$HOME/AppData/Local/Google/Chrome/User Data/Default/History"

# 履歴ファイルのコピーを作成（Chromeが使用中の場合のため）
HISTORY_DB="$HOME/chrome_history_copy.db"
cp "$CHROME_HISTORY_DB" "$HISTORY_DB"

# fzfを使用してタイトルを選択し、変数に格納
select_title=$(
sqlite3 "$HISTORY_DB" "SELECT DISTINCT title FROM urls ORDER BY last_visit_time DESC LIMIT 100" |
     fzf --no-sort --reverse --prompt='Search History: ' --no-multi)

get_url=$(sqlite3 "$HISTORY_DB" "SELECT url FROM urls WHERE title='$select_title' ORDER BY last_visit_time DESC LIMIT 1")

start $get_url
echo "===== Google research: '${select_title}' ====="
# コピーした履歴ファイルを削除
rm "$HISTORY_DB"

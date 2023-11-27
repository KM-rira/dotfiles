#!/bin/bash

# Chrome履歴ファイルのパス
CHROME_HISTORY="$HOME/AppData/Local/Google/Chrome/User Data//History"

# 履歴ファイルのコピーを作成（Chromeが使用中の場合のため）
HISTORY_DB="$HOME/chrome_history_copy.db"
cp "$CHROME_HISTORY" "$HISTORY_DB"

# SQLiteコマンドを使用してURLのタイトルを抽出し、fzfでフィルタリング
# 選択された行からURLを取得
sqlite3 "$HISTORY_DB" "SELECT title, url FROM urls ORDER BY last_visit_time DESC" |
    awk -F'|' '{print $1}' |
    fzf --no-sort --reverse --prompt='Search History: ' --no-multi |
    grep -Ff - "$HISTORY_DB" | awk -F'|' '{print $2}'

# コピーした履歴ファイルを削除
rm "$HISTORY_DB"
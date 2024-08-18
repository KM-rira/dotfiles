#!/bin/bash

# 終了時間を記録（ミリ秒単位のタイムスタンプ）
END_TIME=$(date +%s%3N)

# 開始時間と終了時間の差を計算
DIFF_MS=$((END_TIME - START_TIME))

# 秒とミリ秒に分ける
DIFF_SEC=$((DIFF_MS / 1000))
DIFF_MS_REST=$((DIFF_MS % 1000))

# 時、分、秒に分ける
DIFF_HOUR=$((DIFF_SEC / 3600))
DIFF_MIN=$(((DIFF_SEC % 3600) / 60))
DIFF_SEC_REST=$((DIFF_SEC % 60))

# フォーマットされた経過時間の表示
printf "Elapsed Time: %02d:%02d:%02d.%03d\n" $DIFF_HOUR $DIFF_MIN $DIFF_SEC_REST $DIFF_MS_REST


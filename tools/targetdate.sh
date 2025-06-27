#!/bin/zsh

# ウィグルの日程までの日付を算出するコマンド
targetdate() {
	local target="${targetDate}"
	# 現在のエポック秒
	local now_epoch=$(date +%s)
	# 目標日をエポック秒に変換（-j: 実際の時刻変更をせず、-f: フォーマット指定）
	local target_epoch=$(date -j -f "%Y-%m-%d" "$target" "+%s")

	if ((target_epoch > now_epoch)); then
		# 秒差を日数に換算（切り捨て）
		local days=$(((target_epoch - now_epoch) / 86400))
		echo "あと ${days} 日です。（${target} まで）"
	else
		echo "${target} は既に過ぎています。"
	fi
}

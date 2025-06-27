#!/bin/zsh

maketarget() {
	# Makefile のターゲット一覧を抽出（自動生成の内部ターゲットなどが混じることもあるためフィルタリングしています）
	local target
	target=$(make -qp 2>/dev/null | awk -F: '/^[a-zA-Z0-9][^$#\/\t=]*:([^=]|$)/ {print $1}' | sort -u | fzf --prompt="Select make target: ")
	if [ -n "$target" ]; then
		echo "実行中: make $target"
		make "$target"
	fi
}

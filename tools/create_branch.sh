#!/bin/zsh

createbranch() {
	local local_only=0

	# -l オプションが指定されているかチェック
	while getopts "l" opt; do
		case "$opt" in
			l) local_only=1 ;;
			*) echo "Usage: createbranch [-l] branch_name"; return 1 ;;
		esac
	done
	shift $((OPTIND - 1))

	if [ "$#" -eq 0 ]; then
		echo "===== NEED PARAMETER ====="
		return 1
	fi

	branch="$1"
	git checkout -b "$branch"

	# -l が指定されていない場合はリモートにプッシュ
	if [ "$local_only" -eq 0 ]; then
		git push -u origin "$branch"
	fi
}

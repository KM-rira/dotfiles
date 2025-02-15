#!/bin/zsh

createbranch() {
	if [ "$#" -eq 0 ]; then
		echo "===== NEED PARAMETER ====="
		return 1
	fi

	branch="$1"
	git checkout -b "$branch"
	git push -u origin "$branch"
}

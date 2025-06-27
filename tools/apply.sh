#!/bin/zsh

function apply() {
	if [[ -z "$1" ]]; then
		echo "使い方: apply <stash番号>"
		return 1
	fi

	git stash apply "stash@{$1}"
}

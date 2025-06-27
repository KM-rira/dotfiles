#!/bin/zsh

curlfmt() {
	echo "$@" | sed 's/ -/ \\\n-/g'
}

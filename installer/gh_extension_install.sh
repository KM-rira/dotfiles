#!/bin/bash

if ! command -v gh >/dev/null 2>&1; then
	echo "gh is not installed."
	exit 1
fi

error_list=()

install_extension() {
	local extension="$1"

	echo -e "================\n $extension start!!!\n================"
	gh extension install "$extension"
	status=$?
	if [ "$status" -ne 0 ]; then
		error_list+=("$extension")
	fi
	echo -e "================\n $extension end!!!\n================"
}

extensions=(
	dlvhdr/gh-dash
	github/gh-aw
	basecamp/gh-signoff
	yusukebe/gh-markdown-preview
)

for extension in "${extensions[@]}"; do
	install_extension "$extension"
done

if [ "${#error_list[@]}" -ne 0 ]; then
	echo -e "==================\nError: ${error_list[*]} installation failed.\n=================="
	exit 1
else
	echo -e "==================\nAll extensions installed successfully.\n=================="
fi

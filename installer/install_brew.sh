#!/bin/bash

if [ "$(id -u)" -eq 0 ]; then
	echo "You are root."
	exit 1
fi

error_list=()

install_function() {
	echo -e "================\n $2 start!!!\n================"
	eval "$1 $2 $3"
	status=$?
	# エラーチェック
	if [ $status -ne 0 ]; then
		error_list+=("$2")
	fi
	echo -e "================\n $2 end!!!\n================"
}

# brew install
install_cmd='brew install'
packages=(git-delta dust tlrc glances glow)
for package in "${packages[@]}"; do
	install_function "$install_cmd" "$package"
done

git config --global core.pager delta
git config --global interactive.diffFilter 'delta --color-only'
git config --global delta.navigate true
git config --global merge.conflictStyle zdiff3

# error_list が空でない場合、エラーを出力
if [ ${#error_list[@]} -ne 0 ]; then
	echo -e "==================\nError: ${error_list[@]} installation failed.\n=================="
	exit 1
else
	echo -e "==================\nAll installation is successful.\n=================="
fi

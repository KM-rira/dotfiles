#!/bin/bash

# if [ "$(id -u)" -eq 0 ]; then
# 	echo "You are root."
# 	exit 1
# fi

prerequisite_installation_list=(bash cargo zsh)

for prerequisite_installation in "${prerequisite_installation_list[@]}"; do
	which "$prerequisite_installation"
	if [ $? -ne 0 ]; then
		echo "$prerequisite_installation is not installed."
		exit 1
	fi
done

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

# brew install (cczeなくなった)
install_cmd='brew install'
packages=(gh git-delta dust tlrc glances glow yazi lazygit lazydocker cheat usql bat luarocks zoxide jq fd ripgrep fzf zoxide shfmt lsd duf node npm chrony vim sd)
for package in "${packages[@]}"; do
	if [ "$package" = "usql" ]; then
		brew tap xo/xo
	fi
	install_function "$install_cmd" "$package"
done

# 事後に実行
# sudo chronyd -q 'server ntp.nict.jp iburst'

# git-delta の設定
git config --global core.pager delta
git config --global interactive.diffFilter 'delta --color-only'
git config --global delta.navigate true
# wslではエラーだったのでコメントアウト、mergeが正しい
#git config --global merge.conflictStyle zdiff3

# cargo install
install_cmd='cargo install'
packages=(xsv)
for package in "${packages[@]}"; do
	install_function "$install_cmd" "$package"
done

# npm install
install_cmd='npm install -g'
package=(gtop aicommits cspell)
for package in "${packages[@]}"; do
	install_function "$install_cmd" "$package"
done

# error_list が空でない場合、エラーを出力
if [ ${#error_list[@]} -ne 0 ]; then
	echo -e "==================\nError: ${error_list[@]} installation failed.\n=================="
	exit 1
else
	echo -e "==================\nAll installation is successful.\n=================="
fi

#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
	echo "You are not root."
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

# update
echo -e "================\n update start!!!\n================"
apt update
apt-get update
echo -e "================\n update end!!!\n================"

# apt-get install
install_cmd='apt-get install -y'
packages=(bat lsd duf nodejs npm ntpdate)

# 配列内の各パッケージに対して install_function を実行
for package in "${packages[@]}"; do
	install_function "$install_cmd" "$package"
done

ntpdate ntp.nict.jp

# apt install
install_cmd='apt install -y'
packages=(zoxide lazygit jq fd-find ripgrep fzf zoxide shfmt zsh)

# 配列内の各パッケージに対して install_function を実行
for package in "${packages[@]}"; do
	install_function "$install_cmd" "$package"
done

# brew install
install_cmd='brew install'
packages=(git-delta dust tlrcg lances)
echo -e "========\n $install_cmd start!!!\n========"
apt-get install -y build-essential procps curl file git
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
echo -e "========\n $install_cmd end!!!\n========"

for package in "${packages[@]}"; do
	install_function "$install_cmd" "$package"
done

# npm install
install_cmd='npm install'
package=(gtop)
install_function "$install_cmd" "$package" "-g"

# error_list が空でない場合、エラーを出力
if [ ${#error_list[@]} -ne 0 ]; then
	echo -e "==================\nError: ${error_list[@]} installation failed.==================\n"
	exit 1
fi

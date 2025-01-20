#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo "You are not root."
    exit 1
fi

# 引数を２つ受け取るメソッド
install_function() {
    echo -e "========\n $2 start!!!\n========"
    eval "$1 $2"
    echo -e "========\n $2 end!!!\n========"
}

# apt install
# update
echo -e "========\n update start!!!\n========"
apt update
apt-get update
echo -e "========\n update end!!!\n========"

install_cmd='apt-get install -y'
package='bat'
install_function "$install_cmd" "$package"

package='lsd'
install_function "$install_cmd" "$package"

package='duf'
install_function "$install_cmd" "$package"

package='fd-find'
install_function "$install_cmd" "$package"

package='ntpdate'
install_function "$install_cmd" "$package"
ntpdate ntp.nict.jp


# brew install
install_cmd='brew install'
echo -e "========\n $install_cmd start!!!\n========"
apt-get install -y build-essential procps curl file git
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
echo -e "========\n $install_cmd end!!!\n========"

package='git-delta'
install_function "$install_cmd" "$package"

package='dust'
install_function "$install_cmd" "$package"


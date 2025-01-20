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

# update
echo -e "========\n update start!!!\n========"
apt update
apt-get update
echo -e "========\n update end!!!\n========"

# apt-get install
install_cmd='apt-get install -y'
package='bat'
install_function "$install_cmd" "$package"

package='lsd'
install_function "$install_cmd" "$package"

package='duf'
install_function "$install_cmd" "$package"

package='fd-find'
install_function "$install_cmd" "$package"

package='ripgrep'
install_function "$install_cmd" "$package"

package='fzf'
install_function "$install_cmd" "$package"

package='jq'
install_function "$install_cmd" "$package"

package='nodejs'
install_function "$install_cmd" "$package"

package='npm'
install_function "$install_cmd" "$package"

package='ntpdate'
install_function "$install_cmd" "$package"
ntpdate ntp.nict.jp

# apt-get install
install_cmd='apt install -y'

package='zoxide'
install_function "$install_cmd" "$package"

package='lazygit'
install_function "$install_cmd" "$package"

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

package='tlrc'
install_function "$install_cmd" "$package"

package='glances'
install_function "$install_cmd" "$package"

# npm install
install_cmd='npm install'

package='gtop -g'
install_function "$install_cmd" "$package"


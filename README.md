# setup procedure

## nvim setting
$ v -v
NVIM v0.10.3
Build type: RelWithDebInfo
LuaJIT 2.1.1713484068
Run "nvim -V1 -v" for more info

### tag log
git for-each-ref refs/tags --sort=taggerdate \
  --format='%(refname:short) %(taggerdate)'

### install
sudo apt install ninja-build gettext cmake unzip curl build-essential
git clone git@github.com:neovim/neovim.git
git tag
git checkout vx.x.x
make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=$HOME/.local install
make install

### 失敗時:
rm -rf ~/repo/neovim/build
rm -rf ~/repo/neovim/.deps
rm -rf ~/.local/bin/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/lib/nvim
rm -rf ~/.local/state/nvim
make distclean

## clone
```bash
git clone https://github.com/KM-rira/dotfiles.git
```

```
brew install
```

```
cd dotfiles/installer
bash install_brew.sh
sudo bash install.sh
```

## install list
```
zsh
lazygit
go install github.com/TheEdgeOfRage/logfmt
sudo npm install -g cspell
```

## edit zshrc
```
# zshchに追加
echo "nohup bash ~/dotfiles/pull_dotfiles.sh > /dev/null 2>&1 & >>" ~/.zshrc
echo "source ~/dotfiles/aliases.sh" >> ~/.zshrc
```

## edit cheat config
```
~/.config/cheat/conf.yml
cheatpathsのpersonalのpathを~/dotfiles/cheatsに変更
```

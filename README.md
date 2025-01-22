# setup procedure

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
```

## edit zshrc
```
# zshchに追加
echo "nohup bash ~/dotfiles/pull_dotfiles.sh > /dev/null 2>&1 & >>" ~/.zshrc
echo "source ~/dotfiles/aliases.sh" >> ~/.zshrc
```


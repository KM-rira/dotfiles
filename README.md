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
make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=$HOME/.local
make install

## Nix Installation (Recommended)
This project uses Nix and Home Manager to manage Neovim and other tools. Neovim is pinned to **v0.11.5**.

### First time setup
```bash
# Linux
home-manager switch --flake .#koji-linux --impure

# Mac
home-manager switch --flake .#koji-mac --impure
```

### Update or Apply changes
If you changed `flake.nix` (e.g., changing Neovim version) or want to update packages:
```bash
nix flake update
home-manager switch --flake .#<config-name> --impure
```

### 失敗時:
rm -rf ~/repo/neovim/build
rm -rf ~/repo/neovim/.deps
rm -rf ~/.local/bin/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/lib/nvim
rm -rf ~/.local/state/nvim
make distclean

## emacs install

## install
rm -rf ~/.emacs.d
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
~/.emacs.d/bin/doom install

export PATH="$HOME/.emacs.d/bin:$PATH"

echo 'export DOOMDIR="$HOME/dotfiles/emacs/doom"' >> ~/.zshenv

echo 'export DOOMDIR="$HOME/dotfiles/emacs/doom"' >> ~/.profile

export DOOMDIR="$HOME/dotfiles/emacs/doom"

DOOMDIR="$HOME/dotfiles/emacs/doom" ~/.emacs.d/bin/doom sync

## 失敗
rm -rf ~/.emacs.d/.local/straight
rm -rf ~/.emacs.d/.local/cache
rm -rf ~/.emacs.d/.local/etc

# font

🟦 Step 1：フォントをインストール（最確実）

GUI Emacs を使うなら手動インストールが一番確実。

① GitHub から all-the-icons のフォントを入手
git clone https://github.com/domtronn/all-the-icons.el ~/.local/share/all-the-icons-temp

② フォントを ~/.local/share/fonts にコピー
mkdir -p ~/.local/share/fonts
cp ~/.local/share/all-the-icons-temp/fonts/* ~/.local/share/fonts/

③ フォントキャッシュ更新（Mintは必須）
fc-cache -f -v ~/.local/share/fonts

④ 一時フォルダを削除（任意）
rm -rf ~/.local/share/all-the-icons-temp

🟩 Step 2：Doom Emacs に all-the-icons をロードさせる

~/.doom.d/init.el の :ui セクションに alltheicons を追加する。

:ui
;;deft
doom
doom-dashboard
(modeline)
(alltheicons)   ;; ← これを必ず有効化
...


または標準 Doom の場合は以下があればOK：

:ui
alltheicons

🟨 Step 3：Doom の再同期
~/.emacs.d/bin/doom sync

🟧 Step 4：Emacs を完全終了 → 再起動

GUI 版で必ず再起動して反映させる。

🟪 Step 5：フォントが読み込まれたか確認

Emacs 内で：

M-x all-the-icons-install-fonts


※ Doom では SPC h i F のようなショートカットは無い
（all-the-icons-install-fonts は Doom のインタラクティブロード対象外のため
呼び出せないことが多い）

呼べなくても問題なし。
手動コピーしたフォントを Emacs が見つけていれば OK。

🟩 Step 6：アイコンが正しく表示されるか確認
① M-x all-the-icons-insert

アイコン一覧が表示されれば成功。

② modeline にアイコンが表示されるか

Doom の modeline の左側に

Git のアイコン

Major mode のアイコン
が出ていれば OK。

③ SPC : treemacs（treemacs 使用時）

ファイルアイコンがカラフルなら OK。

🔥（重要）Linux Mintでよくある問題点と対策
❗ GUI Emacs が「~/.local/share/fonts」を読まない場合がある

→ fc-cache -f -v を忘れずに実行
→ それでも読まない場合は以下を実行：

sudo fc-cache -f -v

❗ Emacs を Flatpak で入れているとフォント読み込まれない

→ Flatpak 版はフォントサンドボックスの関係で all-the-iconsはほぼ動かない
→ 必ず通常版 Emacs を使う：

sudo apt install emacs

❗ Wayland / X11 混在でフォントが参照されない

→ env QT_QPA_PLATFORM=xcb emacs で開いて確認
→ あるいは X11 版を利用する

※ Linux Mint では通常問題にならない。

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

→ コマンドライン結果をコピーしたいなら：
:redir @+ | コマンド | redir END

→ コマンドラインにペーストしたいなら：
<C-r>+

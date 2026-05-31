#!/usr/bin/env bash

set -e

# ドットファイルのルートディレクトリを取得
DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"

echo "========================================"
echo "Setting up configuration files (Copy Mode)..."
echo "========================================"

# -----------------------------------------
# Neovim (init.luaのみをコピー)
# -----------------------------------------
echo "-> Setting up Neovim..."
mkdir -p "$CONFIG_DIR/nvim"
if [ -e "$CONFIG_DIR/nvim/init.lua" ]; then
    echo "  Backing up existing Neovim init.lua to init.lua.bak"
    mv "$CONFIG_DIR/nvim/init.lua" "$CONFIG_DIR/nvim/init.lua.bak.$(date +%Y%m%d%H%M%S)" 2>/dev/null || true
fi
cp "$DOTFILES_DIR/nvim/init/init.lua" "$CONFIG_DIR/nvim/init.lua"
echo "  [OK] Neovim init.lua copied."

# -----------------------------------------
# WezTerm
# -----------------------------------------
echo "-> Setting up WezTerm..."
mkdir -p "$CONFIG_DIR/wezterm"
cp "$DOTFILES_DIR/terminal/wezterm.lua" "$CONFIG_DIR/wezterm/wezterm.lua"
echo "  [OK] WezTerm config copied."

# -----------------------------------------
# Starship
# -----------------------------------------
echo "-> Setting up Starship..."
mkdir -p "$CONFIG_DIR"
cp "$DOTFILES_DIR/starship/starship.toml" "$CONFIG_DIR/starship.toml"
echo "  [OK] Starship config copied."

# -----------------------------------------
# Karabiner (Mac用)
# -----------------------------------------
if [ "$(uname)" = "Darwin" ]; then
    echo "-> Setting up Karabiner (Mac only)..."
    mkdir -p "$CONFIG_DIR/karabiner"
    cp "$DOTFILES_DIR/karabiner.json" "$CONFIG_DIR/karabiner/karabiner.json"
    echo "  [OK] Karabiner config copied."
fi

# -----------------------------------------
# (必要に応じて他の設定もここに追加)
# -----------------------------------------

echo "========================================"
echo "All configurations copied successfully!"
echo "========================================"

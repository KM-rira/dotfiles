#!/usr/bin/env bash

set -e

# ドットファイルのルートディレクトリを取得
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_DIR="$HOME/.config"

echo "========================================"
echo "Setting up configuration files..."
echo "========================================"

# -----------------------------------------
# Neovim
# -----------------------------------------
echo "-> Setting up Neovim..."
mkdir -p "$CONFIG_DIR"
if [ -L "$CONFIG_DIR/nvim" ] || [ -e "$CONFIG_DIR/nvim" ]; then
    echo "Backing up existing Neovim config to nvim.bak"
    mv "$CONFIG_DIR/nvim" "$CONFIG_DIR/nvim.bak.$(date +%Y%m%d%H%M%S)" 2>/dev/null || rm -rf "$CONFIG_DIR/nvim"
fi
ln -sfn "$DOTFILES_DIR/nvim" "$CONFIG_DIR/nvim"
echo "  [OK] Neovim config linked."

# -----------------------------------------
# WezTerm
# -----------------------------------------
echo "-> Setting up WezTerm..."
mkdir -p "$CONFIG_DIR/wezterm"
ln -sfn "$DOTFILES_DIR/terminal/wezterm.lua" "$CONFIG_DIR/wezterm/wezterm.lua"
echo "  [OK] WezTerm config linked."

# -----------------------------------------
# Starship
# -----------------------------------------
echo "-> Setting up Starship..."
mkdir -p "$CONFIG_DIR"
ln -sfn "$DOTFILES_DIR/starship/starship.toml" "$CONFIG_DIR/starship.toml"
echo "  [OK] Starship config linked."

# -----------------------------------------
# Karabiner (Mac用)
# -----------------------------------------
if [ "$(uname)" = "Darwin" ]; then
    echo "-> Setting up Karabiner (Mac only)..."
    mkdir -p "$CONFIG_DIR/karabiner"
    ln -sfn "$DOTFILES_DIR/karabiner.json" "$CONFIG_DIR/karabiner/karabiner.json"
    echo "  [OK] Karabiner config linked."
fi

# -----------------------------------------
# (必要に応じて他の設定もここに追加)
# -----------------------------------------

echo "========================================"
echo "All configurations linked successfully!"
echo "========================================"

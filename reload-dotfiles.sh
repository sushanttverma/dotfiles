#!/bin/bash

# =============================================
# Reload Dotfiles
# =============================================

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "🔄 Reloading dotfiles..."

# Re-symlink everything
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/config/ghostty/config" "$HOME/.config/ghostty/config"
ln -sf "$DOTFILES_DIR/config/starship.toml" "$HOME/.config/starship.toml"

# Reload shell
source "$HOME/.zshrc"

echo "✅ Dotfiles reloaded!"

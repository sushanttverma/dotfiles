#!/bin/bash

# =============================================
# Dotfiles Setup Script
# =============================================

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "🚀 Setting up dotfiles..."

# =============================================
# Install Homebrew
# =============================================
if ! command -v brew &> /dev/null; then
  echo "📦 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# =============================================
# Install Brewfile packages
# =============================================
echo "📦 Installing packages from Brewfile..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

# =============================================
# Install Oh My Zsh
# =============================================
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "📦 Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# =============================================
# Install Zsh Plugins
# =============================================
echo "📦 Installing Zsh plugins..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] && \
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] && \
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

[ ! -d "$ZSH_CUSTOM/plugins/zsh-completions" ] && \
  git clone https://github.com/zsh-users/zsh-completions "$ZSH_CUSTOM/plugins/zsh-completions"

# =============================================
# Setup fzf
# =============================================
echo "📦 Setting up fzf..."
$(brew --prefix)/opt/fzf/install --all --no-bash --no-fish 2>/dev/null || true

# =============================================
# Symlink configs
# =============================================
echo "🔗 Symlinking config files..."

# Backup and link .zshrc
[ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ] && mv "$HOME/.zshrc" "$HOME/.zshrc.backup"
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

# Backup and link .gitconfig
[ -f "$HOME/.gitconfig" ] && [ ! -L "$HOME/.gitconfig" ] && mv "$HOME/.gitconfig" "$HOME/.gitconfig.backup"
ln -sf "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"

# Create config directories
mkdir -p "$HOME/.config/ghostty"
mkdir -p "$HOME/.config"

# Link Ghostty config
ln -sf "$DOTFILES_DIR/config/ghostty/config" "$HOME/.config/ghostty/config"

# Link Starship config
ln -sf "$DOTFILES_DIR/config/starship.toml" "$HOME/.config/starship.toml"

# =============================================
# Done!
# =============================================
echo ""
echo "✅ Setup complete!"
echo ""
echo "Run: source ~/.zshrc"
echo ""

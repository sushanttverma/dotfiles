#!/bin/bash

# =============================================
# Dotfiles Setup Script
# =============================================

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_step() {
  echo -e "${BLUE}==>${NC} $1"
}

print_success() {
  echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
  echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
  echo -e "${RED}✗${NC} $1"
}

echo ""
echo -e "${GREEN}🚀 Dotfiles Setup Script${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# =============================================
# Check macOS
# =============================================
if [[ "$(uname)" != "Darwin" ]]; then
  print_error "This script is designed for macOS only."
  exit 1
fi

# =============================================
# Install Xcode Command Line Tools
# =============================================
if ! xcode-select -p &> /dev/null; then
  print_step "Installing Xcode Command Line Tools..."
  xcode-select --install
  echo "Press any key after Xcode tools installation completes..."
  read -n 1 -s
fi
print_success "Xcode Command Line Tools installed"

# =============================================
# Install Homebrew
# =============================================
if ! command -v brew &> /dev/null; then
  print_step "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  print_success "Homebrew already installed"
fi

# Ensure brew is in PATH for this session
eval "$(/opt/homebrew/bin/brew shellenv)"

# =============================================
# Update Homebrew
# =============================================
print_step "Updating Homebrew..."
brew update

# =============================================
# Install Brewfile packages
# =============================================
print_step "Installing packages from Brewfile..."
brew bundle --file="$DOTFILES_DIR/Brewfile"
print_success "Brewfile packages installed"

# =============================================
# Install Oh My Zsh
# =============================================
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  print_step "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  print_success "Oh My Zsh already installed"
fi

# =============================================
# Install Zsh Plugins
# =============================================
print_step "Installing Zsh plugins..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
  print_success "zsh-autosuggestions installed"
else
  print_success "zsh-autosuggestions already installed"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
  print_success "zsh-syntax-highlighting installed"
else
  print_success "zsh-syntax-highlighting already installed"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-completions" ]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-completions "$ZSH_CUSTOM/plugins/zsh-completions"
  print_success "zsh-completions installed"
else
  print_success "zsh-completions already installed"
fi

# =============================================
# Setup fzf
# =============================================
print_step "Setting up fzf..."
if [ -f "$(brew --prefix)/opt/fzf/install" ]; then
  $(brew --prefix)/opt/fzf/install --all --no-bash --no-fish 2>/dev/null || true
  print_success "fzf configured"
fi

# =============================================
# Symlink configs
# =============================================
print_step "Symlinking config files..."

# Create config directories
mkdir -p "$HOME/.config/ghostty"
mkdir -p "$HOME/.config"

# Backup function
backup_and_link() {
  local src="$1"
  local dest="$2"
  local name="$3"
  
  if [ -f "$dest" ] && [ ! -L "$dest" ]; then
    mv "$dest" "$dest.backup.$(date +%Y%m%d_%H%M%S)"
    print_warning "Backed up existing $name"
  fi
  
  ln -sf "$src" "$dest"
  print_success "Linked $name"
}

# Link all configs
backup_and_link "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc" ".zshrc"
backup_and_link "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig" ".gitconfig"
backup_and_link "$DOTFILES_DIR/config/ghostty/config" "$HOME/.config/ghostty/config" "Ghostty config"
backup_and_link "$DOTFILES_DIR/config/starship.toml" "$HOME/.config/starship.toml" "Starship config"

# =============================================
# macOS Defaults (Optional)
# =============================================
print_step "Configuring macOS defaults..."

# Show hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Fast key repeat
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

print_success "macOS defaults configured"

# =============================================
# Done!
# =============================================
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${GREEN} Setup complete!${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal (or run: source ~/.zshrc)"
echo "  2. Restart Finder: killall Finder"
echo ""

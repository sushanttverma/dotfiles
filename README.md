# Dotfiles

My personal dotfiles for macOS.

## What's included

- **Ghostty** - Terminal emulator config
- **Zsh** - Shell config with Oh My Zsh
- **Starship** - Cross-shell prompt

## Packages installed

| Package | Description |
|---------|-------------|
| ghostty | GPU-accelerated terminal |
| starship | Minimal, fast prompt |
| zoxide | Smarter cd command |
| fzf | Fuzzy finder |
| bat | Better cat with syntax highlighting |
| eza | Modern ls replacement |

## Zsh Plugins

- zsh-autosuggestions
- zsh-syntax-highlighting  
- zsh-completions

## Quick Install

```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/Developer/dotfiles
cd ~/Developer/dotfiles
./config.sh
```

## Manual Install

1. Install [Homebrew](https://brew.sh)
2. Run the install script: `./config.sh`
3. Restart your terminal

## Updating

Pull latest changes and re-run:

```bash
cd ~/Developer/dotfiles
git pull
./config.sh
```

## Key Shortcuts (Ghostty)

| Shortcut | Action |
|----------|--------|
| `Cmd+D` | Split right |
| `Cmd+Shift+D` | Split down |
| `Cmd+Alt+Arrow` | Navigate splits |
| `Cmd+T` | New tab |
| `Cmd+W` | Close tab |
| `Ctrl+Alt+G` | Open Ghostty at Finder folder |

## Zoxide Usage

```bash
z foo      # Jump to folder matching "foo"
zi         # Interactive mode (pick from list)
z -        # Go back
```

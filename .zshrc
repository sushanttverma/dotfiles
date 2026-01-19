# =============================================
# ZSH Configuration
# =============================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""  # Empty because using Starship
CASE_SENSITIVE="true"
plugins=(git docker zsh-autosuggestions zsh-syntax-highlighting zsh-completions)
source $ZSH/oh-my-zsh.sh

# =============================================
# Environment Variables
# =============================================
export EDITOR='code -w'
export TERM=xterm-256color
export GOPATH=$HOME/go

# =============================================
# PATH Configuration
# =============================================
export PATH="/Users/sushant/.antigravity/antigravity/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"

# =============================================
# Shell Integrations
# =============================================
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# =============================================
# Conditional Aliases (Modern Tools)
# =============================================
if command -v bat &> /dev/null; then
  alias cat='bat'
fi

if command -v eza &> /dev/null; then
  alias ls='eza --git --group-directories-first'
  alias l='eza --git --group-directories-first'
  alias la='eza --git --group-directories-first -a'
  alias ll='eza --git --group-directories-first -alF'
  alias lt='eza --git --group-directories-first -T'
  alias ltl='eza --git --group-directories-first -TL'
fi

# =============================================
# Navigation
# =============================================
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -- -='cd -'
alias o='open .'

# =============================================
# Clear / Screen
# =============================================
alias c='clear'
alias cl='clear'
alias cls='clear'
alias clr='clear'
alias clera='clear'
alias clar='clear'
alias claer='clear'

# =============================================
# Safety Nets
# =============================================
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# =============================================
# Git - Basic
# =============================================
alias g='git'
alias gi='git init'
alias gs='echo ""; echo "*********************************************"; echo -e "   DO NOT FORGET TO PULL BEFORE COMMITTING"; echo "*********************************************"; echo ""; git status'
alias gss='git status -s'

# Git - Add & Commit
alias ga='git add'
alias gaa='git add .'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'

# Git - Push & Pull
alias gpsh='git push'
alias gpsho='git push -u origin'
alias gpshf='git push --force-with-lease'
alias gpl='git pull'
alias gplo='git pull origin'
alias gf='git fetch'
alias gfa='git fetch --all'

# Git - Branch
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gsw='git switch'
alias gswc='git switch -c'

# Git - Merge & Rebase
alias gm='git merge'
alias grb='git rebase'
alias grbi='git rebase -i'
alias grbc='git rebase --continue'
alias grba='git rebase --abort'

# Git - Stash
alias gst='git stash'
alias gstp='git stash pop'
alias gstl='git stash list'
alias gstd='git stash drop'
alias gsta='git stash apply'

# Git - Log & Diff
alias glo='git log --oneline'
alias glog='git log --oneline --graph --decorate'
alias gloga='git log --oneline --graph --decorate --all'
alias gd='git diff'
alias gds='git diff --staged'

# Git - Cherry-pick
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gcpe='git cherry-pick -e'
alias gcpn='git cherry-pick -n'
alias gcps='git cherry-pick --skip'

# Git - Remote
alias gro='git remote add origin'
alias grv='git remote -v'

# Git - Reset
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias grs='git reset --soft'

# =============================================
# Docker
# =============================================
alias d='docker'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias drm='docker rm'
alias drmi='docker rmi'
alias dex='docker exec -it'
alias dl='docker logs'
alias dlf='docker logs -f'

# Docker Compose
alias dc='docker compose'
alias dcd='docker compose down'
alias dcu='docker compose up'
alias dcud='docker compose up -d'
alias dcr='docker compose restart'
alias dcl='docker compose logs'
alias dclf='docker compose logs -f'
alias dcps='docker compose ps'

# =============================================
# pnpm
# =============================================
alias p='pnpm'
alias pa='pnpm add'
alias pad='pnpm add -D'
alias pb='pnpm build'
alias pd='pnpm dev'
alias pi='pnpm install'
alias pr='pnpm run'
alias psd='pnpm start:dev'
alias pt='pnpm test'
alias px='pnpx'

# =============================================
# Node / pnpm Utilities
# =============================================
alias lint='npx next lint'
alias nuke='rm -rf node_modules pnpm-lock.yaml && pnpm i'
alias outdated='pnpm outdated'

# =============================================
# System / Misc
# =============================================
alias h='history'
alias hg='history | grep'
alias now='date +"%Y-%m-%d %H:%M:%S"'
alias path='echo $PATH | tr ":" "\n"'
alias reload='source ~/.zshrc'
alias week='date +%V'
alias zshrc='$EDITOR ~/.zshrc'

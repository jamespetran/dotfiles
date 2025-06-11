# Modern replacements
alias ls='eza --icons'
alias cat='bat'
alias find='fd'

# Git
alias g='git'
alias gst='git status'
alias gcm='git commit -m'
alias gaa='git add .'
alias gb='git branch'
alias gco='git checkout'
alias glg='git log --oneline --decorate --graph --all'
alias gcl='git clone'

# zoxide (better cd)
eval "$(zoxide init zsh)"

# App launchers
alias idea='flatpak run com.jetbrains.IntelliJ-IDEA-Ultimate'

# Docker/Podman smart aliasing
if command -v podman &> /dev/null && grep -q silverblue /etc/os-release 2>/dev/null; then
  alias d='podman'
  alias dps='podman ps'
  alias dcu='podman-compose up'
  alias dcd='podman-compose down'
else
  alias d='docker'
  alias dps='docker ps'
  alias dcu='docker compose up'
  alias dcd='docker compose down'
fi

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ~='cd ~'

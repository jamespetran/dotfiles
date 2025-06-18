# A wrapper for chezmoi that ensures the Bitwarden vault is unlocked.
cz() {
  # No Bitwarden?  Just run chezmoi.
  if ! command -v bw >/dev/null 2>&1; then
    command chezmoi "$@"
    return
  fi

  # Quick check: do we already have a usable session?
  if ! bw --quiet --nointeraction --session "${BW_SESSION:-}" list items --limit 1 2>/dev/null; then
    echo "🔒 Unlocking Bitwarden vault for this shell…" >&2
    # --raw gives *just* the key, no banner text.
    key=$(bw unlock --raw) || { echo "❌ Unlock failed." >&2; return 1; }
    export BW_SESSION="$key"
  fi

  # Run chezmoi with a valid session in the env.
  command chezmoi "$@"
}

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

# Rust
alias cb='cargo build'
alias cr='cargo run'
alias ct='cargo test'
alias cl='cargo clippy'
alias cf='cargo fmt'
alias cw='cargo watch -x check'

# zoxide (better cd)
eval "$(zoxide init zsh)"

# App launchers
alias idea='/home/james/.local/share/JetBrains/Toolbox/apps/intellij-idea-ultimate/bin/idea'

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

# Coding helpers
alias k='kubectl'
alias python='python3'
alias pip='pip3'
alias serve='python3 -m http.server 8000'
alias ports='ss -tulpn'
alias grep='grep --color=auto'

alias cls='clear && printf "\e[3J"'

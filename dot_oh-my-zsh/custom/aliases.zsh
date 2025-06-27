# A wrapper for chezmoi that ensures the Bitwarden vault is unlocked when needed.
cz() {
  # No Bitwarden?  Just run chezmoi.
  if ! command -v bw >/dev/null 2>&1; then
    command chezmoi "$@"
    return
  fi

  # Commands that definitely need Bitwarden
  local bw_commands="apply|execute-template|data"
  
  # Check if this command might need Bitwarden
  local needs_bw=false
  case "${1:-}" in
    apply|execute-template|data)
      needs_bw=true
      ;;
    edit)
      # Only need BW if editing a template file
      if [[ "${2:-}" == *.tmpl ]]; then
        needs_bw=true
      fi
      ;;
    *)
      # For other commands, try without BW first
      needs_bw=false
      ;;
  esac

  # Function to ensure Bitwarden is unlocked
  ensure_bw_unlocked() {
    if ! bw --quiet --nointeraction --session "${BW_SESSION:-}" list items --limit 1 2>/dev/null; then
      echo "🔒 Unlocking Bitwarden vault for this operation…" >&2
      local key
      key=$(bw unlock --raw) || { echo "❌ Unlock failed." >&2; return 1; }
      export BW_SESSION="$key"
    fi
  }

  # If we know we need Bitwarden, unlock it first
  if [[ "$needs_bw" == "true" ]]; then
    ensure_bw_unlocked || return 1
    command chezmoi "$@"
  else
    # Try without Bitwarden first
    if ! command chezmoi "$@" 2>/tmp/chezmoi_error; then
      # Check if the error suggests we need Bitwarden
      if grep -q "bitwarden\|template.*error" /tmp/chezmoi_error 2>/dev/null; then
        echo "🔄 Command requires Bitwarden, retrying with authentication…" >&2
        ensure_bw_unlocked || return 1
        command chezmoi "$@"
      else
        # Show the original error
        cat /tmp/chezmoi_error >&2
        return 1
      fi
    fi
  fi
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

# Claude Code CLI
alias claude="~/.claude/local/claude"

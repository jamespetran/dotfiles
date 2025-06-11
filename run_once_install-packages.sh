#!/usr/bin/env bash
#
# Idempotent, tool-aware installer for a developer environment.
# Managed by chezmoi.

set -e

echo "🚀 Starting unified developer environment setup..."

# --- Layer 1: System Foundation (DNF) ---
# Use DNF if available to install essential build tools and system dependencies.
if command -v dnf >/dev/null 2>&1; then
  echo "→ Installing system foundation packages with DNF..."
  sudo dnf install -y \
    git curl zsh util-linux-user \
    gcc-c++ cmake make pkgconf-pkg-config \
    python3-pip python3-devel \
    openssl-devel perl perl-libs perl-core
fi

# --- Layer 1.5: User-Space Tools (Homebrew) ---
# Use Homebrew for modern CLI tools. Install it if it's not present.
echo "→ Installing user-space tools with Homebrew..."
if ! command -v brew >/dev/null 2>&1; then
  echo "  → Homebrew not found. Installing..."
  sudo mkdir -p /home/linuxbrew/.linuxbrew
  sudo chown -R "$(whoami)" /home/linuxbrew/.linuxbrew
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Add brew to the current shell's PATH to use it immediately.
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew update
if brew install --force-bottle fzf fd ripgrep bat zoxide eza git-delta btop jq yq tldr lazygit gh direnv git-lfs aria2; then
  echo "🍺 Installed all tools from bottles"
else
  echo "⚠️  Bottle unavailable for some tools; falling back to source build"
  brew install fzf fd ripgrep bat zoxide eza git-delta btop jq yq tldr lazygit gh direnv git-lfs aria2
fi

# --- Layer 2: Language Toolchains (Official Installers) ---
echo "→ Layer 2: Installing language toolchains..."

# Layer 2a: Try distro Rust first, then rustup fallback
if command -v dnf >/dev/null 2>&1 && dnf list rust >/dev/null 2>&1; then
  sudo dnf install -y rust cargo
else
  echo "→ Falling back to rustup installer"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
  rustup default stable
fi

# Layer 2b: Try distro Node.js first, then nvm fallback
if command -v dnf >/dev/null 2>&1 && dnf list nodejs >/dev/null 2>&1; then
  sudo dnf install -y nodejs
else
  export NVM_DIR="$HOME/.nvm"
  if [ ! -s "$NVM_DIR/nvm.sh" ]; then
    echo "  → Installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  fi
  # shellcheck source=/dev/null
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  nvm install --lts
fi

# --- Layer 3: Isolated CLI Applications (pipx & cargo) ---
echo "→ Layer 3: Installing isolated CLI applications..."

# Ensure toolchains are sourced for the current script session
[ -s "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install Python apps with pipx
if ! command -v pipx >/dev/null 2>&1; then
  python3 -m pip install --user pipx
  python3 -m pipx ensurepath
fi
export PATH="$PATH:$HOME/.local/bin"
# Layer 3a: DNF-packaged Python CLIs first
if command -v dnf >/dev/null 2>&1; then
  sudo dnf install -y python3-pipx python3-poetry
else
  python3 -m pip install --user pipx
  python3 -m pipx ensurepath
fi
# Now ensure the rest of your Python tools
pipx install --include-deps huggingface_hub

# Install Rust apps with cargo
if command -v dnf >/dev/null 2>&1 && dnf list --quiet zellij >/dev/null 2>&1; then
  sudo dnf install -y zellij
elif command -v brew >/dev/null 2>&1; then
  brew install zellij
else
  cargo install zellij
fi

echo "✅ Package setup complete."
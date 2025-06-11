#!/usr/bin/env bash
# Conditional installer — cross-platform bootstrap

set -e

echo "→ Ensuring packages are installed..."

# Check for Homebrew (macOS/WSL)
if command -v brew >/dev/null 2>&1; then
  echo "✓ Homebrew detected, updating..."
  brew update

  # Install required packages using brew
  brew install \
    fzf \
    fd \
    ripgrep \
    bat \
    zoxide \
    eza \
    git-delta \
    bitwarden-cli

# Fedora / Toolbox / Immutable Linux (Silverblue)
elif command -v dnf >/dev/null 2>&1; then
  echo "✓ Fedora / Toolbox detected"
  sudo dnf install -y --skip-unavailable \
    zsh \
    git \
    curl \
    fzf \
    fd-find \
    ripgrep \
    bat \
    zoxide \
    util-linux-user

# Ubuntu / Debian (Apt)
elif command -v apt-get >/dev/null 2>&1; then
  echo "✓ Ubuntu / Debian detected"
  sudo apt-get update
  sudo apt-get install -y \
    zsh \
    git \
    curl \
    fzf \
    fd-find \
    ripgrep \
    bat \
    zoxide \
    util-linux-user

# WSL (Windows Subsystem for Linux) detection
elif grep -qi microsoft /proc/version; then
  echo "⚠️  WSL detected — not installing via apt"
  echo "You can install using 'brew' or 'apt-get' for a full Linux environment."

else
  echo "⚠️  OS not recognized — skipping package installation"
fi

echo "✓ Package setup complete."

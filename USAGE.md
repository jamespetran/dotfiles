# Development Environment Usage Guide

Complete guide to your streamlined development environment setup and tools.

## 🚀 Getting Started

### Installation
```bash
# Quick setup (2 minutes)
chezmoi init --apply https://github.com/yourusername/dotfiles
exec zsh

# Validate installation
./test-simple.sh
```

### What Gets Installed
- **Shell Environment**: Zsh, Oh My Zsh, Powerlevel10k theme
- **Modern CLI Tools**: ripgrep, bat, eza, fzf, fd, jq, yq
- **Git Tools**: git-delta, lazygit, GitHub CLI
- **Container Runtime**: podman with Docker aliases
- **Terminal Tools**: zellij, atuin, broot
- **Language Runtimes**: Python 3.11, Node.js LTS (via mise)
- **Build Tools**: gcc, cmake (essential only)
- **Global Tools**: pipx, black, flake8, TypeScript

### Key Benefits
- ✅ **Host tools ready**: Python, Node.js, pip, cargo available immediately
- ✅ **Fixed configuration**: No more pip virtualenv requirement conflicts
- ✅ **Streamlined setup**: One path, no mode confusion
- ✅ **Container flexibility**: Use containers when you need different environments

---

## 🔧 Essential Commands

### Chezmoi Management
```bash
cz apply              # Apply dotfiles changes (Bitwarden-aware wrapper)
cz diff               # Show differences between source and target files
cz edit <file>        # Edit a dotfile in the source directory  
cz status             # Show status of managed files
cz data               # Show template data available to chezmoi
```

### Package Management
```bash
# Keep packages updated (runs automatically on cz apply)
./run_always_update-packages.sh.tmpl

# Force package installation 
sudo dnf install <package>    # Fedora/RHEL
sudo apt install <package>    # Debian/Ubuntu  
brew install <package>        # Homebrew packages
```

### Language Development
```bash
# Python (mise-managed 3.11)
python --version              # Check version
pipx install <tool>           # Install global Python tools
poetry new project           # Create Python project with poetry

# Node.js (mise-managed LTS)
node --version               # Check version
npm install -g <tool>        # Install global Node.js tools
npm create <template>        # Create Node.js project

# Runtime management
mise list                    # Show installed runtimes
mise use python@3.12        # Switch Python version for project
mise use node@20            # Switch Node.js version for project
```

---

## 🛠️ Tool Guides

### Modern CLI Tools

#### File Operations
```bash
# Listing
ls                    # eza with icons  
ll                    # eza -la with icons and details
tree                  # directory tree view

# Search
rg "pattern"          # ripgrep content search
rg "pattern" --type rs # search in Rust files only
fd "filename"         # find files by name
fzf                   # fuzzy finder

# File viewing
bat file.txt          # syntax highlighted cat
bcat file.txt         # explicit bat alias
view file.json        # same as bat
```

#### Git Workflow
```bash
# Enhanced git
lazygit               # Interactive git UI
gh                    # GitHub CLI
git lg                # Pretty log with graph
git diff              # with git-delta highlighting
git show              # with git-delta highlighting

# Advanced git (if available)
git absorb            # Auto-create fixup commits
git sl                # Smart log (git-branchless)
```

### Terminal Environment

#### Shell Features
```bash
# History (Atuin)
Ctrl+R                # Search encrypted shell history
atuin search "command" # Search specific command
atuin stats           # History statistics

# Navigation (zoxide)
z project             # Jump to recent directory
zi                    # Interactive directory picker

# Completion
# Tab completion for most tools
# Auto-suggestions appear as you type
# Smart completion caching for performance
```

#### Terminal Multiplexing (Zellij)
```bash
# Start session
zellij                # Launch zellij session
zellij list-sessions  # Show active sessions

# Custom layouts (if available)
zdev                  # Development layout
zrust                 # Rust-specific layout
zai                   # AI development layout
zmon                  # System monitoring

# Navigation
Alt+[n]               # Switch panes
Alt+[hjkl]            # Navigate panes
Ctrl+p, q             # Quit session
```

#### File Navigation (broot)
```bash
# Interactive navigation
br                    # Launch broot
explore               # Same as br
nav                   # Same as br

# Broot shortcuts inside the interface
:e file               # Edit file  
:v file               # View with bat
/pattern              # Search files
Alt+Enter             # cd to directory and exit
```

### Container Operations
```bash
# Container shortcuts (podman with Docker aliases)
d ps                  # List containers (podman ps)
d run                 # Run container (podman run)
d build               # Build image (podman build)
docker ps             # Also works (alias to podman)

# Compose operations
dcu                   # docker-compose up (if available)
dcd                   # docker-compose down (if available)

# Test container functionality
podman run --rm hello-world    # Test basic functionality
```

---

## 🔄 Package Management & Updates

### Automatic Updates
```bash
# Runs automatically on every `cz apply`
./run_always_update-packages.sh.tmpl

# What it updates:
# - Homebrew packages (brew update && brew install)
# - Zsh plugins (git pull on autosuggestions, syntax-highlighting, powerlevel10k)
```

### Manual Package Management
```bash
# System packages (as needed)
sudo dnf upgrade                    # Fedora/RHEL system updates
sudo apt update && sudo apt upgrade # Debian/Ubuntu system updates

# Homebrew packages
brew update                         # Update package definitions
brew upgrade                        # Upgrade all packages
brew upgrade <specific-package>     # Upgrade specific package

# Language-specific tools
pipx upgrade-all                    # Upgrade all pipx-installed tools
npm update -g                       # Update global Node.js packages
```

---

## 🔐 Security & Credentials

### Bitwarden Integration
```bash
# Check Bitwarden status
bw status

# Unlock vault (required for credential access)
bw unlock

# The `cz` wrapper automatically unlocks Bitwarden when needed
cz apply              # Prompts for Bitwarden if locked
```

### Required Bitwarden Items
- **"GPG Private Key"** (Secure Note): Your GPG private key for commit signing
- **"github.com"** (Login): Must have custom field "noreply_email" with your GitHub noreply email

### GPG Commit Signing
```bash
# Check GPG status
gpg --list-secret-keys
gpg --list-secret-keys 21D39CC1D0B3B44A    # Your key ID

# Verify git configuration
git config --global -l | grep -E "user\.|signing"

# Test commit signing
git log --show-signature -1
```

---

## 🧪 Testing & Validation

### Quick Health Check
```bash
# Run the validation script
./test-simple.sh

# Check specific components
which python node cargo    # Language runtimes
which rg bat eza fzf       # Modern CLI tools
which lazygit gh zellij    # Development tools
```

### Manual Validation
```bash
# Test language tools
python --version           # Should show Python 3.11.x
node --version             # Should show Node.js LTS
npm --version              # Should show npm version
pipx --version             # Should show pipx version

# Test mise functionality
mise list                  # Show installed runtimes
mise --version             # Show mise version

# Test container runtime
podman --version           # Show podman version
podman run --rm hello-world # Test basic container functionality
```

---

## 🆘 Troubleshooting

### Common Issues

#### Installation Problems
```bash
# Missing tools after installation
cz apply                   # Re-run installation

# Homebrew not found
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# Or install Homebrew:
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Language tools not found
mise list                  # Check what's installed
mise install python@3.11  # Install specific version
mise use --global python@3.11 # Set as global default
```

#### Shell Issues
```bash
# Shell not responding or slow startup
exec zsh                   # Restart shell
source ~/.zshrc            # Reload configuration

# Check startup time
zsh -xvs                   # Debug shell startup (verbose)
time zsh -i -c exit        # Measure shell startup time
```

#### Bitwarden Issues
```bash
# Bitwarden locked during chezmoi operations
bw unlock                  # Unlock vault manually
bw status                  # Check vault status

# Missing Bitwarden items
bw get item "github.com"   # Verify GitHub item exists
bw get notes "GPG Private Key" # Verify GPG key exists
```

#### Language Runtime Issues
```bash
# Python/pip issues
which python python3      # Check Python locations
pip --version              # Should work without virtualenv errors
pipx list                  # Check pipx installations

# Node.js/npm issues  
which node npm             # Check Node.js locations
npm config list           # Check npm configuration

# Runtime version issues
mise current               # Show current versions
mise use python@3.11      # Switch Python version
mise use node@lts          # Switch Node.js version
```

### Performance Issues
```bash
# Check system resources
btop                       # Modern system monitor
htop                       # Traditional system monitor

# Check disk usage
du -sh ~/.local/share/mise # Check mise cache size
du -sh ~/.cache            # Check general cache size

# Clear caches if needed
rm -rf ~/.cache/*          # Clear all caches (nuclear option)
```

### Recovery Commands
```bash
# Reset chezmoi state (if confused)
chezmoi state reset
chezmoi init --apply <your-repo>

# Disable problematic scripts temporarily
mv run_onchange_setup-mise.sh.tmpl run_onchange_setup-mise.sh.tmpl.disabled

# Complete fresh install
rm -rf ~/.local/share/chezmoi ~/.config/chezmoi
chezmoi init --apply <your-repo>
```

---

## 📚 Additional Resources

### File Locations
- **Dotfiles source**: `~/.local/share/chezmoi/`
- **Tool configurations**: `~/.config/`
- **Shell history**: `~/.local/share/atuin/`
- **Mise installations**: `~/.local/share/mise/`
- **Homebrew**: `/home/linuxbrew/.linuxbrew/`

### Configuration Files
- **Chezmoi config**: `~/.config/chezmoi/chezmoi.toml`
- **Mise config**: `~/.config/mise/config.toml`
- **Zsh config**: `~/.zshrc`
- **Git config**: `~/.gitconfig` (auto-generated)

### Getting More Help
- **Check latest error context**: [latest_error.md](latest_error.md)
- **Claude Code guidance**: [CLAUDE.md](CLAUDE.md)
- **Tool-specific help**: Most tools support `--help` flag

---

*Built for productive daily development workflows with host tools + container flexibility*
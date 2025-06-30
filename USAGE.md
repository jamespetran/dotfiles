# Dotfiles Usage Guide

Complete guide to your development environment setup and tools.

## 🎯 Installation Modes

### Minimal Setup (Recommended)

**Perfect for**: Clean base system + dev containers workflow

#### What Gets Installed
- **Shell Environment**: Zsh, Oh My Zsh, Powerlevel10k
- **Essential CLI Tools**: ripgrep, bat, eza, fzf, fd, jq, yq
- **Git Tools**: git-delta, lazygit, GitHub CLI
- **Container Runtime**: podman with Docker aliases
- **Terminal Tools**: zellij, atuin, broot
- **File Navigation**: Modern CLI alternatives

#### Installation
```bash
# First time
chezmoi init --apply https://github.com/yourusername/dotfiles

# Or switch from full
./switch-to-minimal.sh
chezmoi apply
```

#### Development Workflow
1. **Base system**: Only shell + essential tools
2. **Language development**: Use dev containers
3. **IntelliJ projects**: Tools → Dev Containers → Create Dev Container
4. **Isolated environments**: Each project in its own container

---

### Full Installation (Power Users)

**Perfect for**: Everything on host, maximum performance

#### What Gets Installed  
**All minimal tools PLUS:**
- **Language Runtimes**: Python 3.11, Node.js LTS, Rust toolchain
- **Build Tools**: gcc, cmake, sccache
- **Python Tools**: poetry, pipx, huggingface_hub
- **Rust Tools**: cargo-nextest, cargo-watch, cargo-edit, etc.
- **Performance Tools**: Advanced compilation caching

#### Installation
```bash
# Fresh install - choose "full" when prompted
chezmoi init --apply https://github.com/yourusername/dotfiles

# Migration from minimal requires fresh install
```

#### Development Workflow
1. **Everything local**: All runtimes on host system
2. **mise management**: Runtime switching with `mise use`
3. **Global tools**: Available everywhere
4. **Maximum performance**: Native compilation, shared caches

---

## 🐳 Dev Container Templates

Available in `devcontainer-templates/` for minimal mode:

### Python Development
```bash
# Copy to your project
cp devcontainer-templates/python/.devcontainer.json .

# Features:
# - Python 3.11, poetry, pipx
# - No virtualenv restrictions  
# - Mounts your zsh config
```

### Rust Development  
```bash
# Copy to your project
cp devcontainer-templates/rust/.devcontainer.json .

# Features:
# - Latest Rust, sccache enabled
# - Cargo tools pre-installed
# - Shared cargo registry cache
```

### Node.js Development
```bash  
# Copy to your project
cp devcontainer-templates/node/.devcontainer.json .

# Features:
# - Node.js 20 LTS, pnpm, yarn
# - Shared npm cache
# - Mounts your zsh config
```

---

## 🔧 Essential Commands

### Chezmoi Management
```bash
cz apply              # Apply dotfiles changes
cz diff               # Show differences  
cz edit <file>        # Edit a dotfile
cz status             # Show status
cz data               # Show template data
```

### Package Management
```bash
# Minimal mode
./run_weekly_safe-upgrades.sh     # Safe CLI tool upgrades
# Manual upgrades: see manual-upgrade-checklist.md

# Full mode  
# Packages auto-upgrade on cz apply
```

### Container Operations
```bash
# Container shortcuts (podman/docker)
d ps                  # List containers
dcu                   # Compose up
dcd                   # Compose down
```

---

## 🚀 Tool Guides

*The sections below apply to both minimal and full modes (unless noted)*

### Modern CLI Tools

#### File Operations
```bash
# Listing (available in both modes)
ls                    # eza with icons  
ll                    # eza -la with icons
tree                  # broot (alias)

# Search (available in both modes)
rg "pattern"          # ripgrep search
fd "name"             # find alternative  
fzf                   # fuzzy finder

# File viewing (available in both modes)
bat file.txt          # syntax highlighted cat
bcat file.txt         # explicit bat alias
```

#### Git Workflow
```bash
# Enhanced git (available in both modes)
lazygit               # Interactive git UI
gh                    # GitHub CLI
git lg                # Pretty log
git absorb            # Auto-create fixup commits
git sl                # Smart log (git-branchless)
```

### Language Development

#### Minimal Mode (in containers)
```bash
# Copy appropriate .devcontainer.json to your project
# IntelliJ: Tools → Dev Containers → Create Dev Container
# VS Code: Reopen in Container

# Each project isolated in container
# Language tools available inside container only
```

#### Full Mode (on host)
```bash
# Runtime management
mise list             # Show installed runtimes
mise use python@3.11  # Switch Python version  
mise use node@lts     # Switch Node version

# Python
poetry new project    # Create Python project
pipx install tool     # Install global Python tool

# Rust  
cargo new project     # Create Rust project
ct                    # cargo nextest (fast tests)
cw                    # cargo watch
cstats                # sccache statistics

# Node.js
npm create app        # Create Node project (or pnpm, yarn)
```

### Terminal Environment

#### Shell Features (both modes)
```bash
# History (Atuin)
Ctrl+R                # Search shell history
atuin stats           # History statistics

# Navigation (zoxide)
z project             # Jump to recent directory
zi                    # Interactive directory picker

# Layouts (zellij)
zellij                # Start session
Alt+[n]               # Switch panes
Alt+[hjkl]            # Navigate panes
```

#### File Navigation (both modes)
```bash
# Interactive navigation
br                    # Launch broot
explore               # Same as br
tree                  # Same as br

# Broot shortcuts
:e file               # Edit file  
:v file               # View with bat
/pattern              # Search files
Alt+Enter             # cd and exit
```

### Performance & Monitoring

#### Available in Both Modes
```bash
btop                  # System monitor
htop                  # Traditional top
lsof                  # Open files
strace                # System calls
```

#### Full Mode Only
```bash
# Build performance
sccache --show-stats  # Compilation cache stats
cargo nextest         # Fast Rust testing
```

---

## 🔄 Upgrade Management

### Minimal Mode
- **Daily**: `cz apply` ensures packages installed (no upgrades)
- **Weekly**: `./run_weekly_safe-upgrades.sh` for safe CLI tools
- **Manual**: Use `manual-upgrade-checklist.md` for critical tools
- **Containers**: Upgrade language runtimes in containers only

### Full Mode  
- **Daily**: `cz apply` installs and upgrades packages
- **Automatic**: All tools upgrade when you apply dotfiles
- **Language tools**: Managed by mise, poetry, npm, cargo

---

## 🆘 Troubleshooting

### Common Issues

#### Minimal Mode
- **Missing language tools**: Install in dev container, not host
- **Container not starting**: Check podman/docker status
- **IntelliJ can't find tools**: Use dev container integration

#### Full Mode
- **pip requires virtualenv**: Check `mise` environment variables
- **Build cache not working**: Check `sccache --show-stats`
- **Runtime conflicts**: Use `mise use` to switch versions

#### Both Modes
- **Bitwarden locked**: Run `bw unlock`  
- **Shell startup slow**: Check plugin loading times
- **Git signing fails**: Verify GPG key import

### Getting Help
- **Migration context**: [latest_error.md](latest_error.md)
- **Upgrade problems**: [manual-upgrade-checklist.md](manual-upgrade-checklist.md)  
- **Container setup**: [devcontainer-templates/README.md](devcontainer-templates/README.md)
- **Claude Code issues**: [CLAUDE.md](CLAUDE.md)

---

*Built for performance, security, and developer productivity*
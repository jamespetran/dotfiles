# Terminal Power User Guide

This dotfiles setup transforms your terminal into a **Rust-grade development environment** with blazing performance, intelligent tooling, and rock-solid reliability.

## 🚀 Quick Start

### Prerequisites
- **Bitwarden CLI**: Required for credential management
- **GPG Key**: Store your GPG private key in Bitwarden as "GPG Private Key" secure note
- **GitHub Email**: Add "noreply_email" field to "github.com" item in Bitwarden
- **Sudo Access**: For system package installation

### Installation
1. Install chezmoi and clone your dotfiles
2. Unlock Bitwarden: `bw unlock`
3. Apply configuration: `cz apply` (will prompt for Bitwarden if needed)
4. Restart shell: `exec zsh`

### What Gets Installed
- **Layer 1**: OS packages (git, gcc, python3, podman, etc.)
- **Layer 2**: Homebrew + modern CLI tools (ripgrep, bat, eza, fzf, etc.)
- **Layer 3**: Language toolchains (Rust, Node.js, Python via mise)
- **Layer 4**: Shell framework (Oh My Zsh + Powerlevel10k)
- **Layer 5**: Development tools (lazygit, GitHub CLI, Zellij)
- **Layer 6**: Performance optimizations (sccache, cargo-nextest)

## 📚 Table of Contents

- [Core Philosophy](#core-philosophy)
- [Security & Credentials](#security--credentials)
- [Rust Development](#rust-development)
- [File Management](#file-management)
- [Dataset Analysis](#dataset-analysis)
- [Background Tasks & Notifications](#background-tasks--notifications)
- [Git Workflow](#git-workflow)
- [Terminal Layouts](#terminal-layouts)
- [Performance Tools](#performance-tools)
- [Project Automation](#project-automation)
- [Shell Intelligence](#shell-intelligence)
- [Troubleshooting](#troubleshooting)

## 🔐 Security & Credentials

### Bitwarden Integration
Credentials are securely managed via Bitwarden CLI:

```bash
# Check Bitwarden status
bw status

# Unlock vault (required for credential access)
bw unlock

# The cz wrapper automatically unlocks when needed
cz apply
```

### Required Bitwarden Items
- **"GPG Private Key"** (Secure Note): Your GPG private key for commit signing
- **"github.com"** (Login): Must have custom field "noreply_email" with your GitHub noreply email

### GPG Commit Signing
Automatically configured for secure commits:
```bash
# Check GPG status
gpg --list-secret-keys

# Your commits are automatically signed with key: 21D39CC1D0B3B44A
git log --show-signature -1
```

### Smart Bitwarden Access
Recent optimization prevents unnecessary Bitwarden prompts:
- Scripts check if configuration is already correct
- Only prompts for Bitwarden when changes are actually needed
- No more shell startup interruptions

## 🦀 Core Philosophy

This setup follows **Rust principles**:
- **Performance**: Modern tools that are orders of magnitude faster
- **Safety**: Explicit error handling, no silent failures
- **Choice**: Non-interactive tools for speed, interactive for exploration
- **Zero-cost abstractions**: Only pay for what you use

### Interactive vs Non-Interactive

**Fast & Scriptable** (when you want speed):
- `cat` - quick file dump
- `tree` - directory structure
- `ls` - file listing (via eza)
- `find` - file search (via fd)

**Rich & Interactive** (when you want exploration):
- `bcat` or `view` - syntax highlighted viewing
- `explore` or `br` - interactive file navigation
- `analyze` - dataset analysis with previews

## 🦀 Rust Development

### Blazing Fast Testing
```bash
# Ultra-fast tests (replaces cargo test)
ct                    # cargo nextest run
cn                    # cargo nextest run (explicit)
cnw                   # cargo watch + nextest

# Traditional tests (when needed)
ctc                   # cargo test
```

### Build Performance
```bash
# Check cache status
cstats                # sccache statistics

# Build commands (automatically cached)
cb                    # cargo build
cr                    # cargo run
jr                    # cargo build --release

# Analysis
csize                 # binary size analysis
cl                    # clippy
cf                    # format
```

### Development Workflow
```bash
# Start development session
cw                    # cargo watch -x check
jd                    # just dev (if justfile exists)

# With notifications for long tasks
ntest                 # test with completion notification
nbuild                # build with notification
```

## 📁 File Management

### Quick Navigation
```bash
# Fast listing
ls                    # eza with icons
ll                    # eza -la with icons
tree                  # directory tree

# Interactive exploration
explore               # broot file navigator
nav                   # same as explore
br                    # short broot alias
```

### Smart Search
```bash
# Fast file finding
fd pattern            # find files by name
fd pattern dir        # search in specific directory

# Content search  
rg pattern            # ripgrep content search
rg pattern --type rs  # search in Rust files only
```

### File Operations
```bash
# Viewing files
cat file.txt          # quick dump
bcat file.rs          # syntax highlighted
view file.json        # same as bcat

# File analysis
file large_file       # file type detection
dust                  # disk usage (better du)
dust -d 2 ~/projects  # disk usage depth 2
```

## 📊 Dataset Analysis

Perfect for AI/ML dataset work and quantization analysis:

### Dataset Preview
```bash
analyze data.json     # Smart format detection & preview
analyze dataset.csv   # CSV structure analysis
analyze model.parquet # Parquet schema & sample

# Alias: dv (dataset view)
dv data.jsonl         # JSONL analysis
```

### Dataset Statistics
```bash
datastat              # Current directory stats
datastat ~/datasets   # Specific directory stats

# Shows: file counts, types, size distribution
```

### Dataset Search & Validation
```bash
datafind "*.json"     # Find datasets by pattern
datafind "model" ~/ai # Search in specific directory

datacheck data.csv    # Validate dataset quality
# Checks: format validity, consistency, missing data
```

### Batch Operations
```bash
# Process multiple datasets
dbatch check *.csv    # Validate all CSV files
dbatch stats *.json   # Get stats for all JSON files
```

## 🔔 Background Tasks & Notifications

### Smart Notifications
```bash
# Run with completion notification
nrun cargo build --release
nrun python train_model.py

# Smart notifications (only for long tasks >30s)
nsmart cargo test
nsmart ./long_script.sh
```

### Background Task Management
```bash
# Start background task
nbg training python train_model.py
nbg analysis ./analyze_data.sh

# Manage background tasks
nlist                 # List active tasks
nkill training        # Stop specific task

# Pre-configured shortcuts
ntrain                # Background training alias
```

## 🚀 Git Workflow

### Advanced Git Tools
```bash
# Smart commit creation
gabs                  # git absorb (auto-fixup commits)

# Advanced workflow
gsl                   # git smartlog (branch visualization)
gundo                 # git undo (safe undo)
gsync                 # git sync (rebase + merge)

# Enhanced viewing
glgg                  # git lg (beautiful log)
gdiff                 # git diff with word-level changes
gshow                 # git show with word-level changes
```

### GitHub Integration
```bash
# GitHub CLI workflow
ghd                   # Interactive PR dashboard
ghpr                  # Create draft PR
ghprl                 # List PRs
ghs pattern           # Search repositories
ghi                   # List issues
```

## 🖥️ Terminal Layouts

### Zellij Layouts (Terminal Multiplexing)
```bash
# Development layouts
zdev                  # General development (editor + terminal + git)
zrust                 # Rust-specific (cargo watch + testing)
zai                   # AI development (training + data + monitoring)
zmon                  # System monitoring

# Inside layouts:
# Ctrl+p + n/p      - Next/previous tab
# Ctrl+p + h/j/k/l  - Navigate panes
# Ctrl+p + q        - Quit
```

### Layout Features
- **zdev**: Editor, terminal, lazygit
- **zrust**: Code, testing, build monitoring
- **zai**: Code, AI testing, training, data processing, monitoring, git
- **zmon**: System monitoring, logs, network usage

## ⚡ Performance Tools

### Benchmarking
```bash
# Command benchmarking
hyperfine 'command1' 'command2'
hyperfine --warmup 3 'cargo build' 'cargo check'

# System monitoring
btop                  # Modern htop replacement
procs                 # Modern ps replacement
procs --tree          # Process tree view
```

### Analysis Tools
```bash
# Code analysis
tokei                 # Code statistics
tokei --languages rust python

# Performance profiling (for Rust projects)
cargo flamegraph      # Generate flame graphs
```

## 🧠 Shell Intelligence

### Atuin: Encrypted Shell History
```bash
# Search through encrypted history
# Ctrl+R (or up arrow) - Interactive search
atuin search "cargo build"    # Search specific command
atuin stats                   # History statistics
```

**Features:**
- Encrypted, searchable command history
- Cross-session persistence
- Optional cloud sync across machines
- Automatic history import from existing shell

### Enhanced Zsh
```bash
# Smart completion and suggestions
# Auto-suggestions appear as you type
# Tab completion for most tools

# Enhanced history
history | tail -10           # Last 10 commands
!cargo                       # Repeat last cargo command
```

**Features:**
- 50,000 command history
- Smart completion caching
- Syntax highlighting
- Auto-suggestions from history

### Environment Management
```bash
# mise - Universal runtime manager
mise list                    # Show installed runtimes
mise install python@3.12    # Install specific version
mise use python@3.12        # Use in current project

# direnv - Automatic environment switching
# Edit .envrc in project root:
echo 'export DEBUG=1' > .envrc
direnv allow                 # Enable for project
# Environment loads automatically when entering directory
```

## 🛠️ Project Automation

### Just Command Runner
```bash
j                     # List available commands
jd                    # just dev
jt                    # just test  
jb                    # just build
jr                    # just build-release
jc                    # just check
jf                    # just fmt
jl                    # just clippy
```

### Project Templates
Copy these to your project root:

**Rust Project:**
```bash
cp ~/.config/just/templates/rust-project.just ./justfile
cp ~/.config/direnv/templates/rust-project.envrc ./.envrc
direnv allow
```

**AI Agent Project:**
```bash
cp ~/.config/just/templates/ai-agent.just ./justfile
cp ~/.config/direnv/templates/ai-agent.envrc ./.envrc
direnv allow
```

### Environment Management
```bash
# mise (universal runtime manager)
mise install python@3.11    # Install Python version
mise use python@3.11        # Use in current project
mise list                   # Show installed versions

# direnv (automatic environment switching)
# Edit .envrc in project root, then:
direnv allow                 # Enable for project
```

## 🔧 Troubleshooting

### Common Issues

**Command not found after `cz apply`:**
```bash
exec zsh              # Restart shell
source ~/.zshrc        # Or reload config
```

**Bitwarden prompts during shell startup:**
- Fixed! Scripts now check if changes are needed before calling Bitwarden
- Should only prompt when configuration actually needs updating
- If still having issues, check that required Bitwarden items exist

**Bitwarden setup errors:**
- Ensure "GPG Private Key" secure note exists in Bitwarden
- Ensure "github.com" item has "noreply_email" custom field
- Run `bw unlock` before `cz apply` if needed

**Slow shell startup:**
```bash
# Check what's taking time
zsh -xvs             # Debug shell startup
```

**Cache issues:**
```bash
# Clear various caches
sccache --zero-stats  # Reset build cache
rm -rf ~/.cache/      # Nuclear option (will rebuild caches)
```

### Performance Tuning

**Rust compilation:**
- sccache automatically caches builds
- Use `cstats` to monitor cache hit rate
- LLD linker is configured for faster linking

**Shell responsiveness:**
- Enhanced zsh config includes completion caching
- History is optimized for 50k entries
- Background tasks don't block the shell

### Getting Help

**Tool-specific help:**
```bash
cargo nextest --help    # Rust testing
just --help            # Command runner
atuin help             # Shell history
broot --help           # File navigation
mise --help            # Runtime management
direnv --help          # Environment switching
gh --help              # GitHub CLI
sccache --help         # Build caching
```

**Debug commands:**
```bash
# Check tool installations
which cargo sccache atuin mise

# Check Bitwarden status
bw status

# Test shell performance
zsh -xvs               # Debug shell startup

# Check cache status
sccache --show-stats   # Build cache statistics
```

**Configuration locations:**
- `~/.config/` - All tool configurations
- `~/.local/share/chezmoi/` - Dotfiles source (this repository)
- `~/.cache/` - Performance caches
- `~/.local/share/atuin/` - Encrypted shell history database

**Architecture Overview:**
- **6-layer installation**: OS packages → Homebrew → Languages → Shell → Tools → Config
- **Idempotent scripts**: Safe to run multiple times
- **Smart dependencies**: Each layer builds on the previous
- **Bitwarden integration**: Secure credential management throughout
- **Performance optimized**: sccache, cargo-nextest, shell caching

## 🎯 What's Next?

1. **Try the tools**: Start with `zai` layout for a development session
2. **Create a project**: Use the templates for your AI agent work
3. **Customize**: Edit configs in `~/.config/` to fit your workflow
4. **Optimize**: Use `hyperfine` to benchmark your common tasks

Remember: **Every tool is designed to fail safely and perform optimally.** If something doesn't work, it will tell you clearly what went wrong and how to fix it.

---

**Built with the Rust philosophy: Fast, Safe, Productive** 🦀
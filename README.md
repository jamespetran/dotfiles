# Development Environment Dotfiles

A **chezmoi-based** dotfiles repository that creates a powerful, streamlined development environment.

## 🚀 Quick Setup (2-minute installation)

```bash
# Install chezmoi and apply dotfiles
chezmoi init --apply https://github.com/yourusername/dotfiles

# Restart shell
exec zsh
```

That's it! Your development environment is ready.

## 🎯 What You Get

### Host Development Tools
- **Language runtimes**: Python 3.11, Node.js LTS (via mise)
- **Essential tools**: pip, cargo, npm available for daily use
- **Fixed configuration**: No more pip virtualenv conflicts
- **Global tools**: pipx, black, flake8, TypeScript
- **Infrastructure tools**: Terraform ecosystem for 2025 learning goals

### Modern Shell Environment  
- **Zsh + Oh My Zsh + Powerlevel10k** - Beautiful, fast prompt
- **Modern CLI tools** - ripgrep, bat, eza, fzf, zoxide
- **Encrypted history** - Atuin for searchable shell history
- **Smart completion** - Enhanced zsh with 50k history

### Development Tools
- **Git enhancements** - lazygit, git-delta, advanced aliases  
- **Terminal multiplexer** - Zellij with custom layouts
- **File navigation** - broot with development shortcuts
- **GitHub CLI** - Integrated workflow tools

### Security & Credentials
- **Bitwarden integration** for secure credential management
- **GPG signing** automatically configured
- **SSH keys** managed securely

## 🛠️ Key Features

### 6-Layer Installation Architecture
1. **OS packages** - Essential system libraries (gcc, python3-dev, etc.)
2. **Homebrew** - Modern CLI alternatives and cross-platform tools
3. **Language toolchains** - Python, Node.js via mise
4. **Shell framework** - Oh My Zsh with plugins and Powerlevel10k theme
5. **Development tools** - GitHub CLI, Zellij, lazygit, performance tools  
6. **Configuration** - Tool-specific configs and optimizations

### Container Support
- **Podman/Docker** - Container runtime with aliases
- **Ready for containers** - Use containers for specific project needs
- **Host + container flexibility** - Best of both worlds

## 🚀 Essential Commands

### Chezmoi Management
```bash
cz apply              # Apply dotfiles changes
cz diff               # Show differences  
cz edit <file>        # Edit a dotfile
cz status             # Show status
```

### Development Tools
```bash
# Modern file operations
ls                    # eza with icons
rg "pattern"          # ripgrep search
bat file.txt          # syntax highlighted viewing

# Git workflow
lazygit               # Interactive git UI
gh                    # GitHub CLI
git lg                # Pretty log

# Language development
python --version      # Python 3.11 (mise-managed)
node --version        # Node.js LTS (mise-managed)
cargo --version       # Rust toolchain
```

### Package Management
```bash
# Keep packages updated
./run_always_update-packages.sh.tmpl

# Language-specific tools
pipx install tool     # Install global Python tool
npm install -g tool   # Install global Node.js tool
```

## 🛠️ Tools Explained

### Why These Tools? (Performance & UX Focused)

This environment prioritizes **fast, intuitive tools** that enhance daily development without breaking existing workflows. Each tool was chosen for specific advantages over traditional alternatives.

#### 🔍 File Search & Navigation
- **ripgrep (`rg`)** - 10x faster than `grep`, respects .gitignore by default, better regex support
- **fd** - 2x faster than `find`, intuitive syntax, parallel execution
- **fzf** - Interactive fuzzy finder, integrates everywhere (shell, vim, git)
- **eza** - Modern `ls` with git status, tree view, better colors
- **broot** - Interactive file navigator, handles huge directories efficiently

*Note: `rg` and `fd` complement traditional tools rather than replace them - different syntax but powerful for interactive use.*

#### 📄 File Processing & Viewing  
- **bat** - `cat` with syntax highlighting, git integration, automatic paging
- **jq** - Industry standard JSON processor, handles massive files efficiently
- **yq** - Same power as `jq` but for YAML/TOML/XML, preserves comments

#### 🔧 Git & Development
- **lazygit** - Visual git interface, covers 95% of git operations intuitively
- **git-delta** - Beautiful syntax-highlighted diffs, side-by-side view
- **gh** - Official GitHub CLI, comprehensive API coverage, extensible

#### 🖥️ Terminal & System
- **zellij** - Modern terminal multiplexer, better UX than tmux, WebAssembly plugins
- **atuin** - Encrypted shell history with cross-machine sync, fuzzy search
- **zoxide** - Smart `cd` replacement using frecency algorithm
- **btop** - Beautiful system monitor, GPU support, mouse interaction

#### ⚡ Performance & Development
- **hyperfine** - Statistical command benchmarking, handles outliers properly
- **tokei** - Blazing fast code statistics, 100x faster than `cloc`
- **just** - Simpler task runner than `make`, no tab sensitivity issues
- **mise** - Polyglot runtime manager, 5x faster than `asdf`, Rust-powered

#### 🏗️ Infrastructure & DevOps (2025 Focus)
*Essential for Terraform learning and modern infrastructure management:*
- **terraform** - Industry standard Infrastructure as Code
- **tflint** - Terraform linter for best practices and error detection
- **terraform-docs** - Auto-generate documentation for Terraform modules
- **terragrunt** - DRY configuration management for Terraform
- **infracost** - Cost estimation for infrastructure changes
- **tenv** - Version manager for Terraform/OpenTofu/Terragrunt

### 🔒 Safe Tool Philosophy

**Command Compatibility**: Traditional commands (`cat`, `ls`, `find`, `grep`) remain available alongside modern alternatives. This prevents script breakage while giving you choice:

- **Interactive work**: Use modern tools (`rg`, `fd`, `bat`, `eza`)
- **Scripts/automation**: Use traditional tools (`grep`, `find`, `cat`, `ls`)
- **System monitoring**: Launch `btop` same way you'd launch `htop` (safe upgrade with better UI)

### 🚀 2025 Enhancements

- **Rust ecosystem dominance**: Most performance tools written in Rust for speed/safety
- **Infrastructure focus**: Complete Terraform ecosystem for cloud-native development  
- **Developer experience**: Tools that "just work" with sensible defaults
- **Cross-platform consistency**: Same experience across Linux, macOS, containers

## 📚 Documentation

- **[USAGE.md](USAGE.md)** - Complete usage guide and tool reference
- **[CLAUDE.md](CLAUDE.md)** - Technical guidance for Claude Code
- **[test-simple.sh](test-simple.sh)** - Validate your setup

## 🔧 Architecture

### Bitwarden Integration
**IMPORTANT**: This setup uses Bitwarden for secure credential management.

**Required Bitwarden Items:**
- **"GPG Private Key"** (Secure Note): Your GPG private key for commit signing
- **"github.com"** (Login): Must have custom field "noreply_email" with your GitHub noreply email

### Fixed Configuration Approach
- **No more mode switching** - Single, streamlined configuration
- **Host tools available** - Python, Node.js, cargo ready for daily use
- **Container flexibility** - Use containers when you need different environments
- **Optimized for productivity** - Solves common development workflow issues

## 🆘 Need Help?

### Quick Validation
```bash
# Test your setup (includes 2025 Terraform tools)
./test-simple.sh
```

### Common Issues
- **Bitwarden locked**: Run `bw unlock` before `cz apply`
- **Missing tools**: Run `cz apply` to ensure all packages are installed
- **Terraform tools pending**: Install with `brew install terraform tflint terraform-docs terragrunt infracost tenv checkov trivy`
- **Shell issues**: Restart with `exec zsh`

### Getting Help
- **Migration context**: Check [latest_error.md](latest_error.md)
- **Claude Code issues**: Read [CLAUDE.md](CLAUDE.md)

---

*Built with chezmoi, secured with Bitwarden, optimized for daily development workflows*
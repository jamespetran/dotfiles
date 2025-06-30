# Development Environment Dotfiles

A **chezmoi-based** dotfiles repository that creates a powerful development environment. Choose your setup style:

## 🎯 Choose Your Path (2-minute setup)

### 🐳 **Minimal + Dev Containers** (Recommended)
**Perfect for**: Clean base system, IntelliJ IDEA Ultimate, containerized development

**What you get**: Essential shell tools + dev containers for each language
- ✅ **Clean host**: Only shell, git, containers, and core utilities
- ✅ **Isolated environments**: Python/Node/Rust in containers only  
- ✅ **IntelliJ ready**: Minimal host requirements
- ✅ **No conflicts**: No pip/npm/cargo version issues

```bash
# Quick setup
chezmoi init --apply https://github.com/yourusername/dotfiles
./switch-to-minimal.sh
chezmoi apply
```

→ **[Minimal Setup Guide](USAGE.md#minimal-setup)**  
→ **[Dev Container Templates](devcontainer-templates/)**

---

### 🔧 **Full Installation** (Power Users)
**Perfect for**: Everything on host, maximum tools, bare metal development

**What you get**: Complete 6-layer installation with all language runtimes
- ⚡ **All tools**: Python, Node, Rust, build tools on host
- ⚡ **Maximum power**: Full mise, sccache, cargo tools
- ⚡ **Single environment**: No containers needed
- ⚠️ **More complex**: Potential version conflicts

```bash
# Quick setup  
chezmoi init --apply https://github.com/yourusername/dotfiles
# Choose "full" when prompted
```

→ **[Full Installation Guide](USAGE.md#full-installation)**

---

## 📚 Documentation

- **[USAGE.md](USAGE.md)** - Complete setup and usage guide
- **[devcontainer-templates/](devcontainer-templates/)** - Dev container configs for IntelliJ/VS Code
- **[manual-upgrade-checklist.md](manual-upgrade-checklist.md)** - Safe upgrade management
- **[CLAUDE.md](CLAUDE.md)** - Technical guidance for Claude Code

## 🔧 Key Features

### Security & Credentials
- **Bitwarden integration** for secure credential management
- **GPG signing** automatically configured
- **SSH keys** managed securely

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

### Container & Runtime Management
- **Podman/Docker** - Container runtime with aliases
- **Mise** - Universal runtime manager (minimal mode: shell tools only)
- **Dev containers** - Pre-configured for Python, Rust, Node.js

## 🚀 Quick Commands

```bash
# Apply changes
cz apply

# Edit a dotfile  
cz edit ~/.zshrc

# Check status
cz status cz diff

# Switch between modes
./switch-to-minimal.sh    # Minimal mode
# (Full mode requires fresh install)
```

## 🆘 Need Help?

- **Migration issues?** Check [latest_error.md](latest_error.md) for context
- **Upgrade problems?** See [manual-upgrade-checklist.md](manual-upgrade-checklist.md)  
- **Container setup?** Browse [devcontainer-templates/](devcontainer-templates/)
- **Claude Code help?** Read [CLAUDE.md](CLAUDE.md)

---

*Built with chezmoi, secured with Bitwarden, optimized for performance*
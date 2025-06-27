# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a chezmoi dotfiles repository that manages a complete development environment setup. The configuration uses Bitwarden for secure credential management and includes automated package installation across multiple package managers.

## Key Commands

### Chezmoi Management
- `cz apply` - Apply dotfiles changes (uses Bitwarden-aware wrapper)
- `cz diff` - Show differences between source and target files
- `cz edit <file>` - Edit a dotfile in the source directory
- `cz status` - Show status of managed files
- `cz data` - Show template data available to chezmoi

The `cz` command is a wrapper function that automatically unlocks Bitwarden when needed.

### Package Installation
- `./run_onchange_install-dev-environment.sh.tmpl` - Full environment bootstrap (one-time)
- `./run_always_update-packages.sh.tmpl` - Keep packages current (every apply)
- Installs across 6 layers: OS → Homebrew → Languages → Shell → Tools → Config

### GPG Key Management
- `./run_onchange_import-gpg-key.sh.tmpl` - Import GPG key from Bitwarden (when needed)
- `./run_onchange_setup-gitconfig.sh.tmpl` - Configure git with Bitwarden email
- Key ID: `21D39CC1D0B3B44A`
- **Optimized**: Only calls Bitwarden if key/config actually needs updating

## Architecture

### File Structure
- `dot_*` files become dotfiles in the home directory (e.g., `dot_zshrc` → `~/.zshrc`)
- `*.tmpl` files are processed as Go templates with access to Bitwarden data
- `.chezmoidata/packages.yaml` contains package lists for different package managers
- Shell customizations are in `dot_oh-my-zsh/custom/`

### Bitwarden Integration (Recently Optimized)
**IMPORTANT CHANGE**: Fixed shell startup prompt issues by moving Bitwarden calls from template-time to runtime.

**Old Approach** (caused shell startup prompts):
- Used `{{ bitwarden }}` template functions
- Evaluated during every chezmoi operation
- Caused console output during shell initialization

**New Approach** (optimized):
- Uses `bw get` CLI commands at script runtime only
- Scripts check if changes are needed before calling Bitwarden
- No shell startup interruptions or Powerlevel10k warnings

**Required Bitwarden Items:**
- GPG private key stored as secure note "GPG Private Key"
- GitHub email in "github.com" item's "noreply_email" field
- Bitwarden CLI (`bw`) installed and unlocked when changes needed

### 6-Layer Installation Architecture
1. **OS packages** - dnf (Fedora) or apt (Debian/Ubuntu) - Essential system libraries
2. **Homebrew** - Modern CLI alternatives and cross-platform tools
3. **Language toolchains** - Rust (rustup), Node.js (mise), Python (mise)
4. **Shell framework** - Oh My Zsh with plugins and Powerlevel10k theme
5. **Development tools** - GitHub CLI, Zellij, lazygit, performance tools  
6. **Configuration** - Tool-specific configs and optimizations

**Script Types:**
- `run_onchange_*` - Execute when script content changes
- `run_always_*` - Execute on every `chezmoi apply`
- Templates processed with **runtime** Bitwarden access (not template-time)

### Development Tools Included
- Modern CLI alternatives: `eza`, `bat`, `fd`, `ripgrep`, `zoxide`
- Git tools: `git-delta`, `lazygit`, `gh` (GitHub CLI)
- Rust development: `cargo`, `zellij`
- Container tools: `podman` (with Docker aliases)
- Other: `fzf`, `jq`, `yq`, `direnv`, `btop`

## Recent Critical Fix: Bitwarden Shell Startup Optimization

**Problem Solved**: Template-time Bitwarden calls caused console output during shell initialization, triggering Powerlevel10k instant prompt warnings.

**Files Modified**:
- `run_onchange_setup-gitconfig.sh.tmpl` - Now uses `bw get item` at runtime
- `run_onchange_import-gpg-key.sh.tmpl` - Now uses `bw get notes` at runtime

**Result**: Clean shell startup, no unnecessary Bitwarden prompts.

## Important Notes

- The repository uses GPG signing for commits (automatically configured)
- Bitwarden only prompts when configuration changes are actually needed
- All installation scripts are idempotent and safe to run multiple times
- Zsh is the target shell with Oh My Zsh framework
- Setup works in both native environments and toolbox containers
- All scripts include proper error handling and exit status reporting

## Documentation

- **USAGE.md** - Comprehensive user guide for all tools and workflows
- **CLAUDE.md** - This file, for Claude Code instances
- All configurations follow Rust principles: performance, safety, explicit error handling

## Power User Features Added

**Phase 1: Shell Intelligence**
- Atuin: Encrypted, searchable shell history
- Enhanced zsh: 50k history, smart completion, custom functions
- Zellij layouts: zdev, zrust, zai, zmon
- Advanced git: git-absorb, git-branchless with enhanced workflows

**Phase 2: Development Workflow**
- mise: Universal runtime management (Python, Node.js)
- just: Command runner with Rust and AI project templates
- direnv: Automatic environment switching with AI-optimized layouts
- GitHub CLI: Extensions and streamlined workflow

**Phase 3: System Intelligence**
- cargo-nextest: Blazing-fast Rust testing
- sccache: Distributed compilation caching
- Dataset analysis: Smart tools for AI/ML data work (dv, dstats, dfind, dcheck)
- Notification system: Smart background task management
- Intelligent file navigation: broot with development-optimized configuration

**Design Philosophy:**
- **Performance First**: Modern Rust-based tools throughout the stack
- **Dual Interface**: Non-interactive (cat, ls) for speed, interactive (bcat, br) for exploration  
- **Smart Caching**: sccache for builds, shell completion caching, encrypted history
- **Secure by Default**: GPG signing, Bitwarden credentials, encrypted shell history
- **Zero-Cost Abstractions**: Only install and configure what's actively used
- **Idempotent Operations**: All scripts safe to run multiple times
- **Layered Dependencies**: Clear installation ordering for reliability

## Maintenance & Debugging for Claude

### Validate Installation Layers
```bash
# Layer 1: OS packages
which gcc git curl python3 || echo "Layer 1 incomplete"

# Layer 2: Homebrew
which brew && brew list | head -5 || echo "Layer 2 incomplete"

# Layer 3: Language toolchains  
which cargo node && mise list || echo "Layer 3 incomplete"

# Layer 4: Shell framework
echo $ZSH && ls $ZSH/custom/plugins || echo "Layer 4 incomplete"

# Layer 5: Development tools
which gh lazygit zellij atuin || echo "Layer 5 incomplete"

# Layer 6: Performance tools
sccache --show-stats && cargo nextest --version || echo "Layer 6 incomplete"
```

### Debug Common Issues
```bash
# Bitwarden integration
bw status                                    # Check vault status
bw get item "github.com" | jq '.fields[]'    # Verify required fields

# Git configuration
git config --global -l | grep -E "user\.|signing"
gpg --list-secret-keys 21D39CC1D0B3B44A

# Performance monitoring
sccache --show-stats                        # Build cache hit rate
atuin stats                                 # Shell history stats
zsh -c 'time zsh -i -c exit'               # Shell startup time
```

### Common Troubleshooting
1. **Shell startup prompts**: Should be fixed, but verify `bw status` and required vault items
2. **Template errors**: Usually Bitwarden access issues or missing vault items
3. **Package failures**: Check internet connection, sudo access, and package manager status
4. **Performance issues**: Verify all layers completed and caches are functioning
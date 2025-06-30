#!/bin/bash
set -euo pipefail

echo "🔄 Switching to minimal dotfiles configuration..."

# Backup current full setup
echo "📦 Backing up current configuration..."
cp .chezmoidata/packages.yaml .chezmoidata/packages-full.yaml
cp run_onchange_setup-mise.sh.tmpl run_onchange_setup-mise-full.sh.tmpl

# Replace with minimal versions  
echo "🎯 Installing minimal configuration..."
cp .chezmoidata/packages-minimal.yaml .chezmoidata/packages.yaml
cp run_onchange_setup-mise-minimal.sh.tmpl run_onchange_setup-mise.sh.tmpl

# Remove problematic scripts that install language runtimes
echo "🧹 Removing language runtime scripts..."
if [ -f "run_onchange_setup-rust-toolchain.sh.tmpl" ]; then
  mv run_onchange_setup-rust-toolchain.sh.tmpl run_onchange_setup-rust-toolchain.sh.tmpl.disabled
fi

echo "✅ Switch complete!"
echo ""
echo "📝 What changed:"
echo "  - Using minimal package set (essential tools only)"
echo "  - Removed Python/Node/Rust from base setup"  
echo "  - Language runtimes now go in dev containers"
echo ""
echo "🚀 Next steps:"
echo "  1. Run 'chezmoi apply' to update your system"
echo "  2. Use dev container templates in devcontainer-templates/"
echo "  3. Keep your base system clean!"
echo ""
echo "🔄 Upgrade strategy:"
echo "  - Daily: Only ensures packages are installed (no upgrades)"
echo "  - Weekly: Run './run_weekly_safe-upgrades.sh.tmpl' for safe CLI tools"
echo "  - Manual: Use 'manual-upgrade-checklist.md' for critical tools"
echo "  - Containers: Upgrade language runtimes in dev containers only"
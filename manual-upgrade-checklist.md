# Manual Upgrade Checklist

For tools that need careful manual upgrades on your minimal base system.

## 🐳 Container Runtime
- [ ] **podman** - Check running containers first: `podman ps -a`
- [ ] Test with simple container: `podman run --rm hello-world`
- [ ] Upgrade: `sudo dnf upgrade podman` or `brew upgrade podman`

## 🖥️ Terminal Tools  
- [ ] **zellij** - Backup layouts first: `cp -r ~/.config/zellij ~/.config/zellij.backup`
- [ ] Check release notes for keybinding changes
- [ ] Upgrade: `brew upgrade zellij`
- [ ] Test your layouts: `zellij list-sessions`

## 🔧 Git Tools
- [ ] **lazygit** - Usually safe, but check keybindings
- [ ] **gh** - May add new auth requirements  
- [ ] Test with: `gh auth status`

## 📁 File Navigation
- [ ] **broot** - Config changes might affect custom shortcuts
- [ ] Backup: `cp ~/.config/broot/conf.hjson ~/.config/broot/conf.hjson.backup`
- [ ] Test custom shortcuts after upgrade

## 🐧 System Packages (dnf/apt)
- [ ] **git** - Usually safe but test signing: `git log --show-signature -1`
- [ ] **podman** - As above
- [ ] **htop** - Safe, just UI changes

## 🧪 Testing After Upgrades
```bash
# Test essential workflow
gh auth status
git status && git log --oneline -5
zellij list-sessions  
podman version
broot --help
```

## 🔄 Rollback Plan
- Homebrew: `brew pin <package>` to prevent upgrades
- System: Use dnf/apt history to rollback
- Config: Restore from .backup files
- Containers: Keep working images tagged
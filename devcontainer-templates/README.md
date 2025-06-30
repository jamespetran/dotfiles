# Dev Container Templates

These templates provide clean, isolated development environments that work with both VS Code and IntelliJ IDEA Ultimate.

## Usage with IntelliJ IDEA Ultimate

1. Copy the appropriate `.devcontainer.json` to your project root
2. In IntelliJ: **Tools → Dev Containers → Create Dev Container**
3. IntelliJ will build and connect to the container

## Available Templates

### Python Development
- Python 3.11 with poetry and pipx
- No virtualenv restrictions inside container
- Mounts your zsh config for consistent shell

### Rust Development  
- Latest stable Rust
- Includes sccache for fast builds
- Cargo tools pre-installed
- Shares cargo registry cache with host

### Node.js Development
- Node.js 20 LTS
- Includes pnpm and yarn
- Shares npm cache with host

## Benefits

- **Clean Host**: No language runtimes on your base system
- **Reproducible**: Same environment for all team members  
- **Isolated**: Each project has its own dependencies
- **Fast**: Shared caches between containers
- **Consistent**: Your shell config works in containers

## Tips

- Use Podman instead of Docker on Fedora Silverblue
- Mount additional config as needed
- Containers restart with your shell environment
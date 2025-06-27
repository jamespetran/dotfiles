# Rust Project Justfile Template
# Copy this to your project root as 'justfile'

# Default recipe to display available commands
default:
    @just --list

# Development commands
dev:
    cargo watch -x "check --all-targets" -x "test --lib"

build:
    cargo build

build-release:
    cargo build --release

# Testing
test:
    cargo test

test-verbose:
    cargo test -- --nocapture

test-watch:
    cargo watch -x "test"

bench:
    cargo bench

# Code quality
check:
    cargo check --all-targets

clippy:
    cargo clippy --all-targets -- -D warnings

clippy-fix:
    cargo clippy --fix --all-targets

fmt:
    cargo fmt

fmt-check:
    cargo fmt -- --check

# Documentation
doc:
    cargo doc --no-deps --open

doc-all:
    cargo doc --document-private-items --no-deps --open

# Cleaning
clean:
    cargo clean

# Dependency management
update:
    cargo update

outdated:
    cargo outdated

audit:
    cargo audit

# AI/ML specific tasks (customize as needed)
train:
    @echo "Add your training script here"
    # python scripts/train.py

infer:
    @echo "Add your inference script here"
    # python scripts/infer.py

evaluate:
    @echo "Add your evaluation script here"
    # python scripts/evaluate.py

# Development environment
setup:
    @echo "Setting up development environment..."
    cargo install cargo-watch cargo-outdated cargo-audit
    @echo "Setup complete!"

# CI/CD simulation
ci: fmt-check clippy test
    @echo "All checks passed! ✅"

# Release preparation
prepare-release version:
    @echo "Preparing release {{version}}..."
    cargo test
    cargo clippy -- -D warnings
    cargo fmt -- --check
    git tag -a "v{{version}}" -m "Release v{{version}}"
    @echo "Ready to release v{{version}}!"

# Docker (if using containers for AI workloads)
docker-build:
    docker build -t ai-agent .

docker-run:
    docker run -it --rm ai-agent

# Profiling and optimization
profile:
    cargo build --release
    perf record target/release/your-binary
    perf report

flamegraph:
    cargo flamegraph

# Database migrations (if using databases)
migrate:
    @echo "Run database migrations here"
    # sqlx migrate run

reset-db:
    @echo "Reset database here"
    # sqlx database drop && sqlx database create && sqlx migrate run
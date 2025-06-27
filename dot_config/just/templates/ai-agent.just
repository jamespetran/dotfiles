# AI Agent Development Justfile Template
# Specialized for AI agent development workflows

# Default recipe
default:
    @just --list

# Core development
dev:
    cargo watch -x "check" -x "test --lib" -s "just lint-python"

build:
    cargo build

build-release:
    cargo build --release --features production

# Testing with AI-specific considerations
test:
    cargo test
    python -m pytest tests/ -v

test-integration:
    @echo "Running integration tests with live APIs..."
    cargo test integration --features integration-tests

test-models:
    @echo "Testing model inference..."
    python scripts/test_models.py

# AI/ML Pipeline
train model:
    @echo "Training {{model}}..."
    python scripts/train.py --model {{model}}

evaluate model:
    @echo "Evaluating {{model}}..."
    python scripts/evaluate.py --model {{model}}

infer input:
    @echo "Running inference on {{input}}..."
    cargo run --bin infer -- "{{input}}"

# Data management
download-data:
    @echo "Downloading training data..."
    python scripts/download_data.py

prepare-data:
    @echo "Preprocessing data..."
    python scripts/prepare_data.py

clean-data:
    @echo "Cleaning data artifacts..."
    rm -rf data/processed/ data/cache/

# Code generation testing
gen-test prompt:
    @echo "Testing code generation with: {{prompt}}"
    cargo run --bin agent -- generate "{{prompt}}"

gen-eval:
    @echo "Evaluating generated code quality..."
    python scripts/evaluate_codegen.py

# Model management
download-models:
    @echo "Downloading pre-trained models..."
    python scripts/download_models.py

update-models:
    @echo "Updating model versions..."
    python scripts/update_models.py

benchmark-models:
    @echo "Benchmarking model performance..."
    python scripts/benchmark.py

# Environment setup
setup-dev:
    @echo "Setting up AI development environment..."
    cargo install cargo-watch cargo-edit
    pip install -r requirements.txt
    python -c "import torch; print(f'PyTorch: {torch.__version__}')"
    @echo "Setup complete!"

setup-prod:
    @echo "Setting up production environment..."
    cargo build --release
    pip install --no-dev -r requirements.txt

# API server management
serve:
    @echo "Starting AI agent API server..."
    cargo run --bin server

serve-dev:
    @echo "Starting development server with hot reload..."
    cargo watch -x "run --bin server"

# Monitoring and debugging
logs:
    tail -f logs/agent.log

monitor:
    @echo "Monitoring system resources..."
    btop

debug-memory:
    @echo "Memory profiling..."
    valgrind --tool=massif target/debug/agent

# Documentation
docs:
    cargo doc --no-deps --open
    python -m mkdocs serve

# Quality assurance
lint:
    cargo clippy --all-targets -- -D warnings
    just lint-python

lint-python:
    python -m black --check .
    python -m isort --check-only .
    python -m flake8 .

format:
    cargo fmt
    python -m black .
    python -m isort .

# Security
audit:
    cargo audit
    python -m safety check

# Deployment
deploy env:
    @echo "Deploying to {{env}}..."
    docker build -t ai-agent:{{env}} .
    # Add your deployment commands here

# Backup and restore
backup:
    @echo "Backing up models and data..."
    tar -czf backup-$(date +%Y%m%d).tar.gz models/ data/processed/

restore backup:
    @echo "Restoring from {{backup}}..."
    tar -xzf {{backup}}

# Research and experimentation
experiment name:
    @echo "Starting experiment: {{name}}"
    mkdir -p experiments/{{name}}
    cp -r templates/experiment/* experiments/{{name}}/
    @echo "Experiment {{name}} initialized!"

# Performance testing
perf-test:
    @echo "Running performance tests..."
    cargo bench
    python scripts/perf_test.py

stress-test:
    @echo "Running stress tests..."
    python scripts/stress_test.py

# Clean up
clean:
    cargo clean
    rm -rf __pycache__/ .pytest_cache/
    find . -name "*.pyc" -delete

clean-all: clean
    rm -rf models/ data/cache/ logs/*.log
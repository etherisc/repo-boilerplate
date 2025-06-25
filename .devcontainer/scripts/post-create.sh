#!/bin/bash

# Post-create script for DevContainer setup
# This script runs after the container is created and can be customized for your tech stack

set -e

echo "🚀 Setting up development environment..."

# Update system packages
echo "📦 Updating system packages..."
sudo apt-get update

# Install common tools
echo "🔧 Installing common development tools..."
sudo apt-get install -y \
    curl \
    wget \
    git \
    vim \
    nano \
    jq \
    tree \
    htop \
    unzip

# =============================================================================
# Tech Stack Specific Setup - Uncomment based on your project
# =============================================================================

# -----------------------------------------------------------------------------
# Node.js Projects
# -----------------------------------------------------------------------------
# echo "📦 Setting up Node.js environment..."
# # Install pnpm (recommended) or yarn
# curl -fsSL https://get.pnpm.io/install.sh | sh -
# source ~/.bashrc
# 
# # Alternative: Install yarn
# # npm install -g yarn
# 
# # Install dependencies
# if [ -f "package.json" ]; then
#     echo "Installing Node.js dependencies..."
#     pnpm install
# fi

# -----------------------------------------------------------------------------
# Python Projects
# -----------------------------------------------------------------------------
# echo "🐍 Setting up Python environment..."
# # Install pip and virtualenv
# sudo apt-get install -y python3-pip python3-venv
# 
# # Create virtual environment
# if [ ! -d ".venv" ]; then
#     python3 -m venv .venv
# fi
# 
# # Activate virtual environment and install dependencies
# source .venv/bin/activate
# if [ -f "requirements.txt" ]; then
#     echo "Installing Python dependencies..."
#     pip install -r requirements.txt
# fi
# 
# # Install development tools
# pip install black flake8 pytest

# -----------------------------------------------------------------------------
# Go Projects
# -----------------------------------------------------------------------------
# echo "🐹 Setting up Go environment..."
# # Go is typically installed via the devcontainer feature
# # Install common Go tools
# go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
# go install golang.org/x/tools/gopls@latest
# 
# # Download dependencies
# if [ -f "go.mod" ]; then
#     echo "Downloading Go dependencies..."
#     go mod download
# fi

# -----------------------------------------------------------------------------
# Java Projects
# -----------------------------------------------------------------------------
# echo "☕ Setting up Java environment..."
# # Install Maven (if not using Gradle)
# if [ -f "pom.xml" ]; then
#     echo "Installing Maven dependencies..."
#     mvn dependency:resolve
# fi
# 
# # Install Gradle dependencies (if using Gradle)
# if [ -f "build.gradle" ] || [ -f "build.gradle.kts" ]; then
#     echo "Installing Gradle dependencies..."
#     ./gradlew build --no-daemon
# fi

# -----------------------------------------------------------------------------
# .NET Projects
# -----------------------------------------------------------------------------
# echo "🔷 Setting up .NET environment..."
# # Restore NuGet packages
# if [ -f "*.sln" ] || [ -f "*.csproj" ]; then
#     echo "Restoring .NET dependencies..."
#     dotnet restore
# fi

# -----------------------------------------------------------------------------
# Rust Projects
# -----------------------------------------------------------------------------
# echo "🦀 Setting up Rust environment..."
# # Install Rust toolchain (if not already installed)
# if ! command -v rustc &> /dev/null; then
#     curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
#     source ~/.cargo/env
# fi
# 
# # Build project dependencies
# if [ -f "Cargo.toml" ]; then
#     echo "Building Rust dependencies..."
#     cargo build
# fi

# =============================================================================
# Git Configuration
# =============================================================================
echo "🔧 Setting up Git configuration..."

# Set up Git safe directory (for container security)
git config --global --add safe.directory /workspace

# Set up Git hooks directory if it exists
if [ -d ".githooks" ]; then
    git config core.hooksPath .githooks
fi

# =============================================================================
# Shell Enhancements
# =============================================================================
echo "🎨 Setting up shell enhancements..."

# Install Starship prompt (optional)
# curl -sS https://starship.rs/install.sh | sh -s -- -y
# echo 'eval "$(starship init bash)"' >> ~/.bashrc

# Add useful aliases
cat >> ~/.bashrc << 'EOF'

# Project-specific aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'

# Development shortcuts (uncomment based on your tech stack)
# alias dev='npm run dev'          # Node.js
# alias serve='python -m http.server 8000'  # Python
# alias build='go build .'         # Go
# alias test='mvn test'            # Java Maven
# alias run='dotnet run'           # .NET

EOF

# =============================================================================
# IDE/Editor Setup
# =============================================================================
echo "📝 Setting up editor configuration..."

# VS Code settings are handled by devcontainer.json
# Additional setup can be done here if needed

# =============================================================================
# Database Setup (if applicable)
# =============================================================================
# echo "🗄️ Setting up database connections..."
# # Wait for database services to be ready
# # This is useful when using docker-compose with database services
# 
# # Wait for PostgreSQL
# # echo "Waiting for PostgreSQL..."
# # until pg_isready -h postgres -p 5432; do
# #     sleep 1
# # done
# 
# # Wait for Redis
# # echo "Waiting for Redis..."
# # until redis-cli -h redis ping; do
# #     sleep 1
# # done

# =============================================================================
# Project Setup
# =============================================================================
echo "🏗️ Running project-specific setup..."

# Create necessary directories
mkdir -p logs
mkdir -p tmp
mkdir -p .dev

# Copy environment file template
if [ -f ".env.example" ] && [ ! -f ".env" ]; then
    cp .env.example .env
    echo "📝 Created .env file from template. Please configure your environment variables."
fi

# Make scripts executable
if [ -d "scripts" ]; then
    find scripts -type f -name "*.sh" -exec chmod +x {} \;
fi

# =============================================================================
# Completion
# =============================================================================
echo "✅ Development environment setup complete!"
echo ""
echo "🎯 Next steps:"
echo "1. Configure your .env file if needed"
echo "2. Review and uncomment tech-stack specific sections in this script"
echo "3. Start developing!"
echo ""

# Tech-stack specific next steps (uncomment as needed)
# echo "📦 Node.js: Run 'pnpm dev' to start the development server"
# echo "🐍 Python: Run 'source .venv/bin/activate' to activate virtual environment"
# echo "🐹 Go: Run 'go run main.go' to start your application"
# echo "☕ Java: Run 'mvn spring-boot:run' to start your application"
# echo "🔷 .NET: Run 'dotnet run' to start your application"
# echo "🦀 Rust: Run 'cargo run' to start your application" 
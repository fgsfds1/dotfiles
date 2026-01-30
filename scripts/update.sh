#!/usr/bin/env bash
# Update script for chezmoi dotfiles
# Pulls latest changes and applies them

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_info() {
    echo -e "${BLUE}[UPDATING]${NC} $1"
}

# Check if chezmoi is installed
if ! command -v chezmoi &> /dev/null; then
    echo -e "${RED}[ERROR]${NC} chezmoi is not installed"
    echo "Install chezmoi with: pacman -S chezmoi"
    exit 1
fi

print_status "Updating chezmoi dotfiles..."

# Change to chezmoi directory
cd "$(chezmoi data | jq -r '.chezmoi.workingTree')"

# Pull latest changes from git
print_info "Pulling latest changes from git..."
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
git pull origin "$CURRENT_BRANCH" || git pull origin main

# Apply chezmoi changes
print_info "Applying chezmoi changes..."
chezmoi update

print_status "Update complete!"

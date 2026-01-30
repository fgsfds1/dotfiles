#!/usr/bin/env bash
# Bootstrap script for chezmoi dotfiles
# Installs chezmoi if needed and applies dotfiles

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_info() {
    echo -e "${BLUE}[BOOTSTRAP]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if chezmoi is installed
check_chzmoi() {
    if command -v chezmoi &> /dev/null; then
        local version=$(chezmoi --version)
        print_status "chezmoi is installed: $version"
        return 0
    else
        print_warning "chezmoi is not installed"
        return 1
    fi
}

# Install chezmoi
install_chzmoi() {
    print_info "Installing chezmoi..."

    if command -v pacman &> /dev/null; then
        # Arch Linux
        print_status "Installing chezmoi via pacman..."
        sudo pacman -S --needed chezmoi
    elif command -v brew &> /dev/null; then
        # macOS
        print_status "Installing chezmoi via Homebrew..."
        brew install chezmoi
    elif command -v curl &> /dev/null; then
        # Generic Linux/macOS
        print_status "Installing chezmoi via curl..."
        sh -c "$(curl -fsLS get.chezmoi.io)"
    else
        print_error "Cannot install chezmoi: curl not found"
        return 1
    fi

    print_status "chezmoi installation complete"
}

# Check if chezmoi is initialized
check_initialized() {
    local source_dir=$(chezmoi data | jq -r '.chezmoi.sourceDir' 2>/dev/null)
    if [ -d "$source_dir" ]; then
        print_status "chezmoi is initialized at $source_dir"
        return 0
    else
        print_warning "chezmoi is not initialized"
        return 1
    fi
}

# Initialize chezmoi with current directory
initialize_chzmoi() {
    print_info "Initializing chezmoi..."

    # Add current directory as chezmoi source
    chezmoi init --source "$(pwd)"

    # Add all current files
    print_info "Adding files to chezmoi..."
    chezmoi add -a .

    # Commit initial state in chezmoi working tree
    cd "$(chezmoi data | jq -r '.chezmoi.workingTree')"
    git branch -M main
    git add -A
    git commit -m "Initial chezmoi setup"

    print_status "chezmoi initialization complete"
}

# Apply chezmoi changes
apply_chzmoi() {
    print_info "Applying chezmoi changes..."
    chezmoi update

    print_status "chezmoi application complete"
}

# Main execution
main() {
    print_status "Starting chezmoi bootstrap..."

    # Check and install chezmoi
    if ! check_chzmoi; then
        install_chzmoi
    fi

    # Initialize if needed
    if ! check_initialized; then
        initialize_chzmoi
    fi

    # Apply changes
    apply_chzmoi

    print_status "Bootstrap complete!"
    echo ""
    echo "Next steps:"
    echo "  - Check your configurations: chezmoi diff"
    echo "  - Edit configs: chezmoi edit ~/.config/your-app/config"
    echo "  - View chezmoi status: chezmoi status"
}

# Run main function
main "$@"

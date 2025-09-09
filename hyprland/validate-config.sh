#!/usr/bin/env bash
# Script to validate Hyprland configuration files

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[OK]${NC} $1"
}

validate_config() {
    local config_file="$1"
    local config_name="$2"
    
    echo -e "${BLUE}Validating $config_name...${NC}"
    
    # Check if file exists and is readable
    if [[ ! -f "$config_file" ]]; then
        print_error "Configuration file not found: $config_file"
        return 1
    fi
    
    if [[ ! -r "$config_file" ]]; then
        print_error "Configuration file not readable: $config_file"
        return 1
    fi
    
    # Basic syntax checks
    local errors=0
    
    # Check for unclosed braces
    local open_braces=$(grep -o '{' "$config_file" | wc -l)
    local close_braces=$(grep -o '}' "$config_file" | wc -l)
    
    if [[ $open_braces -ne $close_braces ]]; then
        print_error "Mismatched braces: $open_braces opening, $close_braces closing"
        errors=$((errors + 1))
    fi
    
    # Check for required sections in machine configs
    if [[ "$config_name" != "common" ]]; then
        if ! grep -q "^source.*common" "$config_file"; then
            print_warning "No source line found for common configuration"
        else
            print_success "✓ Sources common configuration"
        fi
        
        if ! grep -q "^monitor" "$config_file"; then
            print_warning "No monitor configuration found"
        else
            print_success "✓ Monitor configuration present"
        fi
    fi
    
    # Check for common required sections in main config
    if [[ "$config_name" == "common" ]]; then
        local required_sections=("general" "decoration" "animations" "input")
        
        for section in "${required_sections[@]}"; do
            if grep -q "^$section\s*{" "$config_file"; then
                print_success "✓ $section section found"
            else
                print_error "Required section missing: $section"
                errors=$((errors + 1))
            fi
        done
        
        # Check for essential keybinds
        if grep -q '\\$mainMod.*killactive' "$config_file"; then
            print_success "✓ Essential keybinds present"
        else
            print_warning "Some essential keybinds may be missing"
        fi
    fi
    
    # Check for executable references
    while IFS= read -r line; do
        if [[ "$line" =~ exec.*= ]]; then
            # Extract command name (first word after exec)
            local cmd=$(echo "$line" | sed 's/.*exec[^=]*=\s*//' | awk '{print $1}' | tr -d '"')
            if [[ -n "$cmd" ]] && ! command -v "$cmd" >/dev/null 2>&1; then
                print_warning "Command not found in PATH: $cmd"
            fi
        fi
    done < "$config_file"
    
    if [[ $errors -eq 0 ]]; then
        print_success "✓ $config_name configuration appears valid"
        return 0
    else
        print_error "✗ $config_name configuration has $errors error(s)"
        return 1
    fi
}

main() {
    echo -e "${BLUE}Hyprland Configuration Validator${NC}"
    echo "=================================="
    echo
    
    local total_errors=0
    
    # Validate common configuration
    if validate_config "common/hyprland.conf" "common"; then
        echo
    else
        total_errors=$((total_errors + 1))
        echo
    fi
    
    # Validate machine-specific configurations
    for machine_dir in */; do
        if [[ -f "${machine_dir}hyprland.conf" ]] && [[ "$machine_dir" != "common/" ]]; then
            machine_name="${machine_dir%/}"
            if validate_config "${machine_dir}hyprland.conf" "$machine_name"; then
                echo
            else
                total_errors=$((total_errors + 1))
                echo
            fi
        fi
    done
    
    # Validate waybar configuration
    if [[ -f "waybar/config.json" ]]; then
        echo -e "${BLUE}Validating waybar configuration...${NC}"
        if command -v jq >/dev/null 2>&1; then
            if jq empty waybar/config.json >/dev/null 2>&1; then
                print_success "✓ Waybar JSON configuration is valid"
            else
                print_error "✗ Waybar JSON configuration is invalid"
                total_errors=$((total_errors + 1))
            fi
        else
            print_warning "jq not available, skipping JSON validation"
        fi
        echo
    fi
    
    # Summary
    echo "=================================="
    if [[ $total_errors -eq 0 ]]; then
        print_success "All configurations validated successfully!"
        exit 0
    else
        print_error "Found $total_errors configuration error(s)"
        exit 1
    fi
}

# Run validation
main "$@"


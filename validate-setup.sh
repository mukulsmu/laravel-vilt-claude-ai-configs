#!/usr/bin/env bash

# Laravel VILT Stack AI Toolkit Setup Validation Script
# Verifies that all components are correctly installed

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_header() {
    echo -e "\n${BLUE}════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Laravel VILT Stack AI Toolkit - Setup Validation${NC}"
    echo -e "${BLUE}════════════════════════════════════════════════════════${NC}\n"
}

print_section() {
    echo -e "\n${BLUE}▶ $1${NC}"
}

print_success() {
    echo -e "  ${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "  ${RED}✗${NC} $1"
}

print_warning() {
    echo -e "  ${YELLOW}!${NC} $1"
}

print_info() {
    echo -e "  ${BLUE}→${NC} $1"
}

errors=0
warnings=0

check_laravel_project() {
    print_section "Checking Laravel Project"

    if [ -f "artisan" ]; then
        print_success "Laravel project detected"

        # Check Laravel version
        if php artisan --version 2>/dev/null | grep -q "Laravel Framework"; then
            version=$(php artisan --version | grep -oP '\d+\.\d+' | head -1)
            print_success "Laravel version: $version"

            if [ "${version%.*}" -ge "11" ]; then
                print_success "Laravel version is 11+ (compatible)"
            else
                print_warning "Laravel version is older than 11 (some features may not work)"
                ((warnings++))
            fi
        fi
    else
        print_error "Not a Laravel project (artisan not found)"
        ((errors++))
    fi
}

check_prerequisites() {
    print_section "Checking Prerequisites"

    # Check PHP
    if command -v php &> /dev/null; then
        php_version=$(php -v | head -1 | grep -oP '\d+\.\d+' | head -1)
        print_success "PHP installed: $php_version"

        if [ "${php_version%.*}" -ge "8" ]; then
            print_success "PHP version is 8.2+ compatible"
        else
            print_error "PHP version should be 8.2+"
            ((errors++))
        fi
    else
        print_error "PHP not found"
        ((errors++))
    fi

    # Check Composer
    if command -v composer &> /dev/null; then
        print_success "Composer installed"
    else
        print_error "Composer not found"
        ((errors++))
    fi

    # Check Node.js
    if command -v node &> /dev/null; then
        node_version=$(node -v | grep -oP '\d+' | head -1)
        print_success "Node.js installed: $(node -v)"
    else
        print_warning "Node.js not found (needed for Vue/Vite)"
        ((warnings++))
    fi

    # Check npm
    if command -v npm &> /dev/null; then
        print_success "npm installed: $(npm -v)"
    else
        print_warning "npm not found"
        ((warnings++))
    fi
}

check_laravel_boost() {
    print_section "Checking Laravel Boost"

    if php artisan list 2>/dev/null | grep -q "boost:"; then
        print_success "Laravel Boost is installed"

        if php artisan list 2>/dev/null | grep -q "boost:mcp"; then
            print_success "Laravel Boost MCP server available"
        else
            print_warning "Laravel Boost MCP command not found"
            ((warnings++))
        fi
    else
        print_error "Laravel Boost not installed (required for optimal functionality)"
        print_info "Install with: composer require laravel/boost && php artisan boost:install"
        ((errors++))
    fi
}

check_copilot_configs() {
    print_section "Checking GitHub Copilot Configurations"

    if [ -f ".github/copilot-instructions.md" ]; then
        print_success ".github/copilot-instructions.md exists"

        if grep -q "VILT" .github/copilot-instructions.md; then
            print_success "VILT configurations detected"
        else
            print_warning "VILT configurations may be missing"
            ((warnings++))
        fi
    else
        print_error ".github/copilot-instructions.md not found"
        ((errors++))
    fi

    if [ -d ".github/instructions" ]; then
        print_success ".github/instructions/ directory exists"
    else
        print_warning ".github/instructions/ not found (path-scoped rules missing)"
        ((warnings++))
    fi

    if [ -d ".github/agents" ]; then
        print_success ".github/agents/ directory exists"
    else
        print_warning ".github/agents/ not found"
        ((warnings++))
    fi

    if [ -f "AGENTS.md" ]; then
        print_success "AGENTS.md exists"
    else
        print_warning "AGENTS.md not found"
        ((warnings++))
    fi
}

check_claude_configs() {
    print_section "Checking Claude Code Configurations"

    if [ -f "CLAUDE.md" ]; then
        print_success "CLAUDE.md exists"
    else
        print_warning "CLAUDE.md not found (optional if not using Claude)"
        ((warnings++))
    fi

    if [ -d ".claude/agents" ]; then
        print_success ".claude/agents/ directory exists"

        agent_count=$(find .claude/agents -name "*.md" | wc -l)
        print_info "Found $agent_count specialist agents"
    else
        print_warning ".claude/agents/ not found (optional if not using Claude)"
        ((warnings++))
    fi

    if [ -d ".claude/instructions" ]; then
        print_success ".claude/instructions/ directory exists"
    else
        print_warning ".claude/instructions/ not found"
        ((warnings++))
    fi
}

check_documentation() {
    print_section "Checking Documentation"

    if [ -d "docs" ]; then
        print_success "docs/ directory exists"

        if [ -d "docs/workflows" ]; then
            print_success "docs/workflows/ exists"
        else
            print_warning "docs/workflows/ not found"
            ((warnings++))
        fi

        if [ -d "docs/mcp-servers" ]; then
            print_success "docs/mcp-servers/ exists"
        else
            print_warning "docs/mcp-servers/ not found"
            ((warnings++))
        fi

        if [ -d "docs/reference" ]; then
            print_success "docs/reference/ exists"
        else
            print_warning "docs/reference/ not found"
            ((warnings++))
        fi
    else
        print_warning "docs/ directory not found (optional but recommended)"
        ((warnings++))
    fi
}

check_vilt_structure() {
    print_section "Checking VILT Stack Structure"

    if [ -d "resources/js" ]; then
        print_success "resources/js/ exists"

        if [ -d "resources/js/Pages" ]; then
            print_success "resources/js/Pages/ exists (Inertia pages)"
        else
            print_warning "resources/js/Pages/ not found"
            ((warnings++))
        fi

        if [ -d "resources/js/Components" ]; then
            print_success "resources/js/Components/ exists"
        else
            print_warning "resources/js/Components/ not found"
            ((warnings++))
        fi

        if [ -f "resources/js/app.js" ] || [ -f "resources/js/app.ts" ]; then
            print_success "resources/js/app.js or app.ts exists"
        else
            print_warning "Main JS/TS entry file not found"
            ((warnings++))
        fi
    else
        print_warning "resources/js/ not found"
        ((warnings++))
    fi

    if [ -f "package.json" ]; then
        print_success "package.json exists"

        if grep -q "@inertiajs/vue3" package.json; then
            print_success "Inertia.js Vue 3 detected"
        else
            print_warning "Inertia.js Vue 3 not found in package.json"
            ((warnings++))
        fi

        if grep -q "vue" package.json; then
            print_success "Vue.js detected"
        else
            print_warning "Vue.js not found in package.json"
            ((warnings++))
        fi
    else
        print_warning "package.json not found"
        ((warnings++))
    fi
}

check_mcp_tools() {
    print_section "Checking MCP Tool Availability (Optional)"

    # Check for uvx (needed for Serena)
    if command -v uvx &> /dev/null; then
        print_success "uvx installed (for Serena MCP)"
    else
        print_info "uvx not found (install with: pip install uvx)"
    fi

    # Check for npx (needed for BrowserMCP)
    if command -v npx &> /dev/null; then
        print_success "npx installed (for BrowserMCP)"
    else
        print_info "npx not found (comes with Node.js/npm)"
    fi
}

print_summary() {
    echo -e "\n${BLUE}════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Validation Summary${NC}"
    echo -e "${BLUE}════════════════════════════════════════════════════════${NC}\n"

    if [ $errors -eq 0 ] && [ $warnings -eq 0 ]; then
        echo -e "${GREEN}✓ Perfect! Your setup is complete and ready to use.${NC}\n"
        echo -e "Next steps:"
        echo -e "  1. Open VS Code and start using GitHub Copilot"
        echo -e "  2. Or use Claude Code CLI: claude"
        echo -e "  3. Check docs/ for development workflows\n"
    elif [ $errors -eq 0 ]; then
        echo -e "${YELLOW}⚠ Setup is functional but has $warnings warning(s).${NC}\n"
        echo -e "Review warnings above for optional improvements.\n"
    else
        echo -e "${RED}✗ Setup has $errors error(s) and $warnings warning(s).${NC}\n"
        echo -e "Please fix the errors above before proceeding.\n"
        exit 1
    fi
}

# Main execution
main() {
    print_header
    check_laravel_project
    check_prerequisites
    check_laravel_boost
    check_copilot_configs
    check_claude_configs
    check_documentation
    check_vilt_structure
    check_mcp_tools
    print_summary
}

main

#!/bin/bash

# Laravel VILT AI Toolkit Installation Script
# This script safely installs our toolkit alongside Laravel Boost

set -e  # Exit on error

echo "🚀 Laravel VILT AI Toolkit Installation"
echo "========================================"
echo ""

# Check if we're in a Laravel project
if [ ! -f "artisan" ]; then
    echo "❌ Error: Not a Laravel project directory (artisan file not found)"
    echo "   Please run this script from your Laravel project root"
    exit 1
fi

# Check if Laravel Boost is installed
if ! php artisan list | grep -q "boost:install"; then
    echo "⚠️  Warning: Laravel Boost not detected"
    echo ""
    echo "Laravel Boost is required for full functionality."
    echo "Would you like to install it now? (y/n)"
    read -r install_boost
    
    if [ "$install_boost" = "y" ]; then
        echo "📦 Installing Laravel Boost..."
        composer require laravel/boost
        php artisan boost:install
        echo "✅ Laravel Boost installed"
    else
        echo "⚠️  Continuing without Laravel Boost (some features may not work)"
    fi
fi

# Clone the configuration repository
if [ -d ".ai-config" ]; then
    echo "🗑️  Removing existing .ai-config directory..."
    rm -rf .ai-config
fi

echo "📥 Downloading VILT AI configuration..."
git clone https://github.com/mukulsmu/laravel-vilt-claude-ai-configs.git .ai-config

# Create .github directory if it doesn't exist
mkdir -p .github

# Handle .github/copilot-instructions.md
if [ -f ".github/copilot-instructions.md" ]; then
    echo "⚠️  Existing Copilot instructions found"
    echo "   Our VILT instructions will replace it (original backed up as .copilot-instructions.md.backup)"
    mv .github/copilot-instructions.md .github/copilot-instructions.md.backup
fi

echo "📝 Installing VILT Copilot instructions..."
cp .ai-config/.github/copilot-instructions.md .github/copilot-instructions.md

# Copy additional configurations
echo "📁 Installing path-scoped instructions (including Laravel Boost reference)..."
cp -r .ai-config/.github/instructions ./.github/

echo "🤖 Installing custom agents..."
cp -r .ai-config/.github/agents ./.github/

echo "⚡ Installing agent skills..."
cp -r .ai-config/.github/skills ./.github/

echo "📋 Installing Coding Agent instructions..."
cp .ai-config/AGENTS.md ./

# Optional: Claude configurations
if [ -d ".claude" ]; then
    echo "🔮 Enhancing Claude configuration..."
    cp -r .ai-config/.claude/agents ./.claude/ 2>/dev/null || true
fi

# Optional: Documentation
echo ""
echo "Would you like to install documentation? (y/n)"
read -r install_docs

if [ "$install_docs" = "y" ]; then
    echo "📚 Installing documentation..."
    cp -r .ai-config/docs ./
fi

# Clean up
echo "🧹 Cleaning up..."
rm -rf .ai-config

echo ""
echo "✅ Installation complete!"
echo ""
echo "📋 Next Steps:"
echo "1. Review .github/copilot-instructions.md"
echo "2. Ensure GitHub Copilot Pro is active in VS Code"
echo "3. Ensure Laravel Herd is running (if installed)"
echo "4. Start coding with AI assistance!"
echo ""
echo "📖 Documentation: See docs/ directory (if installed)"
echo "🔧 MCP Setup: See docs/mcp-servers/copilot-mcp-setup.md"
echo ""
echo "Happy coding! 🎉"

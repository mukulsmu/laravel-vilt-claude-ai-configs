# Installation Guide

Complete installation guide for the Laravel VILT AI Toolkit with Laravel Boost integration.

## Prerequisites

Before installing, ensure you have:

- ✅ Laravel 12+ project (Laravel 11 also supported)
- ✅ PHP 8.2+
- ✅ Composer
- ✅ Git
- ✅ GitHub Copilot Pro subscription
- ✅ (Optional) Anthropic API key for Claude Code

## Understanding the File Structure

### What Laravel Boost Creates

When you run `php artisan boost:install`, Laravel Boost creates:

```
your-laravel-project/
├── .github/
│   └── copilot-instructions.md    # Base Laravel Copilot config
├── .claude/
│   └── mcp-config.json            # Base Claude MCP config (if using Claude)
└── config/
    └── boost.php                  # Boost configuration
```

### What Our Toolkit Adds

Our toolkit provides VILT-specific enhancements:

```
your-laravel-project/
├── .github/
│   ├── copilot-instructions.md    # ENHANCED with VILT patterns (appended)
│   ├── instructions/              # NEW: Path-scoped rules
│   │   ├── laravel.instructions.md
│   │   ├── vue-inertia.instructions.md
│   │   └── database-testing.instructions.md
│   ├── agents/                    # NEW: Custom agents
│   └── skills/                    # NEW: Agent skills
│       ├── feature-development/
│       ├── testing/
│       └── debugging/
├── .claude/
│   └── agents/                    # NEW: Claude specialist agents
├── docs/                          # NEW: Complete documentation
├── AGENTS.md                      # NEW: Copilot Coding Agent instructions
└── Laravel Boost files...         # Existing from Boost
```

## File Merge Strategy

| File | Source | Strategy | Reason |
|------|--------|----------|--------|
| `.github/copilot-instructions.md` | Both | **APPEND** | Boost base + our VILT enhancements |
| `.github/instructions/*.md` | Ours only | **COPY** | Path-scoped rules don't exist in Boost |
| `.github/agents/` | Ours only | **COPY** | Custom agents don't exist in Boost |
| `.github/skills/` | Ours only | **COPY** | Skills don't exist in Boost |
| `AGENTS.md` | Ours only | **COPY** | Coding Agent config doesn't exist in Boost |
| `.claude/agents/` | Ours only | **COPY** | Specialist agents don't exist in Boost |
| `docs/` | Ours only | **COPY** | Documentation doesn't exist in Boost |

**Key Insight**: Only `.github/copilot-instructions.md` needs merging. Everything else is additive.

## Installation Methods

### Method 1: Automated Script (Recommended)

The easiest and safest method:

```bash
cd your-laravel-project

# Install Laravel Boost first (if not already installed)
composer require laravel/boost
php artisan boost:install

# Download and run our installation script
curl -o install.sh https://raw.githubusercontent.com/mukulsmu/laravel-vilt-claude-ai-configs/main/install.sh
chmod +x install.sh
./install.sh
```

The script will:
1. ✅ Check if Laravel Boost is installed
2. ✅ Offer to install Boost if missing
3. ✅ Safely append VILT enhancements to Boost's config
4. ✅ Copy additional files without conflicts
5. ✅ Optionally install documentation
6. ✅ Clean up temporary files

### Method 2: Manual Installation

For more control over the process:

```bash
cd your-laravel-project

# Step 1: Install Laravel Boost
composer require laravel/boost
php artisan boost:install

# Step 2: Clone our toolkit
git clone https://github.com/mukulsmu/laravel-vilt-claude-ai-configs.git .ai-config

# Step 3: Merge Copilot instructions (APPEND, don't overwrite)
cat .ai-config/.github/copilot-instructions.md >> .github/copilot-instructions.md

# Step 4: Copy additional files (these don't conflict)
cp -r .ai-config/.github/instructions ./.github/
cp -r .ai-config/.github/agents ./.github/
cp -r .ai-config/.github/skills ./.github/
cp .ai-config/AGENTS.md ./

# Step 5: (Optional) Add Claude configurations
cp -r .ai-config/.claude/agents ./.claude/

# Step 6: (Optional) Add documentation
cp -r .ai-config/docs ./

# Step 7: Clean up
rm -rf .ai-config

# Step 8: (Optional) Install Claude Code CLI
npm install -g @anthropic/claude-code
claude auth login
```

### Method 3: Selective Installation

Install only what you need:

**GitHub Copilot Only:**
```bash
cd your-laravel-project
composer require laravel/boost
php artisan boost:install

git clone https://github.com/mukulsmu/laravel-vilt-claude-ai-configs.git .ai-config
cat .ai-config/.github/copilot-instructions.md >> .github/copilot-instructions.md
cp -r .ai-config/.github/instructions ./.github/
cp -r .ai-config/.github/agents ./.github/
cp -r .ai-config/.github/skills ./.github/
cp .ai-config/AGENTS.md ./
rm -rf .ai-config
```

**Claude Code Only:**
```bash
cd your-laravel-project
composer require laravel/boost
php artisan boost:install

npm install -g @anthropic/claude-code
claude auth login

git clone https://github.com/mukulsmu/laravel-vilt-claude-ai-configs.git .ai-config
cp -r .ai-config/.claude/agents ./.claude/
cp -r .ai-config/docs ./
rm -rf .ai-config
```

## Verification

After installation, verify everything is set up correctly:

```bash
# 1. Check Copilot instructions file exists and has both base + VILT content
cat .github/copilot-instructions.md | head -30

# Should show:
# - Laravel Boost base instructions (if Boost was installed)
# - "=== VILT Stack Enhancements ===" separator (if using script)
# - Our VILT-specific patterns

# 2. Check additional files exist
ls -la .github/instructions/
ls -la .github/agents/
ls -la .github/skills/
ls -la AGENTS.md

# 3. Check Laravel Boost MCP server is available
php artisan mcp:serve --help

# 4. (Optional) Check Claude configuration
ls -la .claude/agents/
```

## Troubleshooting

### Problem: "File already exists" error when copying

**Solution**: You may have run the installation multiple times. Clean up first:

```bash
# Remove our files (keeps Boost's base)
rm -rf .github/instructions/
rm -rf .github/agents/
rm -rf .github/skills/
rm -f AGENTS.md
rm -rf .claude/agents/
rm -rf docs/

# Reset copilot-instructions.md to Boost's base
git checkout .github/copilot-instructions.md

# Then re-run installation
```

### Problem: Laravel Boost not installed

**Solution**: Install it first:

```bash
composer require laravel/boost
php artisan boost:install
```

### Problem: Duplicate content in copilot-instructions.md

**Solution**: The file was appended multiple times. Reset and re-install:

```bash
# If using Git, reset to Boost's base
git checkout .github/copilot-instructions.md

# Or manually remove the VILT section and re-append
# Edit .github/copilot-instructions.md
# Remove everything after "=== VILT Stack Enhancements ==="

# Then re-append
cat .ai-config/.github/copilot-instructions.md >> .github/copilot-instructions.md
```

### Problem: MCP tools not working

**Solution**: Ensure Laravel Boost MCP server is running:

```bash
# Test the MCP server
php artisan mcp:serve

# In another terminal, test with Claude or Copilot
# Use @boost commands
```

## Post-Installation Setup

### GitHub Copilot Configuration

1. **Open VS Code** in your Laravel project
2. **Verify Copilot is active** (check status bar)
3. **Test Copilot Chat**:
   ```
   "Create a Post model with migration using Inertia patterns"
   ```
4. **Test MCP integration**:
   ```
   @boost "Show all models"
   ```

### Claude Code Configuration

1. **Verify authentication**:
   ```bash
   claude auth status
   ```

2. **Test Claude with MCP**:
   ```bash
   claude "Use mcp__boost__get_models to list all Eloquent models"
   ```

3. **Test specialist agents**:
   ```bash
   claude "VILT Stack Specialist: Explain the Inertia.js pattern used in this project"
   ```

## What's Next?

After installation:

1. **Read the documentation**: `docs/` directory
2. **Try example prompts**: See [Usage Examples](../README.md#usage-examples)
3. **Configure MCP servers**: See [MCP Setup Guide](../docs/mcp-servers/copilot-mcp-setup.md)
4. **Learn workflows**: See [Development Workflows](../docs/workflows/)

## Additional Resources

- **Laravel Boost Integration**: [docs/setup/laravel-boost-integration.md](laravel-boost-integration.md)
- **MCP Setup**: [docs/mcp-servers/copilot-mcp-setup.md](../mcp-servers/copilot-mcp-setup.md)
- **Dual Tool Setup**: [DUAL-SETUP.md](../../DUAL-SETUP.md)
- **Copilot Setup**: [COPILOT-SETUP.md](../../COPILOT-SETUP.md)

## Support

If you encounter issues:

1. Check [Laravel Boost documentation](https://boost.laravel.com/)
2. Review [troubleshooting section](#troubleshooting) above
3. Check our [GitHub issues](https://github.com/mukulsmu/laravel-vilt-claude-ai-configs/issues)

---

**Remember**: Laravel Boost provides the foundation, our toolkit adds VILT-specific enhancements. Both work together seamlessly when installed in the correct order.

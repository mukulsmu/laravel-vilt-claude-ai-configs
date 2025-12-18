# Laravel Boost Base Configuration Reference

This document shows what Laravel Boost creates when you run `php artisan boost:install`.

## Files Created by Laravel Boost

### 1. `.github/copilot-instructions.md`

Laravel Boost creates a base Copilot instructions file with Laravel-specific context:

```markdown
# Laravel Project - GitHub Copilot Instructions

This is a Laravel application. When generating code:

## Laravel Conventions
- Follow Laravel naming conventions
- Use Eloquent ORM for database operations
- Use dependency injection where appropriate
- Follow PSR-12 coding standards

## MCP Integration
- Laravel Boost MCP server is available via `@boost`
- Use MCP tools for Laravel-specific operations

## Available MCP Tools
- `@boost` - Laravel Boost MCP server for app introspection
```

**Our enhancement**: Our `.github/copilot-instructions.md` adds VILT-specific patterns (Vue 3, Inertia.js, Tailwind CSS) on top of this base.

### 2. MCP Server Configuration

Laravel Boost automatically configures its MCP server in your Laravel application. The server runs via:

```bash
php artisan mcp:serve
```

This provides tools like:
- `get_models` - List all Eloquent models
- `get_routes` - List all application routes
- `get_config` - Read configuration values
- `get_logs` - Read log files
- `run_query` - Execute database queries
- And 10+ more tools

### 3. `config/boost.php` (Optional)

Laravel Boost may create a configuration file for customizing behavior:

```php
<?php

return [
    'mcp' => [
        'enabled' => true,
        'tools' => [
            // Tool-specific configuration
        ],
    ],
];
```

## How Our Toolkit Integrates

### File Handling Strategy (Updated)

| File | Laravel Boost Creates | Our Toolkit Provides | Strategy |
|------|----------------------|---------------------|----------|
| `.github/copilot-instructions.md` | ✅ Base Laravel config | ✅ VILT config (replaces) | **REPLACE** with our file |
| `.github/instructions/laravel-boost-base.instructions.md` | ❌ No | ✅ Reference for Boost's content | **COPY** (for documentation) |
| `.github/instructions/*.md` | ❌ No | ✅ Path-scoped rules | **COPY** our files |
| `.github/agents/` | ❌ No | ✅ Custom agents | **COPY** our directory |
| `.github/skills/` | ❌ No | ✅ Skill guides | **COPY** our directory |
| `AGENTS.md` | ❌ No | ✅ Coding Agent instructions | **COPY** our file |

**Key Change**: Instead of appending to Laravel Boost's `copilot-instructions.md`, we replace it with our own file that **references** the Boost instructions through path-scoped instruction files. This is cleaner and follows the same pattern as our other modular instructions.

### How It Works

1. **Laravel Boost creates**: `.github/copilot-instructions.md` with base Laravel conventions
2. **Our toolkit replaces it with**: A VILT-focused file that references Boost's content via `.github/instructions/laravel-boost-base.instructions.md`
3. **Copilot reads**: Both our main instructions AND the path-scoped Boost reference automatically
4. **Result**: No merge conflicts, clean separation of concerns

### File Reference Pattern

Our `.github/copilot-instructions.md` now includes:

```markdown
**Laravel Boost Base Instructions**: See `.github/instructions/laravel-boost-base.instructions.md` 
for the base Laravel conventions that Laravel Boost provides.
```

This follows the same pattern as other modular instructions in `.github/instructions/`.

### Merge vs Copy Decision Tree

```
Is the file created by Laravel Boost?
├─ YES: Our file REFERENCES it (via path-scoped instructions)
│   └─ .github/copilot-instructions.md (we replace with reference-based version)
│   └─ .github/instructions/laravel-boost-base.instructions.md (documents Boost's content)
│
└─ NO: COPY our file directly
    └─ .github/instructions/ (our VILT-specific rules)
    └─ .github/agents/
    └─ .github/skills/
    └─ AGENTS.md
    └─ docs/
```

## Installation Commands (Updated)

```bash
# Step 1: Install Laravel Boost (creates base config)
composer require laravel/boost
php artisan boost:install

# Step 2: Clone our toolkit
git clone https://github.com/mukulsmu/laravel-vilt-claude-ai-configs.git .ai-config

# Step 3: REPLACE copilot-instructions.md with our VILT version (backs up Boost's)
mv .github/copilot-instructions.md .github/copilot-instructions.md.boost-backup  # Optional backup
cp .ai-config/.github/copilot-instructions.md .github/copilot-instructions.md

# Step 4: COPY our additional files (includes Boost reference)
cp -r .ai-config/.github/instructions ./.github/  # Includes laravel-boost-base.instructions.md
cp -r .ai-config/.github/agents ./.github/
cp -r .ai-config/.github/skills ./.github/
cp .ai-config/AGENTS.md ./

# Step 5: Optional - Add docs
cp -r .ai-config/docs ./

# Step 6: Clean up
rm -rf .ai-config
```

## Verification After Installation

Check that files are properly installed:

```bash
# Should show VILT-focused instructions with reference to Boost
cat .github/copilot-instructions.md | head -20

# Should include the Laravel Boost reference file
cat .github/instructions/laravel-boost-base.instructions.md
cat .github/copilot-instructions.md | head -20

# Should exist (from our toolkit)
ls -la .github/instructions/
ls -la .github/agents/
ls -la .github/skills/
ls -la AGENTS.md
```

## What If Laravel Boost Isn't Installed?

If you haven't installed Laravel Boost, our toolkit can still work but you'll miss:
- Laravel MCP server integration (`@boost` command)
- Base Laravel Copilot instructions
- MCP server auto-configuration

**Recommendation**: Always install Laravel Boost first for the complete experience.

## Troubleshooting

### "File not found" when appending
**Problem**: Laravel Boost's `.github/copilot-instructions.md` doesn't exist

**Solution**:
```bash
# Create the directory if needed
mkdir -p .github

# If Boost didn't create the file, just copy ours
cp .ai-config/.github/copilot-instructions.md .github/copilot-instructions.md
```

### Duplicate content after multiple installations
**Problem**: Accidentally ran installation commands multiple times

**Solution**:
```bash
# Remove duplicates and start fresh
git checkout .github/copilot-instructions.md  # Reset to Boost's base
cat .ai-config/.github/copilot-instructions.md >> .github/copilot-instructions.md
```

## Laravel Boost Official Resources

- **Website**: https://boost.laravel.com/
- **GitHub**: https://github.com/laravel/boost
- **Documentation**: https://boost.laravel.com/docs

## Summary

**Laravel Boost provides**:
- Base Laravel AI instructions
- MCP server for Laravel introspection
- Foundation for AI-powered Laravel development

**Our VILT toolkit provides**:
- Vue 3 + Inertia.js + Tailwind CSS patterns
- Path-scoped instructions for frontend/backend
- Custom agents and skills for VILT workflows
- Comprehensive documentation and examples

**Together**: Professional AI-powered Laravel VILT development setup.

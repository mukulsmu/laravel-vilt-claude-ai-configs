# GitHub Copilot MCP Server Setup Guide

Complete guide for configuring MCP (Model Context Protocol) servers with GitHub Copilot Pro for Laravel VILT development.

## Prerequisites

- **GitHub Copilot Pro** subscription ($10/month for individuals)
- **VS Code** with latest Copilot extension
- **Laravel Boost** installed (REQUIRED - provides base MCP configuration)
- **Laravel Herd** installed (recommended for local development)
- **Node.js 18+** for additional MCP servers

## Installation Order (IMPORTANT)

### Step 1: Install Laravel Boost (Required First)

Laravel Boost provides the foundational AI configuration that our toolkit enhances:

```bash
cd your-laravel-project

# Install Laravel Boost
composer require laravel/boost

# Run installation (creates MCP configs for both Claude and Copilot)
php artisan boost:install

# This creates:
# - MCP server configuration in your project
# - Base .github/copilot-instructions.md
# - Base .claude/config.json
# - Laravel Boost MCP server integration
```

**What Laravel Boost Provides:**
- Laravel-specific MCP tools (models, routes, config, logs, queries)
- Base AI instructions for Laravel projects
- Automatic MCP server setup for both Claude and Copilot
- Integration with your Laravel application internals

### Step 2: Add VILT-Enhanced Configuration (Our Toolkit)

After Laravel Boost is installed, add our VILT-specific enhancements:

```bash
# Clone our configuration repository
git clone https://github.com/mukulsmu/laravel-vilt-claude-ai-configs.git .ai-config

# MERGE (don't overwrite) with Laravel Boost's base configuration
cat .ai-config/.github/copilot-instructions.md >> .github/copilot-instructions.md

# Add VILT-specific patterns, agents, and skills
cp -r .ai-config/.github/instructions ./.github/
cp -r .ai-config/.github/agents ./.github/
cp -r .ai-config/.github/skills ./.github/
cp .ai-config/AGENTS.md ./

# Clean up
rm -rf .ai-config
```

## Overview

GitHub Copilot Pro supports MCP servers in VS Code, enabling enhanced capabilities through specialized tools. Laravel Boost automatically configures the core Laravel MCP server. Our toolkit adds VILT-specific patterns and additional MCP integrations.

**Key MCP Servers for Laravel VILT:**

1. **Laravel Boost MCP** - Installed by Laravel Boost (automatic)
2. **Laravel Herd MCP** - Development server management (optional)
3. **Zen MCP** - Code review and security analysis (optional)
4. **Serena MCP** - Semantic code navigation (optional)
5. **Context7 MCP** - Documentation access (optional)

Add to your VS Code `settings.json` (Workspace or User):

```json
{
  "github.copilot.mcpServers": {
    "laravel-herd": {
      "command": "npx",
      "args": ["@laravel/herd-mcp"],
      "env": {
        "HERD_HOME": "/Users/YOUR_USER/Library/Application Support/Herd"
      }
    },
    "laravel-boost": {
      "command": "npx",
      "args": ["@laravel/boost-mcp"]
    },
    "zen": {
      "command": "npx",
      "args": ["@zen/mcp-server"],
      "env": {
        "ZEN_API_KEY": "your-zen-api-key"
      }
    },
    "serena": {
      "command": "npx",
      "args": ["@serena/mcp-server"]
    },
    "context7": {
      "command": "npx",
      "args": ["@context7/mcp-server"],
      "env": {
        "CONTEXT7_API_KEY": "your-context7-key"
      }
    }
  }
}
```

### Step 3: Verify MCP Server Connection

1. Open VS Code
2. Open Copilot Chat (Ctrl/Cmd+I)
3. Type `@herd` - you should see Laravel Herd MCP autocomplete
4. Type `@boost` - you should see Laravel Boost MCP autocomplete

## Laravel Herd MCP Usage

### Server Management

```plaintext
# Start development server
@herd "Start the server on port 8000"

# Stop server
@herd "Stop the development server"

# Switch PHP version
@herd "Switch to PHP 8.3"
@herd "What PHP versions are available?"

# Database connections
@herd "Show all database connections"
@herd "Create a new MySQL database named 'blog'"

# Site management
@herd "List all sites"
@herd "Link current directory as 'myapp'"
```

### Environment Configuration

```plaintext
# Environment variables
@herd "Show environment variables for this site"
@herd "Set APP_ENV to production"

# SSL certificates
@herd "Secure this site with SSL"
@herd "Show SSL certificate info"

# Logs
@herd "Show PHP error logs"
@herd "Tail nginx access logs"
```

## Laravel Boost MCP Usage

### Code Generation

```plaintext
# Generate complete CRUD
@boost "Generate CRUD for Post model with:
- Migration with title, content, user_id
- Controller with Inertia responses
- Form Requests for validation
- Vue pages for index, show, create, edit"

# Generate specific components
@boost "Create Comment model with relationships to Post and User"
@boost "Generate API resource for User with nested posts"
@boost "Create PostPolicy with all authorization methods"
```

### Scaffolding Features

```plaintext
# Feature scaffolding
@boost "Scaffold authentication system with:
- Login/Register pages
- Password reset
- Email verification
- Inertia.js integration"

# Admin panels
@boost "Generate admin panel for User management with:
- List view with search and filters
- Edit form with validation
- Role assignment
- Activity logs"
```

### Testing Generation

```plaintext
# Test generation
@boost "Generate Pest tests for PostController with:
- Feature tests for all endpoints
- Validation tests
- Authorization tests
- Database assertions"
```

## Zen MCP Usage (Code Review)

```plaintext
# Security review
@zen "Review UserController for security vulnerabilities:
- SQL injection risks
- XSS vulnerabilities
- CSRF protection
- Authorization bypass"

# Code quality review
@zen "Analyze PostService for:
- SOLID principles compliance
- Design pattern usage
- Code complexity
- Performance issues"

# Best practices
@zen "Review this migration for Laravel best practices"
```

## Serena MCP Usage (Code Navigation)

```plaintext
# Symbol search
@serena "Find all controller methods that use Inertia::render"
@serena "Show all models with SoftDeletes trait"

# Dependency analysis
@serena "What depends on UserService?"
@serena "Show all components that import useForm"

# Pattern detection
@serena "Find all N+1 query patterns in this codebase"
```

## Context7 MCP Usage (Documentation)

```plaintext
# Latest documentation
@context7 "Get Laravel 11 documentation for queues"
@context7 "Show Inertia.js v2.0 prefetch feature docs"
@context7 "Explain Vue 3.4 defineModel macro"

# Best practices
@context7 "What's the recommended way to handle file uploads in Laravel 11?"
@context7 "Show current best practices for Inertia form validation"
```

## Copilot Agent with MCP Integration

The Coding Agent automatically uses configured MCP servers when appropriate:

```plaintext
# Agent workflow with MCP
"Create a complete blog feature:
1. Use @herd to ensure server is running
2. Use @boost to generate Post CRUD
3. Use @boost to create Vue components
4. Use @zen to review security
5. Generate tests and verify"

# Agent will:
- Check Laravel Herd server status
- Generate code via Laravel Boost
- Create migrations, models, controllers
- Build Inertia pages with Vue
- Run security review with Zen
- Generate comprehensive tests
```

## Project-Specific Configuration

### Add to `.vscode/settings.json` (Project Root)

```json
{
  "github.copilot.mcpServers": {
    "laravel-herd": {
      "command": "npx",
      "args": ["@laravel/herd-mcp"],
      "enabled": true,
      "projectPath": "${workspaceFolder}"
    },
    "laravel-boost": {
      "command": "npx",
      "args": ["@laravel/boost-mcp"],
      "enabled": true,
      "config": {
        "namespace": "App",
        "viewPath": "resources/js/Pages",
        "componentLibrary": "shadcn-vue"
      }
    }
  },
  "github.copilot.instructions": {
    "mcp": {
      "laravel-herd": "Use for all development server operations",
      "laravel-boost": "Use for Laravel code generation, prefer Inertia patterns",
      "zen": "Use for security reviews before PR",
      "serena": "Use for codebase navigation and refactoring",
      "context7": "Use for latest framework documentation"
    }
  }
}
```

## AGENTS.md Integration

Update your `AGENTS.md` to instruct Copilot Agent to use MCP tools:

```markdown
## Development Server

**Always use Laravel Herd MCP** for development server operations:
- Starting/stopping servers
- PHP version management
- Database connections
- Environment configuration

Use `@herd` command for all server-related tasks.

## Code Generation

**Always use Laravel Boost MCP** for Laravel code generation:
- CRUD scaffolding
- Model/Controller/Migration generation
- Inertia page creation
- Test generation

Use `@boost` command for all scaffolding tasks.
```

## Troubleshooting

### MCP Server Not Responding

```bash
# Check if MCP servers are installed
npm list -g @laravel/herd-mcp
npm list -g @laravel/boost-mcp

# Reinstall if needed
npm install -g @laravel/herd-mcp --force
```

### Connection Errors

1. Check VS Code settings syntax
2. Verify environment variables are set
3. Restart VS Code
4. Check Copilot extension is updated

### @mention Not Working

1. Ensure you have GitHub Copilot Enterprise
2. Check MCP servers are configured in settings
3. Verify `"enabled": true` in configuration
4. Reload VS Code window

## Best Practices

### 1. Use MCP for Domain-Specific Tasks

```plaintext
✅ @herd "Start development server"
❌ "Can you start the Laravel server?"

✅ @boost "Generate Post CRUD with Inertia"
❌ "Create a Post model and controller"
```

### 2. Combine MCP with Agent Mode

```plaintext
# Let Agent use MCP automatically
"Create a complete notification system"

# Agent will:
- Use @herd to check server
- Use @boost for scaffolding
- Use @zen for review
```

### 3. Chain MCP Commands

```plaintext
# Sequential operations
"@herd start server, then @boost generate User CRUD, then @zen review security"
```

### 4. Configure Per Project

- Add `.vscode/settings.json` to each Laravel project
- Set project-specific paths and configurations
- Commit settings to share with team

## Team Setup

For team consistency:

1. **Add to repository**: `.vscode/settings.json` with MCP configuration
2. **Document in README**: Required MCP servers and setup steps
3. **Share credentials**: Environment variables for Zen, Context7
4. **Training**: Team workshop on MCP usage patterns

## Additional Resources

- [GitHub Copilot MCP Documentation](https://docs.github.com/en/copilot/using-github-copilot/using-model-context-protocol-with-copilot)
- [Laravel Herd MCP Guide](laravel-herd-guide.md)
- [Laravel Boost MCP Guide](laravel-boost-guide.md)
- [MCP Server Development](https://modelcontextprotocol.io)

---

**Remember**: MCP servers enhance Copilot's capabilities but require GitHub Copilot Enterprise. For professional Laravel VILT development, the combination of Laravel Herd + Laravel Boost MCP servers with Copilot Agent provides the most powerful workflow.

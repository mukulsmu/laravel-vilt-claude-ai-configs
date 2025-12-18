# Quick Reference: Copilot Extensions vs Claude MCP

Quick comparison guide for developers familiar with Claude MCP servers transitioning to or using GitHub Copilot Extensions.

## At a Glance

| Feature | Claude Code | GitHub Copilot |
|---------|-------------|----------------|
| **Extensibility System** | MCP Servers | Extensions + Built-in Features |
| **Code Navigation** | Serena MCP | @workspace + IntelliSense |
| **Multi-File Edits** | Manual + Serena | Copilot Edits (Ctrl/Cmd+Shift+I) |
| **Documentation** | Context7 MCP | Built-in knowledge |
| **Code Review** | Zen MCP | Chat + SonarLint |
| **Testing** | BrowserMCP | Generate tests with Copilot |
| **Setup Required** | Config JSON file | Install from Marketplace |

## Common Tasks

### Code Navigation

**Claude MCP (Serena):**
```bash
mcp__serena__list_dir --relative_path="app/Services"
mcp__serena__get_symbols_overview --relative_path="app/Models"
mcp__serena__search_for_pattern --substring_pattern="whereHas"
```

**Copilot (@workspace):**
```plaintext
@workspace "List files in app/Services"
@workspace "Show symbols in app/Models"
@workspace /search "whereHas"
```

### Multi-File Refactoring

**Claude MCP (Manual):**
```bash
# Find files
mcp__serena__find_file --file_mask="*Controller.php"
# Edit each file manually or with Serena tools
# Review changes
```

**Copilot (Edits):**
```plaintext
1. Press Ctrl/Cmd+Shift+I
2. Select files in Working Set
3. Instructions: "Add error handling to all controllers"
4. Review and Apply
```

### Code Review

**Claude MCP (Zen):**
```bash
mcp__zen__codereview --files="app/Http/Controllers/UserController.php"
mcp__zen__secaudit --scope="authentication"
```

**Copilot (Chat + Extensions):**
```plaintext
"Review UserController.php for:
- Security vulnerabilities
- Performance issues
- Best practices
- Code smells"

# Then install SonarLint for automated scanning
```

### Documentation Lookup

**Claude MCP (Context7):**
```bash
mcp__context7__resolve-library-id --libraryName="laravel"
mcp__context7__get-library-docs --context7CompatibleLibraryID="/laravel/docs"
```

**Copilot (Built-in):**
```plaintext
"What's new in Laravel 11?"
"Show me Inertia.js v2.0 features"
"Explain Vue 3.4 defineModel"
```

### Browser Testing

**Claude MCP (BrowserMCP):**
```bash
mcp__browsermcp__browser_navigate "http://localhost/dashboard"
mcp__browsermcp__browser_click "button" "ref123"
mcp__browsermcp__browser_screenshot
```

**Copilot (Generate Tests):**
```plaintext
"Create a Playwright test that:
1. Navigates to /dashboard
2. Clicks the 'Create Post' button
3. Fills in the form
4. Submits and verifies success"
```

## Feature Mapping

| MCP Server | Primary Purpose | Copilot Solution |
|------------|----------------|------------------|
| **Serena** | Code navigation, symbol search | `@workspace` (built-in) |
| **Context7** | Latest library documentation | Built-in knowledge + Chat |
| **Zen** | Code review, analysis, debugging | Chat analysis + Extensions |
| **BrowserMCP** | UI testing, browser automation | Generate test code (Playwright/Dusk) |
| **Laravel Herd** | Dev server management | Built-in Laravel knowledge |
| **Laravel Boost** | Laravel code generation | Built-in Laravel patterns |

## When to Use Each

### Use Claude Code (MCP) when:
✅ You need systematic multi-step workflows (Zen)  
✅ You want token-efficient code exploration (Serena)  
✅ You need real-time browser debugging (BrowserMCP)  
✅ You want specialized analysis tools  
✅ You prefer terminal-based workflows  

### Use GitHub Copilot (Extensions) when:
✅ You need multi-file editing (Copilot Edits)  
✅ You want IDE-integrated assistance  
✅ You need service integrations (Docker, Azure)  
✅ You prefer visual interfaces  
✅ You want unlimited free completions  

### Use Both when:
✅ You want maximum flexibility  
✅ Different team members prefer different tools  
✅ You need both MCP and Extension capabilities  
✅ You want to optimize request budgets  

## Installation Comparison

### Claude Code + MCP Servers

```bash
# Install Claude Code
npm install -g @anthropic/claude-code

# Configure MCP servers in claude_desktop_config.json
{
  "mcpServers": {
    "serena": { ... },
    "zen": { ... },
    "context7": { ... }
  }
}

# Authenticate
claude auth login
```

### GitHub Copilot + Extensions

```bash
# Install Copilot extensions in VS Code
code --install-extension GitHub.copilot
code --install-extension GitHub.copilot-chat

# Install additional extensions from Marketplace
# Docker, Azure, SonarLint, etc.

# Built-in features (@workspace, Edits) work immediately
```

## Cost Comparison

| Tool | Free Tier | Paid Tier |
|------|-----------|-----------|
| **GitHub Copilot** | Unlimited completions, @workspace, Edits | Premium models (Claude/Gemini), Enterprise features |
| **Claude Code** | N/A | API credits (~$3-20/month for normal use) |

**Cost Optimization Strategy:**
1. Use Copilot free features for 80% of tasks
2. Use Copilot premium for complex reasoning
3. Use Claude MCP for specialized analysis

## Quick Start Commands

### Copilot (VS Code)

```plaintext
# Open Copilot Chat: Ctrl/Cmd+I
# Open Copilot Edits: Ctrl/Cmd+Shift+I

# In Chat:
@workspace "Find all controllers"
"Create a Laravel model with migration"
"Explain this Vue component"

# In Edits:
# 1. Select files
# 2. Type instructions
# 3. Review and apply
```

### Claude Code (Terminal)

```bash
# Direct commands
claude "Create a Laravel CRUD feature for posts"

# With MCP servers
claude "Use mcp__serena__get_symbols_overview for app/Models"
claude "Use mcp__zen__codereview on UserController"

# With specialists
claude "VILT Specialist: Create a notification system"
```

## Pro Tips

### For Copilot Users

1. **Master @workspace** - It replaces most Serena MCP needs
2. **Use Copilot Edits** - Powerful for multi-file changes
3. **Install SonarLint** - Automated code quality (replaces some Zen MCP)
4. **Learn keyboard shortcuts** - Ctrl/Cmd+I (chat), Ctrl/Cmd+Shift+I (edits)
5. **Use premium models strategically** - Complex tasks only

### For Claude MCP Users

1. **Leverage MCP servers** - Unique capability not in Copilot
2. **Use workflows** - Systematic approaches (docs/workflows/)
3. **Combine with Copilot** - Use both for best results
4. **Master specialist agents** - Domain expertise (.claude/agents/)
5. **Optimize API usage** - Use efficient MCP tools (Serena)

## Migration Path

### From Claude-only to Dual Setup

```plaintext
Week 1: Keep using Claude, install Copilot
Week 2: Use Copilot for completions, Claude for analysis
Week 3: Try @workspace and Copilot Edits
Week 4: Use both strategically based on task
```

### From Copilot-only to Dual Setup

```plaintext
Week 1: Keep using Copilot, install Claude Code
Week 2: Configure MCP servers (Zen, Serena)
Week 3: Try MCP workflows for complex tasks
Week 4: Use both strategically based on task
```

## Resources

- **Copilot Extensions Guide**: [docs/copilot-extensions/README.md](README.md)
- **@workspace Guide**: [docs/copilot-extensions/workspace-context.md](workspace-context.md)
- **Copilot Edits Guide**: [docs/copilot-extensions/copilot-edits.md](copilot-edits.md)
- **MCP Server Guides**: [docs/mcp-servers/](../mcp-servers/)
- **Dual Setup**: [DUAL-SETUP.md](../../DUAL-SETUP.md)

---

**Remember**: There's no "better" tool - use what works for your task. Copilot excels at IDE integration and multi-file editing. Claude excels at MCP-powered analysis and systematic workflows. Use both for maximum productivity.

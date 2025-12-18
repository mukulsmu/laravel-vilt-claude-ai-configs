# GitHub Copilot Setup Guide for Laravel VILT Stack

This guide helps you configure GitHub Copilot for optimal assistance with Laravel VILT (Vue, Inertia.js, Laravel, Tailwind CSS) stack development.

## 📋 Prerequisites

- **GitHub Copilot** subscription (Individual, Business, or Enterprise)
- **VS Code** or **JetBrains IDE** with Copilot extension
- **Laravel project** (new or existing)

## 🚀 Quick Setup

### 1. Install GitHub Copilot Extension

**VS Code:**
```bash
# Install from marketplace
code --install-extension GitHub.copilot
code --install-extension GitHub.copilot-chat
```

**JetBrains IDEs:**
- Settings → Plugins → Search "GitHub Copilot" → Install

### 2. Add VILT Configuration to Your Project

```bash
# Navigate to your Laravel project
cd your-laravel-project

# Clone this configuration repository
git clone https://github.com/mukulsmu/laravel-vilt-claude-ai-configs.git .ai-config

# Copy GitHub Copilot configurations
cp -r .ai-config/.github ./

# Copy AGENTS.md for Copilot Coding Agent
cp .ai-config/AGENTS.md ./

# Optional: Copy full documentation
cp -r .ai-config/docs ./
cp .ai-config/CLAUDE.md ./

# Clean up
rm -rf .ai-config
```

### 3. Your Project Structure

After setup, your project should include:

```
your-laravel-project/
├── .github/
│   ├── copilot-instructions.md          # Global Copilot instructions
│   ├── instructions/
│   │   ├── laravel.instructions.md      # PHP/Laravel specific rules
│   │   ├── vue-inertia.instructions.md  # Vue/Inertia specific rules
│   │   └── database-testing.instructions.md  # Testing patterns
│   ├── agents/                          # Custom Copilot agents
│   └── skills/                          # Agent skills
│       ├── feature-development/
│       ├── testing/
│       └── debugging/
├── AGENTS.md                            # Copilot Coding Agent instructions
├── CLAUDE.md                            # Claude AI instructions (optional)
└── docs/                                # Full documentation (optional)
```

## 🎯 How It Works

### Repository Instructions (`.github/copilot-instructions.md`)

This file provides global guidance for all Copilot suggestions in your repository:
- Technology stack details
- Code conventions
- Example patterns
- Security guidelines

Copilot automatically reads this file for every chat and suggestion.

### Path-Scoped Instructions (`.github/instructions/`)

These files apply to specific file types:

| File | Applies To | Purpose |
|------|------------|---------|
| `laravel.instructions.md` | `**/*.php` | PHP/Laravel conventions |
| `vue-inertia.instructions.md` | `resources/js/**/*.{vue,ts,js}` | Vue/Inertia patterns |
| `database-testing.instructions.md` | `database/**/*.php`, `tests/**/*.php` | Testing standards |

### AGENTS.md (Copilot Coding Agent)

The `AGENTS.md` file in your project root provides instructions for GitHub Copilot's Coding Agent feature, enabling:
- Automated issue-to-PR workflows
- Multi-file code changes
- Project-aware code generation

### Agent Skills (`.github/skills/`)

Pre-built skill guides for common tasks:
- **Feature Development**: Complete CRUD feature creation
- **Testing**: Comprehensive testing patterns
- **Debugging**: Systematic troubleshooting approaches

## 💬 Using Copilot Chat

### Effective Prompts for Laravel VILT

```plaintext
# Creating new features
"Create a Post model with migration, controller, and Vue pages following the VILT patterns"

# Code review
"Review this controller for security issues and VILT best practices"

# Debugging help
"Why is my Inertia form not showing validation errors?"

# Refactoring
"Refactor this Livewire component to Vue with Inertia"

# Testing
"Write Pest tests for the PostController including validation and authorization"
```

### Context-Aware Suggestions

Copilot uses the instructions files automatically. You can also:

1. **Reference files**: `@file:app/Models/Post.php`
2. **Ask about structure**: "What's the pattern for forms in this project?"
3. **Request explanations**: "Explain how Inertia routing works here"

## 🤖 Premium Models for Complex Tasks

GitHub Copilot supports premium AI models for complex development tasks. These models provide deeper reasoning capabilities similar to Claude Code.

### Available Premium Models

| Model | Best For |
|-------|----------|
| **Claude Sonnet** | Complex reasoning, code analysis, refactoring |
| **Gemini Pro** | Large codebase analysis, multi-modal tasks |
| **GPT-4o** | Creative solutions, general complex tasks |

### Using Premium Models in Chat

Select your preferred model from the dropdown at the top of Copilot Chat, then type your prompt:

```plaintext
# With Claude Sonnet selected:
"Implement a caching layer with Redis for API responses"

# With Gemini Pro selected:
"Analyze this entire module and identify architectural issues"

# With GPT-4o selected:
"Design a notification system with email, SMS, and push support"
```

### Premium Model Use Cases

**Complex Multi-File Changes:**
```plaintext
# Select Claude Sonnet, then:
"Create a complete blog feature including Post model with migration, 
CRUD controller with Inertia responses, Vue pages for index/show/create/edit, 
and Pest tests for all endpoints"
```

**Architectural Decisions:**
```plaintext
"Review this authentication system and suggest improvements for security and scalability"
```

**Long-Running Tasks:**
```plaintext
# Select Gemini Pro for large context:
"Analyze all controllers in this project and create a report of N+1 query issues"
```

### Optimizing Request Usage

| Task Type | Recommendation |
|-----------|----------------|
| Boilerplate code | Free (standard Copilot) |
| Documentation | Free |
| Simple refactoring | Free |
| Complex logic | Premium (select Claude Sonnet) |
| Architecture review | Premium |
| Multi-file features | Premium |

**Pro Tip**: Start with free requests. If the result isn't satisfactory, switch to a premium model for that specific task.

## ✨ Copilot Edits - Multi-File Editing

**Copilot Edits** allows you to make AI-powered changes across multiple files simultaneously - perfect for refactoring and large-scale code updates.

### Opening Copilot Edits

```bash
# In VS Code:
- Press Ctrl/Cmd+Shift+I (or Ctrl/Cmd+I)
- Or: View → Command Palette → "Copilot: Open Edits"
- Or: Click Copilot icon in sidebar → "Edits"
```

### Use Cases

**Renaming Features:**
```plaintext
Working Set: Select all related files
app/Models/Post.php, app/Http/Controllers/PostController.php,
resources/js/Pages/Posts/*.vue, routes/web.php

Instructions:
"Rename Post to Article throughout the entire codebase including 
file names, class names, routes, and all references"
```

**Refactoring Patterns:**
```plaintext
Working Set: app/Http/Controllers/**/*.php

Instructions:
"Extract authentication logic from all controllers to a new AuthService.
Update controllers to use dependency injection. Maintain all existing functionality."
```

**Component Library Migration:**
```plaintext
Working Set: resources/js/**/*.vue

Instructions:
"Migrate all Button components from custom implementation to shadcn-vue.
Update imports, props, and ensure styling is preserved."
```

### Best Practices

1. **Start with clear working set** - Select specific files you want to change
2. **Write detailed instructions** - Be explicit about what changes to make
3. **Review before applying** - Always check the diff view
4. **Use version control** - Commit before major refactors
5. **Break down large changes** - Multiple small edits are better than one massive change

📖 **Full guide**: [docs/copilot-extensions/copilot-edits.md](docs/copilot-extensions/copilot-edits.md)

## 🔌 Copilot Extensions

GitHub Copilot Extensions provide additional capabilities through third-party integrations. While different from Claude's MCP servers, they serve similar purposes.

### Built-in Extensions

**@workspace** - Code navigation and analysis
```plaintext
@workspace "Find all controller classes that use Form Requests"
@workspace "Show Vue components using the useForm composable"
@workspace "Explain the authentication flow in this project"
```

**@github** - Repository management
```plaintext
@github "Show open issues labeled 'bug'"
@github "What's the status of PR #42?"
@github "List recent commits to the main branch"
```

### Official Extensions

Install from VS Code Marketplace or GitHub:

- **Docker** - Container management and Dockerfile optimization
- **Azure** - Cloud services and deployment assistance
- **DataStax** - Database operations and query optimization

### Recommended Laravel Extensions

```bash
# Laravel-specific tooling
code --install-extension amiralizadeh9480.laravel-extra-intellisense
code --install-extension onecentlin.laravel-blade

# Quality tools
code --install-extension SonarSource.sonarlint-vscode

# Vue/Inertia
code --install-extension Vue.volar
```

### Extension Usage

```plaintext
# Ask about cloud resources
@azure "List my deployed Laravel apps"

# Container optimization
@docker "Optimize this Dockerfile for production Laravel"

# Database help
@datastax "Review this migration for performance issues"
```

📖 **Full guide**: [docs/copilot-extensions/](docs/copilot-extensions/)

### MCP vs Extensions Comparison

While Claude Code uses MCP servers, Copilot uses Extensions. Here's how they compare:

| Function | Claude MCP | Copilot Equivalent |
|----------|------------|-------------------|
| Code navigation | Serena MCP | `@workspace` + IntelliSense |
| Documentation | Context7 MCP | Built-in knowledge + Chat |
| Code review | Zen MCP | Chat analysis + SonarLint |
| Testing | BrowserMCP | Generate tests + Playwright |
| Laravel tools | Laravel Herd/Boost MCP | Built-in Laravel knowledge |

**Key Insight**: Copilot's deep framework knowledge often eliminates the need for specialized extensions for common Laravel/Vue tasks.

## 🤖 Copilot Coding Agent (Enterprise Feature)

If you have GitHub Copilot Enterprise, the Coding Agent can:

1. **Create PRs from issues**: "Fix issue #123"
2. **Multi-file changes**: "Add user profile feature"
3. **Follow project patterns**: Uses AGENTS.md for guidance

### Enabling Coding Agent

1. Ensure AGENTS.md is in your repository root
2. Use `@github` in Copilot Chat for agentic tasks
3. Review generated PRs before merging

## 🔧 IDE Configuration

### VS Code Settings

Add to `.vscode/settings.json`:

```json
{
  "github.copilot.enable": {
    "*": true,
    "plaintext": false,
    "markdown": true,
    "yaml": true
  },
  "github.copilot.advanced": {
    "inlineSuggestCount": 3
  }
}
```

### Recommended Extensions

```bash
# Install helpful extensions
code --install-extension GitHub.copilot
code --install-extension GitHub.copilot-chat
code --install-extension Vue.volar
code --install-extension bmewburn.vscode-intelephense-client
code --install-extension bradlc.vscode-tailwindcss
```

## 📝 Customizing Instructions

### Adding Project-Specific Rules

Edit `.github/copilot-instructions.md` to add:

```markdown
## Project-Specific Guidelines

### Our Component Library
We use shadcn-vue components. Always import from:
- `@/Components/ui/button`
- `@/Components/ui/card`
- `@/Components/ui/input`

### Naming Conventions
- Pages: PascalCase (e.g., `UserProfile.vue`)
- Components: PascalCase (e.g., `ActionButton.vue`)
- Composables: camelCase with `use` prefix (e.g., `useAuth.ts`)

### Business Rules
- All posts require admin approval before publishing
- Users can only edit their own content
- API rate limit: 100 requests/minute
```

### Adding New Path-Scoped Instructions

Create `.github/instructions/api.instructions.md`:

```markdown
---
applyTo: "app/Http/Controllers/Api/**/*.php"
---
# API Controller Guidelines

- Always return JSON responses
- Use API Resources for response formatting
- Include pagination for list endpoints
- Document endpoints with OpenAPI annotations
```

## 🚨 Troubleshooting

### Copilot Not Using Instructions

1. Ensure files are in correct locations
2. Check file syntax (YAML frontmatter for path-scoped)
3. Restart VS Code/IDE
4. Verify Copilot extension is updated

### Suggestions Not Following Patterns

1. Be explicit in prompts: "Following our VILT patterns..."
2. Reference specific files: `@file:.github/copilot-instructions.md`
3. Provide examples in prompts

### Agent Not Available

- Copilot Coding Agent requires GitHub Copilot Enterprise
- Ensure repository has proper permissions
- Check AGENTS.md is in repository root

## 📚 Additional Resources

- **Full Documentation**: `docs/` directory
- **Dual AI Setup**: See [DUAL-SETUP.md](DUAL-SETUP.md) for using both tools together
- **Claude AI Support**: See `CLAUDE.md` and `.claude/` for Claude-specific configs
- **Laravel VILT Docs**: https://inertiajs.com, https://vuejs.org
- **GitHub Copilot Docs**: https://docs.github.com/copilot

## 🎯 Best Practices

1. **Start with free requests**: Use standard Copilot for most tasks
2. **Escalate to premium**: Use `@claude-sonnet` for complex reasoning tasks
3. **Keep instructions concise**: Copilot works best with clear, actionable guidelines
4. **Update regularly**: Keep instructions in sync with your codebase
5. **Use path-scoping**: Apply rules to specific file types when possible
6. **Test suggestions**: Verify Copilot follows your patterns
7. **Combine with Claude Code**: Use Claude for MCP-enhanced workflows

---

**Need help?** Open an issue or check [DUAL-SETUP.md](DUAL-SETUP.md) for the complete dual-tool guide.

*Happy coding with GitHub Copilot and Laravel VILT! 🚀*

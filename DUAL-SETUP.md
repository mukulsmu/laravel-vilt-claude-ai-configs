# Dual AI Agent Setup Guide

Complete guide for using **both Claude Code and GitHub Copilot** together on the same Laravel VILT project for maximum productivity.

## 🎯 Why Use Both?

| Use Case | Best Tool | Request Type |
|----------|-----------|--------------|
| Quick inline completions | Copilot | Free |
| Code documentation | Copilot | Free |
| Simple refactoring | Copilot | Free |
| Multi-file editing | Copilot Edits | Free |
| Code navigation | Copilot @workspace | Free |
| Complex logic | Copilot Premium (Claude/Gemini) | Premium |
| Architectural decisions | Copilot Premium or Claude Code | Premium |
| MCP server integrations | Claude Code only | Premium |
| Security audits | Claude Code (Zen MCP) | Premium |
| Performance analysis | Claude Code (MCP servers) | Premium |

**Key Differences**:
- **Claude Code**: MCP server integration for specialized tools (Zen, Serena, Context7, BrowserMCP)
- **GitHub Copilot**: Extensions + built-in features (@workspace, Edits, premium models)
- **Both**: Excellent Laravel/Vue knowledge, premium model access

---

## 📦 Complete Installation

### Step 1: Prerequisites

```bash
# Node.js 18+ (for both tools)
node --version  # Should be 18+

# PHP 8.2+ (for Laravel)
php --version  # Should be 8.2+

# GitHub Copilot subscription
# - Individual, Business, or Enterprise plan
# - Enterprise for Coding Agent features

# Anthropic API Key (for Claude Code)
# Get from https://console.anthropic.com/
```

### Step 2: Install All Configurations

```bash
# Navigate to your Laravel VILT project
cd your-laravel-project

# Clone the configuration repository
git clone https://github.com/mukulsmu/laravel-vilt-claude-ai-configs.git .ai-config

# ===== GITHUB COPILOT =====
# Copy Copilot configurations
cp -r .ai-config/.github ./

# Copy Copilot Coding Agent instructions
cp .ai-config/AGENTS.md ./

# ===== CLAUDE CODE =====
# Copy Claude configurations
cp -r .ai-config/.claude ./

# Copy Claude instructions
cp .ai-config/CLAUDE.md ./

# ===== SHARED DOCUMENTATION =====
# Copy documentation (used by both)
cp -r .ai-config/docs ./

# Clean up
rm -rf .ai-config
```

### Step 3: Install Claude Code CLI

```bash
# Install Claude Code globally
npm install -g @anthropic/claude-code

# Authenticate with Anthropic
claude auth login
# Or set environment variable
export ANTHROPIC_API_KEY="your-api-key-here"

# Verify installation
claude --version
```

### Step 4: Install Copilot Extensions

**VS Code:**
```bash
code --install-extension GitHub.copilot
code --install-extension GitHub.copilot-chat
```

**JetBrains:**
- Settings → Plugins → Search "GitHub Copilot" → Install

### Step 5: Verify Installation

Your project structure should now look like:

```
your-laravel-project/
├── .github/                          # GitHub Copilot configs
│   ├── copilot-instructions.md       # Global Copilot rules
│   ├── instructions/                 # Path-scoped rules
│   │   ├── laravel.instructions.md
│   │   ├── vue-inertia.instructions.md
│   │   └── database-testing.instructions.md
│   ├── agents/                       # Custom Copilot agents
│   └── skills/                       # Skill guides
│       ├── feature-development/
│       ├── testing/
│       └── debugging/
├── .claude/                          # Claude Code configs
│   └── agents/                       # Specialist agents
│       ├── vilt-specialist.md
│       ├── devops-specialist.md
│       ├── security-specialist.md
│       ├── performance-specialist.md
│       └── testing-specialist.md
├── docs/                             # Shared documentation
│   ├── workflows/
│   ├── mcp-servers/
│   └── reference/
├── AGENTS.md                         # Copilot Coding Agent
├── CLAUDE.md                         # Claude main config
├── app/                              # Laravel app
├── resources/js/                     # Vue components
└── ...
```

---

## 🔄 No Conflicts - They Work Together

Both tools read different configuration files and don't interfere with each other:

| Tool | Reads | Ignores |
|------|-------|---------|
| GitHub Copilot | `.github/`, `AGENTS.md` | `.claude/`, `CLAUDE.md` |
| Claude Code | `.claude/`, `CLAUDE.md`, `docs/` | `.github/copilot-*` |

**The `docs/` directory is shared** - both tools can reference the workflows and guides.

---

## 💰 Optimizing Free vs Premium Requests

### Understanding Tools & Request Types

**GitHub Copilot (Free Features):**
- Standard completions & chat
- @workspace for code navigation
- Copilot Edits for multi-file changes
- Built-in Extensions (@github)

**GitHub Copilot (Premium Features):**
- Claude Sonnet model in chat
- Gemini Pro model in chat
- GPT-4o model in chat
- Third-party Extensions (Docker, Azure, etc.)

**Claude Code (All API-based):**
- All requests use Anthropic API credits
- MCP server integration (unique to Claude)
- Persistent context across sessions
- Specialized tools (Zen, Serena, Context7, BrowserMCP)

### The Optimal Workflow Strategy

#### 🟢 Use Copilot FREE for:

```plaintext
# Quick completions (just type and Tab)
function calculate|  → Copilot completes

# Code navigation
@workspace "Find all service classes"

# Multi-file refactoring  
# Open Copilot Edits (Ctrl/Cmd+Shift+I)
"Rename Post model to Article across all files"

# Documentation generation
"Add PHPDoc to this method"

# Simple code questions
"What does this function do?"

# Boilerplate code
"Create a basic Laravel controller"

# Inline fixes
"Fix the syntax error on line 15"
```

#### 🟡 Use Copilot PREMIUM for:

```plaintext
# In Copilot Chat, select Claude/Gemini/GPT-4o from the model dropdown:
"Refactor this service class following SOLID principles"

# Multi-file feature development (select premium model first)
"Create a complete blog feature with model, migration, controller, and Vue pages"

# Complex debugging
"Analyze why the payment flow fails intermittently"

# Architecture review
"Review this folder structure and suggest improvements"
```

#### 🔵 Use Claude Code for:

```plaintext
# MCP-enhanced analysis (unique to Claude)
claude "Use mcp__zen__codereview to analyze security"
claude "Use mcp__serena__search_for_pattern 'N+1'"

# Systematic workflows with memory
claude "Follow the feature development workflow in docs/"

# Long-running multi-step tasks
claude "Security Specialist: Perform complete security audit"

# Cross-repository understanding
claude "Compare this auth implementation with Laravel best practices"
```

### Daily Workflow Example

```bash
# Morning: Planning (Claude - needs deep analysis)
claude "Analyze the codebase and create a task list for implementing user notifications"

# During development: Quick coding (Copilot Free)
# Just code normally - Copilot provides completions

# Complex feature (Copilot Premium or Claude)
# In Copilot Chat: @claude-sonnet "Implement the notification system"
# Or: claude "VILT Specialist: Create notification components"

# Before commit: Review (Claude MCP)
claude "Use mcp__zen__codereview on my changes"

# Testing (Copilot Free for simple, Claude for comprehensive)
# Copilot: "Write a test for this method"
# Claude: "Testing Specialist: Create comprehensive test suite"
```

---

## 🤖 Premium Model Comparison

### When to Use Which Premium Model

| Model | Best For |
|-------|----------|
| **Claude Sonnet** | Complex reasoning, code analysis, refactoring |
| **Gemini Pro** | Multi-modal tasks, long context understanding |
| **GPT-4o** | General tasks, creative solutions |
| **Claude Code (CLI)** | MCP servers, workflows, persistent memory |

### Copilot Premium Model Selection

In Copilot Chat, use the model dropdown selector (top of chat panel) to switch between:
- GPT-4o (default)
- Claude Sonnet  
- Gemini Pro

Then type your prompt as normal. The selected model processes your request.

### Claude Code Model Selection

```bash
# Default (Sonnet) - Most tasks
claude "Implement user authentication"

# For complex tasks, Claude automatically scales
# Or use specialist agents for domain expertise
claude "Security Specialist: Audit the authentication system"
```

---

## 🔌 Extensibility: MCP Servers vs Copilot Extensions

Both tools offer extensibility, but through different mechanisms.

### Claude Code - MCP Servers

**MCP (Model Context Protocol)** provides deep integration with specialized tools:

| MCP Server | Function | Use Case |
|------------|----------|----------|
| **Zen** | Advanced analysis, code review, security audits | Quality assurance, systematic workflows |
| **Serena** | Semantic code navigation, symbol search | Efficient codebase exploration |
| **Context7** | Up-to-date library documentation | Latest framework best practices |
| **BrowserMCP** | Browser automation, UI testing | Interactive debugging |
| **Laravel Herd** | Laravel development server management | Local development workflow |

**Configuration**: `claude_desktop_config.json` or environment variables

**Usage**:
```bash
claude "Use mcp__zen__codereview to analyze security"
claude "Use mcp__serena__get_symbols_overview for app/Services"
```

### GitHub Copilot - Extensions

**Extensions** integrate third-party services into Copilot Chat:

| Extension | Function | Use Case |
|-----------|----------|----------|
| **@workspace** | Code navigation (built-in) | Find classes, understand structure |
| **@github** | Repository management (built-in) | Issues, PRs, workflows |
| **@docker** | Container management | Dockerfile optimization |
| **@azure** | Cloud services | Deployment, monitoring |
| **SonarLint** | Code quality | Security, bugs, code smells |

**Installation**: VS Code Marketplace or GitHub

**Usage**:
```plaintext
@workspace "Find all controller classes"
@github "Show open issues"
@docker "Optimize this Dockerfile"
```

### Copilot's Built-in Equivalents

Many MCP server functions are built into Copilot:

| MCP Function | Copilot Equivalent |
|--------------|-------------------|
| Serena symbol search | `@workspace` + IntelliSense |
| Context7 docs | Built-in training on latest frameworks |
| Zen code review | Chat analysis + SonarLint |
| BrowserMCP testing | Generate Playwright/Dusk tests |
| Laravel Boost | Excellent built-in Laravel knowledge |

### When to Use Which

**Use Claude MCP when you need:**
- Systematic multi-step workflows (Zen)
- Token-efficient code navigation (Serena)
- Real-time browser debugging (BrowserMCP)
- Specialized analysis tools (Zen security audits)

**Use Copilot Extensions when you need:**
- Service integrations (Docker, Azure, DataStax)
- Repository management (@github)
- Multi-file editing (Copilot Edits)
- Built-in framework knowledge

**Use Both together:**
- Copilot for day-to-day coding
- Claude MCP for specialized analysis
- Switch based on task requirements

📖 **Full Extensions Guide**: [docs/copilot-extensions/](docs/copilot-extensions/)

---

## 📋 Task-Based Tool Selection Guide

### Feature Development

| Task | Tool | Type |
|------|------|------|
| Create model | Copilot Free | Boilerplate |
| Create migration | Copilot Free | Boilerplate |
| Create controller | Copilot Free | Boilerplate |
| Implement business logic | Copilot Premium / Claude | Complex |
| Create Vue pages | Copilot Free → Premium | Mixed |
| Write tests | Copilot Free (simple) / Claude (comprehensive) | Mixed |

### Debugging

| Task | Tool | Type |
|------|------|------|
| Syntax errors | Copilot Free | Simple |
| Logic errors | Copilot Premium | Complex |
| Performance issues | Claude (MCP) | Analysis |
| Security vulnerabilities | Claude (MCP) | Deep scan |

### Code Review

| Task | Tool | Type |
|------|------|------|
| Style/formatting | Copilot Free | Simple |
| Best practices | Copilot Premium | Complex |
| Security review | Claude (MCP) | Deep scan |
| Architecture review | Claude | Complex |

---

## 🔧 VS Code Configuration for Both

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
  },
  "terminal.integrated.env.osx": {
    "ANTHROPIC_API_KEY": "${env:ANTHROPIC_API_KEY}"
  },
  "terminal.integrated.env.linux": {
    "ANTHROPIC_API_KEY": "${env:ANTHROPIC_API_KEY}"
  },
  "terminal.integrated.env.windows": {
    "ANTHROPIC_API_KEY": "${env:ANTHROPIC_API_KEY}"
  }
}
```

### Recommended Extensions

```bash
# Install all recommended extensions
code --install-extension GitHub.copilot
code --install-extension GitHub.copilot-chat
code --install-extension Vue.volar
code --install-extension bmewburn.vscode-intelephense-client
code --install-extension bradlc.vscode-tailwindcss
code --install-extension esbenp.prettier-vscode
code --install-extension dbaeumer.vscode-eslint
```

---

## 💡 Pro Tips

### 1. Context Switching

```bash
# Quick task? Stay in IDE with Copilot
# Complex task? Switch to terminal with Claude

# Example workflow:
# 1. Copilot: Scaffold the controller
# 2. Claude: Implement complex business logic
# 3. Copilot: Generate tests
# 4. Claude: Review and optimize
```

### 2. Use Copilot's Model Flexibility

```plaintext
# Start with free, escalate to premium if needed:
"Write a validation rule for email"  # Free - simple task
@claude-sonnet "Design a custom validation system for complex business rules"  # Premium - complex
```

### 3. Claude for Persistent Context

```bash
# Claude remembers context across a session
claude "Let's work on the user module"
claude "Now add email verification"  # Remembers we're working on users
claude "Add tests for what we built"  # Knows the full context
```

### 4. Combine Strengths

```bash
# Copilot: Generate boilerplate
# Claude: Add intelligence

# Example: Building an API endpoint
# 1. Copilot generates controller scaffold
# 2. Claude reviews and adds security, caching, optimization
# 3. Copilot generates tests from the implementation
# 4. Claude runs security audit with MCP
```

---

## 📊 Request Budget Strategy

### For Individual Developers

| Weekly Budget | Copilot Free | Copilot Premium | Claude Code |
|---------------|--------------|-----------------|-------------|
| Light usage | Unlimited | 10-20 | 20-30 |
| Medium usage | Unlimited | 30-50 | 50-100 |
| Heavy usage | Unlimited | 100+ | 200+ |

### Budget Optimization Tips

1. **Always try free first** - Most tasks don't need premium
2. **Batch premium requests** - Combine multiple questions into one
3. **Use Claude for MCP tasks** - Unique capability worth the tokens
4. **Use Copilot premium for IDE-bound tasks** - Keeps context in editor
5. **Track your usage** - Both tools provide usage dashboards

---

## 🚀 Quick Reference Card

```
┌─────────────────────────────────────────────────────────────┐
│                 DUAL AI TOOL QUICK REFERENCE                │
├─────────────────────────────────────────────────────────────┤
│ COPILOT FREE     │ Completions, docs, simple questions      │
│ COPILOT PREMIUM  │ @claude-sonnet, @gemini, complex tasks   │
│ CLAUDE CODE      │ MCP servers, workflows, multi-step tasks │
├─────────────────────────────────────────────────────────────┤
│ START WITH: Copilot Free                                    │
│ ESCALATE TO: Copilot Premium (in-IDE) or Claude (complex)   │
│ USE CLAUDE FOR: Security audits, performance, architecture  │
└─────────────────────────────────────────────────────────────┘
```

---

## 🆘 Troubleshooting

### Both Tools Not Working

```bash
# Check Copilot
# In VS Code: Copilot icon in status bar should be active

# Check Claude
claude --version
claude auth status
```

### Configuration Not Applied

```bash
# Copilot: Restart VS Code
# Claude: Run from project root directory

# Verify files exist
ls -la .github/copilot-instructions.md
ls -la CLAUDE.md
ls -la AGENTS.md
```

### Premium Models Not Available

- **Copilot**: Check your subscription tier supports premium models
- **Claude**: Verify API key has sufficient credits

---

**Ready to maximize your productivity with dual AI assistants!** 🚀

Use the right tool for each task, optimize your request budget, and leverage the unique strengths of each platform.

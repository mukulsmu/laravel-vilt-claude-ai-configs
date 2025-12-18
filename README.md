# Laravel VILT Stack AI Development Toolkit

**🚀 The #1 AI-powered development toolkit for Laravel VILT stack developers**

Supercharge your Laravel VILT (Vue, Inertia.js, Laravel, Tailwind CSS) stack development with comprehensive configurations for **both Claude Code and GitHub Copilot**. Get intelligent assistance, systematic workflows, and domain expert consultation regardless of your preferred AI coding assistant.

---

## 🎯 **Supports Both AI Coding Agents**

| Feature | Claude Code (Paid) | GitHub Copilot Pro |
|---------|-------------|----------------|
| **Configuration File** | `CLAUDE.md` | `.github/copilot-instructions.md` |
| **Specialist Agents** | `.claude/agents/` | `AGENTS.md` + `.github/agents/` |
| **Path-Scoped Rules** | Per-agent configs | `.github/instructions/` |
| **Workflows & Skills** | `docs/workflows/` | `.github/skills/` |
| **Pricing** | API usage-based | Monthly Pro subscription |
| **Premium Models** | Claude Sonnet/Opus | Claude Sonnet, Gemini Pro, GPT-4o |
| **MCP Servers** | ✅ Full support | ✅ Full support (VS Code) |
| **Coding Agent** | ✅ CLI workflows | ✅ Autonomous coding |
| **Best For** | Terminal workflows, MCP tools | IDE integration, team collaboration |

**Professional Setup** for serious Laravel VILT development:
- **GitHub Copilot Pro**: Coding Agent with MCP servers and premium models
- **Laravel Boost**: Must be installed FIRST (provides AI-ready Laravel project setup)
- **MCP Integration**: Laravel Herd + Laravel Boost MCP servers
- **Premium Models**: Claude Sonnet for complex reasoning tasks
- **Claude Code**: Advanced MCP workflows and systematic analysis
- **Both Tools**: Maximum flexibility and capability

📖 **[Complete Dual Setup Guide](DUAL-SETUP.md)** - Optimize free vs premium requests

---

## ✨ **What This Toolkit Provides**

### 🤖 **AI Specialist Agents**
Pre-configured domain experts for Laravel development:
- **🔧 DevOps Specialist** - Laravel Herd, deployment, infrastructure management
- **🔒 Security Specialist** - Vulnerability assessment, security best practices  
- **⚡ Performance Specialist** - Database optimization, performance tuning
- **🧪 Testing Specialist** - Comprehensive testing strategies and QA
- **🎨 VILT Stack Specialist** - Vue 3, Inertia.js, Ziggy/Wayfinder, frontend patterns

### 📋 **Development Workflows & Skills**
- **Feature Development** - End-to-end CRUD and feature implementation
- **Quality Assurance** - Code review, testing, and validation workflows
- **Debugging & Investigation** - Systematic problem-solving methodologies
- **Performance Optimization** - Analysis and optimization strategies

### 🛠️ **MCP Server Integration** (Both Tools Support MCP)

**Shared MCP Servers** for Laravel VILT development:
- **[Laravel Herd](docs/mcp-servers/laravel-herd-guide.md)** - Local PHP development server management
- **[Laravel Boost](docs/mcp-servers/laravel-boost-guide.md)** - Laravel code generation and scaffolding
- **[Zen](https://github.com/BeehiveInnovations/zen-mcp-server)** - Advanced analysis, multi-model workflows  
- **[Serena](https://github.com/oraios/serena)** - Semantic code analysis and intelligent navigation
- **[Context7](https://github.com/upstash/context7)** - Up-to-date documentation access
- **[BrowserMCP](https://browsermcp.io)** - Real-time browser automation and testing

**Configuration**:
- **Claude Code**: Add to `claude_desktop_config.json`
- **GitHub Copilot**: Add to VS Code settings (automatically configured by Laravel Boost)

📖 **[MCP Setup Guide for Both Tools](docs/mcp-servers/copilot-mcp-setup.md)**

---

## 🚀 **Quick Start**

### Prerequisites

**Install Laravel Boost FIRST** - It provides AI-ready configuration for both Claude and Copilot:

```bash
cd your-laravel-project

# Install Laravel Boost (required)
composer require laravel/boost
php artisan boost:install

# This creates:
# - .github/copilot-instructions.md (base Copilot config)
# - .claude/mcp-config.json (base Claude MCP config)
# - Laravel Boost MCP server
```

📖 **[Laravel Boost Integration Guide](docs/setup/laravel-boost-integration.md)** - Understanding what Boost creates

### Option A: Automated Installation (Recommended) ⭐

Use our installation script for quick setup:

```bash
cd your-laravel-project

# Download and run installation script
curl -o install.sh https://raw.githubusercontent.com/mukulsmu/laravel-vilt-claude-ai-configs/main/install.sh
chmod +x install.sh
./install.sh

# The script will:
# - Check for Laravel Boost (offer to install if missing)
# - Copy our VILT configurations
# - Set up path-scoped instructions
# - Optionally install documentation
```

### Option B: Manual Installation

```bash
# After Laravel Boost is installed, add our VILT configurations
git clone https://github.com/mukulsmu/laravel-vilt-claude-ai-configs.git .ai-config

# Copy all configurations (no merging needed - we use path-scoped instructions)
cp .ai-config/.github/copilot-instructions.md ./.github/  # VILT-specific instructions
cp -r .ai-config/.github/instructions ./.github/          # Path-scoped rules
cp -r .ai-config/.github/agents ./.github/                # Custom agents
cp -r .ai-config/.github/skills ./.github/                # Agent skills
cp .ai-config/AGENTS.md ./                                # Coding Agent instructions

# Optional: Claude configurations
cp -r .ai-config/.claude/agents ./.claude/                # Specialist agents

# Optional: Documentation
cp -r .ai-config/docs ./

# Clean up
rm -rf .ai-config

# Optional: Install Claude Code CLI
npm install -g @anthropic/claude-code
claude auth login
```

📖 **[Complete Installation Guide](docs/setup/INSTALLATION.md)** - Step-by-step with troubleshooting
📖 **[Laravel Boost Integration](docs/setup/laravel-boost-integration.md)** - Understanding file conflicts

### Option C: GitHub Copilot Pro Only

```bash
cd your-laravel-project

# Install Laravel Boost FIRST (required)
composer require laravel/boost
php artisan boost:install

# Then add our VILT configurations
git clone https://github.com/mukulsmu/laravel-vilt-claude-ai-configs.git .ai-config

# Copy Copilot configurations (no merging needed)
cp .ai-config/.github/copilot-instructions.md ./.github/
cp -r .ai-config/.github/instructions ./.github/
cp -r .ai-config/.github/agents ./.github/
cp -r .ai-config/.github/skills ./.github/
cp .ai-config/AGENTS.md ./

# Clean up
rm -rf .ai-config
```

Copilot Pro will automatically use both Laravel Boost's base instructions and our VILT enhancements.

📖 **Full guide:** [COPILOT-SETUP.md](COPILOT-SETUP.md)

### Option C: Claude Code Only

```bash
cd your-laravel-project

# Install Laravel Boost FIRST (required)
composer require laravel/boost
php artisan boost:install

# Install Claude Code CLI
npm install -g @anthropic/claude-code
claude auth login

# Add our enhanced configurations
git clone https://github.com/mukulsmu/laravel-vilt-claude-ai-configs.git .ai-config
cp -r .ai-config/.claude/agents ./.claude/
cat .ai-config/CLAUDE.md >> CLAUDE.md
cp -r .ai-config/docs ./

# Clean up
rm -rf .ai-config
```

📖 **Full guide:** [SETUP.md](SETUP.md)
git clone https://github.com/mukulsmu/laravel-vilt-claude-ai-configs.git .ai-config
cp -r .ai-config/.github ./
cp .ai-config/AGENTS.md ./

# Clean up
rm -rf .ai-config
```

Copilot will automatically use the instructions. Use premium models (`@claude-sonnet`, `@gemini-pro`) for complex tasks.

📖 **Full guide:** [COPILOT-SETUP.md](COPILOT-SETUP.md)

### Option C: Claude Code Only

```bash
# Install Claude Code CLI
npm install -g @anthropic/claude-code
claude auth login

# Add configurations to your project
cd your-laravel-project
git clone https://github.com/mukulsmu/laravel-vilt-claude-ai-configs.git .ai-config
cp -r .ai-config/.claude ./
cp -r .ai-config/docs ./
cp .ai-config/CLAUDE.md ./

# Clean up
rm -rf .ai-config
```

📖 **Full guide:** [SETUP.md](SETUP.md)

---

## 💡 **Usage Examples**

### GitHub Copilot Pro - Inline Completions

```plaintext
# Intelligent completions as you type (Tab to accept)
# Context-aware suggestions from codebase
"Create a Post model with migration"
"Write a test for this method"
"Add PHPDoc to this class"
```

### GitHub Copilot - Coding Agent (Autonomous)

```plaintext
# Autonomous multi-file coding with full project context
"Implement a complete blog feature with CRUD operations"
"Refactor authentication to use a service layer"
"Add comprehensive tests for the User module"
"Migrate from Livewire to Inertia.js for all components"

# Agent uses AGENTS.md for project patterns and conventions
```

### GitHub Copilot - MCP Integration (Laravel Focused)

```plaintext
# With Laravel Herd MCP - Development server management
@herd "Start the development server on port 8000"
@herd "Switch PHP version to 8.3"
@herd "Show database connections"

# With Laravel Boost MCP - Code generation
@boost "Generate a Post resource with full CRUD"
@boost "Create Comment model with relationships"
@boost "Scaffold admin panel for User management"

# With Analysis MCP servers
@zen "Review this controller for security vulnerabilities"
@serena "Find all references to this service method"
@context7 "Get latest Laravel 11 documentation for queues"
```

### Claude Code - MCP-Enhanced Workflows

```bash
# Terminal-based workflows with MCP servers
claude "Use mcp__laravel_herd__start to begin development"
claude "Use mcp__laravel_boost__generate CRUD for Product"
claude "Use mcp__zen__codereview to analyze security vulnerabilities"
claude "Security Specialist: Perform complete authentication audit"
claude "VILT Stack Specialist: Create notification system with real-time updates"
```

### Optimal Workflow Strategy

```plaintext
┌─────────────────────────────────────────────────────────────────┐
│ PROFESSIONAL LARAVEL VILT DEVELOPMENT WORKFLOW                  │
├─────────────────────────────────────────────────────────────────┤
│ 1. SETUP: Laravel Herd MCP for local development server         │
│ 2. SCAFFOLD: Laravel Boost MCP for code generation              │
│ 3. CODE: Copilot Agent for autonomous multi-file implementation │
│ 4. ANALYZE: MCP servers (Zen, Serena, Context7) for deep review │
│ 5. REFINE: Premium models (Claude Sonnet) for complex logic     │
│ 6. WORKFLOW: Claude Code for systematic multi-step processes    │
└─────────────────────────────────────────────────────────────────┘
```

---

## 🛠️ **Technology Stack Optimized For**

- **Laravel 12** - Modern PHP framework with latest features
- **VILT Stack** - Vue 3, Inertia.js, Laravel, Tailwind CSS
- **Laravel Herd** - Native PHP development environment
- **Vite** - Fast build tool and dev server
- **Pest/PHPUnit** - PHP testing framework
- **Vitest** - Vue component testing framework
- **Ziggy/Wayfinder** - Laravel route integration for Vue
- **TypeScript** - Optional type safety (recommended)
- **shadcn-vue** - Modern component library

---

## 📂 **Repository Structure**

```
.
├── .github/                    # GitHub Copilot configurations
│   ├── copilot-instructions.md # Global Copilot instructions
│   ├── instructions/           # Path-scoped rules
│   ├── agents/                 # Custom Copilot agents
│   └── skills/                 # Agent skills
├── .claude/                    # Claude Code configurations
│   └── agents/                 # Claude specialist agents
├── docs/                       # Full documentation
│   ├── copilot-extensions/     # Copilot Extensions guides
│   ├── workflows/              # Development workflows
│   ├── mcp-servers/            # MCP server guides (Claude)
│   └── reference/              # Code conventions
├── AGENTS.md                   # Copilot Coding Agent instructions
├── CLAUDE.md                   # Claude Code instructions
├── COPILOT-SETUP.md           # GitHub Copilot setup guide
├── SETUP.md                    # Claude Code setup guide
└── README.md                   # This file
```

---

## 📚 **Documentation**

| Document | Purpose |
|----------|---------|
| [DUAL-SETUP.md](DUAL-SETUP.md) | **Complete guide for using both tools together** |
| [COPILOT-SETUP.md](COPILOT-SETUP.md) | GitHub Copilot installation and usage |
| [SETUP.md](SETUP.md) | Claude Code installation and MCP servers |
| [CLAUDE.md](CLAUDE.md) | Claude AI development guidelines |
| [AGENTS.md](AGENTS.md) | Copilot Coding Agent instructions |
| [docs/copilot-extensions/](docs/copilot-extensions/) | **GitHub Copilot Extensions guide** |
| [docs/mcp-servers/](docs/mcp-servers/) | Claude MCP server guides |
| [docs/workflows/](docs/workflows/) | Step-by-step development processes |
| [docs/reference/](docs/reference/) | Code conventions and patterns |
| [MIGRATION.md](MIGRATION.md) | TALL → VILT stack migration guide |

---

## 🤝 **Contributing**

Found an issue or have an improvement?

1. Check existing documentation
2. Follow patterns in existing files
3. Test with both Claude and Copilot
4. Submit a PR with examples

---

## 📄 **License**

MIT License - see [LICENSE](LICENSE) file for details.

---

## ⭐ **Star This Repo**

If this toolkit helps your Laravel VILT development, please give it a star! It helps others discover it.

---

*Transform your Laravel VILT stack development with AI-powered assistance from your preferred coding agent.* 🚀

**Works with:** Claude Code • GitHub Copilot • VS Code • JetBrains IDEs

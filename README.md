# Laravel VILT Stack AI Development Toolkit

**🚀 The #1 AI-powered development toolkit for Laravel VILT stack developers**

Supercharge your Laravel VILT (Vue, Inertia.js, Laravel, Tailwind CSS) stack development with comprehensive configurations for **both Claude Code and GitHub Copilot**. Get intelligent assistance, systematic workflows, and domain expert consultation regardless of your preferred AI coding assistant.

---

## 🎯 **Supports Both AI Coding Agents**

| Feature | Claude Code | GitHub Copilot |
|---------|-------------|----------------|
| **Configuration File** | `CLAUDE.md` | `.github/copilot-instructions.md` |
| **Specialist Agents** | `.claude/agents/` | `AGENTS.md` + `.github/agents/` |
| **Path-Scoped Rules** | Per-agent configs | `.github/instructions/` |
| **Workflows & Skills** | `docs/workflows/` | `.github/skills/` |
| **Free Requests** | N/A (API credits) | Unlimited completions & chat |
| **Premium Models** | Claude Sonnet/Opus | Claude Sonnet, Gemini Pro, GPT-4o |
| **Multi-File Edits** | ✅ Native | ✅ Copilot Edits (VS Code) |
| **Extensibility** | MCP Servers | GitHub Copilot Extensions |
| **Autonomous Coding** | ✅ Full workflows | ✅ Coding Agent (Enterprise) |

**Use both together** for maximum productivity:
- **Copilot Free**: Quick completions, documentation, simple tasks
- **Copilot Edits**: Multi-file refactoring and code changes (VS Code)
- **Copilot Premium**: Complex features using Claude Sonnet/Gemini/GPT-4o
- **Copilot Extensions**: Third-party integrations (Azure, DataStax, Docker, etc.)
- **Claude Code**: MCP server integration, systematic workflows, deep analysis

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

### 🛠️ **Tool Extensibility**

**Claude Code - MCP Server Integration:**
Enhanced capabilities through Model Context Protocol servers:
- **[Zen](https://github.com/BeehiveInnovations/zen-mcp-server)** - Advanced analysis, multi-model workflows
- **[Serena](https://github.com/oraios/serena)** - Semantic code analysis and intelligent navigation
- **[Context7](https://github.com/upstash/context7)** - Up-to-date documentation access
- **[BrowserMCP](https://browsermcp.io)** - Real-time browser automation and testing

**GitHub Copilot - Extensions:**
Third-party integrations through Copilot Extensions:
- **Azure/GitHub** - Cloud services, repositories, issues
- **Docker** - Container management
- **DataStax** - Database operations
- **Available in VS Code** - Extensions marketplace

---

## 🚀 **Quick Start**

### Option A: Both Tools (Recommended) ⭐

```bash
cd your-laravel-project

# Clone configuration repository
git clone https://github.com/mukulsmu/laravel-vilt-claude-ai-configs.git .ai-config

# Copy ALL configurations
cp -r .ai-config/.github ./      # GitHub Copilot
cp -r .ai-config/.claude ./      # Claude agents
cp -r .ai-config/docs ./         # Documentation
cp .ai-config/CLAUDE.md ./       # Claude instructions
cp .ai-config/AGENTS.md ./       # Copilot Coding Agent

# Clean up
rm -rf .ai-config

# Install Claude Code CLI
npm install -g @anthropic/claude-code
claude auth login
```

📖 **[Complete Dual Setup Guide](DUAL-SETUP.md)** - Includes request optimization strategies

### Option B: GitHub Copilot Only

```bash
cd your-laravel-project

# Clone and copy Copilot configurations
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

### GitHub Copilot - Free Requests (Unlimited)

```plaintext
# Quick completions - just type and Tab
# Documentation generation
# Simple refactoring
"Create a Post model with migration"
"Write a test for this method"
"Add PHPDoc to this class"
```

### GitHub Copilot - Edits (Multi-File Changes)

```plaintext
# In VS Code, open Copilot Edits panel (Ctrl/Cmd+Shift+I)
# Works across multiple files simultaneously

"Rename the Post model to Article throughout the codebase"
"Extract authentication logic from controllers to a service class"
"Add proper type hints to all controller methods"
"Refactor all Vue components to use Composition API"
```

### GitHub Copilot - Premium Models (Chat)

```plaintext
# In Copilot Chat, select Claude Sonnet/Gemini/GPT-4o from model dropdown:
"Implement a complete blog feature with model, controller, and Vue pages"
"Analyze this codebase structure and suggest improvements"
"Refactor this service following SOLID principles"
```

### Claude Code (MCP-Enhanced)

```bash
# Terminal commands with MCP server integration
claude "Use mcp__zen__codereview to analyze security vulnerabilities"
claude "Security Specialist: Perform complete security audit"
claude "VILT Stack Specialist: Create notification system with real-time updates"
claude "Follow the feature development workflow for user profiles"
```

### Optimal Workflow Strategy

```plaintext
┌─────────────────────────────────────────────────────────────────┐
│ 1. START: Copilot Free for quick completions & simple tasks     │
│ 2. MULTI-FILE: Copilot Edits for refactoring across files       │
│ 3. COMPLEX: Copilot Premium (Claude/Gemini) for deep reasoning  │
│ 4. ANALYSIS: Claude Code with MCP for security/performance      │
│ 5. REVIEW: Claude Code for comprehensive systematic workflows   │
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
│   ├── workflows/              # Development workflows
│   ├── mcp-servers/            # MCP server guides
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

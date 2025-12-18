# Laravel VILT Stack AI Development Toolkit

**🤖 Dual AI Support**: Works with **both Claude Code and GitHub Copilot** for comprehensive Laravel development

Transform your Laravel VILT (Vue 3, Inertia.js, Laravel, Tailwind CSS) development with AI-powered workflows, specialist agents, systematic quality assurance, and extensive tooling integration.

---

## ✨ What This Toolkit Provides

### 🤖 **Dual AI Integration**
- **Claude Code** - Architecture, planning, comprehensive analysis, code review
- **GitHub Copilot** - Real-time autocomplete, inline suggestions, quick implementations
- **Shared Knowledge** - Both tools reference same example files for consistency

### 👨‍💻 **8 AI Specialist Agents**
Pre-configured domain experts for Laravel development:
- **🎨 VILT Stack Specialist** - Vue 3, Inertia.js, Wayfinder, shadcn-vue patterns
- **👑 Admin Specialist** - Filament & Nova admin panel workflows
- **🔧 DevOps Specialist** - Laravel Herd, deployment, infrastructure management
- **🔒 Security Specialist** - Vulnerability assessment, security best practices  
- **⚡ Performance Specialist** - Database optimization, query tuning, caching strategies
- **🧪 Testing Specialist** - Comprehensive testing strategies, Pest, Playwright
- **🗄️ Database Architect** - Schema design, migrations, relationship optimization
- **📝 Git Workflow Specialist** - Conventional commits, branching strategies, PR workflows

### 📋 **Systematic Development Workflows**
- **Feature Development** - End-to-end implementation from planning to deployment
- **Quality Assurance** - Code review, testing, and validation workflows
- **Debugging & Investigation** - Systematic problem-solving methodologies
- **Performance Optimization** - Analysis and optimization strategies
- **GitHub Copilot Usage** - Best practices for dual-tool workflows

### 🛠️ **10+ MCP Server Integrations** (Claude Code)
Enhanced capabilities through official MCP servers:

#### Core Development
- **[Serena](https://github.com/oraios/serena)** - Semantic code analysis, intelligent navigation, symbol-based editing
- **[Context7](https://github.com/upstash/context7)** - Up-to-date documentation access for Laravel, Vue, Inertia
- **[Playwright MCP](https://github.com/microsoft/playwright-mcp)** - Browser automation with Laravel integration
- **[BrowserMCP](https://browsermcp.io)** - Real-time browser debugging and testing

#### Quality Assurance
- **[Zen](https://github.com/BeehiveInnovations/zen-mcp-server)** - Advanced analysis, multi-model workflows, code review

#### Laravel & Development
- **Laravel Boost** - Laravel-specific utilities (logs, tinker, routes)
- **Laravel Herd MCP** - Herd environment management
- **Git MCP** - Version control automation and workflow optimization
- **Filesystem MCP** - File operations, watching, and management

### 📚 **900+ Lines of Code Examples**
Production-ready patterns in `.claude/examples/`:
- **VILT Examples** - Wayfinder routing, Inertia forms, shadcn-vue components, real-time features
- **Filament Examples** - Resources, forms, tables, widgets, authorization
- **Nova Examples** - Resources, filters, lenses, metrics, actions

---

## 🚀 **Quick Start**

### For Claude Code Users

```bash
# 1. Install Claude Code
npm install -g @anthropic/claude-code
claude auth login

# 2. Add to your Laravel project
cd your-laravel-project
git clone https://github.com/mukulsmu/laravel-vilt-claude-ai-configs.git .ai-config
cp -r .ai-config/.claude ./
cp -r .ai-config/.github ./
cp -r .ai-config/docs ./
cp .ai-config/CLAUDE.md ./

# 3. Configure MCP servers (see docs/mcp-servers/)

# 4. Initialize project memory
claude "Read docs/setup/init-memory.md and initialize project_context"

# 5. Start development
claude "Help me implement user authentication following VILT patterns"
```

### For GitHub Copilot Users

```bash
# 1. Install GitHub Copilot in VS Code

# 2. Add configurations to your Laravel project
cd your-laravel-project
git clone https://github.com/mukulsmu/laravel-vilt-claude-ai-configs.git .ai-config
cp -r .ai-config/.github ./
cp -r .ai-config/.claude ./

# 3. Verify files exist:
# - .github/copilot-instructions.md
# - .claude/examples/vilt-examples.md
# - .claude/examples/filament-examples.md
# - .claude/examples/nova-examples.md

# 4. Start coding - Copilot will suggest patterns automatically!
```

### For Both Tools (Recommended)

```bash
# Install full toolkit
cd your-laravel-project
git clone https://github.com/mukulsmu/laravel-vilt-claude-ai-configs.git .ai-config
cp -r .ai-config/.claude ./
cp -r .ai-config/.github ./
cp -r .ai-config/docs ./
cp .ai-config/CLAUDE.md ./

# Use Claude for architecture, Copilot for implementation
# See docs/workflows/github-copilot-usage.md for best practices
```

---

## 🛠️ **Technology Stack Optimized For**

### Backend
- **Laravel 12** - Modern PHP framework with latest features
- **Laravel Herd** - Native PHP development environment (recommended)
- **Pest/PHPUnit** - PHP testing framework
- **FilamentPHP** - Modern admin panel (optional)
- **Laravel Nova** - Premium admin panel (optional)

### Frontend
- **Vue 3** - Progressive JavaScript framework with Composition API
- **Inertia.js 2.x** - SPA adapter bridging Laravel and Vue
- **Wayfinder** - Type-safe routing (recommended)
- **Ziggy** - Laravel route integration (legacy support)
- **shadcn-vue** - Modern accessible UI components
- **Tailwind CSS** - Utility-first CSS framework
- **Vite** - Fast build tool and dev server
- **Vitest** - Vue component testing framework
- **TypeScript** - Type safety (recommended)

### Development Tools
- **Playwright** - End-to-end browser testing
- **Laravel Pint** - Code style fixer
- **Laravel Debugbar** - Development debugging
- **Telescope** - Application monitoring

---

## 📖 **Documentation Structure**

### Getting Started
- **[SETUP.md](SETUP.md)** - Comprehensive installation and configuration
- **[CLAUDE.md](CLAUDE.md)** - Core AI development guidelines and patterns
- **[docs/setup/](docs/setup/)** - Initial setup and project architecture

### Development Workflows
- **[Feature Development](docs/workflows/feature-development.md)** - Complete development process
- **[Quality Assurance](docs/workflows/quality-assurance.md)** - Code review and testing
- **[Debugging & Investigation](docs/workflows/debugging-investigation.md)** - Problem-solving
- **[Performance Optimization](docs/workflows/performance-optimization.md)** - Performance tuning
- **[GitHub Copilot Usage](docs/workflows/github-copilot-usage.md)** - Dual-tool best practices

### MCP Server Guides
- **[Serena Guide](docs/mcp-servers/serena-guide.md)** - Semantic code analysis
- **[Zen Guide](docs/mcp-servers/zen-guide.md)** - Advanced analysis workflows
- **[Context7 Guide](docs/mcp-servers/context7-guide.md)** - Documentation access
- **[Playwright Guide](docs/mcp-servers/playwright-guide.md)** - Browser automation
- **[BrowserMCP Guide](docs/mcp-servers/browsermcp-guide.md)** - Real-time debugging
- **[Git Guide](docs/mcp-servers/git-guide.md)** - Version control automation
- **[Laravel Boost Guide](docs/mcp-servers/laravel-boost-guide.md)** - Laravel utilities
- **[Laravel Herd Guide](docs/mcp-servers/laravel-herd-guide.md)** - Herd management

### Reference Materials
- **[Code Conventions](docs/reference/code-conventions.md)** - VILT stack patterns and standards
- **[Laravel Commands](docs/reference/laravel-commands.md)** - Complete command reference
- **[AI Interaction Patterns](docs/reference/ai-interaction-patterns.md)** - Natural language development
- **[Decision Tracking](docs/reference/decision-tracking.md)** - Architectural decision records

---

## 💡 **Key Features**

### Hybrid Paradigm System
- **Memory-First**: Check project context before generating code
- **Example-First**: Reference proven patterns instead of hallucinating
- **Type-Safety**: Prefer TypeScript and type-safe patterns
- **Log-Safety**: Limit log retrieval to prevent context overflow
- **Symbolic Exploration**: Use semantic analysis instead of reading full files

### Intelligent Code Generation
- **Context-Aware**: Adapts to your project's routing (Wayfinder/Ziggy) and admin system (Filament/Nova)
- **Pattern-Consistent**: Follows same standards whether using Claude or Copilot
- **Production-Ready**: 900+ lines of tested examples from official documentation

### Quality Assurance Gates
- **Pre-commit Review**: Automated code review before committing
- **Security Audits**: Systematic vulnerability scanning
- **Performance Analysis**: Database query optimization and profiling
- **Browser Testing**: Automated E2E testing with Playwright

---

## 🎯 **Use Cases**

### Perfect For:
- ✅ Building new Laravel VILT applications
- ✅ Migrating from TALL stack to VILT
- ✅ Adding AI assistance to existing Laravel projects
- ✅ Learning modern Laravel + Vue patterns
- ✅ Implementing best practices systematically
- ✅ Scaling development team productivity

### Ideal Team Size:
- 👤 Solo developers - Complete guidance and automation
- 👥 Small teams (2-5) - Consistent patterns and quality gates
- 👨‍👩‍👧‍👦 Growing teams (5+) - Standardized workflows and conventions

---

## 🆚 **Claude Code vs GitHub Copilot**

| Feature | Claude Code | GitHub Copilot |
|---------|-------------|----------------|
| **Best For** | Architecture & Planning | Autocomplete & Implementation |
| **Scope** | Project-wide analysis | File/context-aware |
| **Memory** | Persistent across sessions | Current file + nearby files |
| **Tools** | 10+ MCP servers | Built-in only |
| **Cost** | Per-use API calls | Monthly subscription |
| **When to Use** | Morning planning, evening review | Active coding during day |

**Recommendation**: Use both together for maximum productivity. See [GitHub Copilot Usage Guide](docs/workflows/github-copilot-usage.md).

---

## 🔧 **Installation Examples**

### MCP Server Setup (Claude Code Only)

**Serena** (Semantic Code Analysis)
```bash
uvx --from git+https://github.com/oraios/serena serena start-mcp-server --context ide-assistant --project /path/to/project
```

**Zen** (Advanced Analysis)
```bash
git clone https://github.com/BeehiveInnovations/zen-mcp-server.git
cd zen-mcp-server
python -m venv .zen_venv
source .zen_venv/bin/activate
pip install -r requirements.txt
```

**Playwright MCP** (Browser Automation)
```bash
npx -y @modelcontextprotocol/server-playwright
```

**Git MCP** (Version Control)
```bash
uvx mcp-server-git --repository /path/to/project
```

See [SETUP.md](SETUP.md) for complete MCP configuration.

---

## 📊 **Project Stats**

- **8 Specialist Agents** - Domain experts ready to assist
- **10+ MCP Servers** - Extended capabilities (Claude)
- **900+ Lines Examples** - Production-ready code patterns
- **20+ Documentation Files** - Comprehensive guidance
- **5 Development Workflows** - Systematic processes
- **100% Laravel 12 Compatible** - Latest framework features

---

## 🤝 **Contributing**

Contributions welcome! Please see [Documentation Guidelines](docs/maintenance/documentation-guidelines.md) for contribution standards.

---

## 📄 **License**

MIT License - see [LICENSE](LICENSE) file for details.

---

## 🔗 **Related Projects**

- **[Laravel Breeze](https://laravel.com/docs/breeze)** - Starter kit with authentication
- **[Laravel Vue Starter Kit](https://github.com/laravel/vue-starter-kit)** - Official Vue + Inertia starter
- **[FilamentPHP](https://filamentphp.com)** - Modern Laravel admin panel
- **[shadcn-vue](https://www.shadcn-vue.com)** - Accessible Vue components

---

**Transform your Laravel VILT development with comprehensive AI assistance, systematic workflows, and production-ready patterns.** 🚀

*Built for developers who want both the strategic thinking of Claude Code and the tactical speed of GitHub Copilot.*

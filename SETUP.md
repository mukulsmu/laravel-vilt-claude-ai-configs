# Laravel VILT Stack AI Development Setup Guide

Complete technical setup instructions for integrating AI-powered development workflows into your Laravel VILT stack project.

## 📋 Prerequisites

- **Node.js 18+** - For Vue 3, Vite, and MCP server dependencies  
- **PHP 8.2+** - For Laravel 12
- **Laravel Herd** (macOS/Windows) or Laravel Valet - For local development
- **Laravel Project** - Existing or new Laravel application
- **Anthropic API Key** - Get from https://console.anthropic.com/

## 🚀 Installation

### 1. Install Claude Code CLI

```bash
# Install via npm (recommended)
npm install -g @anthropic/claude-code

# Verify installation
claude --version

# Setup authentication
claude auth login
# Or set environment variable
export ANTHROPIC_API_KEY="your-api-key-here"
```

### 2. Install AI Development Configurations

```bash
# Navigate to your Laravel project
cd your-laravel-project

# Clone configuration repository
git clone https://github.com/your-org/laravel-ai-starter.git .ai-config

# Copy configurations to your project
cp -r .ai-config/.claude ./
cp -r .ai-config/docs ./
cp .ai-config/CLAUDE.md ./

# Clean up
rm -rf .ai-config
```

Your project structure should now include:
```
your-laravel-project/
├── .claude/                 # AI agent configurations
├── docs/                   # Development workflows and guides  
├── CLAUDE.md              # Main AI development guidelines
└── [your Laravel files]
```

### 3. MCP Server Installation (Recommended)

#### Zen MCP Server (Advanced Analysis)

```bash
# Clone and setup Zen server
git clone https://github.com/BeehiveInnovations/zen-mcp-server.git
cd zen-mcp-server

# Install dependencies
python -m venv .zen_venv
source .zen_venv/bin/activate  # On Windows: .zen_venv\Scripts\activate
pip install -r requirements.txt

# Note the full path for Claude configuration:
# /full/path/to/zen-mcp-server/.zen_venv/bin/python /full/path/to/zen-mcp-server/server.py
```

#### Serena MCP Server (Code Analysis)

```bash
# Install uvx if not already available
pip install uvx

# Serena will be installed on-demand via:
# uvx --from git+https://github.com/oraios/serena serena start-mcp-server --context ide-assistant --project /path/to/your/project
```

#### Context7 MCP Server (Documentation)

```bash
# Context7 uses SSE (Server-Sent Events) 
# Configure URL: https://mcp.context7.com/sse
# See https://github.com/upstash/context7 for setup details
```

#### BrowserMCP (Browser Automation)

```bash
# Install via npm (installs on-demand)
# Command: npx @browsermcp/mcp@latest
# See https://browsermcp.io for configuration details
```

### 4. Configure MCP Servers in Claude

Add your MCP servers to Claude's configuration. Create or edit `.claude/config.json`:

```json
{
  "mcpServers": {
    "zen": {
      "command": "/full/path/to/zen-mcp-server/.zen_venv/bin/python",
      "args": ["/full/path/to/zen-mcp-server/server.py"]
    },
    "serena": {
      "command": "uvx",
      "args": ["--from", "git+https://github.com/oraios/serena", "serena", "start-mcp-server", "--context", "ide-assistant", "--project", "/full/path/to/your/project"]
    },
    "context7": {
      "command": "sse",
      "args": ["https://mcp.context7.com/sse"]
    },
    "browsermcp": {
      "command": "npx",
      "args": ["@browsermcp/mcp@latest"]
    }
  }
}
```

Verify MCP server connections:
```bash
claude mcp list
```

## 🛠️ MCP Server Usage

### Zen - Advanced Analysis & Quality Assurance
```bash
# Comprehensive code review
claude "Use mcp__zen__codereview to review UserController for security issues"

# Multi-model consensus for complex decisions  
claude "Use mcp__zen__consensus with o3,gemini-pro to evaluate architecture options"

# Systematic debugging
claude "Use mcp__zen__debug to investigate authentication failures"

# Security audit
claude "Use mcp__zen__secaudit to analyze the payment system"

# Performance analysis
claude "Use mcp__zen__analyze to identify dashboard bottlenecks"
```

### Serena - Code Navigation & Analysis
```bash
# Analyze codebase structure
claude "Use mcp__serena__get_symbols_overview for the app/ directory"

# Find specific code patterns
claude "Use mcp__serena__search_for_pattern to find Livewire validation"

# Navigate to classes/methods
claude "Use mcp__serena__find_symbol to locate User model relationships"

# Document architectural decisions
claude "Use mcp__serena__write_memory to document auth flow decisions"
```

### Context7 - Documentation Access
```bash
# Laravel documentation lookup
claude "Use mcp__context7__get_docs for Laravel validation rules"

# Package documentation  
claude "Use mcp__context7__search for Livewire 3 lifecycle hooks"

# Best practices lookup
claude "Use mcp__context7__get_library_docs for Tailwind responsive patterns"
```

### BrowserMCP - Browser Testing & Automation
```bash
# Navigate and screenshot
claude "Use mcp__browsermcp__browser_navigate to /login and screenshot"

# Test user workflows
claude "Use mcp__browsermcp__browser_click to test registration form"

# Debug responsive design  
claude "Use mcp__browsermcp__browser_resize to mobile and test layout"

# Get console errors
claude "Use mcp__browsermcp__browser_get_console_logs for JS errors"
```

## 🤖 AI Specialist Agent Usage

### Development Workflow Examples

```bash
# DevOps tasks
claude "DevOps Specialist: Configure Laravel Herd with multiple PHP versions"

# Security review
claude "Security Specialist: Review OAuth implementation for vulnerabilities"  

# Performance optimization
claude "Performance Specialist: Optimize N+1 queries and Inertia responses"

# Testing strategy
claude "Testing Specialist: Create test plan for payment processing"

# Frontend development
claude "VILT Stack Specialist: Design file upload component with Vue and Inertia"
claude "VILT Stack Specialist: Implement real-time notifications with Echo"
```

## 🔍 Troubleshooting

### Claude Code Issues
```bash
# Check status and update
claude status
npm update -g @anthropic/claude-code

# Authentication issues
claude auth status
claude auth login
```

### MCP Server Issues  
```bash
# Check MCP server status
claude mcp list
claude mcp status

# Restart servers
claude mcp restart

# Debug connections
claude mcp debug
```

### Common Issues
1. **API Key**: Ensure valid Anthropic API key and ideally also OpenAI and Gemini for consensus with sufficient credits
2. **File Permissions**: Check Claude can read/write project files  
3. **MCP Paths**: Verify absolute paths in MCP server configurations
4. **Python Environment**: Ensure correct Python/virtual environment for Zen
5. **Project Root**: Run Claude from your Laravel project root directory

## 📚 Documentation Structure

- **`CLAUDE.md`** - Core AI development guidelines and quick reference
- **`docs/workflows/`** - Step-by-step development processes
- **`docs/mcp-servers/`** - Detailed MCP server usage guides
- **`docs/reference/`** - Command references and best practices
- **`.claude/agents/`** - AI specialist agent configurations

## 🎯 Getting Started

### Basic Usage
```bash
# Start AI session
claude "Help me understand this Laravel codebase structure"

# Feature development with workflow
claude "Follow feature development workflow for user profile editing"

# Code review before commit
claude "Use Zen to review all changes before committing"
```

### Advanced Usage
```bash
# Multi-step debugging
claude "Use systematic debugging workflow: investigate payment failures using Zen debug, analyze code with Serena, test with BrowserMCP"

# Comprehensive quality assurance  
claude "Perform complete QA: Zen code review, security audit, performance analysis, and browser testing"

# Architecture decision support
claude "Use Zen consensus with multiple models to evaluate microservices vs monolith for this Laravel app"
```

## 📞 Support

- **Documentation**: Complete guides in `docs/` directory
- **AI Help**: Ask Claude for assistance with any development task  
- **MCP Issues**: Use `claude mcp help` for MCP-specific problems
- **Community**: Laravel community resources and Discord/forums

---

**Ready to supercharge your Laravel VILT stack development with AI assistance!** 🚀

Start with `claude` in your project directory and leverage MCP servers and specialist agents for enhanced productivity.

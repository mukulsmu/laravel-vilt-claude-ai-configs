# CLAUDE.md - Laravel VILT Stack AI-Assisted Development Guidelines

**Architecture**: This configuration works with Laravel Boost for optimal AI-powered development.

## How This Works

This file provides VILT stack-specific instructions for Claude Code. It works alongside Laravel Boost's base Laravel configuration.

**Laravel Boost Base Instructions**: See [`.claude/instructions/laravel-boost-base.instructions.md`](.claude/instructions/laravel-boost-base.instructions.md) for the base Laravel conventions that Laravel Boost provides. Those instructions are automatically available when Laravel Boost is installed. This file adds VILT-specific enhancements.

**No Merging Required**: Simply copy this file to your project. Claude will reference both this file and the Boost base instructions automatically.

---

# VILT Stack Development Guidelines

This document provides essential context and quick reference for AI-assisted development in Laravel VILT stack applications.

## **🚀 Development Environment**

**Laravel Herd** is used for native PHP development environment. Commands run directly:

```bash
# Essential Commands
php artisan migrate --seed  # Database setup
npm run dev                 # Frontend development (Vite)
php artisan test           # Run tests
php artisan serve          # Start development server (if not using Herd)
npm run build              # Build production assets
```

**📖 [Complete Commands Reference](docs/reference/laravel-commands.md)**

---

## 🛠️ MCP Server Tools Strategy

**Always use MCP servers for enhanced development:**

### Core Development (Always Available)
- `mcp__serena__*` - Semantic code analysis and intelligent navigation
- `mcp__context7__*` - Up-to-date documentation access
- `mcp__browsermcp__*` - Real-time browser debugging with authenticated sessions

### Quality Assurance (Recommended)
- `mcp__zen__codereview` - Professional code review before PRs
- `mcp__zen__precommit` - Automated quality gates for commits
- `mcp__zen__secaudit` - Security auditing for releases

### Advanced Development (Complex Tasks)
- `mcp__zen__thinkdeep` - Extended reasoning for architectural decisions
- `mcp__zen__debug` - Systematic debugging workflows
- `mcp__zen__consensus` - Multi-model validation for major decisions

**📖 [Complete MCP Server Guides](docs/mcp-servers/)**

---

## 📖 Documentation-First Development

**ALWAYS consult docs/ before starting complex tasks.** The documentation contains:

### Documentation Priority Workflow
```bash
1. **Check CLAUDE.md** → Essential context and quick reference
2. **Consult docs/workflows/** → Understand the process for your task type  
3. **Reference docs/reference/** → Get specific standards, commands, patterns
4. **Engage .claude/agents/** → Delegate complex domain-specific work
5. **Use docs/mcp-servers/** → Optimize tool usage and troubleshooting
```

### When Documentation is Incomplete
```bash
# If docs are missing or outdated, update them FIRST
mcp__serena__write_memory "missing_documentation" "Document what needs to be added"

# Then implement with proper documentation
"Implement [feature] and update docs/workflows/[relevant].md with new patterns discovered"
```

---

## 📊 Smart Tool Selection

**Match tool complexity to task complexity:**
- **Edit/MultiEdit**: Simple, targeted changes and small modifications
- **Serena tools**: Complex refactoring, cross-file analysis, unfamiliar code
- **Zen tools**: Quality assurance, debugging, architectural analysis

**📖 [Complete Development Workflows](docs/workflows/)**

---

## 🏗️ Laravel VILT Stack Architecture Quick Reference

### Core Technology Stack
- **Laravel 12** + **VILT Stack** (Vue 3, Inertia.js, Laravel, Tailwind CSS)
- **Vue 3** - Progressive JavaScript framework with Composition API
- **Inertia.js** - SPA adapter bridging Laravel and Vue
- **Ziggy** - Laravel routes in JavaScript
- **Laravel Herd** - Native PHP development environment
- **Pest/PHPUnit** - PHP testing framework
- **Vitest** - Vue component testing framework

### Key Application Patterns
- **`resources/js/Pages/`** - Inertia page components (Vue)
- **`resources/js/Components/`** - Reusable Vue components
- **`resources/js/Layouts/`** - Shared layout components
- **`app/Services/`** - Business logic services  
- **`app/Models/`** - Eloquent models and relationships
- **`app/Http/Controllers/`** - Controllers returning Inertia responses

**📖 [Complete Architecture Guide](docs/setup/project-architecture.md)**

---

## 🤖 AI Development Guidelines

### Core Development Principles
1. **Documentation First**: Always check `docs/` for detailed information
2. **Pattern Consistency**: Follow existing TALL stack patterns  
3. **Quality Gates**: Use MCP tools for systematic quality assurance
4. **Context Preservation**: Use Serena memory system to document decisions

### Natural Language Development Workflow
```bash
# 1. Context gathering
mcp__serena__get_symbols_overview [relevant_directory]
mcp__serena__search_for_pattern [related_functionality]

# 2. Implementation with quality gates  
mcp__zen__codereview [implemented_feature]
mcp__zen__precommit [validate_changes]

# 3. Knowledge preservation
mcp__serena__write_memory [pattern_name] [architectural_decisions]
```

### Component Architecture Decision Rules
```bash
# Full-page UI with server-side data
→ Create Inertia Page in resources/js/Pages/

# Reusable UI components
→ Create Vue Component in resources/js/Components/

# Interactive features with real-time updates
→ Use Vue 3 Composition API + Laravel Echo

# API endpoints for external integrations
→ Standard Laravel API controllers with proper validation

# Admin functionality + CRUD operations
→ Consider FilamentPHP or build custom Inertia pages
```

### Sub-Agent Coordination Strategy
**Use specialized sub-agents for complex domain-specific work:**

```bash
# Task Complexity Assessment
Simple (1 file, <50 lines)     → Main Agent Only
Moderate (2-3 files)           → Consider specialist agent  
Complex (Multi-system)         → Multi-agent workflow
Architecture/Performance       → Always use specialist

# Example Delegations
"DevOps Specialist: Configure Laravel Herd environment for [feature]"
"VILT Stack Specialist: Create Vue component with Inertia integration"
"Testing Specialist: Create comprehensive test suite for [component]"
"Security Specialist: Audit authentication system for vulnerabilities"
"Performance Specialist: Optimize database queries and Inertia responses"
```

**📖 [AI Interaction Patterns](docs/reference/ai-interaction-patterns.md)**

---

## 📚 Documentation Contribution Guidelines

**Critical**: Follow strict documentation architecture to prevent duplication and maintain consistency.

### Documentation Ownership Rules
- **Workflows** = PROCESS (how to do tasks) → Delegate to specialists
- **Agents** = EXPERTISE (domain knowledge) → Provide comprehensive coverage
- **Never duplicate content** between workflows and agents

### Before Contributing Documentation
1. **Check existing coverage** - Avoid duplication with current docs
2. **Verify specialist references** - Only reference existing agents (DevOps, Security, Performance, Testing, TALL Stack)  
3. **Follow delegation patterns** - Workflows delegate complex tasks to appropriate specialists
4. **Use established structures** - Follow architectural patterns in existing documents

**📖 Complete Guidelines**: [Documentation Maintenance Guidelines](docs/maintenance/documentation-guidelines.md)

---

## 🔄 Git Workflow

**Commit after EVERY change** without asking permission:
```bash
git add -A && git commit -m "[action]: [description]"
```

**Commit Prefixes:** `feat:`, `fix:`, `refactor:`, `style:`, `docs:`, `chore:`, `test:`

---

## 📚 Documentation Navigation & When to Consult

**💡 Always check docs/ for detailed guidance before starting complex tasks.**

### 🚀 Setup & Getting Started
**Consult when:** Setting up environment, understanding codebase architecture, first-time setup
- **[Development Environment](docs/setup/development-environment.md)** - Docker, Sail, basic setup

### 🛠️ Development Workflows  
**Consult when:** Starting new features, debugging issues, optimizing performance, ensuring quality
- **[Feature Development](docs/workflows/feature-development.md)** - Complete development process, planning to deployment
- **[Quality Assurance](docs/workflows/quality-assurance.md)** - Code review, testing, security workflows
- **[Debugging & Investigation](docs/workflows/debugging-investigation.md)** - Systematic problem-solving approaches
- **[Performance Optimization](docs/workflows/performance-optimization.md)** - Performance analysis and tuning strategies

### 🤖 AI Agent Specialists
**Consult when:** Need domain expertise for complex tasks, specialized knowledge required
- **[DevOps Specialist](.claude/agents/devops-specialist.md)** - Laravel Herd, deployment, infrastructure management
- **[Testing Specialist](.claude/agents/testing-specialist.md)** - Comprehensive testing strategies & QA processes
- **[Security Specialist](.claude/agents/security-specialist.md)** - Security audits, vulnerability assessments
- **[Performance Specialist](.claude/agents/performance-specialist.md)** - Performance optimization & database tuning
- **[VILT Stack Specialist](.claude/agents/vilt-specialist.md)** - Vue 3, Inertia.js, Ziggy, frontend patterns

### 🔧 MCP Server Tools
**Consult when:** Need to understand tool capabilities, optimize tool usage, troubleshoot MCP issues
- **[Serena Guide](docs/mcp-servers/serena-guide.md)** - Semantic code analysis, navigation, editing
- **[Zen Guide](docs/mcp-servers/zen-guide.md)** - Advanced analysis, multi-model workflows, quality assurance
- **[Context7 Guide](docs/mcp-servers/context7-guide.md)** - Up-to-date documentation access & retrieval
- **[BrowserMCP Guide](docs/mcp-servers/browsermcp-guide.md)** - Real-time browser debugging and troubleshooting

### 📖 Reference Materials
**Consult when:** Need command syntax, coding standards, architectural decisions, AI interaction patterns
- **[Laravel Commands](docs/reference/laravel-commands.md)** - Complete Sail, Artisan, and project command reference
- **[Code Conventions](docs/reference/code-conventions.md)** - TALL stack patterns, naming, structure standards
- **[AI Interaction Patterns](docs/reference/ai-interaction-patterns.md)** - Natural language development techniques
- **[Decision Tracking](docs/reference/decision-tracking.md)** - Architectural decision record templates & processes

### 🔍 Quick Documentation Lookup
```bash
# Find relevant documentation
mcp__serena__list_dir --relative_path="docs" --recursive=true
mcp__serena__search_for_pattern --substring_pattern="your_topic" --relative_path="docs"

# Check specific workflow  
"Before implementing [feature], consult docs/workflows/feature-development.md"

# Get specialist guidance
For [complex_task], delegate to appropriate specialist in .claude/agents/
```

**📖 [Complete Documentation Index](docs/README.md)**

---

## 🎯 Development Context

### Session Continuation Protocol
1. **Check memories**: `mcp__serena__list_memories` and read relevant entries
2. **Review git status**: Check recent commits and current branch state  
3. **Use TodoWrite**: Track complex tasks and progress

### Browser Testing & Debugging (BrowserMCP)
**Use BrowserMCP for real-time debugging and troubleshooting:**
```bash
# Available via mcp__browsermcp__* tools
# - Real-time browser automation and testing
# - Authenticated session debugging
# - New feature validation and troubleshooting
```

**Use for:** UI debugging, feature testing, user workflow validation, real-time troubleshooting.

---

## 💡 Collaboration Guidelines

- **Challenge and question**: Don't immediately agree with suboptimal approaches
- **Push back constructively**: Suggest better alternatives with clear reasoning
- **Think critically**: Consider edge cases, performance, maintainability
- **Seek clarification**: Ask follow-up questions for ambiguous requirements
- **Propose improvements**: Suggest better patterns and cleaner implementations

---

**Built with ❤️ using Laravel VILT stack and AI-powered development workflows**

*For detailed information on any topic, always consult the [docs/](docs/) directory.*

# CLAUDE.md - Laravel VILT Stack AI Controller

**Core Stack**: Laravel 12, Vue 3, Inertia.js, Tailwind CSS, TypeScript  
**Environment**: Laravel Herd, Vite, Pest, Vitest  
**Routing**: Wayfinder (Primary) / Ziggy (Legacy)

**🤖 Dual AI Support**: This configuration works with **both Claude Code and GitHub Copilot**
- **Claude Code**: Uses this file + MCP servers for comprehensive development
- **GitHub Copilot**: Uses `.github/copilot-instructions.md` + shared `.claude/examples/`
- **Shared Knowledge**: Both tools reference the same example files for consistency

---

## 🧠 Memory First Protocol (Claude Code Only)

> **Note**: This section uses MCP servers which are Claude Code specific. GitHub Copilot users should check `package.json` and `composer.json` directly.

**DO NOT** scan the file system to understand the project structure.

### Step 1: Read Memory
```bash
mcp__serena__read_memory "project_context"
```

### Missing Memory?
If the memory does not exist, **STOP** and ask the user to run:
```bash
"Read docs/setup/init-memory.md and follow the initialization steps"
```

---

## ⚡ Core Workflow Rules (The "Hybrid Paradigm")

1.  **Memory First Rule**: **ALWAYS** check for a `project_context` memory before starting any task. This memory contains the foundational DNA of the project (stack, admin panel, etc.) and dictates which tools and patterns to use.
    - `mcp__serena__read_memory 'project_context'`

2.  **Example Retrieval Rule**: If you need syntax examples for components, forms, or other patterns, **DO NOT HALLUCINATE**. Read the relevant file in the `.claude/examples/` directory first. These are your reference libraries.

3.  **Log Safety Rule**: **ALWAYS** limit log retrieval to 20 lines. There are no exceptions to this rule. This prevents context window overflow and keeps the focus on the most recent, relevant information.
    - ❌ `mcp__boost__get_laravel_logs` (unbounded)
    - ✅ `mcp__boost__get_laravel_logs --lines=20 --level=error`

4.  **Symbolic Exploration**: **NEVER** read full files to "look around".
    - ✅ Use `mcp__serena__get_symbols_overview` or `mcp__serena__find_symbol`
    - ❌ Don't use `read_file` for exploration

5.  **Targeted Editing**: Prefer `mcp__serena__replace_symbol_body` over rewriting full files when possible.

---

## 🏗️ Development Standards (Strict Enforcement)

### 1. Routing Strategy
- **Wayfinder** (`@wayfinder/routes`): **DEFAULT**. Use type-safe imports.
- **Ziggy**: **LEGACY ONLY**. Do not use unless `project_context` explicitly confirms `Routing: Ziggy`.

### 2. Frontend Architecture (shadcn-vue)
- **Location**: `resources/js/Components/ui/`
- **Usage**: `import { Button } from '@/Components/ui/button'`
- **Constraint**: Do not create raw Tailwind buttons. If a component is missing, tell the user to run:
  ```bash
  npx shadcn-vue@latest add [component]
  ```

### 3. Admin Panels (Filament/Nova)
- **Constraint**: Do not generate custom Livewire admin tables.
- **Action**: Check `project_context`. If `Admin: Filament` or `Admin: Nova`, delegate to the Admin Specialist agent.

---

## 🤖 Workflow Triggers

| Intent | Action / Command |
|--------|------------------|
| **New Feature** | `mcp__serena__read_memory "project_context"` → Plan → Implement |
| **Debug Issue** | `mcp__boost__get_laravel_logs --lines=20` → `mcp__zen__debug` |
| **Frontend Dev** | Activate VILT Specialist: "Read `.claude/examples/vilt-examples.md` first." |
| **Admin Dev** | Activate Admin Specialist: "Read `.claude/examples/[type]-examples.md` first." |

---

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

## 🛠️ MCP Server Tools Strategy (Claude Code Only)

> **GitHub Copilot Users**: MCP servers are exclusive to Claude Code. Copilot provides inline suggestions and chat without external tool integration.

**Always use MCP servers for enhanced Claude Code development:**

### Core Development (Always Available)
- `mcp__serena__*` - Semantic code analysis and intelligent navigation
- `mcp__context7__*` - Up-to-date documentation access
- `mcp__browsermcp__*` - Real-time browser debugging with authenticated sessions
- `mcp__playwright__*` - Browser automation with Laravel integration

### Quality Assurance (Recommended)
- `mcp__zen__codereview` - Professional code review before PRs
- `mcp__zen__precommit` - Automated quality gates for commits
- `mcp__zen__secaudit` - Security auditing for releases

### Advanced Development (Complex Tasks)
- `mcp__zen__thinkdeep` - Extended reasoning for architectural decisions
- `mcp__zen__debug` - Systematic debugging workflows
- `mcp__zen__consensus` - Multi-model validation for major decisions

### Laravel & Development Tools
- `mcp__boost__*` - Laravel-specific utilities (logs, tinker, routes)
- `mcp__herd__*` - Laravel Herd environment management
- `mcp__filesystem__*` - File operations and watching
- `mcp__git__*` - Git operations and workflow automation

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
- **[GitHub Copilot Usage](docs/workflows/github-copilot-usage.md)** - Dual AI tool best practices

### 🤖 AI Agent Specialists
**Consult when:** Need domain expertise for complex tasks, specialized knowledge required
- **[VILT Stack Specialist](.claude/agents/vilt-specialist.md)** - Enforces Vue 3, Inertia.js, and shadcn-vue patterns.
- **[Admin Specialist](.claude/agents/admin-specialist.md)** - Handles logic for Filament and Nova admin panels.
- **[DevOps Specialist](.claude/agents/devops-specialist.md)** - Laravel Herd, deployment, infrastructure management
- **[Testing Specialist](.claude/agents/testing-specialist.md)** - Comprehensive testing strategies & QA processes
- **[Security Specialist](.claude/agents/security-specialist.md)** - Security audits, vulnerability assessments
- **[Performance Specialist](.claude/agents/performance-specialist.md)** - Performance optimization & database tuning
- **[Database Architect](.claude/agents/database-architect.md)** - Schema design, migrations, relationship optimization
- **[Git Workflow Specialist](.claude/agents/git-specialist.md)** - Conventional commits, branching, PR workflows

### 📝 Hybrid Agent Examples
**Consult when:** You need boilerplate or syntax examples for common patterns.
- **[VILT Examples](.claude/examples/vilt-examples.md)** - Code patterns for Wayfinder, `useForm`, and shadcn-vue.
- **[Filament Examples](.claude/examples/filament-examples.md)** - Boilerplate for Filament Resources, Forms, and Tables.
- **[Nova Examples](.claude/examples/nova-examples.md)** - Boilerplate for Nova Resources and Actions.

### 🔧 MCP Server Tools
**Consult when:** Need to understand tool capabilities, optimize tool usage, troubleshoot MCP issues
- **[Serena Guide](docs/mcp-servers/serena-guide.md)** - Semantic code analysis, navigation, editing
- **[Zen Guide](docs/mcp-servers/zen-guide.md)** - Advanced analysis, multi-model workflows, quality assurance
- **[Context7 Guide](docs/mcp-servers/context7-guide.md)** - Up-to-date documentation access & retrieval
- **[Playwright Guide](docs/mcp-servers/playwright-guide.md)** - Browser automation with Laravel integration
- **[BrowserMCP Guide](docs/mcp-servers/browsermcp-guide.md)** - Real-time browser debugging and troubleshooting
- **[Git Guide](docs/mcp-servers/git-guide.md)** - Version control automation and workflows
- **[Laravel Boost Guide](docs/mcp-servers/laravel-boost-guide.md)** - Laravel utilities (logs, tinker, routes)
- **[Laravel Herd Guide](docs/mcp-servers/laravel-herd-guide.md)** - Herd environment management

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

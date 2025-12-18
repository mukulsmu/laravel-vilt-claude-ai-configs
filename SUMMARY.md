# VILT Stack Configuration Summary

This repository provides comprehensive Claude AI agent configurations and MCP tool integrations for Laravel VILT (Vue, Inertia.js, Laravel, Tailwind CSS) stack development.

## 🎯 What's Included

### AI Specialist Agents
- **VILT Stack Specialist** - Vue 3, Inertia.js, shadcn-vue, TypeScript expertise
- **DevOps Specialist** - Laravel Herd, deployment, infrastructure
- **Security Specialist** - Vulnerability assessment, security audits
- **Performance Specialist** - Database optimization, performance tuning
- **Testing Specialist** - Comprehensive testing strategies

### MCP Server Tools
- **Laravel Boost** - Application debugging, log analysis (with truncation)
- **Laravel Herd** - Environment management, site control, PHP versions
- **Serena** - Semantic code analysis and navigation
- **Zen** - Advanced analysis, code review, debugging
- **Context7** - Up-to-date documentation access
- **BrowserMCP** - Real-time browser testing and debugging

### Project Support
- **Laravel Vue Starter Kit** (Recommended)
  - TypeScript + Vue 3 Composition API
  - shadcn-vue component library
  - Wayfinder type-safe routing
  - Modern tooling with Vite
  
- **Laravel Jetstream** (Vue + Inertia)
  - Complete authentication system
  - Team management
  - Ziggy routing
  - Legacy compatibility
  
- **Custom VILT Setups**
  - Automatic detection patterns
  - Flexible adaptation strategies

## 📚 Documentation Structure

```
.claude/
└── agents/
    ├── vilt-specialist.md      # Vue/Inertia expertise
    ├── devops-specialist.md    # Herd & infrastructure
    ├── security-specialist.md  # Security auditing
    ├── performance-specialist.md
    └── testing-specialist.md

docs/
├── mcp-servers/
│   ├── laravel-boost-guide.md  # ⚠️ Critical: Log truncation!
│   ├── laravel-herd-guide.md   # Environment management
│   ├── serena-guide.md         # Code navigation
│   ├── zen-guide.md            # Advanced analysis
│   ├── context7-guide.md       # Documentation access
│   └── browsermcp-guide.md     # Browser testing
│
├── reference/
│   ├── vue-starter-kit-guide.md    # 📖 Essential reading
│   ├── laravel-commands.md
│   ├── code-conventions.md
│   └── ai-interaction-patterns.md
│
└── workflows/
    ├── feature-development.md
    ├── quality-assurance.md
    ├── debugging-investigation.md
    └── performance-optimization.md

CLAUDE.md              # Main AI development guide
README.md             # Project overview
SETUP.md              # Installation instructions
MIGRATION.md          # TALL → VILT migration guide
```

## 🚀 Quick Start

### For New Projects (Recommended)

```bash
# 1. Create Laravel project
composer create-project laravel/laravel my-app
cd my-app

# 2. Install Vue starter kit
php artisan install:vue

# 3. Install AI configurations
git clone https://github.com/mukulsmu/laravel-vilt-claude-ai-configs.git .ai-config
cp -r .ai-config/.claude ./
cp -r .ai-config/docs ./
cp .ai-config/CLAUDE.md ./

# 4. Setup Laravel Herd (if not installed)
# Download from https://herd.laravel.com/

# 5. Start development
npm install
npm run dev
# Herd automatically serves your site at my-app.test
```

### For Existing Projects

```bash
# 1. Clone AI configurations
cd your-laravel-project
git clone https://github.com/mukulsmu/laravel-vilt-claude-ai-configs.git .ai-config
cp -r .ai-config/.claude ./
cp -r .ai-config/docs ./
cp .ai-config/CLAUDE.md ./

# 2. AI will automatically detect your project type:
#    - Vue Starter Kit (Wayfinder + shadcn-vue)
#    - Jetstream (Ziggy + built-in auth)
#    - Custom setup
```

## 🤖 AI Usage Patterns

### Project Detection

```bash
# AI automatically identifies your setup
"Analyze this Laravel project structure and identify:
1. Is it Vue Starter Kit or Jetstream?
2. Does it use Wayfinder or Ziggy?
3. Are shadcn-vue components available?
4. What's the TypeScript configuration?"

# AI uses these tools:
mcp__serena__search_for_pattern "@wayfinder" --relative_path="resources/js"
mcp__serena__list_dir --relative_path="resources/js/Components/ui"
mcp__serena__search_for_pattern "jetstream" --relative_path="composer.json"
```

### Feature Development

```bash
# For Vue Starter Kit projects
"VILT Stack Specialist: Create a posts management page using shadcn-vue components and Wayfinder routing"

# For Jetstream projects
"VILT Stack Specialist: Add team dashboard using Jetstream layouts and Ziggy routing"

# AI adapts to your project structure automatically
```

### Debugging Workflow

```bash
# Combined MCP power
"Debug the slow dashboard page:
1. Use Herd MCP to check site status
2. Use Boost MCP to analyze logs (last 50 lines only!)
3. Use Serena to find related code
4. Use Zen to suggest optimizations
5. Test fix with BrowserMCP"
```

## ⚠️ Critical Best Practices

### 1. Always Limit Log Queries

```bash
# ❌ NEVER do this (context window overflow!)
mcp__boost__get_laravel_logs

# ✅ ALWAYS use limits
mcp__boost__get_laravel_logs --lines=50 --level=error --since="1 hour ago"
```

### 2. Detect Before Generating

```bash
# Always check project structure first
mcp__serena__search_for_pattern "wayfinder\|ziggy" --relative_path="resources/js"

# Then generate appropriate code
# Wayfinder: import { posts } from '@wayfinder/routes'
# Ziggy: route('posts.index')
```

### 3. Use shadcn-vue When Available

```bash
# Check for shadcn-vue
mcp__serena__list_dir --relative_path="resources/js/Components/ui"

# If present, use shadcn components
import { Button } from '@/Components/ui/button'
import { Card } from '@/Components/ui/card'
```

### 4. Combine MCP Tools Efficiently

```bash
# Site management (Herd)
mcp__herd__get_all_sites
mcp__herd__debug_site --site=myapp.test --limit=50

# Application debugging (Boost)
mcp__boost__get_laravel_logs --level=error --lines=30

# Code analysis (Serena)
mcp__serena__find_symbol "UserController"

# Advanced review (Zen)
mcp__zen__codereview
```

## 📖 Essential Reading

**Before starting any work, read these guides:**

1. **CLAUDE.md** - Core AI development patterns
2. **docs/reference/vue-starter-kit-guide.md** - Project structure & routing
3. **docs/mcp-servers/laravel-boost-guide.md** - Log truncation critical!
4. **docs/mcp-servers/laravel-herd-guide.md** - Environment management

## 🔧 Routing Solutions

### Wayfinder (Recommended for Laravel 12+)

**Features:**
- ✅ Type-safe TypeScript routes
- ✅ IDE autocomplete
- ✅ Compile-time validation
- ✅ Only used routes exposed

**Usage:**
```typescript
import { posts } from '@wayfinder/routes'
router.visit(posts.show({ id: 123 }))
```

**Generate routes:**
```bash
php artisan routes:generate
```

### Ziggy (Legacy/Jetstream)

**Features:**
- ✅ Works with older Laravel versions
- ✅ Pre-installed in Jetstream
- ⚠️ String-based (no type safety)
- ⚠️ Exposes all routes

**Usage:**
```typescript
import { route } from 'ziggy-js'
router.visit(route('posts.show', 123))
```

## 🎨 Component Libraries

### shadcn-vue (Vue Starter Kit)

40+ accessible, customizable components:
- Buttons, Inputs, Forms
- Cards, Dialogs, Modals
- Tables, Tabs, Navigation
- And more...

**Add components:**
```bash
npx shadcn-vue@latest add button card input
```

### Jetstream Components

Basic UI components included:
- Form inputs
- Buttons
- Modals
- Dropdowns

## 🧪 Testing Strategy

### Backend (PHP)
```bash
# Pest/PHPUnit
php artisan test

# With coverage
php artisan test --coverage
```

### Frontend (Vue)
```bash
# Vitest (Starter Kit)
npm run test

# With UI
npm run test:ui
```

### Browser (BrowserMCP)
```bash
# AI-powered browser testing
mcp__browsermcp__browser_navigate "http://myapp.test"
mcp__browsermcp__browser_snapshot
mcp__browsermcp__browser_click "button"
```

## 🔐 Security

### Laravel Boost MCP

**Production Configuration:**
```php
// config/boost.php
'security' => [
    'read_only' => true,  // No write operations
    'allowed_ips' => ['127.0.0.1'],  // Local only
    'mask_sensitive_keys' => true,  // Filter secrets
],
```

### Laravel Herd MCP

**Local Development Only:**
- Never expose Herd MCP to production
- Services bound to localhost only
- Site-specific PHP versions for isolation

## 📈 Performance

### Boost MCP Optimization
```php
'cache' => [
    'enabled' => true,
    'ttl' => 60,
    'driver' => 'redis',
],
'logs' => [
    'default_lines' => 50,
    'max_lines' => 200,
],
```

### Herd MCP Optimization
```bash
# Stop unused services
mcp__herd__stop_service --service=meilisearch
mcp__herd__stop_service --service=minio

# Cache site information
mcp__serena__write_memory "herd_sites" "[site data]"
```

## 🚨 Common Issues

### "Context window full" Error
**Cause**: Requesting full logs without limits
**Solution**: Always use `--lines=50` and `--since="1 hour ago"`

### "Route not found" in Vue
**Cause**: Using wrong routing solution
**Solution**: Check project (Wayfinder vs Ziggy) and adapt

### "Component not found"
**Cause**: Importing from wrong location
**Solution**: Check if using shadcn-vue or Jetstream components

## 🎯 Success Metrics

You'll know the configuration is working when:

1. ✅ AI correctly identifies your project type
2. ✅ Generated code uses correct routing (Wayfinder/Ziggy)
3. ✅ Components match your library (shadcn-vue/Jetstream)
4. ✅ Log queries are always limited
5. ✅ Multiple MCP tools work together seamlessly

## 🤝 Contributing

Found an issue or have an improvement? 

1. Check `docs/maintenance/documentation-guidelines.md`
2. Follow existing patterns
3. Test with both Starter Kit and Jetstream projects
4. Submit PR with examples

## 📞 Support

- **Documentation**: Complete guides in `docs/` directory
- **AI Help**: Ask Claude for assistance with any development task
- **MCP Issues**: Check tool-specific guides in `docs/mcp-servers/`

---

## Version

**Current Version**: 2.0.0

**Changelog**:
- 2.0.0: Complete VILT stack refactor
  - Added Vue Starter Kit support
  - Added Wayfinder routing
  - Added shadcn-vue patterns
  - Added Laravel Boost MCP
  - Added Laravel Herd MCP
  - Added Jetstream compatibility
  - Migrated from TALL to VILT stack
- 1.0.0: Initial TALL stack release

---

**Built with ❤️ for the Laravel VILT stack community**

*Transform your Laravel development with AI-powered assistance, systematic quality assurance, and domain expert guidance.*
